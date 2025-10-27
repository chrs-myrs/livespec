---
criticality: IMPORTANT
failure_mode: AI agents don't discover LiveSpec methodology in projects
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/ai-discoverability.spec.md
---

# PURPOSE.md Template

## Requirements

- [!] Template includes LiveSpec breadcrumb for AI discovery.
  - Section: "Development Methodology"
  - Content: "This project uses [LiveSpec](/.livespec/AGENTS.md) methodology"
  - Instruction: "AI Agents: Read `.livespec/AGENTS.md` before any implementation"
  - Link resolves to project's AGENTS.md file

- [!] Template follows MSL metaspec for PURPOSE.md.
  - Free-form format (not MSL spec structure)
  - Sections: Project name, Purpose, Success criteria
  - Minimal and focused (under 100 lines typical)
  - Clear problem/solution statement
  - Measurable success criteria

- [!] Template balances project vision with methodology pointer.
  - PURPOSE.md remains primarily about project purpose
  - LiveSpec reference is concise (3-4 lines)
  - Does not overwhelm with methodology details
  - Natural reading flow for both humans and AI

## Validation

- Template includes LiveSpec breadcrumb
- Breadcrumb links resolve correctly
- Template follows PURPOSE.md metaspec requirements
- AI agents successfully discover AGENTS.md from PURPOSE.md
- Human readers understand project purpose clearly
- Template under 100 lines (typical)
