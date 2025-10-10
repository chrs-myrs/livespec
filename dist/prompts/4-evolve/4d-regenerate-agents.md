---
implements: specs/behaviors/prompts/4d-regenerate-agents.spec.md
generated: '2025-10-10'
phase: 4-evolve
---

# Regenerate Agent Configuration Prompt

**Purpose**: Update AI agent configuration

## Context

You're in Phase 4 (EVOLVE), maintaining alignment between specifications and code as the system evolves.

## Task

Follow specification requirements.

## Output

Produce drift report, updated specs, or synchronization confirmation.

## Validation

- AGENTS.md regenerated successfully from current workspace specs
- File size under 100KB (cacheable)
- All required sections present (Summary, Decision Tree, 5 Phases, MSL Format, etc.)
- Frontmatter includes spec reference, generation timestamp, version
- Agent can guide new user through LiveSpec without fetching additional context
- Regeneration process completes in under 5 minutes

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: AGENTS.md becomes stale, agents lack current methodology context, users must repeatedly explain LiveSpec process
