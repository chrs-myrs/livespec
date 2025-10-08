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
├── AGENTS.md               # Agent configuration (copied from dist/)
├── CLAUDE.md → AGENTS.md   # Symlink for agent discovery
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
    ├── AGENTS.md           # Source for project AGENTS.md
    ├── prompts/
    ├── standard/
    └── templates/
```

## Step 0: Bootstrap Agent Configuration

**CRITICAL**: Do this FIRST so AI can discover prompts and help with remaining steps.

### 0a: Copy Generic AGENTS.md

```bash
# Copy starter AGENTS.md to project root
cp .livespec/AGENTS.md AGENTS.md
```

This generic AGENTS.md contains LiveSpec methodology knowledge and works for any project immediately.

### 0b: Create Agent Symlink

```bash
# Create symlink for your AI assistant
ln -s AGENTS.md CLAUDE.md      # For Claude Code
# OR
ln -s AGENTS.md COPILOT.md     # For GitHub Copilot
# OR
ln -s AGENTS.md CURSOR.md      # For Cursor IDE
```

### 0c: Verify Discoverability

Test that your AI agent can now access prompts:
- Ask: "What LiveSpec prompts are available?"
- AI should list Phase 0-4 prompts
- If not, check AGENTS.md and symlink exist

**Why this works:** AGENTS.md caches methodology context so AI doesn't need repeated context7 lookups.

**Note:** After customizing workspace specs, regenerate AGENTS.md using `prompts/4-evolve/4d-regenerate-agents.md` for project-specific content.

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

## Regenerate Agent Configuration (Optional)

After customizing workspace specs, you can regenerate AGENTS.md for project-specific content:

```bash
# Regenerate AGENTS.md from workspace specs + PURPOSE.md
# (Use prompts/4-evolve/4d-regenerate-agents.md)
```

**When to regenerate:**
- After customizing constitution.spec.md, patterns.spec.md, workflows.spec.md
- After creating PURPOSE.md with project-specific vision
- To replace generic AGENTS.md with project-specific version

**Note:** The generic AGENTS.md from Step 0 already works fine for most projects. Only regenerate if you need project-specific methodology content in AGENTS.md.

## Exit Criteria

**Step 0 (Critical for discoverability):**
- [ ] AGENTS.md exists at project root (copied from .livespec/)
- [ ] Agent-specific symlink created (CLAUDE.md, COPILOT.md, or CURSOR.md)
- [ ] AI agent can discover .livespec/ prompts

**Step 1 (Version tracking):**
- [ ] .livespec-version file created
- [ ] customizations.yaml file created

**Step 2 (Domain organization):**
- [ ] Domain organization considered (subfolders if needed)

**Step 3 (Workspace specs):**
- [ ] Folder structure matches LiveSpec standard
- [ ] specs/workspace/ contains constitution, patterns, workflows
- [ ] All workspace specs follow MSL format
- [ ] Workspace defines HOW to build, not WHAT to build

**Optional:**
- [ ] AGENTS.md regenerated from workspace specs (if project-specific content needed)

## Next Step

Once workspace is established, proceed to `0b-define-problem.md`
