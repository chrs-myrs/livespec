---
derives-from:
  - specs/features/three-modes.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Without registry, users and AI agents cannot navigate methodology
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/ai-discoverability.spec.md
---

# LiveSpec v5 Registry

## Requirements
- [!] LiveSpec v5 provides unified commands and skills for spec-first development, with reference prompts for detailed workflows.
  - 5 commands for user invocation
  - 3 skills with mode-specific workflows
  - 5 reference prompts for detailed guidance
  - No submodule or legacy installation support (v5 is plugin-only)

## Commands

User-invocable via `/livespec:<command>`:

| Command | Purpose | Routes To |
|---------|---------|-----------|
| `go` | Intelligent entry point | Analyzes intent, routes to appropriate skill |
| `design` | Spec creation and refinement | design skill (feature, debug, refine, workspace, spec modes) |
| `audit` | Health, validation, context | audit skill (health, validate, context, extract modes) |
| `learn` | Session completion | learn skill (capture, compliance modes) |
| `upgrade` | Legacy → v5 migration | Guide to remove submodule, install plugin |

### Command: go

Entry point with intent routing:

| Intent Pattern | Routes To |
|----------------|-----------|
| "add", "create", "new feature" | `/livespec:design feature` |
| "fix", "debug", "broken" | `/livespec:design debug` |
| "update", "refine", "change" | `/livespec:design refine` |
| "check", "health", "validate" | `/livespec:audit` |
| "context", "rebuild", "regenerate" | `/livespec:audit context` |
| "done", "complete", "wrap up" | `/livespec:learn` |
| "upgrade", "migrate" | `/livespec:upgrade` |

### Command: upgrade

**CRITICAL**: This command NEVER updates git submodules. It only:
1. Detects legacy installations (submodule, symlink, dist/ copy)
2. Guides REMOVAL of legacy artifacts
3. Confirms plugin installation
4. Guides specs/ folder migration if needed

## Skills

Located in `skills/`:

| Skill | Modes | Purpose |
|-------|-------|---------|
| `design` | feature, debug, refine, workspace | Unified spec work |
| `audit` | health, validate, context, extract | Evolution and maintenance |
| `learn` | capture, compliance | Session completion and learning |

### Skill: design

Absorbed functionality from old: init, spec-writing, design prompts

| Mode | Purpose | Output |
|------|---------|--------|
| `feature` | New feature with spec-first | specs/features/*.spec.md |
| `debug` | Diagnose spec-implementation gaps | Analysis + spec updates |
| `refine` | Update existing spec | Updated spec |
| `workspace` | Setup/customize workspace | specs/workspace/*.spec.md |

### Skill: audit

Absorbed functionality from old: context-generation, drift-detection, validation prompts

| Mode | Purpose | Output |
|------|---------|--------|
| `health` | Proactive spec health check | Health report |
| `validate` | Run validation checks | Pass/fail status |
| `context` | Regenerate CLAUDE.md + AGENTS.md | Updated context files |
| `extract` | Extract specs from code | specs/features/*.spec.md |

### Skill: learn

New in v5, absorbed functionality from: complete-session, measure-compliance, learn prompts

| Mode | Purpose | Output |
|------|---------|--------|
| (default) | Full session completion | Compliance data + learnings |
| `capture` | Capture learnings mid-session | Spec updates |
| `compliance` | Show compliance scores only | Score report |

## Reference Prompts

Deep-dive guidance for skills (in `references/prompts/`):

| Prompt | Used By | Purpose |
|--------|---------|---------|
| `design/architecture.md` | design skill | Architecture design workflow |
| `evolve/extract-specs.md` | audit skill | Spec extraction from code |
| `utils/learn.md` | learn skill | Learning application workflow |
| `utils/health-report.md` | audit skill | Health check workflow |
| `utils/measure-compliance.md` | learn skill | Compliance measurement |

## Spec Templates

Located in `references/templates/specs/`:

| Template | Purpose |
|----------|---------|
| `base.spec.md` | Base requirements all specs inherit |
| `behavior.spec.md` | Observable outcome specs |
| `contract.spec.md` | API/interface specs |
| `outcomes.spec.md` | High-level requirements |
| `constraints.spec.md` | Hard boundaries |
| `strategy.spec.md` | Architectural decisions |
| `workspace.spec.md` | Process specs |
| `purpose.spec.md` | PURPOSE.md requirements |
| `domain-model.spec.md` | Domain model specs |
| `taxonomy.spec.md` | Project classification |

## Migration from v4

v4 → v5 changes:

| v4 | v5 | Notes |
|----|----|----|
| 17 commands | 5 commands | Consolidated |
| 7 skills | 3 skills | Merged |
| 32 prompts | 5 reference prompts | Absorbed into skills |
| Submodule install | Plugin install | No submodule operations |
| Numbered folders | Semantic folders | foundation/, strategy/, features/ |

## Validation

- Registry lists 5 commands, 3 skills, 5 reference prompts
- No references to submodule update operations
- upgrade command explicitly forbids submodule operations
- All paths point to existing files
- Skills reference appropriate templates
