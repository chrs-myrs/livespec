---
specifies: prompts/2-build/2a-implement-from-specs.md
criticality: CRITICAL
failure_mode: Implementation doesn't follow specifications
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Implement from Specifications

## Requirements
- [!] Prompt actively verifies Phase 0 and Phase 1 prerequisites before proceeding, preventing premature implementation.
  - Checks PURPOSE.md exists (if missing → guide to 0b-define-problem)
  - Checks specs/1-requirements/strategic/outcomes.spec.md exists (if missing → guide to 0c-define-outcomes)
  - Checks specs/1-requirements/strategic/constraints.spec.md exists (if missing → guide to 0f-identify-constraints)
  - Checks specs/3-behaviors/ directory exists with behavior specs (if missing → guide to 1b-define-behaviors)
  - Checks specs/workspace/ exists with constitution/patterns (if missing → guide to 0a-setup-workspace)
  - STOPS execution if any prerequisite missing
  - Outputs clear guidance to missing Phase 0/1 prompts

- [!] Prompt guides AI agent to implement system by following specifications in priority order (CRITICAL first), respecting workspace patterns and constraints.
  - Produces implementation code matching behavior specifications (format: follows workspace patterns from specs/workspace/patterns.spec.md)
  - All CRITICAL behaviors implemented first, then IMPORTANT
  - Implementation follows workspace patterns (coding conventions, naming, structure)
  - All constraints from constraints.spec.md satisfied
  - Code matches behavior specifications (observable outcomes verifiable)
  - No features added beyond specifications (YAGNI principle)

## Context

Use when:
- After design complete (Phase 1 complete: architecture, behaviors, contracts defined)
- Ready to build the system
- All specifications validated and approved
- Team ready to implement

## Prerequisites

- specs/workspace/ exists (constitution, patterns, workflows define HOW)
- specs/3-behaviors/ exists (defines WHAT to build)
- specs/2-strategy/architecture.spec.md exists (system structure)
- specs/1-requirements/strategic/constraints.spec.md exists (boundaries to respect)
- specs/3-contracts/ exists if external interfaces (API contracts)
- Agent understands project workspace patterns
- Development environment ready

## Outputs

- Implementation code in project structure (format: follows workspace patterns, implements behaviors, satisfies constraints, respects architecture)
- All CRITICAL behaviors implemented
- All IMPORTANT behaviors implemented (if time/resources permit)
- Tests created per workspace testing patterns (if TDD workflow)

## Validation

- All CRITICAL behaviors implemented and verifiable
- Implementation follows workspace patterns (naming, structure, conventions)
- All constraints from constraints.spec.md satisfied
- Code matches behavior specifications (can verify observable outcomes)
- No unauthorized features added (only specified behaviors)
- Architecture from architecture.spec.md followed
- Contracts from contracts/ implemented if applicable

## Success Criteria

- Behaviors demonstrable (can show working system features)
- Code maintainable (follows patterns, well-structured)
- Specifications traceable (can map code to specs)
- Constraints verifiable (can prove compliance)
- Quality appropriate (follows workspace quality standards)

## Error Handling

**If specifications unclear or conflicting:**
- Stop implementation
- Request clarification from user
- Document ambiguity discovered
- Do not guess or make assumptions

**If workspace patterns undefined:**
- Guide to Phase 0a: Use `.livespec/0-define/0a-setup-workspace.md`
- Cannot implement without HOW guidance

**If implementation violates constraints:**
- Stop immediately
- Report constraint violation
- Suggest spec revision or implementation adjustment
- Never proceed with constraint violation

**If behavior unimplementable as specified:**
- Report technical infeasibility
- Suggest alternative approaches
- Request spec revision if needed
- Document limitations discovered

## Constraints

What this prompt should NOT do:
- ❌ Add features not in specifications (no "gold plating")
- ❌ Violate constraints from constraints.spec.md (non-negotiable)
- ❌ Ignore workspace patterns (consistency critical)
- ❌ Skip CRITICAL behaviors (priority order matters)
- ❌ Implement beyond specifications without approval (YAGNI)
