---
spec: specs/behaviors/prompts/utils-upgrade.spec.md
---

# Upgrade Methodology (AI-Assisted)

**Purpose**: Safely upgrade .livespec/ to latest LiveSpec version using AI-assisted progressive merge
**Context**: See `specs/behaviors/prompts/utils-upgrade.spec.md` for full requirements

## Overview

This prompt guides AI agents through upgrading .livespec/ while respecting user customizations. The process is **progressive** with **mandatory verification gates** ensuring you actually follow the process (not fake it).

**Key principle:** AI reads `customizations.yaml` to know what's custom, then applies intelligent merge strategy.

**Enforcement principle:** Like spec-first development (principle #1), upgrade process requires proof-of-work - you must show evidence you completed each step before proceeding.

## When to Use

Use this prompt when:
- LiveSpec releases a new version
- You want latest methodology improvements
- Critical bug fixes in prompts
- New features or metaspecs added

Do NOT use if:
- `.livespec/` is a symlink (dogfooding setup - use `git pull` in linked repo instead)
- No `.livespec/` exists (use 0a-setup-workspace.md for fresh install)

---

## ⚠️ PRE-FLIGHT CHECKS (Essential)

**Please perform these checks before upgrading:**

### 1. Check Installation Type

```bash
test -L .livespec && echo "SYMLINK" || echo "DIRECTORY"
```

**If SYMLINK:**
- **STOP IMMEDIATELY** - This is a dogfooding setup
- Instruct user: `cd` to the linked repository and run `git pull` instead
- Exit without making any changes

**If DIRECTORY:**
- Continue to step 2

### 2. Read Current Version

```bash
cat .livespec/.livespec-version 2>/dev/null || echo "Pre-2.1.0 installation (no version file)"
```

**Note current version** - If missing, this is a pre-2.1.0 installation (more changes expected).

### 3. Clone LiveSpec Repository

```bash
TEMP_DIR=$(mktemp -d)
git clone https://github.com/chrs-myrs/livespec.git "$TEMP_DIR"
NEW_DIST="$TEMP_DIR/dist"
```

**PROOF REQUIRED**: Show the git clone output above. You must actually clone the repository - do not fake this step.

### 4. Verify New Distribution

```bash
ls "$NEW_DIST/"
cat "$NEW_DIST/.livespec-version.template"
```

**PROOF REQUIRED**: Show the new version number. You must show evidence you fetched the correct distribution.

**Store variables for later phases:**
- `TEMP_DIR` - Temporary directory path
- `NEW_DIST` - Path to new distribution ($TEMP_DIR/dist)
- `NEW_VERSION` - Version number from .livespec-version.template

### 5. Read Customizations Tracking

```bash
cat .livespec/customizations.yaml 2>/dev/null || echo "No customizations tracked (pre-2.1.0 or not customized)"
```

If missing: Assume nothing customized yet.

**Pre-flight checks complete.** Proceed to Phase 1.

---

## Phase 1: Create Backup (MANDATORY)

**Essential first step - create backup before any changes:**

```bash
BACKUP_DIR=".livespec.backup-$(date +%Y%m%d-%H%M%S)"
cp -r .livespec "$BACKUP_DIR"
```

**PROOF REQUIRED**: Show backup created:

```bash
ls -la "$BACKUP_DIR" | head -20
```

You must show the ls output proving the backup directory exists and contains files.

**Store backup path** for rollback instructions at end: `BACKUP_DIR`

**Phase 1 complete when:**
- [ ] Backup directory created (path shown above)
- [ ] Backup contains .livespec/ contents (ls output shown)
- [ ] Backup path stored in BACKUP_DIR variable

**PHASE GATE**: Cannot proceed to Phase 2 without showing backup evidence above.

---

## Phase 2: Preview Changes from CHANGELOG

Read upstream CHANGELOG to understand what changed:

```bash
cat "$NEW_DIST/../CHANGELOG.md" 2>/dev/null | head -200
```

**Summarize for user:**
- Find [Unreleased] or latest version section
- Explain key changes in plain language
- Highlight ⚠️ HIGH IMPACT changes
- Note changes affecting customized files (from customizations.yaml)

**Example summary:**
```
Upgrading from 2.1.0 to 2.2.0:

Key changes:
- Spec-first development now principle #1 (affects all future development)
- AGENTS.md Core Principles updated (drift fix)
- Workspace specs now require applies_to frontmatter
- 0a-setup-workspace.md: Added Step 0 for agent bootstrap
  → If you customized this prompt, we'll need to review the merge

I'll guide you through merging these changes.
```

If no CHANGELOG or section empty: Note "No changelog available, proceeding with file-by-file diff."

---

## Phase 3: Update Standard Files (Auto)

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

**AI should reference CHANGELOG for upstream changes description** (from [Unreleased] section, ⚠️ entries).

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 prompts/0-define/0a-setup-workspace.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📤 Upstream changes (from CHANGELOG):
  - Added Step 0: Bootstrap Agent Configuration (HIGH IMPACT)
  - Step 0 must execute FIRST (before version tracking)
  - Existing steps renumbered (Version tracking → Step 1, Domain org → Step 2)
  - Exit criteria restructured by step

  Why: Fixed discoverability gap - users couldn't use prompts without AGENTS.md

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

---

## Phase 7: Regenerate AGENTS.md (If Needed)

**Check if workspace specs changed during upgrade:**

```bash
diff -rq .livespec/specs/workspace/ "$BACKUP_DIR/specs/workspace/" 2>/dev/null
```

**If workspace/ specs changed:**

1. **MANDATORY**: Regenerate AGENTS.md

```
AI: "Workspace specs changed during upgrade. I need to regenerate AGENTS.md to prevent drift..."
```

Use `4d-regenerate-agents.md` to regenerate AGENTS.md from current workspace specs.

2. **PROOF REQUIRED**: Show before/after diff of Core Principles section

```bash
# Show that Core Principles now matches constitution.spec.md
grep -A 30 "## Core Principles" AGENTS.md
```

3. **Verify principle order** matches constitution.spec.md (Specs Before Implementation should be #1)

**Why this matters:** We caught AGENTS.md drift in 2.2.0 release - Core Principles section didn't match current constitution.spec.md. This phase prevents that.

**If workspace/ specs NOT changed:**
- Skip this phase
- Note: "Workspace specs unchanged, AGENTS.md regeneration not needed"

---

## Phase 8: Self-Validation (MANDATORY)

**Prove the upgrade worked - show evidence for all tests:**

### Test 1: Version Updated

```bash
cat .livespec/.livespec-version
```

**PROOF REQUIRED**: Output should show new version number (stored in $NEW_VERSION).

### Test 2: Critical Files Present

```bash
echo "Metaspecs: $(ls .livespec/standard/metaspecs/*.spec.md 2>/dev/null | wc -l)"
echo "Phase 0 prompts: $(ls .livespec/prompts/0-define/*.md 2>/dev/null | wc -l)"
echo "Phase 1 prompts: $(ls .livespec/prompts/1-design/*.md 2>/dev/null | wc -l)"
```

**PROOF REQUIRED**: Show file counts. Expected:
- Metaspecs: 7
- Phase prompts: 4+ per phase

### Test 3: Backup Available for Rollback

```bash
ls -d "$BACKUP_DIR" && echo "✓ Backup available at: $BACKUP_DIR"
```

**PROOF REQUIRED**: Show backup directory exists.

### Validation Summary

Report validation results:
```
✅ Self-Validation Complete:
  ✓ Version updated: 2.1.0 → 2.2.0
  ✓ Metaspecs present: 7 files
  ✓ Prompts intact: 20+ files across 5 phases
  ✓ Backup available: .livespec.backup-20251009-123456

Upgrade successful!
```

**PHASE GATE**: All tests must pass before proceeding to Phase 9. You cannot claim upgrade success without showing validation outputs.

---

## Phase 9: Finalize Upgrade

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
- Reference CHANGELOG for context on upstream changes (WHY they were made)

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
User: "Use upgrade-methodology.md to upgrade to 2.2.0"

AI: "I'll help you upgrade .livespec/ to version 2.2.0.

Performing pre-flight checks..."

[Runs test -L .livespec]
DIRECTORY

[Runs cat .livespec/.livespec-version]
2.1.0

AI: "Current version: 2.1.0"

[Runs git clone]
Cloning into '/tmp/tmp.abc123/livespec'...
remote: Enumerating objects: 1234, done.
...

AI: "✓ Repository cloned"

[Runs cat $TEMP_DIR/dist/.livespec-version.template]
2.2.0

AI: "✓ New version: 2.2.0

Now creating backup..."

[Creates backup]
BACKUP_DIR=".livespec.backup-20251009-142233"

[Runs ls -la "$BACKUP_DIR"]
drwxr-xr-x  8 user user 4096 Oct  9 14:22 .
drwxr-xr-x 12 user user 4096 Oct  9 14:22 ..
drwxr-xr-x  4 user user 4096 Oct  9 14:22 prompts
drwxr-xr-x  2 user user 4096 Oct  9 14:22 standard
...

AI: "✓ Backup created at .livespec.backup-20251009-142233

Phase 2: Checking CHANGELOG for changes..."

Upgrading from 2.1.0 to 2.2.0:

Key changes:
- Spec-first development now principle #1
- AGENTS.md Core Principles updated to match constitution.spec.md
- Workspace specs now require applies_to frontmatter

Phase 3: Updating standard files...
✓ Updated 10 metaspecs and conventions

Phase 4: Updating non-customized prompts...
✓ Updated 15 prompts automatically

Phase 5: Found 1 customized prompt to review...

Phase 7: Checking if workspace specs changed...

[Runs diff -rq]
Files .livespec/specs/workspace/constitution.spec.md and .livespec.backup-20251009-142233/specs/workspace/constitution.spec.md differ

AI: "Workspace specs changed. Regenerating AGENTS.md..."

[Regenerates AGENTS.md, shows diff]

Phase 8: Self-validation...

[Runs cat .livespec/.livespec-version]
2.2.0
✓ Version updated

[Runs file counts]
Metaspecs: 7
Phase 0 prompts: 4
...
✓ Critical files present

[Verifies backup]
✓ Backup available at: .livespec.backup-20251009-142233

✅ Self-Validation Complete:
  ✓ Version updated: 2.1.0 → 2.2.0
  ✓ Metaspecs present: 7 files
  ✓ Prompts intact: 24 files across 5 phases
  ✓ Backup available: .livespec.backup-20251009-142233

Upgrade successful!
```

## Exit Criteria

- [ ] **Pre-flight checks complete** (evidence shown):
  - [ ] Installation type checked (DIRECTORY not SYMLINK)
  - [ ] Current version noted
  - [ ] Repository cloned (git clone output shown)
  - [ ] New version verified (version number shown)
  - [ ] Customizations read
- [ ] **Phase 1: Backup created** (ls output shown proving backup exists)
- [ ] **Phase 2: CHANGELOG preview** (key changes summarized for user)
- [ ] **Phase 3: Standard files updated** (canonical metaspecs/conventions)
- [ ] **Phase 4: Non-customized prompts updated** (auto-applied)
- [ ] **Phase 5: Customized prompts reviewed** (user chose action for each)
- [ ] **Phase 6: Templates and new files merged** (user approved new files)
- [ ] **Phase 7: AGENTS.md regenerated** (if workspace specs changed, diff shown)
- [ ] **Phase 8: Self-validation complete** (all 3 tests passed, outputs shown):
  - [ ] Version updated (cat output shown)
  - [ ] Critical files present (file counts shown)
  - [ ] Backup available (backup path shown)
- [ ] **Phase 9: Finalize**:
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
