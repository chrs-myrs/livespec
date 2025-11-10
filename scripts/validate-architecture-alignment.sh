#!/usr/bin/env bash
#
# Architecture Alignment Validation
#
# Validates that directory structures described in architecture/strategy specs actually exist.
# Prevents spec-reality drift where specs describe non-existent structures.
#
# Usage:
#   ./scripts/validate-architecture-alignment.sh
#
# Exit codes:
#   0 - All referenced structures exist
#   1 - Missing structures detected

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Counters
paths_checked=0
paths_exist=0
paths_missing=0

echo "Validating architecture alignment..."
echo ""

# Check if architecture specs exist
ARCH_SPECS=()
[[ -f "specs/2-strategy/architecture.spec.md" ]] && ARCH_SPECS+=("specs/2-strategy/architecture.spec.md")

# Also check other strategy specs
while IFS= read -r spec; do
    ARCH_SPECS+=("$spec")
done < <(find specs/2-strategy/ -name "*.spec.md" -type f 2>/dev/null | head -5)

if [[ ${#ARCH_SPECS[@]} -eq 0 ]]; then
    echo -e "${YELLOW}⚠${NC} No strategy specs found"
    echo "Nothing to validate."
    exit 0
fi

echo "Checking architecture specs for directory references..."
echo ""

# Create temp file to store missing paths
missing_file=$(mktemp)
trap "rm -f $missing_file" EXIT

# Extract directory paths from specs
# Look for patterns like: `path/to/dir/`, "path/", Location: path/
for spec in "${ARCH_SPECS[@]}"; do
    echo "Scanning: $spec"

    # Extract potential paths (backtick-wrapped or quoted paths with /)
    paths=$(grep -oE '`[a-zA-Z0-9_/-]+/`|"[a-zA-Z0-9_/-]+/"' "$spec" 2>/dev/null | tr -d '`"' || true)

    # Also look for "Location:" patterns
    location_paths=$(grep -i "location:" "$spec" 2>/dev/null | grep -oE '`[a-zA-Z0-9_/-]+/`' | tr -d '`' || true)

    # Combine all found paths
    all_paths=$(echo -e "$paths\n$location_paths" | sort -u | grep -v '^$' || true)

    if [[ -z "$all_paths" ]]; then
        echo "  No directory references found"
        continue
    fi

    # Check each path
    while IFS= read -r path; do
        # Skip if empty or looks like URL or relative internal reference
        [[ -z "$path" ]] && continue
        [[ "$path" =~ ^http ]] && continue
        [[ "$path" =~ ^\./ ]] && [[ ! -d "$path" ]] && continue

        paths_checked=$((paths_checked + 1))

        # Remove trailing slash for checking
        check_path="${path%/}"

        if [[ -d "$check_path" ]]; then
            echo -e "  ${GREEN}✓${NC} Exists: $path"
            paths_exist=$((paths_exist + 1))
        else
            echo -e "  ${RED}✗${NC} Missing: $path"
            echo "$spec|$path" >> "$missing_file"
            paths_missing=$((paths_missing + 1))
        fi
    done <<< "$all_paths"

    echo ""
done

echo "==================================================================="
echo "Architecture Alignment Results"
echo "==================================================================="
echo "Paths checked: $paths_checked"
echo "Paths exist: $paths_exist"
echo "Paths missing: $paths_missing"
echo ""

if [[ $paths_missing -gt 0 ]]; then
    echo -e "${RED}✗ FAIL: Architecture specs reference non-existent structures${NC}"
    echo ""
    echo "Missing structures:"
    echo ""

    # Group by spec file
    cut -d'|' -f1 "$missing_file" | sort -u | while read -r spec; do
        echo "  In $spec:"
        grep "^$spec|" "$missing_file" | cut -d'|' -f2 | while read -r path; do
            echo "    - $path"
        done
        echo ""
    done

    echo "This indicates spec-reality drift. Two possible causes:"
    echo ""
    echo "1. Specs describe planned structures (future state):"
    echo "   - Mark specs with future tense: 'will be located in...'"
    echo "   - Add implementation checklist: - [ ] Create directory"
    echo "   - Move spec to Phase 1 design if not yet implemented"
    echo ""
    echo "2. Specs describe current structures that don't exist:"
    echo "   - Create missing directories: mkdir -p [path]"
    echo "   - OR update specs to reflect actual implementation"
    echo ""
    echo "Example remediation:"
    echo "  mkdir -p policies/universal policies/agentic"
    echo "  mkdir -p templates/cicd templates/mcp"
    echo "  mkdir -p src/audit src/forge"
    echo ""
    exit 1
else
    echo -e "${GREEN}✓ PASS: All referenced structures exist${NC}"
    echo ""
    echo "Architecture specs align with reality."

    if [[ $paths_checked -eq 0 ]]; then
        echo ""
        echo "Note: No directory paths detected in architecture specs."
        echo "This is fine for high-level architectures, but consider if"
        echo "concrete directory structures should be documented."
    fi

    exit 0
fi
