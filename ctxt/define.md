# DEFINE Mode

> **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

Sub-agent context for problem definition and workspace setup.

## Summary

Define mode establishes the problem space and project constraints. This mode creates the foundation by defining why the project exists, what success looks like, and how the team will work together.

## When to Use

**Entry conditions:**
- Starting new project (no specs exist yet)
- Existing project without specifications
- Problem space unclear or assumptions unchallenged

**Exit conditions:**
- PURPOSE.md defines why project exists and success criteria
- Constraints and outcomes documented in specs/foundation/
- Workspace specs (constitution, patterns, workflows) customized
- Team aligned on approach

## Workflow

### Quick Start Path (5 minutes)

Use `/livespec:init`:
1. Creates directory structure
2. Copies default workspace specs
3. Generates template PURPOSE.md
4. Creates initial AGENTS.md

### Full Customization Path (20-30 minutes)

Use `/livespec:init --full`:
1. Interactive domain selection (Software/Governance/Hybrid)
2. Compression level choice (light/moderate/aggressive)
3. Customized workspace specs
4. Tailored AGENTS.md generation

### Key Artifacts

**PURPOSE.md** (must be <20 lines):
```markdown
# Project Purpose

## Why This Exists
[Problem this project solves - 1-3 sentences]

## What Success Looks Like
- [Measurable criterion 1]
- [Measurable criterion 2]
- [Measurable criterion 3]
```

**specs/foundation/outcomes.spec.md:**
```yaml
---
type: outcomes
category: foundation
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without clear outcomes, project lacks cohesive direction
governed-by: []
derives-from:
  - PURPOSE.md
supports:
  - specs/strategy/architecture.spec.md
---
```
- Strategic success criteria
- High-level requirements (not features)
- Measurable outcomes

**specs/foundation/constraints.spec.md:**
```yaml
---
type: constraints
category: foundation
fidelity: behavioral
criticality: CRITICAL
failure_mode: Violating constraints makes project unusable or defeats its purpose
governed-by: []
derives-from:
  - PURPOSE.md
  - specs/foundation/outcomes.spec.md
supports:
  - specs/strategy/architecture.spec.md
---
```
- Hard boundaries (technical, legal, organizational)
- Non-negotiable requirements
- Compliance mandates

**specs/workspace/:**
- constitution.spec.md — Development principles
- patterns.spec.md — Conventions
- workflows.spec.md — Development processes
- taxonomy.spec.md — Project classification

### Workspace Frontmatter Template

Workspace specs require `applies_to` field:
```yaml
---
type: workspace
category: workspace
fidelity: process
criticality: IMPORTANT
failure_mode: [Concrete failure description]
governed-by: []
applies_to:
  - all_projects
---
```

## Decision Points

**Should I skip Define mode?**
- YES if: Extracting from existing codebase (use `/livespec:audit extract`)
- NO if: Starting new project (need foundation)

**Quick start or full customization?**
- Quick: Solo developer, familiar with LiveSpec, time-sensitive
- Full: Team, new to LiveSpec, complex domain

**How detailed should PURPOSE.md be?**
- Vision only (<20 lines)
- NOT feature lists (those go in specs/features/)
- NOT constraints (those go in specs/foundation/constraints.spec.md)

## Common Patterns

### Solo Developer Fast Path

```bash
/livespec:init           # 5 min setup
# Edit PURPOSE.md        # 5 min
/livespec:design         # Move to design mode
```

Total: 10 minutes to working specs

### Team Onboarding Path

```bash
/livespec:init --full    # 20-30 min interactive
# Workshop PURPOSE.md    # Team discussion
# Document constraints   # From team input
/livespec:audit context  # Rebuild context
```

Total: 1-2 hours, entire team aligned

### Existing Codebase (Brownfield)

Skip Define mode entirely:
```bash
/livespec:audit extract  # Extract specs from code
# Validate extractions
# Customize workspace specs
```

## Taxonomy Decisions

During Define mode, establish taxonomy (`specs/workspace/taxonomy.spec.md`):

**Domain options:**
- `software` — User-facing application or service
- `governance` — Methodology frameworks, policies, procedures
- `generation` — AI/automation pipelines
- `planning` — Project management, roadmaps
- `documentation` — Knowledge management
- `hybrid` — Multiple domains

**Key taxonomy outputs:**
- Project Domain (affects how features/ is organized)
- Workspace Scope (what's operating context vs deliverable)
- Specs Boundary (what belongs in specs/ vs dist/)

## References

- Init skill: `/livespec:init`
- Parent context: AGENTS.md
- Metaspecs: `references/standards/metaspecs/base.spec.md`

---

*Define mode specialist for LiveSpec v5.4.0*
*Parent: AGENTS.md*
