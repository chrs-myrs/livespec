---
description: Upgrade LiveSpec to v5 plugin architecture
---

# LiveSpec Upgrade

Migrate from legacy installations (submodule/symlink or dist/ copy) to the v5 plugin architecture.

## Usage

```
/livespec:upgrade           # Guided upgrade workflow
/livespec:upgrade check     # Check current installation type
```

## What This Does

1. **Detects installation type:**
   - Plugin (v5) - Already upgraded
   - Submodule + symlink (v4) - Needs migration
   - dist/ copy (v3) - Needs migration

2. **For legacy installations:**
   - Guides removal of `.livespec-repo/` submodule
   - Guides removal of `.livespec` symlink
   - Confirms plugin is installed
   - Guides specs/ folder migration (numbered → semantic)

## Detailed Guide

For comprehensive migration steps, read:
`${CLAUDE_PLUGIN_ROOT}/references/guides/upgrade-to-v5.md`

This guide covers:
- Removing git submodule safely
- Removing symlinks
- Plugin installation options (global vs local)
- specs/ folder restructuring
- Workspace spec updates
- Troubleshooting

## Quick Check

```bash
# Check for legacy submodule
ls -la .livespec-repo 2>/dev/null && echo "LEGACY: Submodule found"

# Check for legacy symlink
ls -la .livespec 2>/dev/null && echo "LEGACY: Symlink found"

# Check for plugin
ls -la .claude-plugin 2>/dev/null && echo "PLUGIN: Local plugin found"
```

## Migration Summary

| From | Action |
|------|--------|
| Submodule (`.livespec-repo/`) | `git submodule deinit -f .livespec-repo && git rm -f .livespec-repo` |
| Symlink (`.livespec`) | `rm .livespec` |
| dist/ copy | `rm -rf .livespec/` |

Then install plugin globally or locally per the upgrade guide.
