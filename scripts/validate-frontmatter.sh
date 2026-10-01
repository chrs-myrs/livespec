#!/usr/bin/env bash
# validate-frontmatter.sh — Check all .spec.md files for IMP-005 frontmatter compliance
#
# Usage: bash scripts/validate-frontmatter.sh [--verbose] [--strict] [path...]
#   path      tree to scan for *.spec.md, or a single spec file (default: specs/)
#   --strict  promote empty-mandatory-field warnings to errors
# Exit 0: all checks pass
# Exit 1: one or more failures
# Exit 2: usage error
#
# Specifies: specs/features/mandatory-frontmatter.spec.md

set -uo pipefail

VERBOSE=""
STRICT=""
SPEC_ROOTS=()

for arg in "$@"; do
    case "$arg" in
        --verbose) VERBOSE="--verbose" ;;
        --strict)  STRICT="--strict" ;;
        -*)        echo "Unknown option: $arg" >&2
                   echo "Usage: $0 [--verbose] [--strict] [path...]" >&2
                   exit 2 ;;
        *)         SPEC_ROOTS+=("$arg") ;;
    esac
done

(( ${#SPEC_ROOTS[@]} )) || SPEC_ROOTS=(specs/)

for root in "${SPEC_ROOTS[@]}"; do
    if [[ ! -e "$root" ]]; then
        echo "ERROR: no such file or directory: $root" >&2
        exit 2
    fi
done

ERRORS=0
WARNINGS=0
CHECKED=0
EMPTY_MANDATORY=0

# Allowed values (canonical source: references/standards/vocabulary.spec.md)
VALID_TYPES="outcomes constraints strategy behavior contract workspace taxonomy prompt agent validator diagram command registry domain-model purpose"
VALID_CATEGORIES="workspace foundation strategy features interfaces artifacts"
VALID_FIDELITY="full-detail behavioral decisions-only process"
VALID_CRITICALITY="CRITICAL IMPORTANT"

# Per-category mandatory fields (beyond base 6)
# Format: category:field1,field2
CATEGORY_FIELDS=(
    "workspace:applies_to"
    "foundation:derives-from,supports"
    "strategy:derives-from"
    "features:satisfies,guided-by"
    "interfaces:supports"
    "artifacts:specifies"
)

# Relationship graph population, counted only where the field is mandatory for
# the spec's own category (declared - populated == empty-field reports)
MANDATORY_FIELDS="applies_to derives-from supports satisfies guided-by specifies"
declare -A FIELD_DECLARED FIELD_POPULATED
for f in $MANDATORY_FIELDS; do
    FIELD_DECLARED[$f]=0
    FIELD_POPULATED[$f]=0
done

error() {
    echo "  ERROR: $1"
    ((ERRORS++))
}

warn() {
    echo "  WARN:  $1"
    ((WARNINGS++))
}

verbose() {
    [[ "$VERBOSE" == "--verbose" ]] && echo "  OK:    $1"
}

# Extract a YAML field value from frontmatter text
# Handles both single-value and list fields (returns first line only for lists)
# NOTE: these deliberately avoid pipelines. `echo "$fm" | grep -q ...` sends
# SIGPIPE to echo when grep exits on first match; with `set -o pipefail` the
# pipeline returns 141 and a field that IS present reads as missing. That race
# fires under load and produced intermittent false "Missing required field"
# errors. Pure bash is both correct and far faster.
get_field() {
    local fm="$1" field="$2" line
    while IFS= read -r line; do
        if [[ "$line" == "$field":* ]]; then
            trim "${line#"$field":}"
            return 0
        fi
    done <<< "$fm"
    return 0
}

has_field() {
    local fm="$1" field="$2"
    [[ $'\n'"$fm" == *$'\n'"$field":* ]]
}

trim() {
    local v="$1"
    v="${v#"${v%%[![:space:]]*}"}"
    v="${v%"${v##*[![:space:]]}"}"
    printf '%s' "$v"
}

# True when a declared field carries no values. Structural: covers both
# `field: []` and a bare `field:` with no list items beneath it.
field_is_empty() {
    local fm="$1" field="$2"
    local in_field=false found=false val
    while IFS= read -r line; do
        if [[ "$line" =~ ^${field}: ]]; then
            in_field=true
            val=$(trim "${line#*:}")
            if [[ -n "$val" && "$val" != "[]" ]]; then
                found=true
                break
            fi
            continue
        fi
        if [[ "$in_field" == true ]]; then
            if [[ "$line" =~ ^[[:space:]]+-[[:space:]] ]]; then
                val=$(trim "${line#*-}")
                if [[ -n "$val" ]]; then
                    found=true
                    break
                fi
            else
                in_field=false
            fi
        fi
    done <<< "$fm"
    [[ "$found" == false ]]
}

# Get category from directory path
# Category is the directory immediately under the specs/ path segment.
# Must match specs/ as a whole segment — metaspecs/ also ends in "specs/".
category_from_path() {
    local path="$1" rest="$1"
    [[ "$path" =~ (^|/)specs/(.*)$ ]] && rest="${BASH_REMATCH[2]}"
    echo "$rest" | cut -d'/' -f1
}

# The category-matches-directory rule is an invariant of the specs/ tree only;
# spec-shaped files living elsewhere (lib/, scripts/) have no such directory
under_specs_tree() {
    [[ "$1" =~ (^|/)specs/ ]]
}

echo "Validating spec frontmatter (IMP-005)..."
echo ""

# Find all .spec.md files, excluding sync-conflict files
while IFS= read -r specfile; do
    [[ "$specfile" == *"sync-conflict"* ]] && continue

    ((CHECKED++))

    # Extract frontmatter (first --- block only)
    fm=$(awk '/^---$/{n++; if(n==2) exit; next} n==1{print}' "$specfile")

    if [[ -z "$fm" ]]; then
        echo "$specfile:"
        error "No YAML frontmatter found"
        continue
    fi

    has_errors=false

    # --- Base 6 fields ---

    # 1. type
    if has_field "$fm" "type"; then
        val=$(get_field "$fm" "type")
        if ! echo "$VALID_TYPES" | grep -qw "$val"; then
            has_errors=true
            [[ "$has_errors" == "true" ]] && { echo "$specfile:"; has_errors=shown; }
            error "type '$val' not in allowed values"
        fi
    else
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        error "Missing required field: type"
    fi

    # 2. category
    expected_cat=$(category_from_path "$specfile")
    if has_field "$fm" "category"; then
        val=$(get_field "$fm" "category")
        if ! echo "$VALID_CATEGORIES" | grep -qw "$val"; then
            [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
            error "category '$val' not in allowed values"
        elif under_specs_tree "$specfile" && [[ "$val" != "$expected_cat" ]]; then
            [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
            error "category '$val' does not match directory '$expected_cat'"
        fi
    else
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        error "Missing required field: category"
    fi

    # 3. fidelity
    if has_field "$fm" "fidelity"; then
        val=$(get_field "$fm" "fidelity")
        if ! echo "$VALID_FIDELITY" | grep -qw "$val"; then
            [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
            error "fidelity '$val' not in allowed values"
        fi
    else
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        error "Missing required field: fidelity"
    fi

    # 4. criticality
    if has_field "$fm" "criticality"; then
        val=$(get_field "$fm" "criticality")
        if ! echo "$VALID_CRITICALITY" | grep -qw "$val"; then
            [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
            error "criticality '$val' not in allowed values"
        fi
    else
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        error "Missing required field: criticality"
    fi

    # 5. failure_mode
    if ! has_field "$fm" "failure_mode"; then
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        error "Missing required field: failure_mode"
    fi

    # 6. governed-by
    if ! has_field "$fm" "governed-by"; then
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        error "Missing required field: governed-by"
    fi

    # --- Warnings ---

    # Check for metaspec refs in governed-by (only check list items directly under governed-by).
    # Older versions planted pre-schema metaspec copies under references/templates/
    # and *.metaspec.md names; neither contains "metaspecs/".
    METASPEC_RE='metaspecs/|references/templates/|\.metaspec\.md'
    in_governed_by=false
    while IFS= read -r line; do
        if [[ "$line" =~ ^governed-by: ]]; then
            in_governed_by=true
            # Check inline value (governed-by: .livespec/...)
            if grep -qE "$METASPEC_RE" <<< "$line"; then
                [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                warn "governed-by contains metaspec reference (should be content governance only)"
            fi
            continue
        fi
        if [[ "$in_governed_by" == true ]]; then
            if [[ "$line" =~ ^[[:space:]]+-[[:space:]] ]]; then
                if grep -qE "$METASPEC_RE" <<< "$line"; then
                    [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                    warn "governed-by contains metaspec reference (should be content governance only)"
                fi
            else
                in_governed_by=false
            fi
        fi
    done <<< "$fm"

    # Check for underscore field names
    if grep -qE "^derives_from:|^governed_by:" <<< "$fm"; then
        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
        warn "Underscore field name detected (use hyphens: derives-from, governed-by)"
    fi

    # --- Per-category mandatory fields ---
    if has_field "$fm" "category"; then
        cat_val=$(get_field "$fm" "category")
        for entry in "${CATEGORY_FIELDS[@]}"; do
            cat_name="${entry%%:*}"
            fields_str="${entry#*:}"
            if [[ "$cat_val" == "$cat_name" ]]; then
                IFS=',' read -ra fields <<< "$fields_str"
                for field in "${fields[@]}"; do
                    if ! has_field "$fm" "$field"; then
                        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                        error "Missing $cat_name-mandatory field: $field"
                        continue
                    fi
                    ((FIELD_DECLARED[$field]++))
                    if field_is_empty "$fm" "$field"; then
                        ((EMPTY_MANDATORY++))
                        [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                        if [[ "$STRICT" == "--strict" ]]; then
                            error "Empty $cat_name-mandatory field: $field (declared, no values)"
                        else
                            warn "Empty $cat_name-mandatory field: $field (declared, no values)"
                        fi
                    else
                        ((FIELD_POPULATED[$field]++))
                        verbose "$field populated"
                    fi
                done
            fi
        done
    fi

done < <(find "${SPEC_ROOTS[@]}" -name "*.spec.md" -type f | sort -u)

echo ""
echo "Relationship graph population (fields mandatory for the spec's category):"
graph_shown=false
for f in $MANDATORY_FIELDS; do
    declared=${FIELD_DECLARED[$f]}
    [[ $declared -eq 0 ]] && continue
    graph_shown=true
    printf "  %-14s %3d / %-3d populated\n" "$f" "${FIELD_POPULATED[$f]}" "$declared"
done
[[ "$graph_shown" == false ]] && echo "  (no per-category mandatory fields declared in this tree)"

if [[ ${FIELD_DECLARED[specifies]} -gt ${FIELD_POPULATED[specifies]} ]]; then
    echo ""
    echo "  Note: an empty 'specifies' has no substitute field — those artifact specs"
    echo "        have no machine-checkable link to the deliverable they govern."
fi

echo ""
echo "Summary:"
if (( ${#SPEC_ROOTS[@]} == 1 )); then
    echo "  Scanned:       ${SPEC_ROOTS[0]}"
else
    echo "  Scanned:       ${#SPEC_ROOTS[@]} paths"
fi
echo "  Files checked: $CHECKED"
echo "  Errors:        $ERRORS"
echo "  Warnings:      $WARNINGS"
echo "  Empty mandatory fields: $EMPTY_MANDATORY"
[[ "$STRICT" != "--strict" && $EMPTY_MANDATORY -gt 0 ]] && \
    echo "  (re-run with --strict to fail on empty mandatory fields)"

if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo "FAILED: $ERRORS error(s) found"
    exit 1
else
    echo ""
    echo "PASSED: All frontmatter checks passed"
    exit 0
fi
