---
spec: specs/prompts/0a-setup-workspace.spec.md
---

# 0a: Setup Workspace

**Phase**: DEFINE
**Purpose**: Create LiveSpec folder structure and workspace specifications
**Context**: See `specs/prompts/folder-structure.spec.md` for structure requirements

## Task

Create the standard LiveSpec folder structure for this project:

```
project/
├── specs/
│   ├── workspace/
│   │   ├── constitution.md
│   │   ├── patterns.md
│   │   └── workflows.md
│   ├── behaviors/
│   └── contracts/
└── prompts/
    ├── 0-define/
    ├── 1-design/
    ├── 2-build/
    ├── 3-verify/
    └── 4-evolve/
```

## Workspace Specifications

Create initial workspace specifications in `specs/workspace/`:

###constitution.md
Define core development principles for this project:
- What governance rules apply?
- What quality standards must be met?
- What philosophies guide decisions?

### patterns.md
Define code and specification patterns:
- Naming conventions
- File organization rules
- Quality criteria

### workflows.md
Define development workflows:
- How to add features
- How to fix bugs
- How to review changes

## Format

All specifications must follow MSL format (see `specs/behaviors/msl-format.md`):

```markdown
# [Name]
**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [What breaks]

## Specification
[Minimal description]

## Validation
[How to verify]
```

## Exit Criteria

- [ ] Folder structure matches LiveSpec standard
- [ ] specs/workspace/ contains constitution, patterns, workflows
- [ ] All workspace specs follow MSL format
- [ ] Workspace defines HOW to build, not WHAT to build

## Next Step

Once workspace is established, proceed to `0b-define-problem.md`
