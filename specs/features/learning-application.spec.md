---
criticality: IMPORTANT
failure_mode: Session insights lost, specs become stale, repeated mistakes across sessions
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
---

# Learning Application

Applies session learnings to workspace and strategy specs, completing the knowledge capture loop.

## Requirements

- [!] Gather learning candidates from current conversation
  - Scan for corrections made (mistaken assumptions corrected)
  - Scan for user clarifications (requirements refined)
  - Scan for patterns emerged (repeated issues, new conventions)
  - Scan for explicit documentation requests

- [!] Present candidates for user selection via AskUserQuestion
  - Show each detected learning as selectable option
  - Allow multi-select (user chooses which to apply)
  - Include option to add custom learning not detected

- [!] Determine appropriate target spec for each selected learning
  - Process/convention changes → specs/workspace/
  - Architectural decisions → specs/strategy/
  - Feature behaviors → specs/features/
  - Show user which spec each learning will update

- [!] Apply updates to specs
  - Edit existing specs to incorporate learnings
  - Add new requirements or clarify existing ones
  - Preserve MSL format and spec structure

- [!] Trigger context rebuild after updates
  - Run regenerate-contexts.md to update AGENTS.md
  - Ensure learnings immediately available in next session
