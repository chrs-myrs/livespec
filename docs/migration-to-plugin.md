# Migration Guide: dist/ to Plugin

This guide helps existing LiveSpec users migrate from the file-copy distribution (`cp -r dist/ .livespec/`) to the Claude Code plugin installation.

## Why Migrate?

| Aspect | dist/ Copy | Plugin |
|--------|------------|--------|
| Updates | Manual copy | `/plugin update livespec` |
| File duplication | ~100 files per project | None |
| Commands | Use prompt paths | `/livespec:*` commands |
| Version management | Manual tracking | Automatic |
| IDE integration | None | Slash command autocomplete |

## Prerequisites

- Claude Code 1.0.33 or later
- Existing project with `.livespec/` directory

## Migration Steps

### Step 1: Verify Current Setup

```bash
# Check your current LiveSpec version
cat .livespec/VERSION 2>/dev/null || cat .livespec-version

# List what you have
ls -la .livespec/
```

### Step 2: Install Plugin

```bash
# Add LiveSpec marketplace
/plugin marketplace add chrs-myrs/livespec

# Install plugin
/plugin install livespec@livespec
```

### Step 3: Verify Plugin Works

Test a command to ensure the plugin is active:

```bash
/livespec:validate
```

You should see validation output (may show errors if project needs updates - that's fine).

### Step 4: Update Project References

If you have any scripts or documentation referencing `.livespec/` paths, update them:

| Old Reference | New Reference |
|---------------|---------------|
| `.livespec/prompts/0-define/0a-quick-start.md` | `/livespec:init` |
| `.livespec/prompts/1-design/1b-design-architecture.md` | `/livespec:design architecture` |
| `.livespec/prompts/2-build/2a-implement-from-specs.md` | `/livespec:build` |
| `.livespec/prompts/3-verify/3a-run-validation.md` | `/livespec:verify` |
| `.livespec/prompts/4-evolve/4a-detect-drift.md` | `/livespec:audit detect` |
| `.livespec/prompts/utils/validate-project.md` | `/livespec:validate` |
| `.livespec/prompts/utils/complete-session.md` | `/livespec:complete-session` |

### Step 5: Remove .livespec/ Directory

Once you've verified the plugin works:

```bash
# Remove the copied framework files
rm -rf .livespec/

# If using submodule
git submodule deinit .livespec-repo
git rm .livespec-repo
rm -rf .git/modules/.livespec-repo
```

### Step 6: Update .gitignore

Remove any `.livespec/` related entries from `.gitignore` if you added them:

```bash
# Remove from .gitignore (if present):
# .livespec/
# .livespec-repo/
```

### Step 7: Update Version Tracking

If you had `.livespec-version`, it's no longer needed for plugin installations:

```bash
# Optional: remove version file
rm .livespec-version
```

The plugin version is managed automatically.

## Command Mapping

### Skills (Interactive Workflows)

| Old Prompt | New Command |
|------------|-------------|
| `0a-quick-start.md` | `/livespec:init` |
| `0b-customize-workspace.md` | `/livespec:init --full` |
| `1b-design-architecture.md` | `/livespec:design architecture` |
| `1c-define-behaviors.md` | `/livespec:design behaviors` |
| `2a-implement-from-specs.md` | `/livespec:build` |
| `3a-run-validation.md` | `/livespec:verify` |
| `4a-detect-drift.md` | `/livespec:audit detect` |
| `4b-extract-specs.md` | `/livespec:audit extract` |

### Commands (Utility Operations)

| Old Prompt | New Command |
|------------|-------------|
| `validate-project.md` | `/livespec:validate` |
| `complete-session.md` | `/livespec:complete-session` |
| `run-health-report.md` | `/livespec:health-report` |
| `regenerate-contexts.md` | `/livespec:audit context` |
| `learn.md` | `/livespec:learn` |
| `audit-*.md` | `/livespec:audit [type]` |
| `next-steps.md` | `/livespec:next-steps` |
| `suggest-improvements.md` | `/livespec:suggest-improvements` |
| `reorganize-workspace.md` | `/livespec:refine-workspace` |
| `run-spike.md` | `/livespec:run-spike <topic>` |
| `analyze-failure.md` | `/livespec:analyze-failure` |
| `upgrade-methodology.md` | `/livespec:upgrade` |
| `measure-session-compliance.md` | `/livespec:measure-session` |

## What Stays the Same

These project files remain unchanged:

- `specs/` - Your specifications
- `PURPOSE.md` - Project purpose
- `AGENTS.md` - Generated agent context
- `ctxt/` - Context tree (if using)
- `project.yaml` - Build configuration (if using)

## Rollback

If you need to go back to the dist/ copy method:

```bash
# Clone LiveSpec
git clone https://github.com/chrs-myrs/livespec.git /tmp/livespec

# Copy dist/ back
cp -r /tmp/livespec/dist .livespec

# Uninstall plugin (optional)
/plugin uninstall livespec
```

## Troubleshooting

### Plugin Not Found

```
Error: Plugin 'livespec' not found
```

**Fix:** Add the marketplace first:
```bash
/plugin marketplace add chrs-myrs/livespec
```

### Commands Not Available

If `/livespec:*` commands don't appear:

1. Check plugin is installed: `/plugin list`
2. Try reinstalling: `/plugin uninstall livespec && /plugin install livespec@livespec`
3. Restart Claude Code

### AGENTS.md References Old Paths

If your AGENTS.md still references `.livespec/` paths:

```bash
/livespec:audit context
```

This regenerates AGENTS.md with current configuration.

## Need Help?

- [Plugin installation guide](plugin-installation.md)
- [GitHub Issues](https://github.com/chrs-myrs/livespec/issues)
- [GitHub Discussions](https://github.com/chrs-myrs/livespec/discussions)
