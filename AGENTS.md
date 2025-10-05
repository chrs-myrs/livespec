# LiveSpec Agent Configuration

## Summary

This document provides essential LiveSpec knowledge for AI agents. Cache this once per session to handle 90% of LiveSpec operations without repeated context7 lookups. Check for project-specific workspace specs for overrides.

## Quick Start Template (80% of Cases)

### Setting Up New Project
```bash
# 1. Copy LiveSpec methodology
cp -r livespec/prompts .livespec

# 2. Create specs structure
mkdir -p specs/{workspace,behaviors,contracts}

# 3. Create PURPOSE.md
echo "# Project Purpose

## Why This Exists
[Problem this project solves]

## What Success Looks Like
[Measurable success criteria]" > PURPOSE.md

# 4. Use first prompt
# "Use .livespec/0-define/0a-setup-workspace.md"
```

### Working with Existing Project
```bash
# Extract specifications from existing code
# "Use .livespec/4-evolve/4b-extract-specs.md to document this codebase"
```

## Decision Tree

```
What do you need to do?
│
├─ **New project?**
│  └─ Start Phase 0: Use .livespec/0-define/0a-setup-workspace.md
│
├─ **Existing project without specs?**
│  └─ Start Phase 4: Use .livespec/4-evolve/4b-extract-specs.md
│
├─ **Code and specs drifted?**
│  └─ Phase 4: Use .livespec/4-evolve/4a-detect-drift.md
│
├─ **Need to design new feature?**
│  └─ Phase 1: Use .livespec/1-design/1a-design-architecture.md
│
├─ **Ready to implement?**
│  └─ Phase 2: Use .livespec/2-build/2a-implement-from-specs.md
│
└─ **Need validation?**
   └─ Phase 3: Use .livespec/3-verify/3a-run-validation.md
```

## The 5 Phases

### Phase 0: DEFINE
Establish problem space and development approach.

**When**: Starting new project
**Outputs**: PURPOSE.md, workspace specs, constraints
**Key Prompt**: `0a-setup-workspace.md`

### Phase 1: DESIGN
Design solution architecture.

**When**: After problem is clear, before implementation
**Outputs**: architecture.spec.md, behaviors/, contracts/
**Key Prompt**: `1a-design-architecture.md`

### Phase 2: BUILD
Implement the solution.

**When**: After design is approved
**Outputs**: Code + tests that satisfy specifications
**Key Prompt**: `2a-implement-from-specs.md`

### Phase 3: VERIFY
Validate solution meets requirements.

**When**: After implementation is complete
**Outputs**: Validation report, stakeholder approval
**Key Prompt**: `3a-run-validation.md`

### Phase 4: EVOLVE
Keep specs and code synchronized (continuous).

**When**: Ongoing throughout development
**Outputs**: Updated specifications, drift reports
**Key Prompt**: `4a-detect-drift.md`

## MSL Format Quick Reference

All specifications use MSL (Minimal Specification Language):

```markdown
# [Feature/Component Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [What breaks without this]

## Specification
[Concise description of WHAT is required, not HOW]

## Validation
- [Testable criterion 1]
- [Testable criterion 2]
- [Testable criterion 3]
```

**That's it.** Four sections. Keep specifications minimal.

## Folder Structure Pattern

```
your-project/
├── PURPOSE.md              # Always create first
│
├── .livespec/              # Copied from livespec/prompts/
│   ├── 0-define/
│   ├── 1-design/
│   ├── 2-build/
│   ├── 3-verify/
│   ├── 4-evolve/
│   └── templates/          # Workspace templates
│
└── specs/
    ├── workspace/          # HOW you build (process)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── behaviors/          # WHAT system does
    ├── contracts/          # API/data contracts
    └── constraints.spec.md # Hard boundaries
```

## Essential Templates

### Workspace Constitution
```markdown
# [Project Name] Development Constitution

**Criticality**: CRITICAL
**Failure Mode**: Development becomes inconsistent

## Specification
[3-5 core development principles for this project]

## Validation
- [Observable behaviors demonstrating adherence]
```

### Behavior Specification
```markdown
# [Feature Name]

**Criticality**: CRITICAL
**Failure Mode**: [Impact if missing]

## Specification
[Observable behavior the system must exhibit]

## Validation
- [How to verify this works]
- [Edge cases to test]
```

### API Contract
```markdown
# [Endpoint Name]

**Criticality**: CRITICAL
**Failure Mode**: [Integration breaks]

## Specification
[Request/response format, authentication, rate limits]

## Validation
- [Valid requests succeed]
- [Invalid requests fail appropriately]
```

## Key Principles

1. **Workspace vs Product** - Separate HOW (workspace/) from WHAT (behaviors/)
2. **MSL Minimalism** - Specify only CRITICAL or IMPORTANT requirements
3. **Bidirectional Sync** - Specs → Code AND Code → Specs
4. **Phase 4 is Continuous** - Drift detection prevents staleness
5. **Trust Implementers** - Don't over-prescribe details

## Common Anti-Patterns

❌ **Skipping Phase 0**
```
Bad:  Jump straight to coding
Good: Create PURPOSE.md and workspace specs first
```

❌ **Over-specification**
```
Bad:  "Button must be exactly 120px wide with #007bff color"
Good: "Submit button must be clearly visible"
```

❌ **Ignoring Drift**
```
Bad:  Let specs and code diverge over months
Good: Run Phase 4 drift detection weekly/before releases
```

❌ **Wrong Criticality**
```
Bad:  Everything marked CRITICAL
Good: Only truly critical requirements marked CRITICAL
```

## Bidirectional Linking

LiveSpec uses YAML frontmatter for bidirectional links:

**In prompts:**
```markdown
---
spec: specs/prompts/0a-setup-workspace.spec.md
---
```

**In specs:**
```markdown
---
specifies: prompts/0-define/0a-setup-workspace.md
---
```

This enables AI agents to navigate between prompts and their specifications.

## When to Fetch Full Prompts

Cache this document, but fetch full prompts when you need:

| Need | Fetch | When |
|------|-------|------|
| Setup workspace | `.livespec/0-define/0a-setup-workspace.md` | New project |
| Extract specs | `.livespec/4-evolve/4b-extract-specs.md` | Existing codebase |
| Detect drift | `.livespec/4-evolve/4a-detect-drift.md` | Periodic sync check |
| Design architecture | `.livespec/1-design/1a-design-architecture.md` | Before implementation |
| Implement | `.livespec/2-build/2a-implement-from-specs.md` | Building features |
| Validate | `.livespec/3-verify/3a-run-validation.md` | Testing completeness |

## Workspace Specs Guide AI

The three workspace specs define HOW this specific project is built:

- **constitution.spec.md** - Development principles and governance
- **patterns.spec.md** - Code and specification patterns
- **workflows.spec.md** - Development process workflows

**Always read workspace specs first** when working on a project. They contain project-specific conventions and constraints.

## Quick Examples by Use Case

### Starting Fresh
```bash
# 1. Copy methodology
cp -r livespec/prompts .livespec

# 2. Create structure
mkdir -p specs/{workspace,behaviors,contracts}

# 3. Use first prompt
# "Use .livespec/0-define/0a-setup-workspace.md"
```

### Documenting Existing Code
```bash
# Use extract prompt on existing codebase
# "Use .livespec/4-evolve/4b-extract-specs.md to document this codebase"
```

### Checking for Drift
```bash
# Run drift detection
# "Use .livespec/4-evolve/4a-detect-drift.md"
```

### Designing New Feature
```bash
# Use design prompts
# "Use .livespec/1-design/1b-define-behaviors.md for [feature]"
```

## Integration with Context7

When using Context7:
```bash
# Fetch LiveSpec methodology remotely
"Use @context7/chrs-myrs/livespec methodology"
```

Context7 will provide:
- This AGENTS.md file (cache it!)
- Full prompt files as needed
- MSL guide
- Examples

## Final Notes

LiveSpec is just folders and markdown. The methodology guides AI agents to:
1. Create proper specifications (Phase 0-1)
2. Implement from specs (Phase 2)
3. Validate correctness (Phase 3)
4. Keep specs synchronized (Phase 4)

Remember: Start simple, add complexity only when needed. Trust the phases.

---
*Agent configuration for [LiveSpec](https://github.com/chrs-myrs/livespec)*
