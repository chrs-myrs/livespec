---
description: Migrate from legacy LiveSpec (submodule/copy) to v5 plugin
routes-to: skills/upgrade/SKILL.md
---

# /livespec:upgrade

Migrate from legacy LiveSpec installations to v5 plugin architecture.

**Routes to:** `skills/upgrade/SKILL.md`

## Usage

- `/livespec:upgrade` - Detect state and migrate
- `/livespec:upgrade check` - Detection only (no changes)

## What This Does

1. **Detect** current installation type (submodule, symlink, copy, numbered specs)
2. **Show** migration plan and get confirmation
3. **Execute** `scripts/upgrade-to-v5.sh` (deterministic, tested)
4. **Commit** the changes
