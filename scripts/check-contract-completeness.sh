#!/usr/bin/env bash
#
# Contract Completeness Validation
#
# Validates that every parameter in contract specifications has a corresponding
# behavior specification reference.
#
# Usage:
#   ./scripts/check-contract-completeness.sh [path]
#
# Exit codes:
#   0 - All contracts complete
#   1 - Incomplete contracts found

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
contracts_checked=0
parameters_found=0
missing_references=0
errors=()

# Target path (default to specs/3-contracts if not provided)
TARGET_PATH="${1:-specs/3-contracts}"

# Check if target exists
if [[ ! -e "$TARGET_PATH" ]]; then
    echo -e "${RED}ERROR: Path not found: $TARGET_PATH${NC}"
    exit 1
fi

# Function to check if a parameter has behavior reference
check_parameter_reference() {
    local file="$1"
    local param_name="$2"
    local context="$3"

    # Look for behavior reference near parameter definition
    # Patterns we look for:
    # - Inline: "- Behavior: specs/3-behaviors/..."
    # - Inline: "- Spec: specs/3-behaviors/..."
    # - Frontmatter: satisfies/implements referencing behavior spec

    # Check inline reference (within 2 lines of parameter)
    if grep -A 2 -E "^\s*-\s+\`?${param_name}\`?" "$file" | grep -qE "(Behavior|Spec|behavior|spec):\s*specs/3-behaviors/"; then
        return 0  # Found reference
    fi

    # Check frontmatter for satisfies/implements
    if head -n 20 "$file" | grep -qE "^(satisfies|implements):" && \
       head -n 20 "$file" | grep -qE "specs/3-behaviors/"; then
        # Has frontmatter reference - consider complete for now
        # (Could be stricter and require per-parameter refs)
        return 0
    fi

    # No reference found
    return 1
}

# Function to extract parameters from contract file
extract_parameters() {
    local file="$1"

    # Look for parameter definitions (various formats):
    # - `param_name` (required): Description
    # - `param_name` (optional): Description
    # - param_name (required): Description
    # - **param_name**: Description

    grep -nE '^\s*[-*]\s+(`[^`]+`|\*\*[^*]+\*\*|[a-z_][a-z0-9_]*)\s*\(' "$file" || true
}

# Function to process a single contract file
process_contract() {
    local file="$1"

    ((contracts_checked++))

    # Extract parameters
    local params
    params=$(extract_parameters "$file")

    if [[ -z "$params" ]]; then
        # No parameters found - might be different format or no params
        return 0
    fi

    # Process each parameter
    local file_has_errors=0
    while IFS= read -r param_line; do
        ((parameters_found++))

        # Extract parameter name from line
        # Handle: `param`, **param**, or plain param
        local param_name
        param_name=$(echo "$param_line" | sed -E 's/^[^`*a-z]*[`*]*([a-z_][a-z0-9_]*)[`*]*.*/\1/')

        # Check if parameter has behavior reference
        if ! check_parameter_reference "$file" "$param_name" "$param_line"; then
            ((missing_references++))

            if [[ $file_has_errors -eq 0 ]]; then
                # First error in this file - print file header
                errors+=("")
                errors+=("${RED}ERROR: Contract parameters without behavior specs:${NC}")
                errors+=("  File: $file")
                file_has_errors=1
            fi

            errors+=("    Parameter: ${YELLOW}$param_name${NC} - Missing behavior reference")
        fi
    done <<< "$params"

    if [[ $file_has_errors -eq 1 ]]; then
        errors+=("  ${YELLOW}Fix: Add behavior reference for each parameter${NC}")
        errors+=("  Example: - \`$param_name\` (required): Description")
        errors+=("           - Behavior: specs/3-behaviors/feature.spec.md#section")
    fi
}

# Main execution
echo "Checking contract completeness..."
echo "Target: $TARGET_PATH"
echo ""

# Find all contract spec files
if [[ -f "$TARGET_PATH" ]]; then
    # Single file
    process_contract "$TARGET_PATH"
elif [[ -d "$TARGET_PATH" ]]; then
    # Directory - find all .spec.md files
    while IFS= read -r file; do
        process_contract "$file"
    done < <(find "$TARGET_PATH" -name "*.spec.md" -type f)
fi

# Print results
echo ""
echo "==================================================================="
echo "Contract Completeness Validation Results"
echo "==================================================================="
echo "Contracts checked: $contracts_checked"
echo "Parameters found: $parameters_found"
echo "Missing references: $missing_references"
echo ""

if [[ $missing_references -gt 0 ]]; then
    # Print accumulated errors
    for error in "${errors[@]}"; do
        echo -e "$error"
    done
    echo ""
    echo -e "${RED}✗ FAIL: $missing_references parameter(s) without behavior references${NC}"
    echo ""
    echo "Each contract parameter must reference a behavior spec that documents:"
    echo "  - What the parameter does"
    echo "  - Validation rules"
    echo "  - Edge cases"
    echo ""
    exit 1
else
    echo -e "${GREEN}✓ PASS: All contract parameters have behavior references${NC}"
    exit 0
fi
