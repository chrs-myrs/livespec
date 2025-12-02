# Issue Registry

Tracks problems encountered during LiveSpec usage.

Format: `.livespec/standard/registries/issues.spec.md`

---

## Current Issues

### ISSUE-001: Generated File Direct Edits

**What:** Users occasionally edit AGENTS.md, CLAUDE.md, or context tree files directly instead of editing source specs

**Why Problematic:** Changes lost on regeneration, creates drift between sources and outputs, validation errors

**Category:** Process

**Status:** Investigating

**Resolution:** Need clearer warnings in generated files, validation that catches edits faster, better guidance about regeneration workflow

**Discovered:** Multiple sessions (validation catches this regularly)

**Related:** GAP-005 (need better generated file protection)

---

### ISSUE-002: Cross-Reference Breaks During Reorganization

**What:** When prompts renamed/moved, cross-references in frontmatter and navigation break if not systematically updated

**Why Problematic:** Broken bidirectional linking, prompt discovery fails, validation errors

**Category:** Tooling

**Status:** Open

**Resolution:** Need checklist for updates (source, spec, registry, navigation, predecessors, docs) or automated tool

**Discovered:** 2025-11-13 during prompt reorganization discussion

**Related:** Need cross-reference update automation

---

### ISSUE-003: Session Completion Not Triggered Proactively

**What:** Agents don't recommend session completion even when context >100K tokens or all tasks done

**Why Problematic:** Sessions run too long, context degrades, manual session management burden

**Category:** Guidance

**Status:** Investigating

**Resolution:** Add active trigger logic to AGENTS.md, make detection unmissable

**Discovered:** 2025-11-08 (127K token session feedback)

**Related:** GAP-001 (agent session prompting)

---

### ISSUE-004: Terminology Inconsistency

**What:** "Conversation" vs "session", "internalise learnings" vs "capture learnings", ambiguous "framework evolution"

**Why Problematic:** User and agent confusion about workflows, unclear when to use which tool

**Category:** Documentation

**Status:** Investigating

**Resolution:** Create terminology guide, standardize across all docs/prompts, validate term usage

**Discovered:** 2025-11-13 user question about improvement workflows

**Related:** GAP-002 (learning terminology confusion)

---

## Maintenance

**Update:** After sessions (if issues encountered), after health reports
**Review:** 5+ open issues, same issue 3+ times, CRITICAL severity, weekly
**Archive:** Resolved issues to `.archive/issues-resolved-YYYY-MM.md`
