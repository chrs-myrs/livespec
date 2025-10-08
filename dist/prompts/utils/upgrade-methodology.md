---
spec: specs/behaviors/prompts/utils-upgrade.spec.md
---

# Upgrade Methodology (AI-Assisted)

**Purpose**: Safely upgrade .livespec/ to latest LiveSpec version using AI-assisted progressive merge
**Context**: See `specs/behaviors/prompts/utils-upgrade.spec.md` for full requirements

## Overview

This prompt guides AI agents through upgrading .livespec/ while respecting user customizations. The process is **progressive**: automatically updating safe files, asking about customized files, and never touching explicitly protected files.

**Key principle:** AI reads `customizations.yaml` to know what's custom, then applies intelligent merge strategy.

## When to Use

Use this prompt when:
- LiveSpec releases a new version
- You want latest methodology improvements
- Critical bug fixes in prompts
- New features or metaspecs added

Do NOT use if:
- `.livespec/` is a symlink (dogfooding setup - use `git pull` in linked repo instead)
- No `.livespec/` exists (use 0a-setup-workspace.md for fresh install)

## Pre-Flight Checks

**AI agent should perform these checks first:**

1. **Detect installation type:**
```bash
test -L .livespec && echo "SYMLINK" || echo "DIRECTORY"
```

If SYMLINK: Stop here. Instruct user to `cd` to linked repository and `git pull`.

2. **Read current version:**
```bash
cat .livespec/.livespec-version 2>/dev/null
```

If missing: Assume pre-2.1.0 installation (no version tracking yet).

3. **Read customizations tracking:**
```bash
cat .livespec/customizations.yaml 2>/dev/null
```

If missing: Assume nothing customized yet (or pre-2.1.0).

4. **Create backup:**
```bash
BACKUP_DIR=".livespec.backup-$(date +%Y%m%d-%H%M%S)"
cp -r .livespec "$BACKUP_DIR"
echo "Backup created: $BACKUP_DIR"
```

**Store backup path for rollback instructions at end.**

## Fetch New Distribution

AI agent should fetch latest LiveSpec distribution. Prefer git clone:

```bash
TEMP_DIR=$(mktemp -d)
git clone https://github.com/chrs-myrs/livespec.git "$TEMP_DIR"
NEW_DIST="$TEMP_DIR/dist"
NEW_VERSION=$(cat "$NEW_DIST/.livespec-version.template")
echo "Fetched LiveSpec version: $NEW_VERSION"
```

**Alternative methods** (if git fails):
- GitHub release tarball
- User-provided local path

**Verify:** NEW_DIST path set and contains standard/, prompts/, templates/

## Progressive Merge Strategy

AI applies changes in phases, from safest to most interactive:

### Phase 1: Standard Files (Always Overwrite)

**Rationale:** `standard/` contains canonical metaspecs and conventions. Never customize these.

**Action:**
```bash
cp -r "$NEW_DIST/standard" .livespec/
```

**Report to user:**
```
✓ Updated standard/ (canonical files, no customization allowed)
  - metaspecs/base.spec.md
  - metaspecs/behavior.spec.md
  - metaspecs/contract.spec.md
  [etc...]
```

### Phase 2: Non-Customized Prompts (Overwrite)

**Check customizations.yaml** for which prompts are customized.

**For each prompt NOT in customizations.yaml:**
```bash
# Example: prompts/3-verify/3a-run-validation.md not customized
cp "$NEW_DIST/prompts/3-verify/3a-run-validation.md" .livespec/prompts/3-verify/
```

**Report to user:**
```
✓ Updated prompts/ (not customized):
  - prompts/3-verify/3a-run-validation.md
  - prompts/4-evolve/4c-sync-complete.md
  [list all auto-updated prompts]
```

### Phase 3: Customized Prompts (Interactive)

**For each prompt IN customizations.yaml modified list:**

1. **Show user-friendly comparison:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 prompts/0-define/0a-setup-workspace.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📤 Upstream changes (what LiveSpec changed):
  - Added better examples for PURPOSE.md
  - Improved workspace template references
  - Added domain organization guidance

📝 Your customizations (from customizations.yaml):
  - Reason: "Added governance-specific workspace setup steps"
  - Modified: 2025-10-07

Options:
  [m] Merge upstream (lose your customizations, re-apply manually)
  [k] Keep yours (miss upstream improvements)
  [e] Edit together (AI helps merge both)
  [d] View full diff

Your choice?
```

2. **Handle user choice:**

**If [m] (merge):**
```bash
cp "$NEW_DIST/prompts/0-define/0a-setup-workspace.md" .livespec/prompts/0-define/
```
Remove from customizations.yaml (no longer custom).
Report: "⚠️ Applied upstream version. You'll need to re-apply your governance steps."

**If [k] (keep):**
Do nothing.
Report: "✓ Kept your version (upstream changes not applied)."

**If [e] (edit together):**
AI reads both versions, understands differences, proposes merged version with BOTH:
- Upstream improvements
- User's customizations

Show proposed merge, ask for approval. If approved, write merged version.
Update customizations.yaml: modified_at = today, reason = "Merged with upstream X.Y.Z"

**If [d] (diff):**
Show full diff using diff -u, then re-prompt for choice.

3. **Repeat for each customized prompt.**

### Phase 4: Templates (Merge Strategy)

**Add new templates from upstream:**
```bash
# Find templates in NEW_DIST not in .livespec
# Copy them
cp -r "$NEW_DIST/templates/governance" .livespec/templates/ 2>/dev/null
cp -r "$NEW_DIST/templates/operations" .livespec/templates/ 2>/dev/null
```

**Preserve custom templates** (listed in customizations.yaml templates.added).

**Report:**
```
✓ Templates updated:
  + templates/governance/policy.spec.md.template (new in 2.1.0)
  + templates/operations/runbook.spec.md.template (new in 2.1.0)
  ✓ templates/custom/my-template.md (preserved - your custom template)
```

### Phase 5: Never-Overwrite Paths (Skip Entirely)

**Check customizations.yaml never_overwrite list.**

**For each path in never_overwrite:**
Skip entirely. Don't even show diff.

**Report:**
```
⊘ Skipped (never_overwrite):
  - prompts/custom/governance/ (your custom prompts)
```

### Phase 6: New Files (Add)

**Files in NEW_DIST not in .livespec:**

List them, ask if user wants them:
```
🆕 New files available in 2.1.0:
  - prompts/utils/new-helper.md
  - standard/conventions/new-convention.spec.md

Add these? [y/n for each]
```

Add approved files.

## Finalize Upgrade

### Update Version File

```bash
cp "$NEW_DIST/.livespec-version.template" .livespec/.livespec-version
```

### Update customizations.yaml

If any new customizations made during merge:
```yaml
version: 2.1.0  # Update to new version
customized_at: 2025-10-07  # Update timestamp
prompts:
  modified:
    - path: prompts/0-define/0a-setup-workspace.md
      reason: Merged upstream 2.1.0 with governance customizations
      modified_at: 2025-10-07
```

### Create Upgrade Report

Generate `var/upgrade-reports/upgrade-summary-YYYYMMDD.txt`:
```
===== LIVESPEC UPGRADE SUMMARY =====
Upgraded: 2.0.0 → 2.1.0
Date: 2025-10-07
Backup: .livespec.backup-20251007-143022

PHASE 1: Standard Files
✓ Updated 10 canonical files (metaspecs, conventions)

PHASE 2: Non-Customized Prompts
✓ Updated 15 prompts automatically

PHASE 3: Customized Prompts
✓ Kept your version: prompts/0-define/0a-setup-workspace.md
✓ Merged: prompts/1-design/1a-design-architecture.md

PHASE 4: Templates
+ Added templates/governance/ (new in 2.1.0)
+ Added templates/operations/ (new in 2.1.0)

PHASE 5: Never-Overwrite
⊘ Skipped prompts/custom/governance/ (protected)

PHASE 6: New Files
+ Added prompts/utils/new-helper.md

ROLLBACK INSTRUCTIONS:
rm -rf .livespec && mv .livespec.backup-20251007-143022 .livespec

NEXT STEPS:
- Test methodology: Try using a prompt
- Review kept customizations for upstream improvements
- Regenerate AGENTS.md if workspace specs changed
```

Show summary to user.

### Cleanup

```bash
# Remove temp directory
rm -rf "$TEMP_DIR"
```

**Ask user:** "Upgrade successful. Remove backup? (y/n)"
If yes: `rm -rf "$BACKUP_DIR"`

## AI Agent Guidelines

### How AI Should Behave

**Be conversational:**
- Explain what you're doing at each step
- Use user-friendly language (not just bash output)
- Help user understand tradeoffs

**Be intelligent about merges:**
- When user chooses [e]dit, actually merge intelligently
- Understand semantic meaning of both versions
- Propose merged version that preserves both intents

**Be safe:**
- Always create backup first
- Never auto-apply to customized files without asking
- Provide rollback instructions
- Verify critical files exist after upgrade

**Be helpful:**
- Explain upstream changes in context user understands
- Suggest which option [m/k/e] makes sense
- Flag breaking changes that need user attention
- Offer to help fix issues post-upgrade

### Example AI Interaction

```
User: "Use upgrade-methodology.md to upgrade to 2.1.0"

AI: "I'll help you upgrade .livespec/ from 2.0.0 to 2.1.0. First, let me create a backup..."

[Creates backup]

AI: "✓ Backup created at .livespec.backup-20251007-143022

Fetching LiveSpec 2.1.0..."

[Fetches distribution]

AI: "✓ Fetched version 2.1.0

I'll now upgrade in phases:

Phase 1: Updating standard files (canonical, no customization)...
✓ Updated 10 metaspecs and conventions

Phase 2: Updating non-customized prompts...
✓ Updated 15 prompts automatically

Phase 3: Reviewing your customized prompts...

Found 2 customized prompts. Let me check each one.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 prompts/0-define/0a-setup-workspace.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

You customized this on 2025-10-05 to add governance-specific setup steps.

Upstream 2.1.0 added:
- Domain organization guidance (behaviors/policies/ pattern)
- Version tracking file creation
- Customization tracking file creation

This is interesting! The upstream changes actually complement your governance customizations. Would you like me to merge both together? I can create a version that has your governance steps PLUS the new version tracking.

Options:
[m] Merge upstream (you'll need to re-add governance steps)
[k] Keep yours (you'll miss version tracking setup)
[e] Edit together (I'll merge both - RECOMMENDED)
[d] View full diff

Your choice? █
```

## Exit Criteria

- [ ] Backup created
- [ ] New distribution fetched
- [ ] Phase 1: Standard files updated
- [ ] Phase 2: Non-customized prompts updated
- [ ] Phase 3: Customized prompts reviewed (user chose action for each)
- [ ] Phase 4: Templates merged
- [ ] Phase 5: Never-overwrite paths skipped
- [ ] Phase 6: New files added (user approved)
- [ ] .livespec-version updated
- [ ] customizations.yaml updated
- [ ] Upgrade summary created
- [ ] Rollback instructions provided
- [ ] Temp files cleaned up

## Troubleshooting

**Git clone fails:**
- Try GitHub release tarball method
- Ask user for local LiveSpec path
- Check internet connection

**customizations.yaml missing:**
- Treat as pre-2.1.0 install (nothing tracked yet)
- After upgrade, create customizations.yaml with current state
- Document this in upgrade summary

**Merge conflict too complex:**
- Offer to keep user's version
- Provide manual merge instructions
- Save both versions for user to compare later

**Critical file missing after upgrade:**
- Stop immediately
- Rollback from backup
- Report what went wrong
- Ask user to file issue on GitHub

## Notes

- **AI-native approach:** No bash scripts, just AI following prompt
- **Progressive safety:** Safe changes automatic, risky changes interactive
- **Intelligence:** AI actually understands changes, not just diffs
- **Customization-aware:** Respects customizations.yaml tracking
- **User control:** User decides on every conflicting change
- **Rollback always available:** Backup preserved until user confirms success
