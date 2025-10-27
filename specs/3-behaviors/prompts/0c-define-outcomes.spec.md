---
specifies: prompts/0-define/0c-define-outcomes.md
criticality: CRITICAL
failure_mode: Projects lack high-level requirements, leading to disconnected features
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Define Outcomes

## Requirements
- [!] Prompt guides AI agent to create outcomes specification that defines high-level project requirements derived from PURPOSE.md.
  - Produces `specs/1-requirements/strategic/outcomes.spec.md` (format: MSL with criticality, failure_mode, Requirements)
  - Contains 3-6 high-level outcome requirements
  - Each outcome traces to PURPOSE.md success criteria
  - Each outcome has validation criteria
  - Outcomes are high-level (not detailed behaviors)
  - No implementation details included

## Context

Use when:
- After PURPOSE.md created (Phase 0b complete)
- Before architecture design (Phase 1)
- Need to translate vision into measurable outcomes
- Team needs high-level requirements baseline

## Prerequisites

- PURPOSE.md exists with vision and success criteria
- `specs/1-requirements/strategic/` directory created
- Agent understands MSL format
- Agent understands difference between outcomes (high-level) and behaviors (detailed)

## Outputs

- `specs/1-requirements/strategic/outcomes.spec.md` - High-level requirements specification (format: MSL with 3-6 outcome requirements, each with validation criteria, traceability to PURPOSE.md)

## Validation

- specs/1-requirements/strategic/outcomes.spec.md exists
- Follows MSL format (criticality, failure_mode, Requirements with [!])
- Contains 3-6 high-level outcomes
- Each outcome traces to PURPOSE.md success criteria
- Each outcome has testable validation criteria
- Outcomes are appropriately high-level (strategic, not feature-level)
- No implementation details (technology, architecture decisions)

## Success Criteria

- Outcomes capture strategic requirements (not tactical features)
- Traceability clear (can map outcomes to PURPOSE.md)
- Validation criteria enable progress measurement
- Outcomes comprehensive (cover all success criteria from PURPOSE.md)
- Outcomes minimal (only essential high-level requirements)

## Error Handling

**If PURPOSE.md missing:**
- Guide to Phase 0b: Use `.livespec/0-define/0b-define-problem.md` first
- Explain outcomes derive from purpose

**If outcomes too detailed (feature-level):**
- Remind: Outcomes are strategic (high-level), behaviors are tactical (detailed)
- Example: "User authentication with MFA" → "System secures user access"
- Guide to keep outcomes at problem-space level, not solution-space

**If unable to trace outcomes to PURPOSE.md:**
- Review PURPOSE.md for clarity
- Question whether outcome is genuinely needed
- Suggest revising PURPOSE.md if success criteria unclear

**If too many outcomes (>6):**
- Group related outcomes under broader categories
- Focus on critical outcomes only
- Suggest detailed outcomes move to behaviors/ (Phase 1b)

## Constraints

What this prompt should NOT do:
- ❌ Define detailed feature-level behaviors (those belong in specs/3-behaviors/)
- ❌ Include implementation technology (language, framework, architecture)
- ❌ Specify HOW outcomes are achieved (that's architecture/design)
- ❌ Create outcomes unrelated to PURPOSE.md (every outcome must trace)
- ❌ Skip validation criteria (outcomes must be measurable)
