#!/usr/bin/env bash
# validate-coverage.sh — How much of the project do the specs govern, and which spec governs a file?
#
# Usage: bash scripts/validate-coverage.sh [--verbose] [--json]
#        bash scripts/validate-coverage.sh --which <path>
#   --verbose     list every file no spec governs
#   --json        machine-readable output with the governed-set map
#                 (specs/interfaces/formats/validator-output.spec.md)
#   --which PATH  print the specs governing PATH, which need not exist yet, or
#                 why it needs none
# Exit 0: report produced (coverage is reported, never enforced)
# Exit 1: --which found no spec governing a path that needs one
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/validate-coverage.spec.md
#
# A file is governed only when a spec's specifies: names it, as a file, a
# directory or a glob. Matching is done in awk: the bash macOS ships (3.2) has no
# associative arrays.

set -uo pipefail

usage() {
    echo "Usage: $0 [--verbose] [--json]" >&2
    echo "       $0 --which <path>" >&2
    exit 2
}

VERBOSE=false
JSON=false
WHICH=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --verbose) VERBOSE=true ;;
        --json)    JSON=true ;;
        --which)   [[ $# -ge 2 && -n "$2" ]] || usage; WHICH="$2"; shift ;;
        *)         usage ;;
    esac
    shift
done
[[ -n "$WHICH" ]] && $JSON && usage

# specifies: values are written from the repository root.
PREFIX="$(git rev-parse --show-prefix 2>/dev/null || true)"
TOP="$(git rev-parse --show-toplevel 2>/dev/null || pwd -P)"
IN_GIT=false
git rev-parse --git-dir >/dev/null 2>&1 && IN_GIT=true
[[ -n "$WHICH" && "$WHICH" != /* ]] && WHICH="${PREFIX}${WHICH}"
cd "$TOP" || exit 2

if $JSON; then
    VO_HELPER="$(dirname "${BASH_SOURCE[0]}")/validator-output.sh"
    [[ -f "$VO_HELPER" ]] || { echo "ERROR: --json needs $VO_HELPER" >&2; exit 2; }
    # shellcheck source=validator-output.sh
    source "$VO_HELPER"
    vo_init validate-coverage
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

# Why a path needs no spec, or nothing. The one implementation of these
# exemptions: check-requires-spec.sh reaches it through --which.
exempt_reason() {
    local p="$1" base="${1##*/}" dir from
    for dir in var generated .archive .git node_modules .cache build dist worktrees; do
        if [[ "$p" == "$dir/"* || "$p" == *"/$dir/"* ]]; then
            echo "lives under $dir/ (transient, not committed as a deliverable)"; return 0
        fi
    done
    if [[ "$p" == specs/workspace/* ]]; then
        echo "workspace specs ARE specifications (no meta-spec required)"; return 0
    fi
    if [[ "$base" == *.spec.md ]]; then
        echo "file is itself a specification"; return 0
    fi
    case "$base" in
        *.log|*.lock|*.cache) echo "data/log artefact, carries no specified behaviour"; return 0 ;;
    esac
    if [[ -f "$p" ]] && grep -m1 -qE '^(# )?vendored-from: ' "$p" 2>/dev/null; then
        from="$(grep -m1 -oE 'vendored-from: .*' "$p")"
        echo "vendored from ${from#vendored-from: }, which is specified upstream"; return 0
    fi
    return 1
}

# Tracked files: the tree a commit carries. Outside git, the files on disk.
if $IN_GIT; then
    TRACKED="$(git ls-files | LC_ALL=C sort)"
else
    TRACKED="$(find . -type f ! -path './.git/*' | sed 's|^\./||' | LC_ALL=C sort)"
fi

# specifies: values from every spec the project authored. A spec vendored from
# the toolchain describes the toolchain's own files.
SPECIFIES_AWK='
function trim(s) { sub(/^[[:space:]]+/, "", s); sub(/[[:space:]]+$/, "", s); return s }
function item(v,    q) {
    sub(/[[:space:]]+#.*$/, "", v); sub(/[[:space:]]+\(.*$/, "", v); v = trim(v)
    q = substr(v, 1, 1)
    if (length(v) > 1 && (q == "\"" || q == SQ) && substr(v, length(v), 1) == q) v = trim(substr(v, 2, length(v) - 2))
    if (v != "") print FILENAME "\t" v
}
function flow(v,    inner, i, c, buf) {
    inner = substr(v, 2, length(v) - 2); buf = ""
    for (i = 1; i <= length(inner); i++) {
        c = substr(inner, i, 1)
        if (c == ",") { item(buf); buf = "" } else buf = buf c
    }
    item(buf)
}
FNR == 1 { dashes = 0; cur = 0 }
dashes >= 2 { next }
/^---[[:space:]]*$/ { dashes++; next }
dashes == 1 && /^[A-Za-z_][A-Za-z0-9_-]*:/ {
    cur = 0
    if ($0 !~ /^specifies:/) next
    cur = 1; v = $0; sub(/^specifies:/, "", v); v = trim(v); sub(/[[:space:]]+#.*$/, "", v)
    if (v == "" || v == "[]") next
    if (v ~ /^\[.*\]$/) flow(v); else item(v)
    next
}
dashes == 1 && cur && /^[[:space:]]*-/ { v = $0; sub(/^[[:space:]]*-[[:space:]]*/, "", v); item(v) }
'
# Specs not yet committed count too: the spec-first gate runs after a spec is
# written and before anything is committed.
SPEC_CANDIDATES="$TRACKED"
if $IN_GIT; then
    SPEC_CANDIDATES="$(git ls-files --cached --others --exclude-standard -- '*.spec.md' | LC_ALL=C sort -u)"
fi
SPEC_FILES=()
while IFS= read -r f; do
    [[ -n "$f" && -f "$f" && "$f" == *.spec.md && "$f" != *sync-conflict* ]] || continue
    grep -m1 -qE '^vendored-from: ' "$f" 2>/dev/null && continue
    # An archived or transient spec governs nothing
    case "/$f" in */var/*|*/generated/*|*/.archive/*|*/build/*|*/dist/*|*/worktrees/*) continue ;; esac
    SPEC_FILES+=("$f")
done <<< "$SPEC_CANDIDATES"

PATTERNS=""
if (( ${#SPEC_FILES[@]} )); then
    while IFS=$'\t' read -r spec value; do
        [[ -n "$value" ]] || continue
        value="${value#./}"
        if [[ "$value" == *[\*\?\[]* ]]; then kind=glob
        elif [[ "$value" == */ || -d "$value" ]]; then kind=dir
        else kind="file"
        fi
        PATTERNS+="P"$'\t'"$spec"$'\t'"$value"$'\t'"$kind"$'\n'
    done < <(awk -v SQ="'" "$SPECIFIES_AWK" "${SPEC_FILES[@]}")
fi

# Match paths against patterns: G file spec for each match, C spec value count.
MATCH_AWK='
function esc(s,    i, c, out) {
    out = ""
    for (i = 1; i <= length(s); i++) { c = substr(s, i, 1); if (index(".+(){}|^$[]\\*?", c)) out = out "\\" c; else out = out c }
    return out
}
function glob2re(g,    i, c, re, j) {
    re = "^"
    for (i = 1; i <= length(g); i++) {
        c = substr(g, i, 1)
        if (c == "*" && substr(g, i + 1, 1) == "*") {
            if (substr(g, i + 2, 1) == "/") { re = re "(.*/)?"; i += 2 } else { re = re ".*"; i++ }
        } else if (c == "*") re = re "[^/]*"
        else if (c == "?") re = re "[^/]"
        else if (c == "[") {
            j = index(substr(g, i + 1), "]")
            if (j > 0) { re = re substr(g, i, j + 1); i += j } else re = re "\\["
        }
        else re = re esc(c)
    }
    return re "$"
}
BEGIN { FS = "\t" }
$1 == "P" {
    n++; ps[n] = $2; pv[n] = $3; v = $3; sub(/\/$/, "", v)
    if ($4 == "glob") re[n] = glob2re(v)
    else if ($4 == "dir") re[n] = "^" esc(v) "/"
    else re[n] = "^" esc(v) "$"
    next
}
$1 == "F" { for (i = 1; i <= n; i++) if ($2 ~ re[i]) { print "G\t" $2 "\t" ps[i]; hits[i]++ }; next }
END { for (i = 1; i <= n; i++) print "C\t" ps[i] "\t" pv[i] "\t" (hits[i] + 0) }
'

match_paths() {   # match_paths <newline-separated paths>
    { printf '%s' "$PATTERNS"; while IFS= read -r p; do [[ -n "$p" ]] && printf 'F\t%s\n' "$p"; done <<< "$1"; } \
        | awk "$MATCH_AWK"
}

# --- --which: one path, which need not exist ---
if [[ -n "$WHICH" ]]; then
    WHICH="$(norm "$WHICH")"
    if reason="$(exempt_reason "$WHICH")"; then
        printf 'exempt\t%s\n' "$reason"
        exit 0
    fi
    governing="$(match_paths "$WHICH" | awk -F'\t' '$1 == "G" { print $3 }' | LC_ALL=C sort -u)"
    [[ -n "$governing" ]] || exit 1
    while IFS= read -r s; do printf 'spec\t%s\n' "$s"; done <<< "$governing"
    exit 0
fi

# --- Coverage report ---
CANDIDATES=""
while IFS= read -r f; do
    [[ -n "$f" ]] || continue
    exempt_reason "$f" >/dev/null || CANDIDATES+="$f"$'\n'
done <<< "$TRACKED"

MATCHED="$(match_paths "$TRACKED")"

# U file | M file spec, spec | D spec value | MAP spec file | SUM files governed
REPORT="$(
    { while IFS= read -r f; do [[ -n "$f" ]] && printf 'K\t%s\n' "$f"; done <<< "$CANDIDATES"
      printf '%s\n' "$MATCHED"; } | awk -F'\t' '
    $1 == "K" { cand[$2] = 1; order[++nc] = $2; next }
    $1 == "G" {
        if (!(($2, $3) in seen)) { seen[$2, $3] = 1; gov[$2] = (gov[$2] == "") ? $3 : gov[$2] ", " $3; ng[$2]++ }
        print "MAP\t" $3 "\t" $2; next
    }
    $1 == "C" { if ($4 == 0) print "D\t" $2 "\t" $3; next }
    END {
        for (i = 1; i <= nc; i++) {
            f = order[i]
            if (!(f in ng)) print "U\t" f
            else { governed++; if (ng[f] > 1) print "M\t" f "\t" gov[f] }
        }
        print "SUM\t" (nc + 0) "\t" (governed + 0)
    }' | LC_ALL=C sort -u
)"

IFS=$'\t' read -r _ FILES GOVERNED < <(grep $'^SUM\t' <<< "$REPORT")
PCT=0; (( FILES > 0 )) && PCT=$(( GOVERNED * 100 / FILES ))

echo "Validating coverage..."
echo ""
echo "Governed: $GOVERNED of $FILES files that need a spec (${PCT}%)"

if grep -q $'^U\t' <<< "$REPORT"; then
    echo ""
    if $VERBOSE; then
        echo "Not governed by any spec's specifies:"
        grep $'^U\t' <<< "$REPORT" | cut -f2 | sed 's/^/  /'
    else
        echo "Not governed, by top-level folder (--verbose lists every file):"
        grep $'^U\t' <<< "$REPORT" | cut -f2 | awk -F/ '{ print (NF > 1) ? $1 "/" : "(root)" }' \
            | LC_ALL=C sort | uniq -c | LC_ALL=C sort -k1,1rn -k2,2 \
            | awk '{ printf "  %-24s %d\n", $2, $1 }'
    fi
fi
if grep -q $'^M\t' <<< "$REPORT"; then
    echo ""
    echo "Governed by more than one spec:"
    grep $'^M\t' <<< "$REPORT" | awk -F'\t' '{ print "  " $2 ": " $3 }'
fi
if grep -q $'^D\t' <<< "$REPORT"; then
    echo ""
    echo "specifies: values matching no tracked file:"
    grep $'^D\t' <<< "$REPORT" | awk -F'\t' '{ print "  " $2 ": " $3 }'
fi

if $JSON; then
    while IFS=$'\t' read -r tag a b; do
        case "$tag" in
            U) vo_finding warning ungoverned "$a" "" "no spec's specifies: names this file" ;;
            M) vo_finding warning multiply-governed "$a" "" "governed by more than one spec: $b" ;;
            D) vo_finding warning dead-pattern "$a" "$b" "specifies: $b matches no tracked file" ;;
        esac
    done <<< "$REPORT"
    # The governed-set map: each spec and the sorted files its specifies: matches.
    map="{" last="" sep=""
    while IFS=$'\t' read -r _ spec file; do
        if [[ "$spec" != "$last" ]]; then
            [[ -n "$last" ]] && map+="]"
            _vo_esc "$spec"; map+="$sep"$'\n'"    $_VO_E: ["; sep=","; last="$spec"; fsep=""
        fi
        _vo_esc "$file"; map+="$fsep$_VO_E"; fsep=", "
    done < <(grep $'^MAP\t' <<< "$REPORT" | LC_ALL=C sort -t $'\t' -k2,2 -k3,3)
    [[ -n "$last" ]] && map+="]"$'\n'"  "
    map+="}"
    vo_extra governed "$map"
    vo_extra coverage "{\"files\": $FILES, \"governed\": $GOVERNED}"
fi

echo ""
echo "PASSED: coverage is reported, not enforced"
exit 0
