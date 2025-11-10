#!/usr/bin/env bash
#
# Spec Purity Detection
#
# Detects executable implementation code in specification files (1-requirements/ and 2-strategy/).
# Enforces WHAT-not-HOW principle by flagging procedural code in declarative specs.
#
# Usage:
#   ./scripts/detect-code-in-specs.sh
#
# Exit codes:
#   0 - No violations found
#   1 - Implementation code detected in specs

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Executable code patterns (procedural)
CODE_PATTERNS=(
    'def '
    'function '
    'const.*='
    'if.*:'
    'if.*{'
    'for.*in'
    'for.*{'
    'while.*{'
    'return '
    'cache_key.*='
    '\.push\('
    '\.map\('
    '\.filter\('
)

# Declarative patterns (allowed)
ALLOWED_PATTERNS=(
    '^```json'
    '^```yaml'
    '^```mermaid'
)

# Counters
specs_checked=0
specs_with_violations=0
total_violations=0

echo "Detecting code in specifications..."
echo ""

# Create temp file to store violations
violations_file=$(mktemp)
trap "rm -f $violations_file" EXIT

# Directories to check (strict enforcement)
STRICT_DIRS=("specs/1-requirements" "specs/2-strategy")

echo "Checking requirements and strategy specs (strict WHAT-not-HOW enforcement)..."
echo ""

# Check each directory
for dir in "${STRICT_DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        echo "  Skipping $dir (doesn't exist)"
        continue
    fi

    # Find all spec files
    find "$dir" -name "*.spec.md" -type f 2>/dev/null | while read -r spec_file; do
        specs_checked=$((specs_checked + 1))
        file_violations=0

        # Extract code blocks (content between triple backticks)
        in_code_block=0
        block_start=0
        block_lang=""
        line_num=0

        while IFS= read -r line; do
            line_num=$((line_num + 1))

            # Detect start of code block
            if [[ "$line" =~ ^\`\`\`([a-z]*) ]]; then
                if [[ $in_code_block -eq 0 ]]; then
                    in_code_block=1
                    block_start=$line_num
                    block_lang="${BASH_REMATCH[1]}"
                    continue
                else
                    # End of code block
                    in_code_block=0
                    continue
                fi
            fi

            # If in code block, check for executable patterns
            if [[ $in_code_block -eq 1 ]]; then
                # Skip if declarative language
                is_declarative=0
                block_with_ticks="\`\`\`$block_lang"
                for allowed in "${ALLOWED_PATTERNS[@]}"; do
                    if [[ "$block_with_ticks" =~ $allowed ]]; then
                        is_declarative=1
                        break
                    fi
                done

                if [[ $is_declarative -eq 1 ]]; then
                    continue
                fi

                # Check for executable code patterns
                for pattern in "${CODE_PATTERNS[@]}"; do
                    if echo "$line" | grep -qE "$pattern"; then
                        file_violations=$((file_violations + 1))
                        total_violations=$((total_violations + 1))
                        echo "$spec_file|$line_num|$block_lang|$pattern|$line" >> "$violations_file"
                    fi
                done
            fi
        done < "$spec_file"

        if [[ $file_violations -gt 0 ]]; then
            specs_with_violations=$((specs_with_violations + 1))
        fi
    done
done

# Count results
total_specs=$(find specs/1-requirements specs/2-strategy -name "*.spec.md" -type f 2>/dev/null | wc -l)
violation_count=$(wc -l < "$violations_file" 2>/dev/null || echo "0")

echo "==================================================================="
echo "Spec Purity Detection Results"
echo "==================================================================="
echo "Specs checked: $total_specs"
echo "Specs with code violations: $(cut -d'|' -f1 "$violations_file" 2>/dev/null | sort -u | wc -l)"
echo "Total code patterns detected: $violation_count"
echo ""

if [[ $violation_count -gt 0 ]]; then
    echo -e "${RED}✗ FAIL: Implementation code found in specifications${NC}"
    echo ""
    echo "Violations (grouped by file):"
    echo ""

    # Group violations by file
    cut -d'|' -f1 "$violations_file" | sort -u | while read -r file; do
        echo "  $file"
        grep "^$file|" "$violations_file" | while IFS='|' read -r f line lang pattern code; do
            echo "    Line $line ($lang): $pattern"
            echo "      > $(echo "$code" | xargs)"
        done
        echo ""
    done

    echo "Why this is a problem:"
    echo "  - Specifications should describe WHAT, not HOW"
    echo "  - Implementation details belong in code, not specs"
    echo "  - Procedural code creates maintenance burden"
    echo "  - Violates MSL Minimalism principle"
    echo ""
    echo "Remediation:"
    echo "  1. Remove code blocks from requirements/strategy specs"
    echo "  2. State requirements declaratively"
    echo "  3. Move implementation details to actual code files"
    echo ""
    echo "Examples:"
    echo "  ✗ 'cache_key = hash(dimensions)'"
    echo "  ✓ 'Cache keyed by taxonomy dimensions'"
    echo ""
    echo "  ✗ 'if mtime > cache_mtime: clear()'"
    echo "  ✓ 'Cache invalidated when policies modified'"
    echo ""
    echo "  ✗ 'for policy in policies: validate()'"
    echo "  ✓ 'System validates all applicable policies'"
    echo ""
    echo "Acceptable code in specs:"
    echo "  - JSON/YAML examples (declarative config)"
    echo "  - API examples in 3-contracts/ (interface definitions)"
    echo "  - Mermaid diagrams"
    echo ""
    exit 1
else
    echo -e "${GREEN}✓ PASS: No implementation code in specifications${NC}"
    echo ""
    echo "Requirements and strategy specs are declarative (WHAT not HOW)."
    exit 0
fi
