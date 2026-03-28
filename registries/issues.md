---
store: registry
registry_type: issues
schema_version: 1
last_reviewed: 2026-03-28
entry_count: 1
---

# Issue Registry

Tracks problems encountered during LiveSpec usage.

---

### ISSUE-002: Cross-Reference Breaks During Reorganisation

**What:** When specs are renamed, moved, or fields restructured, cross-references in frontmatter break if not systematically updated

**Why Problematic:** Broken bidirectional linking, spec discovery fails, validation errors. The IMP-005 implementation (2026-03-28) exposed 110 stale references from the earlier distribution model change.

**Category:** Tooling

**Status:** Open — mitigated but not fully solved

**Mitigation:**
- `scripts/validate-frontmatter.sh` catches structural issues
- `var/fix-broken-refs.py` can detect and fix broken path references
- Manual checklist in AGENTS.md for cross-reference updates

**What would close this:** Automated cross-reference validation in the pre-commit hook that checks all relationship field targets exist on disk.

**Discovered:** 2025-11-13
