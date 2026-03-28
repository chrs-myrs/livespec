#!/usr/bin/env bash
# validate-crossrefs.sh — Check all spec frontmatter relationship targets exist
#
# Usage: bash scripts/validate-crossrefs.sh [--verbose]
# Exit 0: all references valid
# Exit 1: broken references found
#
# Specifies: specs/features/validation/cross-reference-validation.spec.md

set -uo pipefail

VERBOSE="${1:-}"
ERRORS=0
CHECKED=0
REFS_CHECKED=0

# Relationship fields to check
REF_FIELDS="governed-by satisfies guided-by derives-from supports specifies implements extends informed-by supersedes updated-by"

# Values that are NOT file paths (skip these)
is_path() {
    local val="$1"
    # Skip empty, non-path values
    [[ -z "$val" ]] && return 1
    [[ "$val" == "[]" ]] && return 1
    [[ "$val" == ":" ]] && return 1
    # Skip known non-path values
    [[ "$val" == "all_projects" ]] && return 1
    [[ "$val" == "this_project" ]] && return 1
    [[ "$val" == "moderate" ]] && return 1
    # Skip descriptive strings (no / or . in path)
    [[ "$val" != *"/"* && "$val" != *".spec"* && "$val" != *".md"* && "$val" != *".sh"* ]] && return 1
    return 0
}

# Strip parenthetical annotations: "specs/foo.spec.md (Requirement 1: Name)" → "specs/foo.spec.md"
strip_annotation() {
    local val="$1"
    echo "$val" | sed 's/ (.*$//'
}

verbose() {
    [[ "$VERBOSE" == "--verbose" ]] && echo "  OK: $1"
}

echo "Validating cross-references..."
echo ""

while IFS= read -r specfile; do
    [[ "$specfile" == *"sync-conflict"* ]] && continue
    ((CHECKED++))

    # Extract frontmatter (first --- block only)
    fm=$(awk '/^---$/{n++; if(n==2) exit; next} n==1{print}' "$specfile")
    [[ -z "$fm" ]] && continue

    has_errors=false

    for field in $REF_FIELDS; do
        # Extract values for this field
        in_field=false
        while IFS= read -r line; do
            if [[ "$line" =~ ^${field}: ]]; then
                in_field=true
                # Check inline value (field: value)
                inline_val=$(echo "$line" | sed "s/^${field}:[[:space:]]*//" | xargs)
                if [[ -n "$inline_val" && "$inline_val" != "[]" ]]; then
                    clean=$(strip_annotation "$inline_val")
                    if is_path "$clean"; then
                        ((REFS_CHECKED++))
                        if [[ ! -e "$clean" ]]; then
                            [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                            echo "  BROKEN: $field → $clean"
                            ((ERRORS++))
                        else
                            verbose "$field → $clean"
                        fi
                    fi
                fi
                continue
            fi
            if [[ "$in_field" == true ]]; then
                if [[ "$line" =~ ^[[:space:]]+-[[:space:]] ]]; then
                    # List item — extract value
                    item_val=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//' | xargs)
                    clean=$(strip_annotation "$item_val")
                    if is_path "$clean"; then
                        ((REFS_CHECKED++))
                        if [[ ! -e "$clean" ]]; then
                            [[ "$has_errors" != "shown" ]] && { echo "$specfile:"; has_errors=shown; }
                            echo "  BROKEN: $field → $clean"
                            ((ERRORS++))
                        else
                            verbose "$field → $clean"
                        fi
                    fi
                else
                    in_field=false
                fi
            fi
        done <<< "$fm"
    done

done < <(find specs/ -name "*.spec.md" -type f | sort)

echo ""
echo "Summary:"
echo "  Files checked:      $CHECKED"
echo "  References checked:  $REFS_CHECKED"
echo "  Broken references:   $ERRORS"

if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo "FAILED: $ERRORS broken reference(s) found"
    exit 1
else
    echo ""
    echo "PASSED: All cross-references valid"
    exit 0
fi
