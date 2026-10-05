# AUDIT Mode

> **Generated file** - Do not edit directly. Regenerate using `/livespec:audit context`

Sub-agent context for spec health, frontmatter compliance, learning capture, and context validation.

## Summary

Audit mode maintains specification health through continuous monitoring. Detects when specs and reality diverge, validates frontmatter compliance (IMP-005), extracts learnings from sessions, and keeps context current.

## When to Use

**Entry conditions:**
- System in production OR active development
- Specs and code exist (can drift)
- Session complete with learnings to capture
- Frontmatter compliance needs checking

**Frequency:**
- Health checks: Weekly (minimum) or before releases
- Frontmatter validation: Before every commit
- Learning capture: End of each session
- Context rebuild: When workspace specs change

## Frontmatter Compliance (IMP-005)

### Run Validation

```bash
scripts/validate-frontmatter.sh
```

**Checks:**
- All six base fields present (type, category, fidelity, criticality, failure_mode, governed-by)
- `type` value is from allowed set
- `category` matches directory location (specs under `specs/` only)
- `fidelity` is from allowed values
- Per-category mandatory fields present
- Per-category mandatory fields carry values — warns when declared empty
- `governed-by` does NOT contain metaspec paths
- No underscore field names (rejects `derives_from`, `guided_by`)

**Reports:** populated/declared count per mandatory field, so an unpopulated relationship graph is visible as a proportion rather than hidden behind a pass.

**Arguments:** `[--verbose] [--strict] [path]` — `path` scans a tree other than `specs/` (spec-shaped files under `lib/`, `scripts/`); `--strict` turns empty-field warnings into errors.

**Exit code 0:** All checks pass
**Exit code 1:** Failures found — must fix before committing
**Exit code 2:** Usage error (unknown option, path is not a directory)

### Common Failures

| Finding | Fix |
|---------|-----|
| Missing base field (`type`) | Add the field (`type: behavior`) |
| Invalid `type` (`feature`) | Use a controlled value (`behavior`) |
| Metaspec path in `governed-by` (warning) | Remove it; format is implied by `type` |
| Underscore field (`derives_from`) | Rename to `derives-from` |
| Missing per-category field (features lack `satisfies`) | Add the upward link |

## Constraint Compliance

### Run Validation

```bash
scripts/validate-constraints.sh [--verbose]
```

**Checks:**
- Every `/livespec:<name>` referenced in README, skills, commands, or agent context resolves to `commands/<name>.md`
- Every `scripts/<name>.sh` referenced in documentation or agent instructions exists
- Every `commands/*.md` `routes-to:` target names an existing `skills/*/SKILL.md`
- Retired-layout references (`.livespec/`, `.livespec-version`) outside migration guides and CHANGELOG history
- Project context (`AGENTS.md`, `CLAUDE.md`, `ctxt/`) doesn't reference the plugin root, and every script it instructs exists in the project
- Toolchain repo only: a git-ignored file under a shipped folder (`templates/`, `references/`, `skills/`, `agents/`, `commands/`, `scripts/`, `examples/`) is an `ignored-shipped-file` ERROR

## Cross-Reference, Coverage and Output

```bash
scripts/validate-crossrefs.sh [--strict] [--fix [--prune]]   # links resolve, trace to PURPOSE.md, supports: mirrors upward links
scripts/validate-coverage.sh [--which <path>]      # which spec's specifies: governs a file (report only)
```

- Links are authored upward only; `--fix` regenerates each parent's `supports:` and migrates retired `implements:` to `satisfies:`, naming every entry it moves. A `supports:` entry with no upward link back is kept and reported (`stale-backlink`); add the link, or run `--fix --prune` to remove it. Specs with `vendored-from` provenance are exempt from tracing to PURPOSE.md
- Upward links must resolve from the repository root to a spec at the same or higher layer; PURPOSE.md is a direct parent only of foundation and workspace specs
- Coverage is reported, never enforced: ungoverned files, multiply-governed files, `specifies:` values matching nothing
- Every validator takes `--json` (one versioned document: `schema_version`, `validator`, `livespec_version`, `findings`); exit codes 0/1/2 as in text mode. Contract: `specs/interfaces/formats/validator-output.spec.md`

**Constraint validator does not check** whether spec paths named in project context resolve (teaching examples use the same syntax as real references).

Exit 0: no errors (warnings permitted). Exit 1: unresolved command, script or route.

### Per-Category Reminder

| Category | Required fields beyond base six |
|----------|----------------------------------|
| workspace | `applies_to` |
| foundation | `derives-from` |
| strategy | `derives-from` |
| features | `satisfies`, `guided-by` |
| interfaces | none (crossrefs validation checks they link upward) |
| artifacts | `specifies` |

## Health Detection

### Spec-Code Drift

| Finding | Action |
|---------|--------|
| Implementation without a spec (`src/api/new-endpoint.py`) | `/livespec:audit extract` |
| Spec without an implementation (deleted code) | `git rm` the spec |
| Behaviour changed, spec outdated | `/livespec:design refine specs/features/<name>.spec.md` |

### Structural Drift

| Finding | Action |
|---------|--------|
| Broken cross-reference (`guided-by` target missing) | Correct the path in the frontmatter |
| Generated file edited by hand | Revert, run `/livespec:audit context` |

### Context Drift

**Context stale:** every generated file ends with a `livespec-context-sources` hash comment of its sources (no timestamps; they differ per clone). `--strict` turns warnings into errors.
```bash
scripts/validate-context.sh            # each file: current, stale or unstamped
scripts/validate-context.sh --changed  # sources changed since the stamp; prints unknown if the stamping commit is not in history
```

Stamped sources: PURPOSE.md and every spec under `specs/` (strategy and interfaces included), plus the inlined spec-first template. Only the flat `ctxt/` files and `ctxt/domains/` are stamped; other subfolders are never stamped or checked. Any unstamped file, `unknown` from `--changed`, or a missing Spec → Generated File Map means FULL.

**Action:** `/livespec:audit context` — classifies the change as MINOR (scoped patch to the mapped file, per the Spec → Generated File Map in `specs/workspace/context-architecture.spec.md`) or FULL (whole-tree rebuild), then delegates to `agents/context-builder.md`, which never preserves a folder layout and ends by running `scripts/validate-context.sh --stamp` (never write the stamp line by hand). When no changed source feeds a generated file, the run re-stamps without regenerating. A retired `ctxt/phases/` or `ctxt/utils/` is reported by `scripts/upgrade-to-v5.sh --detect-only` and never moved or deleted by it.

## Learning Capture (Correction-as-Spec)

### Session Insight Patterns

Signals worth capturing: corrections ("I initially thought X, but actually Y"), user clarifications ("No, I meant..."), and patterns that emerged (same problem hit repeatedly, "we should always do X").

### Learning → Spec Flow

Session insight → categorise (workspace/strategy/features) → present options (AskUserQuestion) → MSL gate (essential? not HOW? proven problem?) → update target spec with correct frontmatter → rebuild context.

### Learning Routing

| Learning Type | Target Location |
|---------------|-----------------|
| Process/Convention | specs/workspace/ |
| Architectural Decision | specs/strategy/ |
| Feature Behavior | specs/features/ |
| Hard Constraint | specs/foundation/constraints.spec.md |

## Health Report Format

A report carries date, overall health (GREEN/YELLOW/RED with a percentage), then PASS/WARN/FAIL lines for frontmatter compliance, structural health (frontmatter, Validation sections), cross-reference health (links valid) and MSL compliance, closed by numbered remediation steps (e.g. run `scripts/validate-frontmatter.sh` for detail; remove metaspec paths from governed-by; fix broken references).

## Remediation Strategies

- **Code without specs:** `/livespec:audit extract` creates a spec with confidence markers; apply full frontmatter, validate, promote
- **Spec without code:** confirm obsolete (`git log --all --full-history -- <spec>`), then `git rm` it
- **Behaviour changed without spec update:** spec right, code wrong → revert code; code right → `/livespec:design refine specs/features/<spec>.spec.md`

### Stale context

```bash
/livespec:audit context
# Regenerates AGENTS.md from workspace specs (scoped or full, auto-classified)
```

## Continuous Evolution Pattern

### Weekly Maintenance

Check frontmatter, constraints and `/livespec:audit health`; triage ERROR and CRITICAL immediately, IMPORTANT within the week, MINOR to backlog; end with `/livespec:audit validate`.

### Pre-Release Validation

```bash
# All seven validators run in CI on every push (.github/workflows/validate.yml)
scripts/validate-frontmatter.sh
scripts/validate-crossrefs.sh --strict
scripts/validate-constraints.sh
scripts/validate-registries.sh
scripts/validate-purpose.sh
scripts/validate-coverage.sh      # report only
scripts/validate-context.sh       # stale/unstamped until context is regenerated

# Rebuild context
/livespec:audit context
```

### Session End

`/livespec:learn` captures learnings, then start a fresh session.

## References

- Context builder agent: `agents/context-builder.md`
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms — IMP-006)
- Coverage and context validators: `specs/artifacts/validators/validate-coverage.spec.md`, `specs/artifacts/validators/validate-context.spec.md`
- Constraint validator spec: `specs/artifacts/validators/validate-constraints.spec.md`
- Hook installer: `scripts/setup-hooks.sh` (spec: `specs/artifacts/validators/setup-hooks.spec.md`)
- Parent context: AGENTS.md

---

*Audit mode specialist for LiveSpec v5.11.0*
*Parent: AGENTS.md*

<!-- livespec-context-sources: sha256:05325e2061ac33a004d5b3b90e0e80bea7a2ac2483e70b5f3cf692cbfc407461 n=96 -->
