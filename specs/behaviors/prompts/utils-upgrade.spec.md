---
specifies: prompts/utils/upgrade-methodology.md
derives_from:
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Users cannot safely upgrade methodology, risking manual errors or abandoning updates when LiveSpec evolves
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Upgrade Methodology Utility Prompt

## Requirements
- [!] Prompt guides user through safely upgrading .livespec/ methodology to latest LiveSpec version, preserving customizations while applying approved changes through backup, fetch, diff, selective apply, and validation workflow.
  - Detects current version from .livespec/VERSION (or notes if missing for pre-upgrade installs)
  - Warns if .livespec/ is symlink (dogfooding case where upgrade inappropriate)
  - Creates timestamped backup (.livespec.backup-YYYYMMDD-HHMMSS/) before any changes
  - Verifies backup complete before proceeding
  - Supports multiple fetch methods (git clone, GitHub release tarball, manual path)
  - Diffs .livespec/ vs new dist/ file by file
  - Categorizes changes: new files, modified standard files, removed files, custom files
  - Presents changes one at a time for user approval
  - Preserves custom files and unapproved changes
  - Updates VERSION file in .livespec/ after successful upgrade
  - Validates .livespec/ structure matches folder-structure convention after upgrade
  - Verifies critical files present (metaspecs, core phase prompts)
  - Lists any structural anomalies
  - Offers to remove backup after successful upgrade
  - Provides rollback instructions (restore from backup)
  - Shows summary of applied changes
  - Process completes in under 10 minutes for typical upgrade
  - Zero data loss (backup preserved, custom files untouched)

## Triggers

**When to use:**
- LiveSpec releases new version
- Metaspecs updated
- New phase prompts added
- Critical bug fixes in prompts
- User wants latest methodology improvements

**When NOT to use:**
- .livespec/ is symlink to dist/ (LiveSpec dogfooding - use git pull instead)
- No .livespec/ directory exists (use Quick Start install instead)
- User has heavily customized prompts (review changes carefully)

## Process Phases

**1. Pre-flight checks:**
- Check .livespec/ exists
- Read current VERSION if present
- Detect if symlink (warn and exit)
- Confirm user wants to proceed
- Display current and target versions

**2. Backup phase:**
- Create timestamped backup directory
- Copy entire .livespec/ to backup
- Verify backup integrity
- Store backup path for rollback

**3. Fetch phase (user chooses):**
- **Option A (Git):** Clone livespec repo to temp directory, extract dist/
- **Option B (Tarball):** Download release from GitHub, extract dist/
- **Option C (Manual):** User provides path to livespec/dist/
- Verify fetched distribution has correct structure

**4. Diff phase:**
- Compare .livespec/ vs new dist/ recursively
- Categorize each file:
  - 🟢 **New**: Exists in new, not in old (safe to add)
  - 🟡 **Modified**: Exists in both, content differs (show diff, user decides)
  - 🔴 **Removed**: Exists in old, not in new (warn before deleting)
  - ⚪ **Custom**: Exists in old, not in standard (preserve, note in summary)
- Generate change report with file paths and categories

**5. Apply phase:**
- Present changes one category at a time (new → modified → removed)
- For each change:
  - Show file path and change type
  - Show diff for modified files
  - Ask user: apply / skip / view full file
- Copy approved files from new dist/ to .livespec/
- Track applied vs skipped changes
- Update VERSION file to new version
- Preserve all custom files unchanged

**6. Validation phase:**
- Verify folder structure matches folder-structure.spec.md
- Check critical paths exist:
  - .livespec/VERSION
  - .livespec/standard/metaspecs/*.spec.md (7 files)
  - .livespec/standard/conventions/*.spec.md (3 files)
  - .livespec/prompts/{0-define,1-design,2-build,3-verify,4-evolve}/*.md
  - .livespec/templates/workspace/*.template
- List any anomalies (unexpected files, missing standard files)
- Report validation results

**7. Cleanup phase:**
- Show upgrade summary:
  - Files added
  - Files modified
  - Files removed
  - Files skipped
  - Custom files preserved
- Offer to remove backup (if validation passed)
- Show rollback command: `rm -rf .livespec && mv .livespec.backup-YYYYMMDD-HHMMSS .livespec`
- Suggest regenerating AGENTS.md if workspace specs changed

## Outputs

**Primary outputs:**
- Upgraded .livespec/ directory with approved changes
- .livespec/VERSION updated to new version
- Timestamped backup (.livespec.backup-YYYYMMDD-HHMMSS/)
- Upgrade summary report

**Validation checks:**
- Backup exists and is complete
- .livespec/ structure valid after upgrade
- VERSION file updated correctly
- All approved changes applied
- Custom files preserved
- No data loss occurred

**Success criteria:**
- User can use upgraded methodology immediately
- Custom files and unapproved changes preserved
- Rollback available if needed
- Clear record of what changed
- Validation passes

## Edge Cases

**No VERSION file in current .livespec/:**
- Note: "Pre-upgrade installation detected (no VERSION file)"
- Assume baseline version 1.0.0
- Proceed with caution (more diffs expected)

**.livespec/ is symlink:**
- Detect: `test -L .livespec`
- Warn: "Detected symlink (dogfooding setup). Use 'git pull' in linked repo instead."
- Exit without changes

**Modified standard prompts:**
- Detect: File exists in both, differs from new standard
- Show as 🟡 Modified with diff
- User decides: overwrite (lose customizations) or skip (keep old version)
- Note in summary: "Skipped modified standard files"

**Custom utilities in utils/:**
- Detect: File in .livespec/prompts/utils/ not in new dist/prompts/utils/
- Preserve automatically
- Note in summary: "Preserved custom utilities"

**Conflicting folder structure:**
- Detect: Folders in .livespec/ not in standard structure
- Preserve folders (don't delete)
- Note in validation: "Non-standard folders detected"

**Fetch fails:**
- Catch: Git clone fails, download fails, manual path invalid
- Offer alternate fetch methods
- Exit gracefully if all methods exhausted

## Validation

- Upgrade prompt exists at dist/prompts/utils/upgrade-methodology.md
- Prompt references VERSION file for version detection
- Backup creation is timestamped and verified before proceeding
- All three fetch methods (git, tarball, manual) documented
- Diff categorization uses 4 categories (new, modified, removed, custom)
- User approves each change individually (not batch apply)
- Validation checks folder structure and critical files
- Rollback instructions provided
- Summary shows what changed
- Edge cases handled (no VERSION, symlink, modified standards, custom files)
