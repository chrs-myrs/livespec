---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Broken cross-references cause spec drift, lost traceability, and silent methodology violations — 110 stale references accumulated before detection in v5.4.0
governed-by:
  - specs/foundation/constraints.spec.md
  - specs/interfaces/formats/validator-output.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/validation.spec.md
  - specs/strategy/dogfooding.spec.md
specifies:
  - scripts/validate-crossrefs.sh
supports:
  - specs/features/lsp/diagnostics.spec.md
---

# Cross-Reference Validation

## Requirements

- [!] A validation script checks that spec relationship links resolve, and that upward links trace every spec to PURPOSE.md, runnable both manually and in the pre-commit hook.
  - Checks all relationship fields: governed-by, satisfies, guided-by, derives-from, supports, specifies, implements, extends, informed-by, supersedes, updated-by
  - Targets are written from the repository root; a target that resolves only relative to the referencing spec is reported with that hint, never resolved
  - Reads inline values, block lists and flow lists (`[a, b]`), strips quotes, parenthetical annotations and trailing comments, and skips non-path values (e.g., "all_projects")
  - Reports any other value form as unparseable rather than guessing
  - Reports an unresolved target with source file, field name and target path
  - Counts relationship fields declared with no values in the summary, so the references-checked figure is not read as coverage it has not earned
  - Accepts optional path arguments, each a directory to scan or a single spec file, so spec-shaped files outside `specs/` and the specs staged for a commit can be checked; defaults to `specs/`

- [!] Upward links (`derives-from`, `satisfies`, `guided-by`, `governed-by`) resolve only to a real parent
  - The target is PURPOSE.md or a spec, and not the spec itself
  - The target's layer is the same as or higher than the source's, ranking PURPOSE, then foundation and workspace, then strategy, then features, interfaces and artifacts
  - PURPOSE.md is a permitted target only for foundation and workspace specs, so a lower spec cannot pass by linking straight to it
  - A spec's layer is its `category` when valid, otherwise the folder it sits in under `specs/`; a link involving a spec of unknown layer is not judged on layer

- [!] Every spec traces to PURPOSE.md
  - A spec with no resolving upward link is reported as unlinked
  - A linked spec whose resolving links never reach PURPOSE.md is reported as having no chain
  - A spec on a cycle of upward links is reported
  - The graph is always the whole tree (every spec under `specs/`, PURPOSE.md and the paths given), even when only some files are checked, so checking the staged specs still sees their chains; findings are reported only for the files checked

- [!] Each spec's `supports:` lists exactly the specs whose upward links resolve to it, so links are navigable both ways within the files
  - A child missing from its parent's list, or an entry with no upward link back, is reported on the parent, whenever the parent or that child is among the files checked
  - `implements:` is retired and reported wherever it is declared
  - `--fix` moves `implements:` values into `satisfies:`, then rewrites each mismatched `supports:` in sorted order, adding the field only to specs that have children
  - `--fix` names every entry it drops, so a relation once written only as `supports:` can be re-expressed as an upward link; it changes nothing else in the frontmatter

- [!] Severity separates what is broken from what is untraced
  - An unresolved or relative target is an error
  - Every other finding is a warning, promoted to an error by `--strict`
  - Exits 0 when there is no error, 1 when there is at least one, 2 on a usage error
  - `--json` reports findings per `specs/interfaces/formats/validator-output.spec.md`
  - Integrated into pre-commit hook alongside frontmatter validation

## Validation

- [ ] `scripts/validate-crossrefs.sh` exists and is executable
- [ ] Script detects broken file path references in frontmatter
- [ ] Script ignores non-path values, and counts empty relationship fields rather than skipping them silently
- [ ] Script strips parenthetical annotations before path checking
- [ ] A flow list `[a, b]` is read as two targets
- [ ] An upward link to a non-spec file, to the spec itself, or to a lower layer is reported
- [ ] A feature whose only upward link is PURPOSE.md is reported
- [ ] Checking one staged spec reports its missing chain using the rest of the tree
- [ ] After `--fix` on this repository no backlink finding remains, and a second `--fix` changes nothing
- [ ] A spec gaining an upward link, checked alone, reports the missing entry on its parent
- [ ] Pre-commit hook runs cross-reference validation
- [ ] All current specs pass with 0 errors, and with 0 warnings under `--strict`
- [ ] Summary reports empty relationship fields alongside references checked
