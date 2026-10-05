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

Folders listed as `DECIDE` are not moved until the user confirms where each one
goes. Ask once per folder with AskUserQuestion, offering the proposed home first
when there is one, then "Somewhere else" and "Leave it for now". Some judgements
mean deleting rather than moving: copies of LiveSpec's own metaspecs, reports
that can be regenerated, raw learning notes. Deletion needs the user's explicit
agreement; the script never deletes. Folders listed as `UNKNOWN` are not part of
the layout and stay where they are; mention them.

`ctxt/` subfolders listed as `RETIRED` (`phases/`, `utils/`) come from an earlier
generation. A context rebuild writes the flat files but does not remove these, so
after `/livespec:audit context` has run, offer to delete them, with the user's
explicit agreement, and check first that nothing in them was edited by hand.
Subfolders listed as `CHECK` stay unless the user says otherwise.

## Step 3: Execute Migration

Run the migration, passing one `--map` per confirmed folder:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/upgrade-to-v5.sh --map specs/meta=specs/workspace
```

Report the output to the user. If verification fails, show the failures and stop.
A `FAIL` naming files left in place means a destination already held a file of
the same name: show both to the user and ask which to keep.

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

Legacy installs predate hook installation, and hooks installed before validator
vendoring resolve nothing at commit time, so they skip every commit. Install or
refresh it now:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup-hooks.sh --check
bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup-hooks.sh
```

Run `--check` first and report the state, including its warning if no hooked
validator is in the project's `scripts/`. An existing foreign hook is preserved
as `pre-commit.local` and chained, never discarded. Locally edited or diverged
vendored scripts are reported and left alone; raise them with the user.

## Step 3c: Remediate What the Upgrade Surfaced

The installed hook validates only the specs being committed, so historical drift
blocks a commit only when the drifted spec is next touched. The upgrade that
installs the validation should still offer the repair, so that the first edit to
an old spec does not stall on problems the upgrade itself exposed.

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/remediate-references.sh --check
```

Present what it would rewrite: retired command names mapped to current ones,
convention references repointed at the copies just vendored in Step 3a, and
metaspec or template entries dropped from `governed-by`, where older versions
planted them although `type` already implies the format. Then apply:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/remediate-references.sh
```

Migration guides and historical documents are skipped: their "old reference"
columns are correct as written.

Then bring relationship links to the current model. Links are authored upward
only, each parent's `supports:` is generated from its children, and
`implements:` is retired:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-crossrefs.sh
```

Review its `stale-backlink` warnings before fixing. Each is a `supports:` entry
with no upward link back, which `--fix` will drop. Where the entry names a spec
that depends on the one listing it, add the upward link to that spec instead:
`satisfies` for an outcome or constraint, `guided-by` for a strategy or
interface, `governed-by` for a workspace pattern. Ask the user when the direction
is unclear. Then:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-crossrefs.sh --fix
```

It moves `implements:` values into `satisfies:`, rewrites each `supports:` from
the upward links, and names every entry it dropped. Specs with no upward link,
or none reaching PURPOSE.md, are warnings: list them for the user, since only
they can say what each spec serves.

Then run the validators and report what remains:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-constraints.sh
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-crossrefs.sh
```

Anything still failing is project-specific and needs a decision: a retired name
with no equivalent, a script the project never built, or a spec reference that
has to be repointed by hand. List these for the user rather than guessing. Do not
leave the step without saying plainly which specs will block a commit when next
touched.

## Step 3d: Record the Accepted Version

Once the user has accepted the upgrade, set `livespec.version` in `project.yaml`
to the toolchain version, creating the file with only that key if it is absent
and changing nothing else if it exists:

```bash
grep -A5 '^livespec:' "${CLAUDE_PLUGIN_ROOT}/project.yaml" | grep -m1 'version:'
```

Step 1's detection reported every version signal the project carries. Mention
any it flagged as differing: a vendored file left alone because it was edited
locally keeps its old version, and generated context lags until
`/livespec:audit context` runs.

## Step 4: Commit

Stage and commit all changes:

```bash
git add -A
git commit -m "$(cat <<'EOF'
Migrate to LiveSpec v5 plugin architecture

- Remove legacy installation artifacts
- Migrate specs/ to semantic folder structure
- Update cross-references
- Record the accepted LiveSpec version in project.yaml

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
