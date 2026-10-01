#!/usr/bin/env bash
# validate-crossrefs.sh — Check spec relationship links resolve, and upward links trace to PURPOSE.md
#
# Usage: bash scripts/validate-crossrefs.sh [--verbose] [--strict] [--json] [--fix] [path...]
#   path      tree to scan for *.spec.md, or a single spec file (default: specs/)
#   --strict  promote traceability warnings to errors
#   --json    machine-readable output (specs/interfaces/formats/validator-output.spec.md)
#   --fix     move retired implements: into satisfies:, and regenerate each
#             parent's supports: from its children's upward links
# Exit 0: no errors (warnings permitted)
# Exit 1: an unresolved target, or any finding under --strict
# Exit 2: usage error
#
# Specifies: specs/features/validation/cross-reference-validation.spec.md
#
# The graph is always the whole tree, so checking only the staged specs still
# sees their chains to PURPOSE.md. Graph work is done in awk: the bash macOS
# ships (3.2) has no associative arrays.

set -uo pipefail

VERBOSE=false
STRICT=false
JSON=false
FIX=false
ROOTS=()

for arg in "$@"; do
    case "$arg" in
        --verbose) VERBOSE=true ;;
        --strict)  STRICT=true ;;
        --json)    JSON=true ;;
        --fix)     FIX=true ;;
        -*)        echo "Unknown option: $arg" >&2
                   echo "Usage: $0 [--verbose] [--strict] [--json] [--fix] [path...]" >&2
                   exit 2 ;;
        *)         ROOTS+=("$arg") ;;
    esac
done

(( ${#ROOTS[@]} )) || ROOTS=(specs/)

for root in "${ROOTS[@]}"; do
    if [[ ! -e "$root" ]]; then
        echo "ERROR: no such file or directory: $root" >&2
        exit 2
    fi
done

# Targets are written from the repository root, so resolve from there. Paths
# given on the command line are relative to where the script was run.
PREFIX="$(git rev-parse --show-prefix 2>/dev/null || true)"
TOP="$(git rev-parse --show-toplevel 2>/dev/null || pwd -P)"
for i in "${!ROOTS[@]}"; do
    [[ "${ROOTS[$i]}" == /* ]] || ROOTS[$i]="${PREFIX}${ROOTS[$i]}"
done
cd "$TOP" || exit 2

if $JSON; then
    VO_HELPER="$(dirname "${BASH_SOURCE[0]}")/validator-output.sh"
    [[ -f "$VO_HELPER" ]] || { echo "ERROR: --json needs $VO_HELPER" >&2; exit 2; }
    # shellcheck source=validator-output.sh
    source "$VO_HELPER"
    vo_init validate-crossrefs
fi

# Repository-root-relative, with . and .. segments resolved.
norm() {
    local p="$1" part IFS=/
    local -a out=() parts=()
    [[ "$p" == "$TOP"/* ]] && p="${p#"$TOP"/}"
    read -ra parts <<< "$p"
    for part in ${parts[@]+"${parts[@]}"}; do
        case "$part" in
            ""|.) ;;
            ..)   (( ${#out[@]} )) && unset "out[$(( ${#out[@]} - 1 ))]" ;;
            *)    out+=("$part") ;;
        esac
    done
    (( ${#out[@]} )) && printf '%s' "${out[*]}"
}

# Files checked, and the graph they are checked against.
SCANNED=""
while IFS= read -r f; do
    [[ "$f" == *sync-conflict* ]] && continue
    SCANNED+="$(norm "$f")"$'\n'
done < <(find "${ROOTS[@]}" -name '*.spec.md' -type f 2>/dev/null)
GRAPH="$SCANNED"
[[ -d specs ]] && GRAPH+="$(find specs -name '*.spec.md' -type f | grep -v sync-conflict)"$'\n'
SCANNED="$(printf '%s' "$SCANNED" | grep -v '^$' | LC_ALL=C sort -u)"
GRAPH="$(printf '%s' "$GRAPH" | grep -v '^$' | LC_ALL=C sort -u)"
GRAPH_FILES=()
while IFS= read -r f; do [[ -n "$f" ]] && GRAPH_FILES+=("$f"); done <<< "$GRAPH"

# Pass 1: relationship values from each frontmatter.
#   C file category | D file field has-value | E file field target | U file field raw
EXTRACT='
function trim(s) { sub(/^[[:space:]]+/, "", s); sub(/[[:space:]]+$/, "", s); return s }
function is_path(v) {
    if (v == "" || v == ":" || v == "all_projects" || v == "this_project" || v == "moderate") return 0
    if (index(v, "/") == 0 && index(v, ".spec") == 0 && index(v, ".md") == 0 && index(v, ".sh") == 0) return 0
    return 1
}
function item(v) {
    sub(/[[:space:]]+#.*$/, "", v)
    sub(/[[:space:]]+\(.*$/, "", v)
    v = trim(v)
    q = substr(v, 1, 1)
    if (length(v) > 1 && (q == "\"" || q == SQ) && substr(v, length(v), 1) == q) v = trim(substr(v, 2, length(v) - 2))
    if (v == "") return
    hasval = 1
    if (is_path(v)) print "E\t" file "\t" cur "\t" v
}
function unparse(v) { hasval = 1; print "U\t" file "\t" cur "\t" v }
function flow(v,    inner, i, c, depth, buf) {
    inner = substr(v, 2, length(v) - 2); depth = 0; buf = ""
    for (i = 1; i <= length(inner); i++) {
        c = substr(inner, i, 1)
        if (c == "(") depth++
        else if (c == ")" && depth > 0) depth--
        if (c == "," && depth == 0) { item(buf); buf = "" } else buf = buf c
    }
    item(buf)
}
function inline(v) {
    v = trim(v); sub(/[[:space:]]+#.*$/, "", v)
    if (v == "" || v == "[]") return
    if (v ~ /^\[/) { if (v ~ /\]$/) flow(v); else unparse(v); return }
    if (v ~ /^[|>{]/) { unparse(v); return }
    item(v)
}
function closefield() { if (cur != "") print "D\t" file "\t" cur "\t" hasval; cur = "" }
BEGIN {
    n = split("governed-by satisfies guided-by derives-from supports specifies implements extends informed-by supersedes updated-by", F, " ")
    for (i = 1; i <= n; i++) REF[F[i]] = 1
}
FNR == 1 { closefield(); file = FILENAME; dashes = 0 }
dashes >= 2 { next }
/^---[[:space:]]*$/ { dashes++; if (dashes == 2) closefield(); next }
dashes == 1 {
    if (match($0, /^[A-Za-z_][A-Za-z0-9_-]*:/)) {
        closefield()
        key = substr($0, 1, RLENGTH - 1); val = substr($0, RLENGTH + 1)
        if (key == "category") print "C\t" file "\t" trim(val)
        if (key in REF) { cur = key; hasval = 0; inline(val) }
        next
    }
    if ($0 ~ /^[[:space:]]*$/ || $0 ~ /^[[:space:]]*#/) next
    if (cur != "" && $0 ~ /^[[:space:]]*-([[:space:]]|$)/) { v = $0; sub(/^[[:space:]]*-[[:space:]]*/, "", v); item(v); next }
    if (cur != "") unparse(trim($0))
}
END { closefield() }
'

# Pass 2: resolution, layers, reachability and cycles.
#   F severity rule path subject message (unit-separated: a subject may be empty,
#   and bash collapses empty tab-separated fields) | OK path field target | SUM counts
RESOLVE='
function layer(p,    seg) {
    if (p == "PURPOSE.md") return "purpose"
    if (p in cat) return cat[p]
    if (p ~ /^specs\/[^\/]+\//) { seg = p; sub(/^specs\//, "", seg); sub(/\/.*$/, "", seg); if ((seg in RANK) && seg != "purpose") return seg }
    return ""
}
function finding(sev, rule, path, subj, msg) {
    print "F" US sev US rule US path US subj US msg
    if (sev == "error") nerr++; else nwarn++
}
BEGIN {
    FS = "\t"
    RANK["purpose"] = 0; RANK["foundation"] = 1; RANK["workspace"] = 1; RANK["strategy"] = 2
    RANK["features"] = 3; RANK["interfaces"] = 3; RANK["artifacts"] = 3
    UP["derives-from"] = 1; UP["satisfies"] = 1; UP["guided-by"] = 1; UP["governed-by"] = 1
    warn = strict ? "error" : "warning"
    US = "\037"
}
$1 == "N" { node[$2] = 1; order[++nn] = $2; next }
$1 == "S" { scan[$2] = 1; ns++; next }
$1 == "C" { if (($3 in RANK) && $3 != "purpose") cat[$2] = $3; next }
$1 == "D" { if ($2 in scan) { declared++; if ($4 == 0) empty++; if ($3 == "implements") retired[$2] = 1 }; next }
$1 == "X" { kind[$2] = $3; next }
$1 == "R" { rel[$2, $3] = 1; next }
$1 == "E" { ne++; es[ne] = $2; ef[ne] = $3; et[ne] = $4; next }
$1 == "U" { if ($2 in scan) finding(warn, "unparseable", $2, $3, $3 ": value not in a supported form: " $4); next }
END {
    for (i = 1; i <= ne; i++) {
        s = es[i]; f = ef[i]; raw = et[i]; t = raw; sub(/^(\.\/)+/, "", t)
        in_scan = (s in scan)
        if (in_scan) refs++
        if (f == "supports" && !((s, t) in act)) { act[s, t] = 1; actl[s] = actl[s] SUBSEP t }
        if (f == "satisfies") sat[s, t] = 1
        if (f == "implements" && in_scan) { nimpl[s]++; impl[s, nimpl[s]] = t }
        if (kind[raw] == "missing") {
            if (!in_scan) continue
            nbroken++
            if ((s, raw) in rel)
                finding("error", "relative-path", s, f ":" raw, f " → " raw " resolves only relative to this spec; write it from the repository root")
            else
                finding("error", "broken-reference", s, f ":" raw, f " → " raw " does not exist")
            continue
        }
        if (!(f in UP)) { if (in_scan) print "OK\t" s "\t" f "\t" raw; continue }
        if (t == s) { if (in_scan) finding(warn, "self-reference", s, f, f " → itself"); continue }
        if (!(t in node)) { if (in_scan) finding(warn, "not-a-spec", s, f ":" raw, f " → " raw " is not a spec or PURPOSE.md"); continue }
        ls = layer(s); lt = layer(t)
        if (t == "PURPOSE.md" && ls != "foundation" && ls != "workspace") {
            if (in_scan) finding(warn, "wrong-layer", s, f ":" t, f " → PURPOSE.md: only foundation and workspace specs may link to it directly")
            continue
        }
        if (ls != "" && lt != "" && RANK[lt] > RANK[ls]) {
            if (in_scan) finding(warn, "wrong-layer", s, f ":" t, f " → " t " is " lt ", below this " ls " spec")
            continue
        }
        if (in_scan) print "OK\t" s "\t" f "\t" raw
        linked[s] = 1
        if (t != "PURPOSE.md" && !((t, s) in der)) { der[t, s] = 1; derl[t] = derl[t] SUBSEP s }
        adj[s] = (s in adj) ? adj[s] SUBSEP t : t
        nedge++; eS[nedge] = s; eT[nedge] = t
    }

    reach["PURPOSE.md"] = 1
    do {
        changed = 0
        for (k = 1; k <= nedge; k++)
            if ((eT[k] in reach) && !(eS[k] in reach)) { reach[eS[k]] = 1; changed = 1 }
    } while (changed)

    for (j = 1; j <= nn; j++) {
        s = order[j]
        if (!(s in scan)) continue
        if (!(s in linked)) { unlinked++; finding(warn, "unlinked", s, "", "no upward link resolves (derives-from, satisfies, guided-by, governed-by)"); continue }
        if (s in reach) chained++
        else finding(warn, "no-chain", s, "", "upward links never reach PURPOSE.md")
        # On a cycle when the spec can reach itself.
        split("", seen); qh = 1; qt = 0; oncycle = 0
        m = split(adj[s], nb, SUBSEP); for (x = 1; x <= m; x++) q[++qt] = nb[x]
        while (qh <= qt) {
            u = q[qh++]
            if (u == s) { oncycle = 1; break }
            if (u in seen) continue
            seen[u] = 1
            if (u in adj) { m = split(adj[u], nb, SUBSEP); for (x = 1; x <= m; x++) q[++qt] = nb[x] }
        }
        if (oncycle) finding(warn, "cycle", s, "", "upward links lead back to this spec")
    }

    # Retired implements:, and the values --fix moves into satisfies:.
    for (s in retired) {
        finding(warn, "retired-field", s, "implements", "implements: is retired; its values belong in satisfies: (--fix moves them)")
        moved = ""
        for (x = 1; x <= nimpl[s]; x++) if (!((s, impl[s, x]) in sat)) moved = moved "\034" impl[s, x]
        print "IMPL" US s US substr(moved, 2)
    }

    # supports: is the inverse of the resolving upward links, reported on the
    # parent whenever the parent or the child concerned is being checked.
    for (j = 1; j <= nn; j++) {
        p = order[j]
        if (p == "PURPOSE.md") continue
        touched = (p in scan); mismatch = 0; dropped = ""
        m = split(derl[p], ch, SUBSEP)
        for (x = 2; x <= m; x++)
            if (!((p, ch[x]) in act) && (touched || (ch[x] in scan))) {
                mismatch = 1
                finding(warn, "missing-backlink", p, ch[x], "supports: lacks " ch[x] ", which links up to this spec")
            }
        m = split(actl[p], en, SUBSEP)
        for (x = 2; x <= m; x++)
            if (!((p, en[x]) in der) && (touched || (en[x] in scan))) {
                mismatch = 1; dropped = dropped "\034" en[x]
                finding(warn, "stale-backlink", p, en[x], "supports: lists " en[x] ", which has no upward link to this spec")
            }
        if (mismatch) { kids = derl[p]; gsub(SUBSEP, "\034", kids); print "SUP" US p US substr(kids, 2) US substr(dropped, 2) }
    }
    print "SUM\t" (ns + 0) "\t" (declared + 0) "\t" (empty + 0) "\t" (refs + 0) "\t" (nbroken + 0) "\t" (chained + 0) "\t" (unlinked + 0) "\t" (nerr + 0) "\t" (nwarn + 0)
}
'

STRICT_N=0; $STRICT && STRICT_N=1
US=$'\037'

# Extraction, existence and resolution: run again after each --fix rewrite.
analyse() {
    local tag src field val f
    EXTRACTED=""
    (( ${#GRAPH_FILES[@]} )) && EXTRACTED="$(awk -v SQ="'" "$EXTRACT" "${GRAPH_FILES[@]}")"

    # Existence is a filesystem question, answered here: X target kind, and R for
    # a missing target that would resolve relative to the spec naming it.
    EXISTENCE=""
    while IFS=$'\t' read -r tag src field val; do
        [[ "$tag" == E ]] || continue
        # A specifies: glob names no single path; validate-coverage.sh reports
        # one that matches nothing.
        if [[ -e "$val" ]] || [[ "$field" == specifies && "$val" == *[\*\?\[]* ]]; then
            EXISTENCE+="X"$'\t'"$val"$'\t'"present"$'\n'
        else
            EXISTENCE+="X"$'\t'"$val"$'\t'"missing"$'\n'
            [[ -e "${src%/*}/$val" ]] && EXISTENCE+="R"$'\t'"$src"$'\t'"$val"$'\n'
        fi
    done <<< "$EXTRACTED"

    RESOLVED="$(
        {
            while IFS= read -r f; do [[ -n "$f" ]] && printf 'N\t%s\n' "$f"; done <<< "$GRAPH"
            [[ -f PURPOSE.md ]] && printf 'N\tPURPOSE.md\n'
            while IFS= read -r f; do [[ -n "$f" ]] && printf 'S\t%s\n' "$f"; done <<< "$SCANNED"
            printf '%s' "$EXISTENCE"
            [[ -n "$EXTRACTED" ]] && printf '%s\n' "$EXTRACTED"
        } | awk -v strict="$STRICT_N" "$RESOLVE"
    )"
}

# Frontmatter rewrite for --fix: supports: replaced (or added when the spec has
# children), implements: dropped, values appended to satisfies:. Lists are
# joined with \034. Nothing else in the file changes.
REWRITE='
function trim(v) { sub(/^[[:space:]]+/, "", v); sub(/[[:space:]]+$/, "", v); return v }
function emit_list(key, joined,    n, a, i) {
    n = (joined == "") ? 0 : split(joined, a, "\034")
    if (n == 0) { print key ": []"; return }
    print key ":"
    for (i = 1; i <= n; i++) print "  - " a[i]
}
function emit_inline(v,    inner, i, c, depth, buf) {
    sub(/[[:space:]]+#.*$/, "", v); v = trim(v)
    if (v == "" || v == "[]") return
    if (v !~ /^\[.*\]$/) { print "  - " v; return }
    inner = substr(v, 2, length(v) - 2); depth = 0; buf = ""
    for (i = 1; i <= length(inner); i++) {
        c = substr(inner, i, 1)
        if (c == "(") depth++
        else if (c == ")" && depth > 0) depth--
        if (c == "," && depth == 0) { if (trim(buf) != "") print "  - " trim(buf); buf = "" } else buf = buf c
    }
    if (trim(buf) != "") print "  - " trim(buf)
}
function append_sat(    n, a, i) { n = split(add_sat, a, "\034"); for (i = 1; i <= n; i++) print "  - " a[i]; sat_done = 1 }
function close_block() { if (blk == "satisfies") append_sat(); blk = "" }
dashes >= 2 { print; next }
/^---[[:space:]]*$/ {
    dashes++
    if (dashes == 2) {
        close_block()
        if (sup_set && !sup_done && sup != "") emit_list("supports", sup)
        if (add_sat != "" && !sat_done) emit_list("satisfies", add_sat)
    }
    print; next
}
dashes == 1 && /^[A-Za-z_][A-Za-z0-9_-]*:/ {
    close_block(); skip = 0
    key = $0; sub(/:.*/, "", key)
    val = $0; sub(/^[^:]*:/, "", val)
    if (key == "supports" && sup_set) { emit_list("supports", sup); sup_done = 1; skip = 1; next }
    if (key == "implements" && drop_impl) { skip = 1; next }
    if (key == "satisfies" && add_sat != "") {
        if (trim(val) == "") { print; blk = "satisfies"; next }
        print "satisfies:"; emit_inline(val); append_sat(); next
    }
    print; next
}
dashes == 1 && skip && /^([[:space:]]|-)/ { next }
{ print }
'

# rewrite <file> <rewrite-supports 0|1> <supports> <drop-implements 0|1> <add-to-satisfies>
rewrite() {
    local tmp
    tmp="$(mktemp)" || return 1
    awk -v sup_set="$2" -v sup="$3" -v drop_impl="$4" -v add_sat="$5" "$REWRITE" "$1" > "$tmp" \
        && cat "$tmp" > "$1"
    rm -f "$tmp"
}

analyse

if $FIX; then
    echo "Fixing relationship links..."
    # implements: first, so the satisfies: it becomes counts towards supports:.
    while IFS="$US" read -r tag f vals; do
        [[ "$tag" == IMPL ]] || continue
        rewrite "$f" 0 "" 1 "$vals"
        echo "  FIXED  $f: implements: moved into satisfies:"
    done < <(grep "^IMPL$US" <<< "$RESOLVED")
    analyse
    while IFS="$US" read -r tag f children dropped; do
        [[ "$tag" == SUP ]] || continue
        children="$(tr '\034' '\n' <<< "$children" | grep -v '^$' | LC_ALL=C sort -u | tr '\n' '\034')"
        rewrite "$f" 1 "${children%$'\034'}" 0 ""
        echo "  FIXED  $f: supports: regenerated"
        while IFS= read -r d; do
            [[ -n "$d" ]] && echo "         dropped $d: it has no upward link here. If it depends on this spec, add one to it"
        done < <(tr '\034' '\n' <<< "$dropped")
    done < <(grep "^SUP$US" <<< "$RESOLVED")
    analyse
    echo ""
fi

echo "Validating cross-references..."
echo ""

# Findings grouped by file, in a stable order.
last=""
while IFS="$US" read -r tag sev rule path subject message; do
    [[ "$tag" == F ]] || continue
    [[ "$path" != "$last" ]] && { echo "$path:"; last="$path"; }
    if [[ "$sev" == error ]]; then echo "  ERROR: $message"; else echo "  WARN:  $message"; fi
    $JSON && vo_finding "$sev" "$rule" "$path" "$subject" "$message"
done < <(grep "^F$US" <<< "$RESOLVED" | LC_ALL=C sort -t "$US" -k4,4 -k3,3 -k6,6)

if $VERBOSE; then
    while IFS=$'\t' read -r tag path field target; do
        [[ "$tag" == OK ]] && echo "  OK: $path: $field → $target"
    done <<< "$RESOLVED"
fi

IFS=$'\t' read -r _ CHECKED DECLARED EMPTY REFS BROKEN CHAINED UNLINKED ERRORS WARNINGS \
    < <(grep '^SUM' <<< "$RESOLVED")

echo ""
echo "Summary:"
if (( ${#ROOTS[@]} == 1 )); then
    echo "  Scanned:             ${ROOTS[0]}"
else
    echo "  Scanned:             ${#ROOTS[@]} paths"
fi
echo "  Files checked:       $CHECKED"
echo "  Relationship fields: $DECLARED declared, $EMPTY empty"
echo "  References checked:  $REFS"
echo "  Broken references:   $BROKEN"
echo "  Traced to PURPOSE:   $CHAINED of $CHECKED ($UNLINKED with no upward link)"
echo "  Warnings:            $WARNINGS"
if ! $STRICT && (( WARNINGS > 0 )); then
    echo "  (re-run with --strict to fail on traceability warnings)"
fi

if (( ERRORS > 0 )); then
    echo ""
    echo "FAILED: $ERRORS error(s) found"
    exit 1
fi
echo ""
echo "PASSED: All cross-references valid"
exit 0
