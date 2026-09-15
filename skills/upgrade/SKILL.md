---
name: upgrade
description: |
  This skill should be used when the user asks to "upgrade LiveSpec", "migrate to v5",
  "remove submodule", or has a legacy .livespec-repo/ folder or .livespec symlink/directory.
  Runs a deterministic migration script with user confirmation.
argument-hint: [check|full]
allowed-tools: Bash, AskUserQuestion
---

# LiveSpec Upgrade

Migrate legacy LiveSpec installations to v5 plugin architecture.

## IMPORTANT: Do NOT Install Plugin

If this skill is running, the plugin is already installed. **Never** attempt to:
- `git clone` LiveSpec
- Create `.claude-plugin/` directories
- Run any plugin installation commands

The upgrade script only removes legacy artifacts and migrates specs.

## Step 1: Detect Current State

Run the detection script from the project root (the script ships in the plugin):

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/upgrade-to-v5.sh --detect-only
```

Route on the reported status:

| Status | Action |
|--------|--------|
| "No LiveSpec installation detected" | Report and stop. Suggest `/livespec:init`; there is no project to upgrade |
| "Already on v5. Nothing to migrate." | Skip Steps 2 and 3 (no legacy artifacts to remove) and go straight to Step 3a |
| Legacy artifacts listed | Continue to Step 2 |

A current project still has upgrade work to do. Conventions may never have been
vendored and the validation hook may never have been installed, because both
postdate most existing v5 projects. Stopping at this step would make those steps
unreachable for exactly the projects that need them.

If `/livespec:upgrade check` was invoked, report detection results and stop.

## Step 2: Show Migration Plan

Run the dry-run to show what will change:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/upgrade-to-v5.sh --dry-run
```

Present the plan to the user and ask for confirmation using AskUserQuestion:
- "Proceed with migration" (recommended)
- "Cancel"

If cancelled, stop.

## Step 3: Execute Migration

Run the migration:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/upgrade-to-v5.sh
```

Report the output to the user. If verification fails, show the failures and stop.

## Step 3a: Vendor or Refresh Conventions

Reached for both a migrated project and one that was already current.

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/vendor-conventions.sh --check
```

Report the state of each convention: unchanged, upstream update available,
locally edited, or diverged. Then apply the safe updates:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/vendor-conventions.sh
```

Only absent and upstream-changed-but-unedited files are written. Locally edited
and diverged files are reported and left alone; tell the user which need a
deliberate decision rather than resolving them automatically.

## Step 3b: Install Validation Hook

Legacy installs predate hook installation, so install it now:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup-hooks.sh --check
bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup-hooks.sh
```

Run `--check` first and report the state. An existing foreign hook is preserved
as `pre-commit.local` and chained, never discarded.

## Step 4: Commit

Stage and commit all changes:

```bash
git add -A
git commit -m "$(cat <<'EOF'
Migrate to LiveSpec v5 plugin architecture

- Remove legacy installation artifacts
- Migrate specs/ to semantic folder structure
- Update cross-references

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

Report completion. Suggest next steps:
- `/livespec:audit context` - Regenerate AGENTS.md
- `/livespec:audit health` - Check spec health

## Troubleshooting

For detailed migration guide, cross-reference mappings, and edge cases:
`references/guides/upgrade-to-v5.md`
