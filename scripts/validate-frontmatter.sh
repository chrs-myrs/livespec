#!/usr/bin/env bash
# validate-frontmatter.sh — Check all .spec.md files for IMP-005 frontmatter compliance
#
# Usage: bash scripts/validate-frontmatter.sh [--verbose]
# Exit 0: all checks pass
# Exit 1: one or more failures
#
# Specifies: specs/features/mandatory-frontmatter.spec.md

set -uo pipefail

VERBOSE="${1:-}"
ERRORS=0
WARNINGS=0
CHECKED=0

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
get_field() {
    local fm="$1" field="$2"
    echo "$fm" | grep -E "^${field}:" | head -1 | sed "s/^${field}:[[:space:]]*//"
}

has_field() {
    local fm="$1" field="$2"
    echo "$fm" | grep -qE "^${field}:" 2>/dev/null
}

# Get category from directory path
category_from_path() {
    local path="$1"
    echo "$path" | sed 's|specs/||' | cut -d'/' -f1
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
        elif [[ "$val" != "$expected_cat" ]]; then
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

    # Check for metaspec refs in governed-by (only check list items directly under governed-by)
    in_governed_by=false
    while IFS= read -r line; do
        if [[ "$line" =~ ^governed-by: ]]; then
            in_governed_by=true
            # Check inline value (governed-by: .livespec/...)
            if echo "$line" | grep -q ".livespec/standard/metaspecs/"; then
                [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                warn "governed-by contains metaspec reference (should be content governance only)"
            fi
            continue
        fi
        if [[ "$in_governed_by" == true ]]; then
            if [[ "$line" =~ ^[[:space:]]+-[[:space:]] ]]; then
                if echo "$line" | grep -q ".livespec/standard/metaspecs/"; then
                    [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                    warn "governed-by contains metaspec reference (should be content governance only)"
                fi
            else
                in_governed_by=false
            fi
        fi
    done <<< "$fm"

    # Check for underscore field names
    if echo "$fm" | grep -qE "^derives_from:|^governed_by:"; then
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
                    fi
                done
            fi
        done
    fi

done < <(find specs/ -name "*.spec.md" -type f | sort)

echo ""
echo "Summary:"
echo "  Files checked: $CHECKED"
echo "  Errors:        $ERRORS"
echo "  Warnings:      $WARNINGS"

if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo "FAILED: $ERRORS error(s) found"
    exit 1
else
    echo ""
    echo "PASSED: All frontmatter checks passed"
    exit 0
fi
