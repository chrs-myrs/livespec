#!/bin/bash
# Test: Folder Structure Behavior
# Spec: specs/behaviors/folder-structure.spec.md

set -e
FAILURES=0

echo "Testing: Folder Structure Behavior"

# Validation: specs/workspace/ contains only development methodology
echo -n "  ✓ workspace/ contains development methodology... "
if [ -d "specs/workspace" ]; then
    # Check that workspace specs exist
    if [ -f "specs/workspace/constitution.spec.md" ] && \
       [ -f "specs/workspace/patterns.spec.md" ] && \
       [ -f "specs/workspace/workflows.spec.md" ]; then
        echo "PASS"
    else
        echo "FAIL - Missing workspace specs"
        FAILURES=$((FAILURES + 1))
    fi
else
    echo "FAIL - workspace/ doesn't exist"
    FAILURES=$((FAILURES + 1))
fi

# Validation: Root contains PURPOSE.md
echo -n "  ✓ Root contains PURPOSE.md... "
if [ -f "PURPOSE.md" ]; then
    echo "PASS"
else
    echo "FAIL - PURPOSE.md missing"
    FAILURES=$((FAILURES + 1))
fi

# Validation: prompts/ organized by 5 phases
echo -n "  ✓ prompts/ organized by 5 phases... "
PHASES=0
for phase in 0-define 1-design 2-build 3-verify 4-evolve; do
    if [ -d "prompts/$phase" ]; then
        PHASES=$((PHASES + 1))
    fi
done

if [ $PHASES -eq 5 ]; then
    echo "PASS"
else
    echo "FAIL - Found $PHASES/5 phases"
    FAILURES=$((FAILURES + 1))
fi

# Validation: specs/strategy/ contains technical approach
echo -n "  ✓ strategy/ contains technical approach... "
if [ -d "specs/strategy" ]; then
    # Check that at least architecture.spec.md exists
    if [ -f "specs/strategy/architecture.spec.md" ]; then
        echo "PASS"
    else
        echo "FAIL - Missing strategy/architecture.spec.md"
        FAILURES=$((FAILURES + 1))
    fi
else
    echo "FAIL - strategy/ doesn't exist"
    FAILURES=$((FAILURES + 1))
fi

# Validation: Structure has .livespec symlink
echo -n "  ✓ .livespec symlink exists... "
if [ -L ".livespec" ]; then
    echo "PASS"
else
    echo "FAIL - Missing .livespec symlink"
    FAILURES=$((FAILURES + 1))
fi

# Validation: Agent-specific config exists (CLAUDE.md for Claude Code)
echo -n "  ✓ Agent configuration accessible... "
if [ -f "CLAUDE.md" ] || [ -L "CLAUDE.md" ] || [ -f "AGENTS.md" ]; then
    echo "PASS"
else
    echo "FAIL - Missing agent config (CLAUDE.md or AGENTS.md)"
    FAILURES=$((FAILURES + 1))
fi

if [ $FAILURES -gt 0 ]; then
    echo "FAILED: $FAILURES test(s) failed"
    exit 1
else
    echo "✅ All folder structure tests passed"
    exit 0
fi
