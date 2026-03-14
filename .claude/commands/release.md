---
description: Release LiveSpec with automatic version increment, changelog update, commit and push
allowed-tools: Read, Edit, Write, Bash, Grep, Glob, AskUserQuestion
---

# Release LiveSpec

Automate the LiveSpec release process: determine version increment, update all version files atomically, finalise CHANGELOG, commit and push.

## Step 1: Read Current State

1. Read `.livespec-version` to get the current version
2. Read `CHANGELOG.md` — specifically the `## [Unreleased]` section
3. If the Unreleased section is empty (no entries between `## [Unreleased]` and the next `## [`), STOP and tell the user: "Nothing to release — the Unreleased section in CHANGELOG.md is empty."

## Step 2: Determine Version Increment

Analyse the Unreleased changelog entries to decide increment type:

**Major** (X.0.0) — any of:
- Entries contain "BREAKING:" prefix
- Folder structure reorganisation
- Backwards-incompatible changes

**Minor** (x.X.0) — any of:
- New skills, commands, or features added
- New specs or capabilities
- Significant enhancements

**Patch** (x.x.X) — all of:
- Bug fixes only
- Version corrections
- Documentation fixes
- No new functionality

### Confidence Gate

Assess your confidence in the version increment decision (0-100%).

**If confidence >= 95%:** State your decision and reasoning, then proceed to Step 3 without asking.

**If confidence < 95%:** Use AskUserQuestion:

```
Question: "Unreleased changes suggest [summary]. Which version increment?"
Header: "Version"
Options:
- "[calculated version] — [increment type] (Recommended)" / "[reasoning]"
- "[alternative version] — [alternative type]" / "[reasoning]"
```

## Step 3: Update All Version Files

Update these files atomically (all must be updated):

1. **`.livespec-version`** — replace version string (source of truth)
2. **`.claude-plugin/plugin.json`** — update `"version"` field
3. **`.claude-plugin/marketplace.json`** — update `"version"` in plugins array
4. **`project.yaml`** — update `livespec.version` field
5. **`AGENTS.md`** — update footer line `*Agent configuration for LiveSpec vX.Y.Z*`
6. **`README.md`** — update `**Current Version: X.Y.Z**`
7. **`skills/evolve/SKILL.md`** — update `version:` in the generated AGENTS.md template
8. **`CHANGELOG.md`** — rename `## [Unreleased]` to `## [X.Y.Z] - YYYY-MM-DD` and add a new empty `## [Unreleased]` section above it

### CHANGELOG Format

The CHANGELOG update should look like:

```markdown
## [Unreleased]

---

## [X.Y.Z] - YYYY-MM-DD
[existing unreleased content moves here]
```

## Step 4: Verify

Run a quick grep to confirm no files still reference the OLD version:

```bash
grep -r "OLD_VERSION" --include="*.md" --include="*.json" --include="*.yaml" . | grep -v CHANGELOG | grep -v node_modules | grep -v .git
```

If stale references found, fix them before proceeding.

## Step 5: Commit and Push

Stage all changed files explicitly (no `git add .`):

```bash
git add .livespec-version .claude-plugin/plugin.json .claude-plugin/marketplace.json \
  project.yaml AGENTS.md README.md skills/evolve/SKILL.md CHANGELOG.md \
  [any other files with version updates found in Step 4]
```

Commit with message format:
```
Release LiveSpec vX.Y.Z

[1-2 sentence summary of what changed]

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
```

Use `--no-verify` (pre-commit hook references a missing test script).

Push to origin.

## Step 6: Tag

Create and push a git tag:

```bash
git tag vX.Y.Z
git push origin vX.Y.Z
```

## Step 7: Report

Output a summary:

```
Released LiveSpec vX.Y.Z (was: vOLD)
- Increment: [major|minor|patch]
- Files updated: [count]
- Tag: vX.Y.Z
```
