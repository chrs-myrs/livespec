---
spec: specs/behaviors/prompts/0a-setup-workspace.spec.md
---

# 0a: Setup Workspace

**Phase**: DEFINE
**Purpose**: Create LiveSpec folder structure and workspace specifications
**Context**: See `specs/behaviors/folder-structure.spec.md` for structure requirements

## Task

Create the standard LiveSpec folder structure for this project:

```
project/
├── specs/
│   ├── workspace/
│   │   ├── constitution.spec.md
│   │   ├── patterns.spec.md
│   │   └── workflows.spec.md
│   ├── behaviors/
│   └── contracts/
└── .livespec/              # Already copied from dist/
    ├── prompts/
    ├── standard/
    └── templates/
```

## Workspace Specifications

Create initial workspace specifications in `specs/workspace/` using provided templates:

### Step 1: Copy Templates

```bash
cp .livespec/templates/workspace/*.template specs/workspace/
```

### Step 2: Customize Each Template

**constitution.spec.md.template** → **constitution.spec.md**
- Replace `[PROJECT_NAME]` with your project name
- Define core development principles
- Specify governance rules and quality standards
- Document guiding philosophies

**patterns.spec.md.template** → **patterns.spec.md**
- Define naming conventions
- Specify file organization rules
- Document coding patterns and quality criteria

**workflows.spec.md.template** → **workflows.spec.md**
- Document how to add features
- Specify bug fix process
- Define change review workflow

### Step 3: Remove .template Extensions

```bash
cd specs/workspace
mv constitution.spec.md.template constitution.spec.md
mv patterns.spec.md.template patterns.spec.md
mv workflows.spec.md.template workflows.spec.md
```

## Format

All specifications must follow MSL format (see `specs/behaviors/msl-format.spec.md`):

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks]
---

# [Name]

## Requirements
- [!] [Minimal description]
  - [How to verify]
```

## Agent Configuration

After workspace specs are created, generate agent configuration file:

```bash
# Generate AGENTS.md from workspace specs + PURPOSE.md
# (Use prompts/4-evolve/4d-regenerate-agents.md)

# Create agent-specific symlink for your AI assistant
ln -s AGENTS.md CLAUDE.md      # For Claude Code
ln -s AGENTS.md COPILOT.md     # For GitHub Copilot
ln -s AGENTS.md CURSOR.md      # For Cursor IDE
```

This enables your AI agent to cache methodology context and guide you proactively.

## Exit Criteria

- [ ] Folder structure matches LiveSpec standard
- [ ] specs/workspace/ contains constitution, patterns, workflows
- [ ] All workspace specs follow MSL format
- [ ] Workspace defines HOW to build, not WHAT to build
- [ ] AGENTS.md generated from workspace specs
- [ ] Agent-specific symlink created (CLAUDE.md, COPILOT.md, etc.)

## Next Step

Once workspace is established, proceed to `0b-define-problem.md`
