---
implements: specs/behaviors/prompts/utils-generate-internalise-learnings.spec.md
phase: utils
purpose: Generate customized learning-capture prompt tailored to project spec structure
---

# Generate Internalise Learnings Prompt

Generate a customized `prompts/utils/internalise-learnings.md` prompt tailored to this project's specification structure and update workflows.

## Pre-flight Checks

**Before generating, verify:**

1. **Check if prompt already exists:**
   ```bash
   ls prompts/utils/internalise-learnings.md 2>/dev/null
   ```
   - If exists: Ask user "internalise-learnings.md already exists. Regenerate? (yes/no)"
   - If user says no: Exit without changes
   - If user says yes: Continue

2. **Verify required specs exist:**
   - specs/workspace/constitution.spec.md
   - specs/workspace/patterns.spec.md

   If missing: Warn but continue with degraded customization

## Phase 1: Read Project Structure

**Map specification taxonomy:**

1. **Workspace (process):**
   ```bash
   ls specs/workspace/*.spec.md
   ```
   These define HOW the project works

2. **Mission (goals):**
   ```bash
   ls specs/mission/*.spec.md 2>/dev/null || echo "Not found"
   ```
   These define high-level WHAT (outcomes, constraints)

3. **Strategy (approach):**
   ```bash
   ls specs/strategy/*.spec.md 2>/dev/null || echo "Not found"
   ```
   These define technical HOW (architecture, cross-cutting)

4. **Behaviors (features):**
   ```bash
   find specs/behaviors/ -name "*.spec.md" -type f | head -10
   ```
   These define detailed WHAT (observable outcomes)

5. **Contracts (interfaces):**
   ```bash
   find specs/contracts/ -type f 2>/dev/null | head -10 || echo "Not found"
   ```
   These define API/data boundaries

## Phase 2: Read Update Workflows

**Understand how specs are maintained:**

1. **Workflows spec:**
   ```bash
   cat specs/workspace/workflows.spec.md 2>/dev/null || echo "Using defaults"
   ```
   Extract: How specs are created, updated, validated

2. **Patterns spec:**
   ```bash
   cat specs/workspace/patterns.spec.md
   ```
   Extract: Naming conventions, file locations, MSL format requirements

3. **Constitution principles:**
   ```bash
   cat specs/workspace/constitution.spec.md
   ```
   Extract: Top 3 principles to reinforce through learnings

## Phase 3: Create Learning → Spec Mapping

**Build decision tree for where learnings go:**

**If learning is about:**
- Development process, principles, conventions → `specs/workspace/`
- High-level project direction, goals, boundaries → `specs/mission/`
- Technical approach, architecture, cross-cutting → `specs/strategy/`
- Observable system behavior, features → `specs/behaviors/`
- API contracts, data formats → `specs/contracts/`

**Map to actual files:**
```bash
# Create guidance based on existing specs
find specs/ -name "*.spec.md" -type f | while read spec; do
  echo "- $spec (for: [infer purpose from name])"
done
```

## Phase 4: Customize Template

**Read base template:**
```bash
cat dist/templates/utils/internalise-learnings.md.template
```

**Apply customizations:**

1. **Ultrathink block** - Set conversation analysis context:
   ```
   <ultrathink>
   I need to analyze THIS conversation to capture learnings for [PROJECT NAME].

   Project principles: [FROM constitution.spec.md - top 3]
   Spec structure: [FROM actual directory structure]
   Update workflow: [FROM workflows.spec.md or defaults]

   I will scan for:
   - Corrections to my assumptions
   - Clarifications about [project-specific concerns]
   - Patterns that emerged
   - Anti-patterns identified

   Then map learnings to appropriate specs in:
   [LIST ACTUAL SPEC FOLDERS]
   </ultrathink>
   ```

2. **Learning classification** - Use actual spec taxonomy:
   ```
   **Process Learnings** → specs/workspace/
   **Mission Learnings** → specs/mission/
   **Strategy Learnings** → specs/strategy/
   **Behavior Learnings** → specs/behaviors/
   **Contract Learnings** → specs/contracts/
   ```

3. **Update guidance** - Reference actual workflows:
   - How to create new specs (from workflows.spec.md)
   - How to update existing specs (from workflows.spec.md)
   - Format requirements (from patterns.spec.md)
   - Validation steps (from workflows.spec.md or defaults)

## Phase 5: Generate Prompt

**Write customized prompt:**

```bash
mkdir -p prompts/utils
cat > prompts/utils/internalise-learnings.md << 'EOF'
---
generated: [ISO-8601 timestamp]
generated_by: prompts/utils/generate-internalise-learnings.md
sources:
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
implements: specs/behaviors/prompts/utils-internalise-learnings.spec.md
---

# Internalise Learnings

[CUSTOMIZED ULTRATHINK BLOCK]

## Execution

### Phase 1: Conversation Analysis

Scanning THIS conversation for learnings...

**Looking for:**
- User corrections to assumptions
- Clarifications about [project-specific concerns from PURPOSE]
- Patterns that emerged during work
- Anti-patterns identified
- Knowledge gaps that caused issues

### Phase 2: Learning Classification

**Mapping learnings to specification structure:**

[ACTUAL SPEC TAXONOMY WITH EXAMPLES]

**Process Learnings** (→ specs/workspace/):
- How we work, conventions, principles
- Files: [LIST ACTUAL WORKSPACE SPECS]

**Mission Learnings** (→ specs/mission/):
- High-level requirements, constraints
- Files: [LIST ACTUAL MISSION SPECS OR "Not yet created"]

**Strategy Learnings** (→ specs/strategy/):
- Architectural decisions, technical approach
- Files: [LIST ACTUAL STRATEGY SPECS OR "Not yet created"]

**Behavior Learnings** (→ specs/behaviors/):
- Observable outcomes, features
- Files: [LIST SOME EXISTING BEHAVIOR SPECS]

### Phase 3: Spec Update Recommendations

**For each learning, propose:**

1. **Target spec:** [specific file path]
2. **Update type:** [new spec | update existing | add validation]
3. **Specific change:** [actual content to add/modify]
4. **Rationale:** [why this prevents future mistakes]

### Phase 4: Implementation Plan

[BASED ON WORKFLOWS.SPEC.MD OR DEFAULTS]

**Steps to capture learnings:**
1. Review proposed spec updates above
2. Create/update specs following [patterns from patterns.spec.md]
3. Validate changes against [principles from constitution.spec.md]
4. Test that documented learning prevents repetition

## Learning Summary

**Patterns Recognized:** [From THIS conversation]
**Spec Updates Needed:** [Specific files]
**Principles Reinforced:** [From constitution.spec.md]
EOF
```

**Report generation:**
```
✅ Generated prompts/utils/internalise-learnings.md

Customized for: [project name]
Spec structure: [folders found]
Sources: [list files read]
Timestamp: [ISO-8601]

To use: Read prompts/utils/internalise-learnings.md and analyze current conversation
To regenerate: Run this prompt again
```

## Notes

- Generated prompt maps to THIS project's actual spec structure
- Ultrathink analyzes current conversation (not pre-filled examples)
- Learning classification uses actual spec folders
- Update guidance follows project's workflows.spec.md
- Gracefully degrades if optional specs missing
- User controls whether to overwrite existing prompt
