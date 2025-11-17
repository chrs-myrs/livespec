---
generated: 2025-11-08T10:51:00Z
generated_by: dist/prompts/utils/generate-internalise-learnings.md
sources:
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
implements: specs/3-behaviors/prompts/utils-internalise-learnings.spec.md
---

# Internalise Learnings

<ultrathink>
I need to analyze THIS current conversation to extract learnings for LiveSpec.

Project principles to reinforce:
1. **Specs Before Implementation** - Every deliverable requires specification before implementation (AI agents guide this)
2. **MSL Minimalism** - Specs justify existence, specify WHAT not HOW, only CRITICAL/IMPORTANT requirements
3. **Test-Driven Development** - Phase 2 follows TDD discipline (tests before code, escape hatch for trivial scripts)
4. **Dogfooding** - LiveSpec uses own methodology
5. **Simplicity Over Features** - No custom tooling required
6. **Living Documentation** - Specs evolve continuously with code
7. **Governance Framework Awareness** - Patterns demonstrated here apply to governance domain specifically
8. **Active Agent Guidance** - Agents have concise definitive context with active verification prompts

Specification structure:
- specs/workspace/ (12 specs) - Process, principles, patterns, workflows
- specs/1-requirements/strategic/ (2 specs) - Outcomes, constraints
- specs/2-strategy/ - Architecture, layer definitions, three-layer pattern
- specs/3-behaviors/ - Observable outcomes (templates, framework, session-completion, validation, measurement, prompts)
- specs/3-contracts/ - Not yet created

I will scan THIS conversation for:
- Corrections to my assumptions about LiveSpec methodology
- Clarifications about spec-first enforcement, MSL minimalism, learning workflows
- Patterns that emerged during session completion implementation
- Anti-patterns I should avoid (over-engineering, skipping validation)
- Knowledge gaps that caused issues (version tracking, regeneration process)

Then map learnings to appropriate specifications.
</ultrathink>

## Execution

### Phase 1: Conversation Analysis

Scanning THIS conversation for learnings (not pre-filled examples)...

**Reading conversation history to identify:**

#### 1.1 User Corrections

Look for moments where user said:
- "Actually, it should be..."
- "No, the correct approach is..."
- "That's not quite right..."
- "Let me clarify..."

**Extract:**
- What assumption was incorrect?
- What is the correct understanding?
- Why does this matter for this project?

#### 1.2 Clarification Requests

Look for:
- Questions I asked that revealed ambiguity
- Areas where user provided additional context
- Specifications that weren't clear enough
- Missing documentation discovered

**Extract:**
- What was unclear?
- What clarification was provided?
- Where should this be documented?

#### 1.3 Discovered Patterns

Look for:
- Patterns that emerged during implementation
- Conventions user reinforced repeatedly
- Best practices demonstrated in code/specs
- Workflows that proved effective

**Extract:**
- What pattern was demonstrated?
- Why is it valuable?
- Where should it be codified?

#### 1.4 Anti-Patterns Identified

Look for:
- Approaches user steered me away from
- Mistakes made and corrected
- Violations of project principles
- Inefficiencies encountered

**Extract:**
- What was the anti-pattern?
- Why is it problematic?
- What principle does it violate?

### Phase 2: Learning Classification

**Mapping learnings to specification structure:**

**Process Learnings** (→ specs/workspace/):
- About how we work
- Development principles
- Coding conventions
- Workflow processes
- Files: constitution.spec.md, patterns.spec.md, workflows.spec.md, version-management.spec.md, workspace-agent.spec.md, distribution.spec.md, cross-references.spec.md, folder-organization.spec.md, generated-files.spec.md, livespec.spec.md, taxonomy.spec.md, third-party-dependencies.spec.md

**Mission Learnings** (→ specs/1-requirements/strategic/):
- High-level requirements refined
- New constraints identified
- Outcomes clarified
- Boundaries adjusted
- Files: outcomes.spec.md, constraints.spec.md

**Strategy Learnings** (→ specs/2-strategy/):
- Architectural insights
- Cross-cutting decisions
- Technical approach refined
- Design patterns validated
- Files: architecture.spec.md, layer-definitions.spec.md, three-layer-architecture.spec.md, phase-workflow.spec.md, dogfooding.spec.md, validation.spec.md, ai-discoverability.spec.md, distribution.spec.md

**Behavior Learnings** (→ specs/3-behaviors/):
- New behaviors discovered
- Existing behaviors clarified
- Validation criteria refined
- Edge cases identified
- Files: templates.spec.md, framework/standard.spec.md, session-completion.spec.md, measurement/*, validation/*, prompts/*

**Contract Learnings** (→ specs/3-contracts/):
- Interface changes needed
- API contracts refined
- Data format updates
- Integration points clarified
- Files: Not yet created

### Phase 3: Spec Update Recommendations

For each learning identified, propose specific update:

**Learning 1: [DESCRIPTION FROM ACTUAL CONVERSATION]**
- **Type**: [Correction | Clarification | Pattern | Anti-pattern]
- **Target Spec**: [SPECIFIC FILE PATH]
- **Update Type**: [New spec | Update existing | Add validation | Add example]
- **Specific Change**:
  ```markdown
  [ACTUAL CONTENT TO ADD/MODIFY IN SPEC]
  ```
- **Rationale**: [Why this prevents future mistakes]
- **Validation**: [How to verify learning is applied]

**Learning 2: [DESCRIPTION FROM ACTUAL CONVERSATION]**
- **Type**: [Correction | Clarification | Pattern | Anti-pattern]
- **Target Spec**: [SPECIFIC FILE PATH]
- **Update Type**: [New spec | Update existing | Add validation | Add example]
- **Specific Change**:
  ```markdown
  [ACTUAL CONTENT TO ADD/MODIFY IN SPEC]
  ```
- **Rationale**: [Why this prevents future mistakes]
- **Validation**: [How to verify learning is applied]

[CONTINUE FOR ALL LEARNINGS IDENTIFIED]

### Phase 4: Implementation Plan

**Steps to capture learnings (from workflows.spec.md):**

1. **Review Recommendations Above**
   - Validate each learning is accurate
   - Prioritize by impact (which prevents most mistakes?)
   - Group by target spec location

2. **Create/Update Specifications**
   - Follow MSL format: title, frontmatter (criticality, failure_mode), Requirements section
   - Use correct criticality: CRITICAL | IMPORTANT only
   - Define failure mode: What breaks without this?
   - Add validation criteria: How to verify?
   - Include bidirectional links (specifies/implements frontmatter)

3. **Validate Changes**
   - Check against principles: Spec-first, MSL minimalism, TDD, dogfooding, simplicity
   - Verify MSL minimalism: Is this essential? (4-question test)
   - Test that learning prevents repetition
   - Update frontmatter dependencies if needed (derives-from, guided-by, satisfies)

4. **Propagate Learning**
   - Update related specs if needed
   - Add examples to patterns.spec.md if pattern
   - Update workflows.spec.md if process learning
   - Follow distribution workflow if methodology change: templates → specs → prompts → AGENTS.md → dist/
   - Regenerate AGENTS.md if workspace specs changed: dist/prompts/4-evolve/4d-regenerate-context.md

### Phase 5: Prevent Repetition

**Creating feedback loop:**

1. **Document in Specs**
   - Implement recommended updates above
   - Make learning explicit in specifications
   - Add validation that catches violation

2. **Update Agent Configuration**
   - If workspace specs changed: Regenerate AGENTS.md
   ```bash
   # Use dist/prompts/4-evolve/4d-regenerate-context.md to regenerate
   ```

3. **Validate Integration**
   - Test that documented learning is enforced
   - Verify agent uses updated specs
   - Confirm anti-pattern is preventable
   - Run validation: scripts/validate-value-pyramid.sh

## Learning Summary

**Patterns Recognized:** [FROM THIS CONVERSATION]
- [PATTERN 1 - ACTUAL FROM CONVERSATION]
- [PATTERN 2 - ACTUAL FROM CONVERSATION]
- [PATTERN 3 - ACTUAL FROM CONVERSATION]

**Spec Updates Needed:**
- [FILE 1: SPECIFIC CHANGE]
- [FILE 2: SPECIFIC CHANGE]
- [FILE 3: SPECIFIC CHANGE]

**Principles Reinforced:** [FROM constitution.spec.md]
- [PRINCIPLE 1 AND HOW IT WAS DEMONSTRATED]
- [PRINCIPLE 2 AND HOW IT WAS DEMONSTRATED]
- [PRINCIPLE 3 AND HOW IT WAS DEMONSTRATED]

**Anti-Patterns Avoided:**
- [ANTI-PATTERN 1 IDENTIFIED IN CONVERSATION]
- [ANTI-PATTERN 2 IDENTIFIED IN CONVERSATION]

**Next Actions:**
1. [HIGHEST PRIORITY SPEC UPDATE]
2. [SECOND PRIORITY SPEC UPDATE]
3. [VALIDATION STEP]

**Validation:**
- [ ] All learnings documented in appropriate specs
- [ ] MSL minimalism maintained (only essential requirements)
- [ ] Validation criteria added (how to verify compliance)
- [ ] Frontmatter dependencies updated if needed
- [ ] AGENTS.md regenerated if workspace specs changed
- [ ] Distribution workflow followed for methodology changes

These learnings are now integrated into project specifications and will prevent repeated mistakes in future conversations.
