#!/usr/bin/env bash
# validate-crossrefs.sh — Check all spec frontmatter relationship targets exist
#
# Usage: bash scripts/validate-crossrefs.sh [--verbose] [path]
#   path  tree to scan for *.spec.md (default: specs/)
# Exit 0: all references valid
# Exit 1: broken references found
# Exit 2: usage error
#
# Specifies: specs/features/validation/cross-reference-validation.spec.md

set -uo pipefail

VERBOSE=""
SPEC_ROOT=""

for arg in "$@"; do
    case "$arg" in
        --verbose) VERBOSE="--verbose" ;;
        -*)        echo "Unknown option: $arg" >&2
                   echo "Usage: $0 [--verbose] [path]" >&2
                   exit 2 ;;
        *)         SPEC_ROOT="$arg" ;;
    esac
done

SPEC_ROOT="${SPEC_ROOT:-specs/}"

if [[ ! -d "$SPEC_ROOT" ]]; then
    echo "ERROR: not a directory: $SPEC_ROOT" >&2
    exit 2
fi

ERRORS=0
CHECKED=0
REFS_CHECKED=0
FIELDS_DECLARED=0
FIELDS_EMPTY=0

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
        field_declared=false
        field_has_value=false
        while IFS= read -r line; do
            if [[ "$line" =~ ^${field}: ]]; then
                in_field=true
                field_declared=true
                # Check inline value (field: value)
                inline_val=$(echo "$line" | sed "s/^${field}:[[:space:]]*//" | xargs)
                if [[ -n "$inline_val" && "$inline_val" != "[]" ]]; then
                    field_has_value=true
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
                    [[ -n "$item_val" ]] && field_has_value=true
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

        # A declared field carrying no values resolves nothing — count it rather
        # than skipping silently, so references-checked is not read as coverage
        if [[ "$field_declared" == true ]]; then
            ((FIELDS_DECLARED++))
            [[ "$field_has_value" == false ]] && ((FIELDS_EMPTY++))
        fi
    done

done < <(find "$SPEC_ROOT" -name "*.spec.md" -type f | sort)

echo ""
echo "Summary:"
echo "  Scanned:             $SPEC_ROOT"
echo "  Files checked:       $CHECKED"
echo "  Relationship fields: $FIELDS_DECLARED declared, $FIELDS_EMPTY empty"
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
