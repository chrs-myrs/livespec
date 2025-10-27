---
implements: specs/3-behaviors/prompts/utils-upgrade.spec.md
generated: '2025-10-10'
---

# Upgrade Methodology Utility Prompt

**Purpose**: Upgrade LiveSpec methodology to latest version

## Context

This utility prompt helps with common development scenarios across all phases.

## Task

1. Prompt guides user through safely upgrading .livespec/ methodology to latest LiveSpec version with mandatory verification gates ensuring AI agents actually follow the process (not fake it), preserving customizations while applying approved changes through backup, fetch, diff, selective apply, validation, and AGENTS.md regeneration workflow.

## Output

Complete the specified task with clear deliverables.

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

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: Users cannot safely upgrade methodology, risking manual errors or abandoning updates when LiveSpec evolves
