# LiveSpec Framework Deployment Guide

This guide explains how to deploy and maintain the Living Specification (LiveSpec) Framework in your projects.

## Table of Contents

1. [Deployment Methods](#deployment-methods)
2. [New Project Setup](#new-project-setup)
3. [Existing Project Migration](#existing-project-migration)
4. [Framework Updates](#framework-updates)
5. [Configuration](#configuration)
6. [Troubleshooting](#troubleshooting)

## Deployment Methods

The LiveSpec framework can be deployed in several ways:

### Method 1: Deploy Script (Recommended)

Use the deployment script from the framework repository:

```bash
# Clone the framework repository
git clone https://github.com/your-org/livespec-framework.git
cd livespec-framework

# Deploy to your project
./deploy-framework.sh /path/to/your/project
```

This method:
- ✅ Copies all prompts to `.claude/commands/livespec/`
- ✅ Creates proper directory structure
- ✅ Sets up configuration files
- ✅ Creates helper scripts
- ✅ Preserves existing content

### Method 2: Manual Installation

For manual control over the installation:

```bash
# In your project directory
mkdir -p .claude/commands/livespec
cp -r /path/to/framework/prompts/* .claude/commands/livespec/
./install-livespec.sh
```

### Method 3: Git Submodule

For teams wanting version control of the framework:

```bash
# Add framework as submodule
git submodule add https://github.com/your-org/livespec-framework.git .claude/framework
git submodule init
git submodule update

# Link to commands directory
ln -s ../../framework/prompts .claude/commands/livespec
```

## New Project Setup

### Step 1: Deploy Framework

```bash
# From framework directory
./deploy-framework.sh /path/to/new/project

# Or from project directory
curl -sSL https://raw.githubusercontent.com/your-org/livespec-framework/main/install-livespec.sh | bash
```

### Step 2: Initialize Project

```bash
cd /path/to/new/project

# Start the orchestrator
./livespec-start.sh
# OR
claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
```

### Step 3: Follow Guided Setup

The orchestrator will guide you through:
1. Project initialization (0a)
2. Complexity assessment (0b)
3. UX discovery if needed (0c)
4. Purpose definition (1a)
5. And continue through all stages...

## Existing Project Migration

### For Projects with Old LiveSpec Versions

1. **Deploy new framework**:
   ```bash
   ./deploy-framework.sh /path/to/existing/project
   ```

2. **Migrate content**:
   ```bash
   claude-code "Use .claude/commands/livespec/migrate-content.md"
   ```

3. **Review migration report**:
   ```bash
   cat reqs/content-migration-report.md
   ```

4. **Fill gaps using orchestrator**:
   ```bash
   claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
   ```

### For Projects with No Framework

1. **Deploy framework**:
   ```bash
   ./deploy-framework.sh /path/to/project
   ```

2. **Extract from code** (if code exists):
   ```bash
   claude-code "Use .claude/commands/livespec/extract-specs-from-code.md"
   ```

3. **Start documentation**:
   ```bash
   ./livespec-start.sh
   ```

## Framework Updates

### Checking for Updates

```bash
# Check current version
cat .claude/livespec.config.json | grep version

# Check for updates (if update script exists)
./update-livespec.sh
```

### Updating Framework

1. **Backup current state**:
   ```bash
   cp -r .claude/commands/livespec .claude/backups/livespec-$(date +%Y%m%d)
   ```

2. **Deploy new version**:
   ```bash
   # From updated framework repo
   ./deploy-framework.sh /path/to/project
   ```

3. **Migrate content if needed**:
   ```bash
   claude-code "Use .claude/commands/livespec/migrate-content.md"
   ```

### Version Compatibility

| Your Version | Latest Version | Action Required |
|-------------|----------------|-----------------|
| 2.0.0 | 2.0.x | Simple update |
| 1.x.x | 2.0.0 | Content migration needed |
| None | 2.0.0 | Fresh deployment |

## Configuration

### Framework Configuration

The framework configuration is stored in `.claude/livespec.config.json`:

```json
{
  "framework": {
    "name": "LiveSpec - Living Specification Framework",
    "version": "2.0.0",
    "deployed": "2024-01-01T10:00:00Z"
  },
  "project": {
    "customizations": [],
    "excluded_prompts": []
  },
  "paths": {
    "prompts": ".claude/commands/livespec",
    "reqs": "reqs",
    "templates": ".claude/commands/livespec/templates"
  }
}
```

### Project Configuration

Project-specific settings in `CLAUDE.md`:

```markdown
# Project Context for Claude Code

## LiveSpec Framework
This project uses LiveSpec Framework v2.0.0

### Custom Settings
- Review cycle: 3 days
- Stakeholders: @alice, @bob
- Skip stages: [if any]
```

### Directory Structure

Standard structure created by deployment:

```
your-project/
├── .claude/
│   ├── commands/
│   │   └── livespec/          # Framework prompts
│   ├── livespec.config.json   # Framework config
│   └── backups/           # Version backups
├── reqs/                  # Your specifications
│   ├── 0-ux/             # UX documentation
│   ├── 1-purpose/        # Purpose docs
│   ├── 2-strategy/       # Strategy docs
│   ├── 3-design/         # Design docs
│   ├── 4-components/     # Component specs
│   ├── 5-implementation/ # Implementation
│   └── reviews/          # Stakeholder reviews
├── CLAUDE.md             # Project context
├── livespec-start.sh         # Quick start script
└── livespec-status.sh        # Status check script
```

## Troubleshooting

### Common Issues

#### "Command not found" when using prompts

**Problem**: Claude Code can't find the prompts
**Solution**: 
```bash
# Check prompt location
ls -la .claude/commands/livespec/

# Ensure correct path in commands
claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
```

#### "Permission denied" errors

**Problem**: Scripts not executable
**Solution**:
```bash
chmod +x livespec-start.sh
chmod +x livespec-status.sh
chmod +x update-livespec.sh
```

#### Old and new structures mixed

**Problem**: Confusion between versions
**Solution**:
```bash
# Clean up old structure
mv prompts prompts.old
mv reqs reqs.backup

# Redeploy framework
./deploy-framework.sh .

# Migrate content
claude-code "Use .claude/commands/livespec/migrate-content.md"
```

#### Missing dependencies

**Problem**: Project missing required structure
**Solution**:
```bash
# Run installer to create structure
./install-livespec.sh

# Or manually create
mkdir -p reqs/{0-ux,1-purpose,2-strategy,3-design,4-components,5-implementation}
mkdir -p reqs/{reviews/feedback,spikes,learnings}
```

### Getting Help

1. **Check documentation**:
   ```bash
   cat .claude/commands/livespec/FRAMEWORK_README.md
   ```

2. **Run diagnostics**:
   ```bash
   ./livespec-status.sh
   ```

3. **Use orchestrator for guidance**:
   ```bash
   claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
   ```

## Best Practices

### DO's ✅

1. **Always backup before updates**
2. **Use deployment scripts** rather than manual copying
3. **Keep framework and content separate**
4. **Version control your specifications** (reqs/)
5. **Document customizations** in CLAUDE.md

### DON'Ts ❌

1. **Don't modify framework prompts directly** (use customizations)
2. **Don't mix versions** (old and new in same project)
3. **Don't skip the orchestrator** (it prevents issues)
4. **Don't ignore migration reports** (they highlight gaps)

## Advanced Topics

### Custom Prompts

Add project-specific prompts in `.claude/commands/custom/`:
```bash
mkdir -p .claude/commands/custom
# Add your prompts here
```

### Framework Extensions

Extend the framework without modifying core:
1. Create extension prompts in custom directory
2. Reference core prompts from extensions
3. Document in CLAUDE.md

### CI/CD Integration

Integrate LiveSpec checks in your pipeline:
```yaml
# Example GitHub Action
- name: Check Documentation Health
  run: |
    claude-code "Use .claude/commands/livespec/align-specs-to-code.md"
```

## Summary

The LiveSpec framework deployment system provides:
- **Easy installation** via scripts
- **Clean separation** of framework and content
- **Version management** with migrations
- **Flexible configuration** options
- **Helper tools** for common tasks

Start with `deploy-framework.sh` for new deployments or `migrate-content.md` for existing projects, then let the orchestrator guide you through the documentation process.