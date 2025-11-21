#!/bin/bash
# Full LiveSpec Validation - All Linkages
# Validates complete spec-to-implementation alignment

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS_COUNT=0
FAIL_COUNT=0
WARN_COUNT=0

pass() {
    echo -e "${GREEN}✓${NC} $1"
    PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    WARN_COUNT=$((WARN_COUNT + 1))
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
}

# Change to repo root
cd "$(git rev-parse --show-toplevel)"

header "1. SPEC → IMPLEMENTATION COVERAGE"

# Check all prompt specs have matching prompts
info "Validating prompt specs have implementations..."
for spec in specs/3-behaviors/prompts/*.spec.md; do
    # Skip if glob didn't match anything
    [ -e "$spec" ] || continue

    basename_spec=$(basename "$spec" .spec.md)

    # Find matching prompt in dist/prompts/ or prompts/
    matching_prompt=$(find dist/prompts/ prompts/generated/ -type f -name "${basename_spec}.md" 2>/dev/null | head -1)

    if [ -n "$matching_prompt" ]; then
        # Check bidirectional link (implements: or spec:)
        if grep -q "^implements: specs/3-behaviors/prompts/${basename_spec}.spec.md" "$matching_prompt" || \
           grep -q "^spec: specs/3-behaviors/prompts/${basename_spec}.spec.md" "$matching_prompt"; then
            pass "Spec $basename_spec → Prompt linked"
        else
            warn "Spec $basename_spec exists but prompt may have incorrect frontmatter path"
        fi
    else
        warn "Spec $basename_spec has no matching prompt (may be planned)"
    fi
done

# Check behavior specs have observable behaviors
info "Validating behavior specs have implementations..."
for spec in specs/behaviors/*.spec.md; do
    basename_spec=$(basename "$spec" .spec.md)
    
    case "$basename_spec" in
        "drift-detection")
            if [ -f "prompts/4-evolve/4a-detect-drift.md" ]; then
                pass "Behavior $basename_spec implemented in Phase 4a"
            else
                fail "Behavior $basename_spec has no implementation"
            fi
            ;;
        "five-phases")
            if [ -d "prompts/0-define" ] && [ -d "prompts/4-evolve" ]; then
                pass "Behavior $basename_spec implemented in phase structure"
            else
                fail "Behavior $basename_spec missing phase implementation"
            fi
            ;;
        "folder-structure")
            if [ -f "specs/workspace/patterns.spec.md" ]; then
                pass "Behavior $basename_spec implemented in patterns"
            else
                fail "Behavior $basename_spec has no implementation"
            fi
            ;;
        "msl-format")
            # Check if specs follow format
            total_specs=$(find specs/ -name "*.spec.md" | wc -l)
            if [ "$total_specs" -gt 10 ]; then
                pass "Behavior $basename_spec widely implemented ($total_specs specs)"
            else
                warn "Behavior $basename_spec may not be widely adopted"
            fi
            ;;
    esac
done

header "2. IMPLEMENTATION → SPEC COVERAGE"

# Check all prompts have specs
info "Validating all prompts are specified..."
find prompts/ -type f -name "*.md" ! -name "README.md" | while read -r prompt; do
    # Extract spec path from frontmatter (try 'implements:' first, then 'spec:')
    spec_path=$(grep "^implements:" "$prompt" | sed 's/implements: *//' | tr -d '\r')
    if [ -z "$spec_path" ]; then
        spec_path=$(grep "^spec:" "$prompt" | sed 's/spec: *//' | tr -d '\r')
    fi

    if [ -z "$spec_path" ]; then
        fail "Prompt $prompt missing 'implements:' or 'spec:' frontmatter"
        continue
    fi

    if [ -f "$spec_path" ]; then
        pass "Prompt $(basename "$prompt") → Spec exists"
    else
        fail "Prompt $(basename "$prompt") references non-existent spec: $spec_path"
    fi
done

# Check workspace specs exist
info "Validating workspace specs..."
for required in constitution patterns workflows; do
    if [ -f "specs/workspace/${required}.spec.md" ]; then
        pass "Workspace spec: $required exists"
    else
        fail "Missing required workspace spec: $required"
    fi
done

header "3. DEPENDENCY GRAPH TRAVERSAL"

# Check PURPOSE.md exists (root)
info "Validating dependency root..."
if [ -f "PURPOSE.md" ]; then
    pass "PURPOSE.md exists (dependency root)"
else
    fail "PURPOSE.md missing (dependency root)"
fi

# Check all derives_from references resolve
info "Validating derives_from references..."
find specs/ -name "*.spec.md" -exec grep -l "^derives_from:" {} \; | while read -r spec; do
    # Extract derives_from entries
    awk '/^derives_from:/,/^[a-z_]+:/ {print}' "$spec" | grep "  - " | sed 's/  - //' | while read -r parent; do
        parent=$(echo "$parent" | tr -d '\r')
        if [ -f "$parent" ]; then
            pass "$(basename "$spec"): derives_from $parent ✓"
        else
            fail "$(basename "$spec"): derives_from $parent (MISSING)"
        fi
    done
done

# Check all constrained_by references resolve
info "Validating constrained_by references..."
find specs/ -name "*.spec.md" -exec grep -l "^constrained_by:" {} \; | while read -r spec; do
    awk '/^constrained_by:/,/^[a-z_]+:/ {print}' "$spec" | grep "  - " | sed 's/  - //' | while read -r constraint; do
        constraint=$(echo "$constraint" | tr -d '\r')
        if [ -f "$constraint" ]; then
            pass "$(basename "$spec"): constrained_by $constraint ✓"
        else
            fail "$(basename "$spec"): constrained_by $constraint (MISSING)"
        fi
    done
done

# Check for circular dependencies
info "Checking for circular dependencies..."
# Simple check - if A derives from B and B derives from A
find specs/ -name "*.spec.md" | while read -r spec1; do
    grep "^derives_from:" -A 10 "$spec1" 2>/dev/null | grep "  - " | sed 's/  - //' | while read -r parent; do
        parent=$(echo "$parent" | tr -d '\r')
        if [ -f "$parent" ]; then
            # Check if parent derives from spec1
            if grep -q "derives_from:" "$parent"; then
                if grep "^derives_from:" -A 10 "$parent" | grep -q "$(basename "$spec1")"; then
                    warn "Potential circular dependency: $(basename "$spec1") ↔ $(basename "$parent")"
                fi
            fi
        fi
    done
done

header "4. BIDIRECTIONAL LINK VALIDATION"

# Prompt ↔ Spec bidirectional validation
info "Validating prompt ↔ spec bidirectional links..."
find prompts/ -type f -name "*.md" ! -name "README.md" | while read -r prompt; do
    # Try 'implements:' first, then 'spec:'
    spec_path=$(grep "^implements:" "$prompt" | sed 's/implements: *//' | tr -d '\r')
    if [ -z "$spec_path" ]; then
        spec_path=$(grep "^spec:" "$prompt" | sed 's/spec: *//' | tr -d '\r')
    fi

    if [ -n "$spec_path" ] && [ -f "$spec_path" ]; then
        # Check if spec links back to prompt
        prompt_rel=$(realpath --relative-to="$(dirname "$spec_path")" "$prompt" 2>/dev/null || echo "$prompt")

        if grep -q "^specifies:.*$(basename "$prompt")" "$spec_path"; then
            pass "Bidirectional: $(basename "$prompt") ↔ $(basename "$spec_path")"
        else
            warn "Spec $(basename "$spec_path") missing 'specifies: $prompt_rel'"
        fi
    fi
done

header "5. TEST COVERAGE ANALYSIS"

info "Validating test coverage for behaviors..."

# Check each behavior spec has test coverage
for spec in specs/behaviors/*.spec.md; do
    basename_spec=$(basename "$spec" .spec.md)
    
    # Find tests that reference this spec
    test_count=$(grep -r "$(basename "$spec")" tests/ 2>/dev/null | wc -l)
    
    if [ "$test_count" -gt 0 ]; then
        pass "Behavior $basename_spec has test coverage ($test_count references)"
    else
        warn "Behavior $basename_spec has no test coverage"
    fi
done

# Check test files exist and are executable
info "Validating test infrastructure..."
if [ -f "tests/run-all-tests.sh" ] && [ -x "tests/run-all-tests.sh" ]; then
    pass "Test runner exists and is executable"
else
    fail "Test runner missing or not executable"
fi

# Count test suites
test_suite_count=$(find tests/ -name "test_*.sh" | wc -l)
if [ "$test_suite_count" -gt 0 ]; then
    pass "Found $test_suite_count test suites"
else
    fail "No test suites found"
fi

header "6. MSL COMPLIANCE AUDIT"

info "Validating MSL format compliance..."

find specs/ -name "*.spec.md" | while read -r spec; do
    errors=0

    # Check for title
    if ! grep -q "^# " "$spec"; then
        fail "$(basename "$spec"): Missing title (# Heading)"
        errors=$((errors + 1))
    fi

    # Check for Requirements section
    if ! grep -q "^## Requirements" "$spec"; then
        fail "$(basename "$spec"): Missing '## Requirements' section"
        errors=$((errors + 1))
    fi

    # Check for criticality in frontmatter
    if ! grep -q "^criticality:" "$spec"; then
        fail "$(basename "$spec"): Missing 'criticality:' in frontmatter"
        errors=$((errors + 1))
    fi

    # Check for failure_mode in frontmatter
    if ! grep -q "^failure_mode:" "$spec"; then
        fail "$(basename "$spec"): Missing 'failure_mode:' in frontmatter"
        errors=$((errors + 1))
    fi

    # Check criticality is valid
    criticality=$(grep "^criticality:" "$spec" | sed 's/criticality: *//')
    if [[ -n "$criticality" ]] && [[ ! "$criticality" =~ (CRITICAL|IMPORTANT) ]]; then
        fail "$(basename "$spec"): Invalid criticality '$criticality' (must be CRITICAL or IMPORTANT)"
        errors=$((errors + 1))
    fi

    if [ "$errors" -eq 0 ]; then
        pass "$(basename "$spec"): MSL compliant"
    fi
done

# Check for .spec.md extension consistency
info "Validating .spec.md extension usage..."
non_spec_in_specs=$(find specs/ -name "*.md" ! -name "*.spec.md" ! -name "README.md" ! -name "DEPENDENCIES.md" | wc -l)
if [ "$non_spec_in_specs" -eq 0 ]; then
    pass "All spec files use .spec.md extension"
else
    fail "Found $non_spec_in_specs files in specs/ without .spec.md extension"
    find specs/ -name "*.md" ! -name "*.spec.md" ! -name "README.md" ! -name "DEPENDENCIES.md"
fi

header "8. CONTRACT COMPLETENESS"

# Check contract parameters have behavior references
if [ -d "specs/3-contracts" ]; then
    info "Validating contract parameters have behavior specs..."
    if bash scripts/check-contract-completeness.sh specs/3-contracts >/dev/null 2>&1; then
        pass "All contract parameters have behavior references"
    else
        fail "Contract parameters missing behavior references (run scripts/check-contract-completeness.sh for details)"
    fi
else
    info "No contracts directory found (specs/3-contracts) - skipping"
fi

header "9. VALUE STRUCTURE TRACEABILITY"

# Check PURPOSE.md exists (foundation of value structure)
info "Validating value structure foundation..."
if [ -f "PURPOSE.md" ]; then
    pass "PURPOSE.md exists (value structure foundation)"
else
    fail "PURPOSE.md missing - all specs must trace to PURPOSE"
fi

# Run structure validation script
info "Validating all specs have upstream references..."
if [ -f "scripts/validate-value-structure.sh" ]; then
    # Capture output and count
    structure_output=$(bash scripts/validate-value-structure.sh 2>&1)
    structure_exit=$?

    # Extract counts from output
    orphaned_count=$(echo "$structure_output" | grep "Orphaned specs:" | sed 's/.*Orphaned specs: //')

    if [ "$structure_exit" -eq 0 ]; then
        if [ -n "$orphaned_count" ] && [ "$orphaned_count" -gt 0 ]; then
            warn "Found $orphaned_count orphaned specs without upstream references"
            # Show orphaned specs
            echo "$structure_output" | grep "^⚠ Orphaned:"
        else
            pass "All specs have upstream references (derives-from/governed-by/satisfies/guided-by)"
        fi
    else
        fail "Value structure validation failed"
        echo "$structure_output"
    fi
else
    warn "Structure validation script not found (scripts/validate-value-structure.sh)"
fi

# Check for common traceability issues
info "Checking for broken reference chains..."
find specs/ -name "*.spec.md" | while read -r spec; do
    # Check each frontmatter reference type
    for field in derives-from governed-by satisfies guided-by; do
        if grep -q "^${field}:" "$spec"; then
            # Extract references and check they exist
            awk "/^${field}:/,/^[a-z_-]+:/ {print}" "$spec" | grep "  - " | sed 's/  - //' | while read -r ref; do
                ref=$(echo "$ref" | tr -d '\r')
                if [ ! -f "$ref" ]; then
                    fail "$(basename "$spec"): ${field} references missing file: $ref"
                fi
            done
        fi
    done
done

header "SUMMARY"

echo ""
echo -e "Results:"
echo -e "  ${GREEN}Passed:${NC}  $PASS_COUNT"
echo -e "  ${RED}Failed:${NC}  $FAIL_COUNT"
echo -e "  ${YELLOW}Warnings:${NC} $WARN_COUNT"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "${GREEN}✓ Full validation PASSED${NC}"
    exit 0
else
    echo -e "${RED}✗ Full validation FAILED ($FAIL_COUNT failures)${NC}"
    exit 1
fi
