#!/usr/bin/env bash
# validate-registries.sh — Check registries/ against registry-specs.spec.md
#
# Usage: bash scripts/validate-registries.sh [--verbose] [--json]
#   --json  machine-readable output (specs/interfaces/formats/validator-output.spec.md)
# Exit 0: all checks pass (warnings allowed)
# Exit 1: one or more errors
#
# Specifies: scripts/validate-registries.spec.md
# Governs:   specs/features/registry-specs.spec.md

set -uo pipefail

VERBOSE=""
JSON=false
for arg in "$@"; do
    case "$arg" in
        --verbose) VERBOSE="--verbose" ;;
        --json)    JSON=true ;;
        *)         echo "Usage: $0 [--verbose] [--json]" >&2; exit 2 ;;
    esac
done

if $JSON; then
    VO_HELPER="$(dirname "${BASH_SOURCE[0]}")/validator-output.sh"
    [[ -f "$VO_HELPER" ]] || { echo "ERROR: --json needs $VO_HELPER" >&2; exit 2; }
    # shellcheck source=validator-output.sh
    source "$VO_HELPER"
    vo_init validate-registries
fi

ERRORS=0
WARNINGS=0

REG_DIR="registries"
REQUIRED_TYPES="decisions debt security"
STALE_DAYS=90   # 3 months

# type -> expected ID prefix
prefix_for() {
    case "$1" in
        decisions) echo "DEC" ;;
        debt) echo "DEBT" ;;
        security) echo "SEC" ;;
        conflicts) echo "CON" ;;
        gaps) echo "GAP" ;;
        dependencies) echo "DEP" ;;
        issues) echo "ISSUE" ;;
        *) echo "" ;;
    esac
}

# Work-item verbs that signal a ticket, not a state observation
WORKITEM_RE='^(implement|fix|add|refactor|resolve|try|migrate|patch|create|build|update|remove) '

# error|warn <rule> <path> <subject> <message>: rule codes are part of the output contract
error() { echo "  ERROR: $4"; ((ERRORS++)); $JSON && vo_finding error "$1" "$2" "$3" "$4"; }
warn()  { echo "  WARN:  $4"; ((WARNINGS++)); $JSON && vo_finding warning "$1" "$2" "$3" "$4"; }
# One text line listing every id, one finding per id.
error_each() {
    local id
    echo "  ERROR: $4"; ((ERRORS++))
    $JSON || return 0
    for id in $3; do vo_finding error "$1" "$2" "$id" "$4"; done
}
ok()    { [[ "$VERBOSE" == "--verbose" ]] && echo "  OK:    $1"; return 0; }

if [[ ! -d "$REG_DIR" ]]; then
    echo "ERROR: no $REG_DIR/ directory — run /livespec:init or create required registries"
    $JSON && vo_finding error missing-registry-dir "$REG_DIR" "" "no $REG_DIR/ directory"
    exit 1
fi

echo "Registry validation ($REG_DIR/):"
echo

# --- Required registries exist ---
for t in $REQUIRED_TYPES; do
    if [[ -f "$REG_DIR/$t.md" ]]; then
        ok "required registry present: $t.md"
    else
        error missing-registry "$REG_DIR/$t.md" "" "required registry missing: $REG_DIR/$t.md"
    fi
done

# --- Per-file checks ---
today_epoch=$(date +%s)

for f in "$REG_DIR"/*.md; do
    base=$(basename "$f")
    [[ "$base" == "README.md" ]] && continue
    type="${base%.md}"
    expected_prefix=$(prefix_for "$type")

    if [[ -z "$expected_prefix" ]]; then
        warn unknown-registry-type "$f" "" "$base: unknown registry type '$type' (not in taxonomy)"
        continue
    fi

    # Frontmatter block = lines between first and second '---'
    fm=$(awk 'NR==1&&$0=="---"{f=1;next} f&&$0=="---"{exit} f{print}' "$f")
    # Everything after the SECOND '---'; stays on across body horizontal rules
    body=$(awk 'b{print} $0=="---"{c++; if(c==2)b=1}' "$f")

    # Frontmatter required keys
    grep -q '^store: *registry' <<<"$fm" || error missing-key "$f" store "$base: missing 'store: registry'"
    grep -q "^type: *$type\b" <<<"$fm" || error type-mismatch "$f" "" "$base: 'type' does not match filename ($type)"
    grep -q '^schema_version:' <<<"$fm" || error missing-key "$f" schema_version "$base: missing 'schema_version'"
    grep -q '^entries:' <<<"$fm" || error missing-key "$f" entries "$base: missing 'entries' key"

    # Staleness from last_reviewed
    lr=$(grep -m1 '^last_reviewed:' <<<"$fm" | sed 's/last_reviewed: *//' | tr -d ' ')
    if [[ -z "$lr" ]]; then
        error missing-key "$f" last_reviewed "$base: missing 'last_reviewed'"
    else
        lr_epoch=$(date -d "$lr" +%s 2>/dev/null || echo 0)
        if [[ "$lr_epoch" == "0" ]]; then
            error invalid-date "$f" last_reviewed "$base: last_reviewed '$lr' is not a valid ISO date"
        else
            age_days=$(( (today_epoch - lr_epoch) / 86400 ))
            (( age_days > STALE_DAYS )) && warn stale "$f" "" "$base: stale — last_reviewed $lr ($age_days days ago, >${STALE_DAYS}d)"
        fi
    fi

    # Entry IDs from frontmatter index
    fm_ids=$(grep -oE '^\s*- id: *[A-Z]+-[0-9]+' <<<"$fm" | sed -E 's/.*id: *//' | sort)
    # Section IDs from body ('## PREFIX-NNN: ...')
    body_ids=$(grep -oE '^## *[A-Z]+-[0-9]+' <<<"$body" | sed -E 's/^## *//' | sort)

    # Prefix correctness (frontmatter)
    while read -r id; do
        [[ -z "$id" ]] && continue
        [[ "$id" == "$expected_prefix"-* ]] || error wrong-prefix "$f" "$id" "$base: entry '$id' has wrong prefix (expected $expected_prefix-)"
    done <<<"$fm_ids"

    # Index <-> body sync
    if [[ "$fm_ids" != "$body_ids" ]]; then
        only_fm=$(comm -23 <(echo "$fm_ids") <(echo "$body_ids") | grep -v '^$' || true)
        only_body=$(comm -13 <(echo "$fm_ids") <(echo "$body_ids") | grep -v '^$' || true)
        [[ -n "$only_fm" ]] && error_each index-without-body "$f" "$only_fm" \
            "$base: entries in index without a body section: $(echo $only_fm)"
        [[ -n "$only_body" ]] && error_each body-without-index "$f" "$only_body" \
            "$base: body sections without an index entry: $(echo $only_body)"
    else
        n=$(grep -c '[A-Z]' <<<"$fm_ids"); [[ -z "$fm_ids" ]] && n=0
        ok "$base: index matches body ($n entries)"
    fi

    # Work-item language in summaries
    while IFS=$'\t' read -r id summary; do
        [[ -z "$summary" ]] && continue
        low=$(tr '[:upper:]' '[:lower:]' <<<"$summary")
        if grep -qE "$WORKITEM_RE" <<<"$low"; then
            warn work-item-summary "$f" "$id" "$base: summary reads like a work item, not a state observation: \"$summary\""
        fi
    done < <(awk '/^[[:space:]]*- id:/ {sub(/.*id:[[:space:]]*/, ""); id=$0; next}
                  /^[[:space:]]*summary:/ {sub(/^[[:space:]]*summary:[[:space:]]*/, ""); print id "\t" $0}' <<<"$fm")
done

echo
echo "Registry validation: $ERRORS error(s), $WARNINGS warning(s)"
(( ERRORS > 0 )) && exit 1
exit 0
