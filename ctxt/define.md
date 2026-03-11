# DEFINE Mode

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
- Strategic success criteria
- High-level requirements (not features)
- Measurable outcomes

**specs/foundation/constraints.spec.md:**
- Hard boundaries (technical, legal, organizational)
- Non-negotiable requirements
- Compliance mandates

**specs/workspace/:**
- constitution.spec.md - Development principles
- patterns.spec.md - Conventions
- workflows.spec.md - Development processes
- taxonomy.spec.md - Project classification

## Decision Points

**Should I skip Define mode?**
- YES if: Extracting from existing codebase (use `/livespec:evolve extract`)
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
/livespec:do design      # Move to design mode
```

Total: 10 minutes to working specs

### Team Onboarding Path

```bash
/livespec:init --full    # 20-30 min interactive
# Workshop PURPOSE.md    # Team discussion
# Document constraints   # From team input
/livespec:rebuild-context
```

Total: 1-2 hours, entire team aligned

### Existing Codebase (Brownfield)

Skip Define mode entirely:
```bash
/livespec:evolve extract  # Extract specs from code
# Validate extractions
# Customize workspace specs
```

## References

- Init skill: `/livespec:init`
- Parent context: AGENTS.md
- Metaspecs: `.livespec/standard/metaspecs/outcomes.spec.md`, `.livespec/standard/metaspecs/constraints.spec.md`

---

*Define mode specialist for LiveSpec*
*Parent: AGENTS.md*
