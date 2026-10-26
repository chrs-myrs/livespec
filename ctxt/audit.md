# AUDIT Mode

> **Generated file** - Do not edit directly. Regenerate using `/livespec:audit context`

Sub-agent context for spec health, frontmatter compliance, learning capture, and context validation.

**Load when:** "health", "validate", "audit specs", "spec health", "context regeneration" — running spec health checks, context validation, extraction.

## Summary

Audit mode maintains specification health through continuous monitoring. Detects when specs and reality diverge, validates frontmatter compliance (IMP-005), extracts learnings from sessions, and keeps context current.

## When to Use

- System in production or active development (specs and code exist, so can drift)
- Frontmatter validation: before every commit
- Health checks: weekly at least, and before releases
- Learning capture: end of each session
- Context rebuild: when `scripts/validate-context.sh` reports stale

## Frontmatter Compliance (IMP-005)

```bash
scripts/validate-frontmatter.sh [--verbose] [--strict] [path]
```

**Checks:**
- All six base fields present (type, category, fidelity, criticality, failure_mode, governed-by)
- `type`, `fidelity` from allowed sets; `category` matches directory (specs under `specs/` only)
- Per-category mandatory fields present, and carrying values (warns when declared empty)
- `governed-by` does NOT contain metaspec paths (warning)
- No underscore field names (rejects `derives_from`, `guided_by`)

**Reports** populated/declared count per mandatory field, so an unpopulated relationship graph shows as a proportion. `path` scans a tree other than `specs/`; `--strict` turns empty-field warnings into errors. Exit 0 pass, 1 failures (fix before committing), 2 usage error.

| Finding | Fix |
|---------|-----|
| Missing base field (`type`) | Add the field (`type: behavior`) |
| Invalid `type` (`feature`) | Use a controlled value (`behavior`) |
| Metaspec path in `governed-by` | Remove it; format is implied by `type` |
| Underscore field (`derives_from`) | Rename to `derives-from` |
| Features spec lacks `satisfies` | Add the upward link |
| `context_compression` in frontmatter | Not read: settings live in `project.yaml`; `/livespec:upgrade` moves it once accepted |

### Per-Category Reminder

| Category | Required beyond base six |
|----------|--------------------------|
| workspace | `applies_to` |
| foundation, strategy | `derives-from` |
| features | `satisfies`, `guided-by` |
| interfaces | none (crossrefs checks they link upward) |
| artifacts | `specifies` |

## Constraint Compliance

```bash
scripts/validate-constraints.sh [--verbose]
```

- Every `/livespec:<name>` referenced in README, skills, commands or agent context resolves to `commands/<name>.md`
- Every `scripts/<name>.sh` referenced in documentation or agent instructions exists (subfolders of `scripts/` included)
- Every `commands/*.md` `routes-to:` target names an existing `skills/*/SKILL.md`
- Retired-layout references (`.livespec/`, `.livespec-version`) outside migration guides and CHANGELOG history
- Project context (`AGENTS.md`, `ctxt/`) doesn't reference the plugin root, and every script it instructs exists in the project
- Toolchain repo only: a git-ignored file under a shipped folder (`templates/`, `references/`, `skills/`, `agents/`, `commands/`, `scripts/`, `examples/`) is an `ignored-shipped-file` ERROR

It does not check whether spec paths named in project context resolve (teaching examples use the same syntax). Exit 0: no errors (warnings permitted). Exit 1: unresolved command, script or route.

## Cross-Reference, Registry, Coverage and Output

```bash
scripts/validate-crossrefs.sh [--strict] [--fix [--prune]]   # links resolve, trace to PURPOSE.md, supports: mirrors upward links
scripts/validate-registries.sh                               # required registries present, entries well-formed, staleness
scripts/validate-coverage.sh [--which <path>]                # which spec's specifies: governs a file (report only)
```

- Links are authored upward only; `--fix` regenerates each parent's `supports:` and migrates retired `implements:` to `satisfies:`, naming every entry it moves. A `supports:` entry with no upward link back is kept and reported (`stale-backlink`); add the link, or `--fix --prune` to remove it. Specs with `vendored-from` provenance are exempt from tracing to PURPOSE.md
- Upward links resolve from the repository root to a spec at the same or higher layer; PURPOSE.md is a direct parent only of foundation and workspace specs
- `registries/proposals.md` (a staging file for outside proposals) and `registries/README.md` are not registries and raise no finding
- Coverage is reported, never enforced: ungoverned files, multiply-governed files, `specifies:` values matching nothing
- Every validator takes `--json` (one versioned document: `schema_version`, `validator`, `livespec_version`, `findings`); exit codes 0/1/2 as in text mode. Contract: `specs/interfaces/formats/validator-output.spec.md`

## Health Detection

| Finding | Action |
|---------|--------|
| Implementation without a spec (`src/api/new-endpoint.py`) | `/livespec:audit extract`: spec with confidence markers, full frontmatter, validate, promote |
| Spec without an implementation | Confirm obsolete (`git log --all --full-history -- <spec>`), then `git rm` it |
| Behaviour changed, spec outdated | Spec right → revert code; code right → `/livespec:design refine specs/features/<name>.spec.md` |
| Broken cross-reference (`guided-by` target missing) | Correct the path in the frontmatter |
| Generated file edited by hand | Revert, run `/livespec:audit context` |

### Context Drift

Every generated file ends with a `livespec-context-sources` hash comment of its sources (no timestamps; they differ per clone). `--strict` turns warnings into errors.
```bash
scripts/validate-context.sh            # each file: current, stale or unstamped
scripts/validate-context.sh --changed  # sources changed since the stamp; unknown if the stamping commit is not in history
```

**Stamped sources:** PURPOSE.md, every spec under `specs/` (strategy and interfaces included), the inlined spec-first template, and the `project.yaml` settings generation reads: `livespec.version`, `livespec.methodology.context_compression`, `agent.context_budget`. Other `project.yaml` keys never mark the context stale; a changed setting is listed as `project.yaml`. Only the flat `ctxt/` files and `ctxt/domains/` are stamped; other subfolders are never stamped or checked.

**Action:** `/livespec:audit context` needs PURPOSE.md and `specs/workspace/context-architecture.spec.md`; if the latter is missing, `/livespec:init` creates it (keeping every existing file) or `/livespec:design workspace` writes it. It then classifies the change by the Spec → Generated File Map in that spec:
- **FULL**: any unstamped file, `unknown` from `--changed`, no map, a source the map doesn't list, a source the map marks Structural (e.g. the context-architecture spec, or a compression or budget change), or a workspace spec added or removed
- **MINOR**: every remaining change maps to one target file
- **Re-stamp only**: no changed source has a generated target

It delegates to `agents/context-builder.md`, which builds exactly the declared shape (root ceiling, ctxt/ files, methodology sections), never preserves a retired folder layout, and ends with `scripts/validate-context.sh --stamp` (never write the stamp line by hand). A retired `ctxt/phases/` or `ctxt/utils/` is reported by `scripts/upgrade-to-v5.sh --detect-only` and never moved or deleted.

### Compression Alignment

`/livespec:audit compression` reads the declared level from `project.yaml` only (`livespec.methodology.context_compression`, `moderate` when absent) and measures the actual one: extraction ratio, reference depth, example coverage, redundancy. A level left in spec frontmatter is reported, not read.

## Learning Capture (Correction-as-Spec)

Signals worth capturing: corrections ("I initially thought X, but actually Y"), user clarifications ("No, I meant..."), and patterns that emerged (same problem hit repeatedly, "we should always do X").

**Flow:** session insight → categorise → present options (AskUserQuestion) → MSL gate (essential? not HOW? proven problem?) → update target spec with correct frontmatter → rebuild context.

| Learning Type | Target Location |
|---------------|-----------------|
| Process/Convention | specs/workspace/ |
| Architectural Decision | specs/strategy/ |
| Feature Behavior | specs/features/ |
| Hard Constraint | specs/foundation/constraints.spec.md |

## Health Report Format

Date, overall health (GREEN/YELLOW/RED with a percentage), then PASS/WARN/FAIL lines for frontmatter compliance, structural health (frontmatter, Validation sections), cross-reference health and MSL compliance, closed by numbered remediation steps (e.g. run `scripts/validate-frontmatter.sh` for detail; remove metaspec paths from governed-by; fix broken references). Weekly triage and the pre-release validator sweep are in `ctxt/evolve.md`.

## References

- Context builder agent: `agents/context-builder.md`
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms — IMP-006)
- Validator specs: `specs/artifacts/validators/` (one per validator, plus `setup-hooks`)
- Hook installer: `scripts/setup-hooks.sh`
- Parent context: AGENTS.md

---

*Audit mode specialist for LiveSpec v5.13.0*
*Parent: AGENTS.md*

<!-- livespec-context-sources: sha256:375031d63176dba9f45458844839f128aebffc3f2d3be85f0fa90c8d0b4f84b9 n=99 -->
