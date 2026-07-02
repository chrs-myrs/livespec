---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without template management, users struggle to bootstrap specs, agents lack reusable verification content, and key processes become embedded in prompts instead of manageable templates
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (minimal maintenance, voluntary adoption)
guided-by:
  - specs/strategy/architecture.spec.md
derives-from:
  - specs/workspace/patterns.spec.md (template architecture pattern)
---

# Template Management

## Requirements

- [!] LiveSpec provides reusable markdown templates at the plugin's root-level `templates/`, with no separate distribution step
  - **Template categories:** `workspace/` (constitution, taxonomy, workflows, context-architecture, workspace-agent variants), `agents/` (spec-first enforcement content), `governance/` (policy, procedure), `mission/` (outcomes, constraints), `operations/` (playbook, runbook), `behaviors/` (MCP integration), `commands/` (utility command scaffold), `reports/` (implementation report), `strategy.spec.md.template`, `utils/` (self-improve)
  - Each template is complete standalone markdown, not a fragment
  - Templates follow descriptive naming (e.g. `constitution-moderate.md.template`, `spec-first-enforcement.md`)
  - Specs reference templates by their real root-level path (`templates/<category>/<name>`)
  - No `dist/` copy step — the plugin's `templates/` directory is read directly at runtime via `${CLAUDE_PLUGIN_ROOT}/templates/`

## Workspace Templates (Bootstrap)

**Purpose:** Bootstrap a new project's workspace specifications

**Location:** `templates/workspace/`

- `constitution-{light,moderate,aggressive}.md.template` - Governance principles, three enforcement levels
- `taxonomy-{software,governance,generation,documentation,planning}.spec.md.template` - Domain classification, one per project type
- `workflows.spec.md.template` - Development workflow definitions
- `context-architecture.spec.md.template`, `workspace-agent.spec.md.template` - Context generation governance

## Agent Templates (Verification & Enforcement)

**Purpose:** Provide reusable verification content inserted into generated `AGENTS.md`

**Location:** `templates/agents/`

**`spec-first-enforcement.md`:** Consolidated four-layer enforcement content —
TodoWrite gate, validation script check, mandatory plan mode for new files, and
the "permanent file" test — inserted into `AGENTS.md`'s spec-first protocol
section during generation.

**Usage flow:**
1. Referenced by `specs/workspace/workspace-agent.spec.md`
2. Read directly by `agents/context-builder.md` during `AGENTS.md` generation
   (triggered via `/livespec:audit context`)
3. Inserted inline into `AGENTS.md`'s spec-first enforcement section
4. Provides structural enforcement for the target project's agents

## Validation

- Templates exist at `templates/<category>/` (root level, not `.livespec/` or `dist/`)
- `templates/agents/spec-first-enforcement.md` exists and is referenced by
  `specs/workspace/workspace-agent.spec.md`
- `agents/context-builder.md` reads templates directly from `templates/`, not
  from any distributed copy
- No spec or generated file references `.livespec/templates/` or `dist/templates/`
