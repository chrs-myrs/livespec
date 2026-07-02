---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Users unable to install LiveSpec properly, leading to manual errors, version drift, and adoption barriers
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
  - specs/foundation/outcomes.spec.md (Requirement 4: Minimal Maintenance)
guided-by:
  - specs/workspace/distribution.spec.md
---

# LiveSpec Installation Methods

## Requirements

- [!] LiveSpec installs as a Claude Code plugin, with no file copying or submodule management required
  - `/plugin marketplace add chrs-myrs/livespec` registers the marketplace
  - `/plugin install livespec@livespec` installs the plugin
  - Claude Code discovers `skills/*/SKILL.md`, `commands/*.md`, and `agents/*.md` automatically — no manual file placement
  - Updates via `/plugin update livespec` (no submodule sync, no directory diffing)
  - No `.livespec/` directory, no `dist/` copy, no install script — the plugin *is* the installed artifact

- [!] `/livespec:init` scaffolds a new project's spec structure after plugin installation
  - Creates `specs/{workspace,foundation,strategy,features,interfaces}` directory structure
  - Creates `PURPOSE.md` (guided or placeholder, per quick/full mode)
  - Creates `specs/workspace/constitution.spec.md` and `taxonomy.spec.md`
  - Does NOT generate `AGENTS.md` — skills are self-contained and work without it
  - Reports "Next Steps" pointing to `/livespec:design` and the optional
    `/livespec:audit context` for generating AGENTS.md/ctxt/ if desired

- [!] Skills work standalone without any generated project context
  - `AGENTS.md`/`ctxt/` are an opt-in enhancement, not a prerequisite
  - Each `skills/*/SKILL.md` carries its full workflow inline
  - A project with zero prior LiveSpec setup can still run `/livespec:design`,
    `/livespec:audit`, etc. immediately after plugin installation

## Validation

- `/plugin install livespec@livespec` makes all 8 skills available as `/livespec:*` commands
- `/livespec:init` creates the specs/ structure and PURPOSE.md without any AGENTS.md generation
- Skills execute correctly in a project with no `AGENTS.md`/`ctxt/` present
- No installation step ever creates, reads, or references a `.livespec/` directory
- `/plugin update livespec` is the only update mechanism documented
