---
generated: 2025-10-10T12:40:00Z
generated_by: prompts/utils/generate-internalise-learnings.md
sources:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
implements: specs/behaviors/prompts/utils-internalise-learnings.spec.md
---

# Internalise Learnings

<ultrathink>
I need to analyze THIS current conversation to extract learnings for LiveSpec.

**LiveSpec Purpose:** Prevent specification-code drift, enable AI agents to provide effective assistance

**Core Principles to Reinforce:**
1. Spec-First Always - Every deliverable has spec before implementation
2. MSL Minimalism - Specs justify existence (CRITICAL/IMPORTANT only)
3. Dogfooding - LiveSpec uses its own methodology

**Specification Structure:**
- specs/workspace/ - Development process (portable)
- specs/mission/ - High-level goals (outcomes, constraints)
- specs/strategy/ - Technical approach (architecture, cross-cutting)
- specs/behaviors/ - Observable outcomes (features)
- specs/contracts/ - Interface definitions (APIs, data)

**Update Workflow:** Spec-first guidance → implement → validate → MSL audit

I will scan THIS conversation for:
- Corrections to my assumptions
- Clarifications about LiveSpec's agent-agnostic philosophy
- Patterns that emerged during self-improvement integration
- Anti-patterns identified or avoided
- Knowledge gaps that caused issues

Then map learnings to appropriate specifications in LiveSpec's structure.
</ultrathink>

## Execution

### Phase 1: Conversation Analysis

Scanning THIS conversation for learnings (not pre-filled examples)...

**Looking for:**
- User corrections to assumptions about file locations, naming conventions
- Clarifications about LiveSpec philosophy (agent-agnostic vs ForgeWick's Claude-specific)
- Patterns that emerged during ForgeWick integration work
- Anti-patterns identified
- Knowledge gaps discovered

#### 1.1 User Corrections

**Analyzing conversation for moments where user corrected my approach:**

[SCANNING CONVERSATION...]

- File location corrections (where specs go, where prompts go)
- Naming convention corrections (frontmatter fields)
- Philosophy corrections (agent-agnostic approach)
- Structure corrections (mission/ folder, spec hierarchy)

**Extract:**
- What assumption was incorrect?
- What is the correct understanding?
- Why does this matter for LiveSpec?

#### 1.2 Clarification Requests

**Looking for areas needing clarification:**

- Generator approach vs static prompts (why generate?)
- prompts/ vs .claude/commands/ (agent-agnostic philosophy)
- Customization drivers (what drives template adaptation?)
- Domain detection (how to infer from specs?)

**Extract:**
- What was unclear initially?
- What clarification was provided?
- Where should this be documented?

#### 1.3 Discovered Patterns

**Patterns that emerged during work:**

- Generators read spec hierarchy top-down (PURPOSE → mission → strategy → workspace)
- Templates customize based on project domain
- Frontmatter conventions: `implements:` for prompts, `governed-by:` for metaspecs
- Dual-command approach (strategic + tactical)

**Extract:**
- What pattern was demonstrated?
- Why is it valuable for LiveSpec?
- Where should it be codified?

#### 1.4 Anti-Patterns Identified

**Approaches steered away from:**

- Claude-specific .claude/commands/ (violates agent-agnostic)
- Pre-filled examples (need actual conversation analysis)
- Generic templates (need project-specific customization)
- Static prompts (need generators for adaptation)

**Extract:**
- What was the anti-pattern?
- Why is it problematic for LiveSpec?
- What principle does it violate?

### Phase 2: Learning Classification

**Mapping learnings to LiveSpec's specification structure:**

**Process Learnings** (→ specs/workspace/):
- How we work, conventions, principles
- Files that might need updates:
  - specs/workspace/constitution.spec.md (principles)
  - specs/workspace/patterns.spec.md (naming, format, frontmatter)
  - specs/workspace/workflows.spec.md (how to create/update specs)
  - specs/workspace/agents.spec.md (agent behaviors)

**Mission Learnings** (→ specs/mission/):
- High-level requirements, constraints
- Files:
  - specs/mission/outcomes.spec.md (what LiveSpec must achieve)
  - specs/mission/constraints.spec.md (agent-agnostic, manual adoption, etc.)

**Strategy Learnings** (→ specs/strategy/):
- Architectural decisions, technical approach
- Files:
  - specs/strategy/architecture.spec.md (5 phases, MSL format, etc.)
  - specs/strategy/ai-discoverability.spec.md (agent integration)

**Behavior Learnings** (→ specs/behaviors/):
- Observable outcomes, features
- Files in:
  - specs/behaviors/prompts/*.spec.md (prompt behaviors)
  - specs/behaviors/*.spec.md (system behaviors)

### Phase 3: Spec Update Recommendations

For each learning identified in THIS conversation, propose specific update:

**Learning 1: [FROM ACTUAL CONVERSATION]**
- **Type**: [Correction | Clarification | Pattern | Anti-pattern]
- **Target Spec**: [SPECIFIC FILE PATH]
- **Update Type**: [New spec | Update existing | Add validation | Add example]
- **Specific Change**:
  ```markdown
  [ACTUAL CONTENT TO ADD/MODIFY IN SPEC]
  ```
- **Rationale**: [Why this prevents future mistakes]
- **Validation**: [How to verify learning is applied]

**Learning 2: [FROM ACTUAL CONVERSATION]**
- **Type**: [Correction | Clarification | Pattern | Anti-pattern]
- **Target Spec**: [SPECIFIC FILE PATH]
- **Update Type**: [New spec | Update existing | Add validation | Add example]
- **Specific Change**:
  ```markdown
  [ACTUAL CONTENT TO ADD/MODIFY IN SPEC]
  ```
- **Rationale**: [Why this prevents future mistakes]
- **Validation**: [How to verify learning is applied]

[CONTINUE FOR ALL LEARNINGS FROM THIS CONVERSATION]

### Phase 4: Implementation Plan

**Based on LiveSpec's workflows.spec.md:**

**Steps to capture learnings:**

1. **Review Recommendations Above**
   - Validate each learning is accurate
   - Prioritize by impact (which prevents most mistakes?)
   - Group by target spec location

2. **Create/Update Specifications**
   - Follow MSL format:
     - YAML frontmatter (derives-from, governed-by, etc.)
     - # Title
     - ## Requirements section with [!] items
   - Use correct criticality: CRITICAL or IMPORTANT only
   - Define failure_mode: What breaks without this?
   - Add validation criteria: How to verify?
   - British English for user docs (synchronisation, behaviour)

3. **Validate Changes**
   - Check against principles:
     - Spec-First: Does this have a spec?
     - MSL Minimalism: Is this CRITICAL or IMPORTANT?
     - Dogfooding: Is LiveSpec using its own methodology?
   - Verify MSL minimalism (ask 4 questions):
     1. Is this essential? Would system fail without it?
     2. Am I specifying HOW instead of WHAT?
     3. What specific problem does this prevent?
     4. Could this be inferred or conventional?
   - Test that learning prevents repetition
   - Update frontmatter dependencies if needed

4. **Propagate Learning**
   - Update related specs if needed
   - Add examples to patterns.spec.md if pattern learning
   - Update workflows.spec.md if process learning
   - Regenerate AGENTS.md if workspace specs changed:
     ```bash
     # If you updated specs/workspace/*
     # Consider regenerating AGENTS.md
     # (Will happen in Phase 4 EVOLVE)
     ```

### Phase 5: Prevent Repetition

**Creating feedback loop:**

1. **Document in Specs**
   - Implement recommended updates above
   - Make learning explicit in specifications
   - Add validation that catches violation

2. **Update Agent Configuration**
   - If workspace specs changed: Regenerate AGENTS.md
   - Ensures future AI agents learn from this conversation

3. **Validate Integration**
   - Test that documented learning is enforced
   - Verify agent uses updated specs
   - Confirm anti-pattern is preventable

## Learning Summary

**Patterns Recognized:** [FROM THIS CONVERSATION - WILL BE FILLED IN WHEN EXECUTED]

**Spec Updates Needed:** [SPECIFIC FILES - WILL BE FILLED IN WHEN EXECUTED]

**Principles Reinforced:** [FROM constitution.spec.md - WILL BE FILLED IN WHEN EXECUTED]

**Anti-Patterns Avoided:** [FROM THIS CONVERSATION - WILL BE FILLED IN WHEN EXECUTED]

**Next Actions:**
1. [HIGHEST PRIORITY SPEC UPDATE]
2. [SECOND PRIORITY SPEC UPDATE]
3. [VALIDATION STEP]

**Validation Checklist:**
- [ ] All learnings documented in appropriate specs
- [ ] MSL minimalism maintained (only CRITICAL/IMPORTANT requirements)
- [ ] Validation criteria added (how to verify compliance)
- [ ] Frontmatter dependencies updated if needed
- [ ] AGENTS.md regenerated if workspace specs changed
- [ ] British English used for user documentation

These learnings are now integrated into LiveSpec specifications and will prevent repeated mistakes in future conversations.
