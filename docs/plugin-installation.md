# LiveSpec Plugin Installation Guide

This guide covers installing LiveSpec as a Claude Code plugin.

## Requirements

- **Claude Code 1.0.33 or later**
- Internet connection (for initial install)

## Installation

### Step 1: Add Marketplace

```bash
/plugin marketplace add chrs-myrs/livespec
```

This adds the LiveSpec self-hosted marketplace to your Claude Code configuration.

### Step 2: Install Plugin

```bash
/plugin install livespec@livespec
```

This installs the LiveSpec plugin from the marketplace.

### Step 3: Verify Installation

```bash
/plugin list
```

You should see `livespec` in the list of installed plugins.

### Step 4: Test a Command

```bash
/livespec:next-steps
```

This should analyze your project and suggest next steps.

## Initialize a Project

For new projects:

```bash
# Quick start with defaults (5 min)
/livespec:init

# Or full customization (20-30 min)
/livespec:init --full
```

This creates:
- `specs/workspace/` - Workspace specifications
- `AGENTS.md` - Agent context
- `PURPOSE.md` - Project purpose template

## Available Commands

### Core Skills

| Command | Description |
|---------|-------------|
| `/livespec:go` | Intelligent entry point - routes based on intent |
| `/livespec:init` | Initialize project with workspace specs |
| `/livespec:design` | Create and refine specifications |
| `/livespec:audit` | Health, validation, context generation |
| `/livespec:learn` | Session completion and learning capture |
| `/livespec:upgrade` | Migrate to latest version |

### Subcommands

| Command | Description |
|---------|-------------|
| `/livespec:design feature <name>` | Create new feature spec |
| `/livespec:design debug <issue>` | Diagnose spec-implementation gap |
| `/livespec:design refine <spec>` | Update existing spec |
| `/livespec:audit health` | Detailed health report |
| `/livespec:audit validate` | Run validation checks |
| `/livespec:audit context` | Regenerate AGENTS.md |
| `/livespec:audit extract` | Extract specs from code |
| `/livespec:learn capture` | Capture learnings mid-session |
| `/livespec:learn compliance` | Show compliance scores |

## Updating

To update to the latest version:

```bash
/plugin update livespec
```

## Uninstalling

To remove the plugin:

```bash
/plugin uninstall livespec
```

Your project files (specs/, AGENTS.md, etc.) remain unchanged.

## Configuration

The plugin reads configuration from `project.yaml` if it exists:

```yaml
livespec:
  methodology:
    spec_first: mandatory
    tdd: mandatory_with_escape
    context_compression: moderate
  taxonomy:
    domain: software
    workspace_scope: [constitution, patterns, workflows, taxonomy]
    specs_boundary: specifications_only

agent:
  doc_format: AGENTS.md
  context_budget: 100KB
  coverage_target: 80
```

If `project.yaml` doesn't exist, sensible defaults are used.

## Troubleshooting

### "Plugin not found"

Make sure you've added the marketplace:
```bash
/plugin marketplace add chrs-myrs/livespec
```

### Commands not appearing

1. Check plugin is installed: `/plugin list`
2. Restart Claude Code
3. Try reinstalling: `/plugin uninstall livespec && /plugin install livespec@livespec`

### Permission errors

The plugin needs permission to:
- Read files (for validation)
- Write files (for spec generation)
- Run bash commands (for some validations)

Approve permissions when prompted.

### Old references in AGENTS.md

If your AGENTS.md references old `.livespec/` paths:
```bash
/livespec:audit context
```

## Migrating from dist/ Copy

See [Migration Guide](migration-to-plugin.md) for detailed migration steps.

## Self-Hosted Marketplace

LiveSpec uses a self-hosted marketplace. The marketplace definition is at:

```
https://github.com/chrs-myrs/livespec/.claude-plugin/marketplace.json
```

This allows plugin distribution without requiring central marketplace approval.

## Need Help?

- [Migration Guide](migration-to-plugin.md)
- [README](../README.md)
- [GitHub Issues](https://github.com/chrs-myrs/livespec/issues)
