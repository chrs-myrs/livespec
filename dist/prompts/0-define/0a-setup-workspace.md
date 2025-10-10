---
implements: specs/behaviors/prompts/0a-setup-workspace.spec.md
generated: '2025-10-10'
phase: 0-define
---

# Prompt Behavior: Setup Workspace

**Purpose**: Initialize LiveSpec methodology structure

## Context

You're setting up a new project or adding LiveSpec to an existing codebase. This establishes the foundation for specification-driven development.

## Task

1. Prompt guides AI agent to create workspace/ specifications (constitution, patterns, workflows) that define how the target project is developed, customized for the specific project context.

## Output

Create or update specification files in specs/ directory with clear, testable requirements.

## Validation

- Prompt produces three workspace spec files
- All specs follow MSL format (Criticality, Failure Mode, Specification, Validation)
- Specs are specific to target project, not generic
- User understands workspace defines HOW to build, not WHAT to build
- Prompt references folder-structure behavior and MSL format requirements

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Users cannot create workspace specifications without guidance
