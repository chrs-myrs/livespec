---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without documented framework structure, users cannot understand what LiveSpec provides or how to use it correctly
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
---

# LiveSpec Standard Framework

## Requirements
- [!] LiveSpec distributes reusable standard defining specification types and conventions, enabling consistent methodology across projects.
  - Framework distributed as a Claude Code plugin containing `references/standards/` and skill-based prompts
  - Target projects install the plugin via `/plugin install livespec@livespec`
  - Standard includes 7 metaspecs (base, behavior, workspace, strategy, requirements, constraints, contract)
  - Standard includes 3 conventions (folder-structure, naming, dependencies)
  - All metaspecs extend base.spec.md which references MSL specification
  - Metaspecs are self-contained MSL specifications (not just documentation)
  - Project specifications reference metaspecs via `constrained_by:` frontmatter
  - Standard enables dogfooding (LiveSpec specs follow same metaspecs)
  - Distribution model: plugin installation (no folder copying or submodules required)

## Metaspecs Provided

**Type metaspecs:**
- base.spec.md - Base requirements for all LiveSpec specs (extends MSL)
- behavior.spec.md - Observable outcomes and validation criteria
- workspace.spec.md - Operating context (agents/humans/workspace interaction)
- strategy.spec.md - Product-specific technical decisions
- requirements.spec.md - High-level project requirements
- constraints.spec.md - Hard boundaries
- contract.spec.md - API and data format contracts

**Convention specs:**
- folder-structure.spec.md - Where specs go in projects
- naming.spec.md - File naming patterns
- dependencies.spec.md - Frontmatter relationship fields

## Distribution

**What gets distributed (via the plugin):**
- references/standards/ (metaspecs + conventions)
- skills/ (methodology skills, invoked as `/livespec:design`, `/livespec:audit`, etc.)
- templates/ (root-level templates)

**What stays in LiveSpec repo:**
- specs/ (LiveSpec's own specifications - dogfooding)
- tools/ (development utilities)
- docs/ (detailed documentation)
