---
specifies: prompts/utils/upgrade-methodology.md
derives-from:
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Users cannot safely upgrade methodology, risking manual errors or abandoning updates when LiveSpec evolves
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/distribution.spec.md
---

# Upgrade Methodology Utility Prompt

## Requirements
- [!] Prompt guides user through safely upgrading .livespec/ methodology to latest LiveSpec version with mandatory verification gates ensuring AI agents actually follow the process (not fake it), preserving customizations while applying approved changes through backup, fetch, diff, selective apply, validation, and AGENTS.md regeneration workflow.
  - **Mandatory pre-flight checks** (essential before upgrade):
    - Detects current version from .livespec/.livespec-version (or notes if missing for pre-2.1.0 installs)
    - Checks if .livespec/ is symlink (warns and exits if true - dogfooding case)
    - Requires agent to clone LiveSpec repository and show git clone output (proof repository fetched)
    - Requires agent to show new version number from cloned distribution before proceeding
    - Agent cannot proceed without completing all pre-flight checks (no faking)
  - **Phase 1: Backup (mandatory evidence)**:
    - Creates timestamped backup (.livespec.backup-YYYYMMDD-HHMMSS/) before any changes
    - Agent must show ls output proving backup exists and contains files
    - Stores backup path for rollback instructions
    - Phase gate: Cannot proceed to Phase 2 without backup evidence
  - **Phase 2-6: Progressive merge** (existing phases with verification):
    - Supports multiple fetch methods (git clone primary, GitHub release tarball fallback, manual path)
    - Diffs .livespec/ vs new dist/ file by file
    - Categorizes changes: new files, modified standard files, removed files, custom files
    - Presents changes per customizations.yaml tracking (auto-update non-customized, review customized)
    - Preserves custom files and unapproved changes
    - Each phase requires completion before next phase starts
  - **Phase 7: AGENTS.md regeneration** (new - mandatory if workspace specs changed):
    - Agent checks if specs/workspace/ changed during upgrade (diff against backup)
    - If changed: Agent must regenerate AGENTS.md using 4d-regenerate-agents.md
    - Agent shows before/after diff of Core Principles section
    - Agent verifies principle order matches constitution.spec.md
    - Prevents AGENTS.md drift (like we caught in 2.2.0 release)
  - **Phase 8: Self-validation** (new - mandatory proof upgrade worked):
    - Agent verifies .livespec/.livespec-version shows new version number
    - Agent counts critical files (metaspecs, prompts) to prove structure intact
    - Agent shows backup directory still exists for rollback
    - All validation tests must pass before marking upgrade complete
    - Agent cannot claim success without showing validation output
  - Updates .livespec/.livespec-version to new version after successful upgrade
  - Validates .livespec/ structure matches folder-structure convention
  - Verifies critical files present (metaspecs, core phase prompts)
  - Lists any structural anomalies
  - Offers to remove backup after successful self-validation
  - Provides rollback instructions (restore from backup)
  - Shows summary of applied changes
  - Process completes in under 15 minutes for typical upgrade (added phases increase time slightly)
  - Zero data loss (backup preserved, custom files untouched, validation proves integrity)

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

**Pre-Flight Checks (MANDATORY):**
- Agent checks .livespec/ exists (error if missing - use setup instead)
- Agent reads current .livespec/.livespec-version if present (note if pre-2.1.0)
- Agent detects if .livespec/ is symlink (warn and exit immediately - use git pull instead)
- Agent clones LiveSpec repository to temp directory
- **PROOF REQUIRED**: Agent shows git clone output proving repository fetched
- **PROOF REQUIRED**: Agent shows new version number from dist/.livespec-version.template
- Agent cannot proceed without showing evidence for all checks

**Phase 1: Backup (mandatory evidence):**
- Create timestamped backup directory (.livespec.backup-YYYYMMDD-HHMMSS/)
- Copy entire .livespec/ to backup
- **PROOF REQUIRED**: Agent shows ls -la output of backup directory
- Store backup path for rollback instructions
- **PHASE GATE**: Cannot proceed to Phase 2 without backup evidence shown

**Phase 2: Fetch validation:**
- Verify fetched distribution has standard/, prompts/, templates/
- Read CHANGELOG from new distribution if present
- Summarize key changes for user (especially ⚠️ HIGH IMPACT changes)
- Highlight changes affecting customized files (from customizations.yaml)

**Phase 3: Standard files (auto-update):**
- Copy standard/ from new dist to .livespec/ (canonical files, always overwrite)
- Report files updated to user

**Phase 4: Non-customized prompts (auto-update):**
- Read customizations.yaml to identify customized files
- Copy non-customized prompts from new dist to .livespec/
- Report files updated to user

**Phase 5: Customized prompts (interactive merge):**
- For each file in customizations.yaml modified list:
  - Show upstream changes (from CHANGELOG if available)
  - Show user's customization reason (from customizations.yaml)
  - Present options: [m]erge upstream, [k]eep yours, [e]dit together, [d]iff
  - Apply user's choice
  - Update customizations.yaml if merged

**Phase 6: Templates and new files:**
- Add new templates from new dist
- Preserve custom templates (from customizations.yaml)
- Ask about new files not yet in .livespec/
- Update .livespec/.livespec-version to new version

**Phase 7: AGENTS.md regeneration (NEW - mandatory if needed):**
- Check if specs/workspace/ changed: `diff -q .livespec/specs/workspace/ $BACKUP/specs/workspace/`
- If changed:
  - **MANDATORY**: Agent must regenerate AGENTS.md using 4d-regenerate-agents.md
  - **PROOF REQUIRED**: Agent shows before/after diff of Core Principles section
  - Agent verifies principle order matches constitution.spec.md
  - Prevents AGENTS.md drift (caught in 2.2.0 release)
- If not changed: Skip this phase

**Phase 8: Self-validation (NEW - mandatory proof):**
- **Test 1**: Verify .livespec/.livespec-version shows new version
  - **PROOF REQUIRED**: Agent shows `cat .livespec/.livespec-version` output
- **Test 2**: Count critical files to prove structure intact
  - **PROOF REQUIRED**: Agent shows metaspec count, prompt count
- **Test 3**: Verify backup still exists for rollback
  - **PROOF REQUIRED**: Agent shows backup directory path
- **PHASE GATE**: All tests must pass before marking upgrade complete
- Agent cannot claim success without showing all validation outputs

**Phase 9: Cleanup and summary:**
- Show upgrade summary (files added/modified/removed/skipped/preserved)
- Offer to remove backup (only if self-validation passed)
- Show rollback command: `rm -rf .livespec && mv .livespec.backup-YYYYMMDD-HHMMSS .livespec`
- Report upgrade complete with new version number

## Outputs

**Primary outputs:**
- Upgraded .livespec/ directory with approved changes
- .livespec/.livespec-version updated to new version
- Timestamped backup (.livespec.backup-YYYYMMDD-HHMMSS/)
- Regenerated AGENTS.md (if workspace specs changed)
- Upgrade summary report with self-validation results

**Mandatory evidence outputs (agent must show):**
- Git clone output (proves repository fetched)
- Backup directory ls output (proves backup created)
- New version number (proves correct version fetched)
- Self-validation test results (proves upgrade worked)
- AGENTS.md diff if regenerated (proves sync)

**Validation checks:**
- Backup exists and is complete (ls output shown)
- .livespec/ structure valid after upgrade (file counts shown)
- .livespec/.livespec-version updated correctly (cat output shown)
- All approved changes applied
- Custom files preserved (customizations.yaml respected)
- AGENTS.md regenerated if workspace specs changed (diff shown)
- No data loss occurred (backup available for rollback)

**Success criteria:**
- User can use upgraded methodology immediately
- Custom files and unapproved changes preserved
- Rollback available if needed (backup path provided)
- Clear record of what changed (summary generated)
- Self-validation passes (all tests shown green)
- Agent provided proof-of-work (cannot fake the process)

## Edge Cases

**No .livespec-version file in current .livespec/:**
- Note: "Pre-2.1.0 installation detected (no .livespec-version file)"
- Assume baseline version 1.0.0 or earlier
- Proceed with caution (more diffs expected)
- Create .livespec-version after successful upgrade

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
- Prompt references .livespec-version file for version detection (not VERSION - naming consistency)
- Prompt includes mandatory pre-flight checks requiring proof-of-work (git clone output, version number)
- Backup creation is timestamped and agent must show ls output (proves backup created)
- Phase gates prevent proceeding without completion (cannot fake phases)
- Fetch method uses git clone as primary (proof required), fallback methods documented
- Diff strategy respects customizations.yaml (auto-update non-customized, review customized)
- User approves customized file changes individually (not batch apply)
- Phase 7 mandates AGENTS.md regeneration if workspace specs changed (prevents drift)
- Phase 8 requires self-validation with proof (version check, file counts, backup verification)
- Agent cannot claim success without showing all validation outputs (no faking)
- Rollback instructions provided with backup path
- Summary shows what changed (added/modified/removed/skipped/preserved)
- Edge cases handled (no .livespec-version, symlink, modified standards, custom files)
