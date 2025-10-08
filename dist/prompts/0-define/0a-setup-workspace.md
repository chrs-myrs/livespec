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
    ├── .livespec-version   # Version tracking
    ├── customizations.yaml # Customization tracking
    ├── prompts/
    ├── standard/
    └── templates/
```

## Step 1: Create Version Tracking Files

Create version and customization tracking files (enables safe upgrades):

```bash
# Create version file
cp .livespec/.livespec-version.template .livespec/.livespec-version

# Create customizations tracking file
cp .livespec/customizations.yaml.template .livespec/customizations.yaml
```

**These files track:**
- `.livespec-version` - Installed LiveSpec version (for upgrade detection)
- `customizations.yaml` - Your customizations to prompts/templates (for safe upgrades)

**AI agents:** Update `customizations.yaml` when user customizes prompts or templates.

## Step 2: Organize Specs by Domain (Optional)

Consider organizing specs with subfolders for clarity:

**Software projects:**
```
specs/behaviors/
├── user-features/     # User-facing behaviors
│   ├── authentication.spec.md
│   └── authorization.spec.md
└── system/            # System behaviors
    └── caching.spec.md

specs/contracts/
└── api/v1/            # API contracts
    └── users-api.yaml
```

**Governance projects:**
```
specs/behaviors/
├── policies/          # Policy behaviors
│   ├── access-control.spec.md
│   └── data-protection.spec.md
└── compliance/        # Compliance behaviors
    └── gdpr.spec.md

specs/contracts/
└── procedures/        # Process contracts
    └── incident-response.spec.md
```

**Operations projects:**
```
specs/behaviors/
└── services/          # Service behaviors
    ├── backup.spec.md
    └── monitoring.spec.md

specs/contracts/
└── runbooks/          # Operational contracts
    ├── incident-response.spec.md
    └── deployment.spec.md
```

**Hybrid projects:**
```
specs/behaviors/
├── user-features/     # Software
├── policies/          # Governance
└── services/          # Operations

specs/contracts/
├── api/               # Software
├── procedures/        # Governance
└── runbooks/          # Operations
```

**Key insight:** behaviors/ and contracts/ work across domains. Organize by domain within these abstractions using subfolders.

## Step 3: Workspace Specifications

Create initial workspace specifications in `specs/workspace/` using provided templates:

### 3a: Copy Templates

```bash
cp .livespec/templates/workspace/*.template specs/workspace/
```

### 3b: Customize Each Template

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

### 3c: Remove .template Extensions

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
- [ ] .livespec-version file created
- [ ] customizations.yaml file created
- [ ] Domain organization considered (subfolders if needed)
- [ ] specs/workspace/ contains constitution, patterns, workflows
- [ ] All workspace specs follow MSL format
- [ ] Workspace defines HOW to build, not WHAT to build
- [ ] AGENTS.md generated from workspace specs
- [ ] Agent-specific symlink created (CLAUDE.md, COPILOT.md, etc.)

## Next Step

Once workspace is established, proceed to `0b-define-problem.md`
