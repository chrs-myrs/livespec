# LiveSpec Methodology Feedback Report

**Date**: 2026-08-06
**LiveSpec Version**: Plugin v5.8.0
**Source project**: forgewick (the Forgewick deployment tool itself)
**Trigger**: full `/livespec:audit` and four-phase remediation, 26 commits
**Anonymisation**: None (personal project)

---

## 1. Context

Forgewick is the tool that forges other projects with LiveSpec. It had drifted
badly against the framework it deploys: 174 frontmatter errors across 47 specs,
46 broken cross-references, a context tree 88% over budget in a structure v5.8
forbids, and agent instructions nine months stale.

The remediation succeeded — the project ended GREEN. This report covers the five
findings that are **about LiveSpec**, not about Forgewick, because each would
affect any project adopting the framework.

---

## 2. Findings

### 2.1 The crossref validator cannot resolve plugin paths (highest impact)

`scripts/validate-crossrefs.sh` resolves every relationship path from the
**project root**. Paths beginning `references/` therefore report broken in any
consuming project, even though they point at real files shipped in the plugin.

This is LiveSpec's own documented convention. The plugin's specs use exactly
these paths, and `references/standards/vocabulary.spec.md` presents them as
normal usage. **A project that follows the convention correctly cannot reach a
clean crossref validation.**

Forgewick ends the audit with 7 permanently "broken" references, all verified
to exist inside the plugin.

The practical risk is the one LiveSpec already understands: `ISSUE-001` in
`registries/issues.md` records that pre-existing failures "were training
contributors to bypass with `--no-verify`". This reproduces that failure mode
at the validator level.

**Suggested fix** — try the plugin root before declaring a path broken:

```bash
if [[ ! -e "$clean" ]]; then
    plugin_root="${CLAUDE_PLUGIN_ROOT:-}"
    if [[ -z "$plugin_root" || ! -e "$plugin_root/$clean" ]]; then
        # report broken
    fi
fi
```

---

### 2.2 No detection or migration for forbidden `ctxt/` subfolders

`references/standards/conventions/context-tree.spec.md` requires `ctxt/` to be
flat — "no `phases/` or `utils/` subfolders" — plus `ctxt/domains/`.

Forgewick had `ctxt/phases/` (five files) and `ctxt/utils/` (three), generated
under an earlier convention. Nothing detects this. `upgrade-to-v5.sh` checks for
submodules, `.livespec-version` and numbered spec folders, but not context tree
layout. `/livespec:audit` reports on specs, not on generated context structure.

The drift was invisible until read against the convention by hand. Any project
generated before the flat layout landed is silently non-conformant.

**Suggested fix**: have `upgrade-to-v5.sh` detect `ctxt/phases/` or `ctxt/utils/`
and report a required rebuild, or have `/livespec:audit context` refuse a MINOR
patch when the layout is non-conformant.

---

### 2.3 Workspace spec template omits the Spec → Generated File Map

`/livespec:audit context` classifies changes MINOR or FULL "based on the Spec →
Generated File Map in `specs/workspace/context-architecture.spec.md`".

Forgewick's `context-architecture.spec.md` had no such map — and nothing had
ever flagged that. Worse, it declared "single AGENTS.md context (flat
structure)" while the project ran a ten-file tree, so the spec that governs
context generation was itself describing a system that did not exist.

Without the map, every regeneration silently degrades to a full rebuild. The
degradation is invisible: the command still works, just wastefully.

**Suggested fix**: include the map as a required section in the workspace spec
template, and have `/livespec:audit context` warn when it is absent rather than
falling back silently.

---

### 2.4 Body-text spec references are entirely unvalidated

Both validators check frontmatter relationship fields only. References written
in prose — extremely common in practice — are never checked.

Forgewick had seven genuinely dead ones, including specs referenced as
`.metaspec.md` when the files are `.spec.md`, and a path to a spec archived
months earlier. All had been wrong long enough to survive multiple audits.

A caution for anyone implementing this: naive path-existence checking produces
heavy false positives. Several apparently-dead paths in Forgewick were correct —
they name files generated in *target* projects (`knowledge-operations.spec.md`,
`project-structure.spec.md`), or are illustrative examples of where product
specs belong. A useful validator has to distinguish those, which may be why this
was left out. A `--warn-only` mode would still be worth having.

---

### 2.5 Audit output has no freshness or supersession mechanism

`.livespec-audit/` held `AUDIT-SUMMARY.txt`, `issues.md` and
`audit-metadata.json` from an audit five months earlier. Nothing in the files or
the command marks them superseded. They described the project as RED at 5/10
against framework v5.1.0 — a picture the current audit comprehensively
contradicts.

Stale audit output is worse than none: it reads authoritative and is wrong.
This nearly caused a real error in this session — the old report was treated as
current context before its date was checked.

**Suggested fix**: have `/livespec:audit` stamp output with the framework
version and git HEAD, and warn when reading a report whose HEAD is no longer an
ancestor of the current one.

---

## 3. What worked well

Worth recording, since feedback skews negative:

- **The frontmatter standard is genuinely mechanical.** 174 errors across 47
  specs were fixed by script plus a judgement table for type/fidelity. The
  vocabulary is small enough to map confidently and strict enough to be worth
  enforcing.
- **`category` matching the directory** is a good constraint — cheap to check,
  catches real misfiling.
- **The context budget is well-calibrated.** Forgewick's tree was 188KB; forced
  under 100KB it lost nothing of value, and the 4-10KB per-specialist ceiling
  was the thing that made the cut decisive rather than negotiable.
- **The scoped pre-commit hook design** (staged specs only, per `ISSUE-001`) is
  right, and the reasoning in its header comment was directly useful.

---

## 4. Metrics

| Measure | Before | After |
|---|---|---|
| Frontmatter errors | 174 / 47 specs | 0 |
| Broken cross-references | 46 | 7 (all §2.1) |
| Unspecced scripts | 16 | 0 |
| Context tree | 188KB, forbidden layout | 77.5KB, conformant |
| Largest spec cluster | 3,315 lines / 54 reqs | 374 lines / 54 reqs |
| Lines per requirement | 61 | 7 |

The bloat figure is worth a note for the methodology. The six specs each stated
their content **twice** — once as `### REQ-*` entries under `## Requirements`,
then again as narrative `##` sections mirroring them one-for-one. That is not an
obvious failure mode, it survived every prior audit, and no current check
detects it. A "sections restating requirements" heuristic would be a strong
addition to `/livespec:audit msl`.

---

## 5. Related

- `feedback/slackward-feedback-e4838980.md` — earlier Forgewick-forged project
- Forgewick-side write-up of §2.1 with reproduction:
  `~/projects/forgewick/research/livespec-validator-plugin-paths.md`
