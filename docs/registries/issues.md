---
store: registry
registry_type: issues
schema_version: 1
last_reviewed: 2026-03-28
entry_count: 5
---

# Issue Registry

Tracks problems encountered during LiveSpec usage.

---

## Current Issues

### ISSUE-001: Generated File Direct Edits

**What:** Users occasionally edit AGENTS.md, CLAUDE.md, or context tree files directly instead of editing source specs

**Why Problematic:** Changes lost on regeneration, creates drift between sources and outputs, validation errors

**Category:** Process

**Status:** Resolved ✓

**Resolution:** Read-only file permissions (chmod 444) applied after generation

**Discovered:** Multiple sessions (validation catches this regularly)

**Related:** GAP-005 (need better generated file protection)

**Resolution (2025-12-15):** Structural fix implemented - generated files now made read-only (chmod 444) after generation. User must explicitly `chmod +w` to edit, creating friction that prompts reconsideration. Updated: specs/workspace/generated-files.spec.md, context-builder agent instructions, and regeneration prompts (regenerate-contexts.md, 4d-regenerate-context.md).

---

### ISSUE-005: Installation Script Missing CLAUDE.md Symlink

**What:** install-livespec.sh creates AGENTS.md but doesn't create CLAUDE.md symlink

**Why Problematic:** Claude Code reads CLAUDE.md; without symlink, users must manually create it

**Category:** Tooling

**Status:** Resolved ✓

**Resolution:** Added symlink creation to install script (after AGENTS.md copy)

**Discovered:** 2025-12-18 damp-case feedback

**Resolution (2025-12-21):** Added 5 lines to install-livespec.sh that create CLAUDE.md → AGENTS.md symlink after AGENTS.md installation.

---

### ISSUE-002: Cross-Reference Breaks During Reorganization

**What:** When prompts renamed/moved, cross-references in frontmatter and navigation break if not systematically updated

**Why Problematic:** Broken bidirectional linking, prompt discovery fails, validation errors

**Category:** Tooling

**Status:** Open (acknowledged limitation)

**Resolution:** Need checklist for updates (source, spec, registry, navigation, predecessors, docs) or automated tool

**Discovered:** 2025-11-13 during prompt reorganization discussion

**Related:** Need cross-reference update automation

**Update (2025-12-15):** Manual checklist approach in use. No automation built. Acceptable workaround since prompt reorganization is infrequent. Consider automation if this becomes more common.

---

### ISSUE-003: Session Completion Not Triggered Proactively

**What:** Agents don't recommend session completion even when context >100K tokens or all tasks done

**Why Problematic:** Sessions run too long, context degrades, manual session management burden

**Category:** Guidance

**Status:** Accepted Limitation ✓

**Resolution:** User-initiated via `/livespec:complete-session` slash command

**Discovered:** 2025-11-08 (127K token session feedback)

**Related:** GAP-001 (agent session prompting)

**Resolution (2025-12-15):** Accepted as limitation. Stronger enforcement would compete with more critical guidance (spec-first protocol). Session completion is user-initiated by design. The workflow works well when used (IMP-003 effective). Closing with GAP-001.

---

### ISSUE-004: Terminology Inconsistency

**What:** "Conversation" vs "session", "internalise learnings" vs "capture learnings", ambiguous "framework evolution"

**Why Problematic:** User and agent confusion about workflows, unclear when to use which tool

**Category:** Documentation

**Status:** Resolved ✓

**Resolution:** Create terminology guide, standardize across all docs/prompts, validate term usage

**Discovered:** 2025-11-13 user question about improvement workflows

**Related:** GAP-002 (learning terminology confusion)

**Resolution (2025-12-15):** IMP-001 established clear four-level taxonomy. No terminology confusion reported in 18 feedback files since Nov 13. Closing this issue with GAP-002.

---

## Resolved Issues (Archived 2025-12-15)

- **ISSUE-001:** Generated File Direct Edits → Structural fix (chmod 444 read-only permissions)
- **ISSUE-003:** Session Completion Not Triggered → Accepted as limitation (user-initiated by design)
- **ISSUE-004:** Terminology Inconsistency → IMP-001 effective (clear taxonomy)

---

## Maintenance

**Update:** After sessions (if issues encountered), after health reports
**Review:** 5+ open issues, same issue 3+ times, CRITICAL severity, weekly
**Archive:** Resolved issues to `.archive/issues-resolved-YYYY-MM.md`
