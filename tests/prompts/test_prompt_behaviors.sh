#!/bin/bash
# Test: Prompt Behaviors
# Spec: All prompt specs (0a-4c)

set -e
FAILURES=0

echo "Testing: Prompt Behaviors"

# Validation: Each prompt has a corresponding behavior spec
echo "  Checking prompt/behavior-spec correspondence..."

for phase_dir in prompts/*; do
    if [ -d "$phase_dir" ]; then
        for prompt_file in "$phase_dir"/*.md; do
            if [ -f "$prompt_file" ]; then
                prompt_name=$(basename "$prompt_file" .md)

                # Skip README files (documentation, not prompts)
                if [ "$prompt_name" = "README" ]; then
                    continue
                fi

                prompt_spec="specs/prompts/${prompt_name}.spec.md"

                if [ -f "$prompt_spec" ]; then
                    echo "    ✓ $prompt_name has prompt spec"
                else
                    echo "    ❌ $prompt_name missing prompt spec"
                    FAILURES=$((FAILURES + 1))
                fi
            fi
        done
    fi
done

# Validation: Prompt specs define expected outputs
echo "  Checking prompt specs define outputs..."

for prompt_spec in specs/prompts/{0,1,2,3,4}*.spec.md; do
    if [ -f "$prompt_spec" ]; then
        if grep -q "^## Prompt Outputs" "$prompt_spec" || \
           grep -q "^## Specification" "$prompt_spec"; then
            echo "    ✓ $(basename $prompt_spec) defines outputs"
        else
            echo "    ❌ $(basename $prompt_spec) missing output definition"
            FAILURES=$((FAILURES + 1))
        fi
    fi
done

if [ $FAILURES -gt 0 ]; then
    echo "FAILED: $FAILURES prompt behavior test(s) failed"
    exit 1
else
    echo "✅ All prompt behavior tests passed"
    exit 0
fi
