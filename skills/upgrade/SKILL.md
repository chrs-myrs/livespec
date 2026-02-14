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

Run the detection script from the project root:

```bash
bash scripts/upgrade-to-v5.sh --detect-only
```

If output says "Already on v5" or "No LiveSpec installation detected", report to user and stop.

If `/livespec:upgrade check` was invoked, report detection results and stop.

## Step 2: Show Migration Plan

Run the dry-run to show what will change:

```bash
bash scripts/upgrade-to-v5.sh --dry-run
```

Present the plan to the user and ask for confirmation using AskUserQuestion:
- "Proceed with migration" (recommended)
- "Cancel"

If cancelled, stop.

## Step 3: Execute Migration

Run the migration:

```bash
bash scripts/upgrade-to-v5.sh
```

Report the output to the user. If verification fails, show the failures and stop.

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
