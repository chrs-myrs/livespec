---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Upgrading a project surfaces stale references it cannot commit past, leaving the project worse off than before it upgraded
governed-by:
  - specs/foundation/constraints.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
specifies:
  - scripts/remediate-references.sh
---

# Reference Remediation

Repairs the stale references an upgrade surfaces. Installing validation into a
project with historical drift blocks its commits until that drift is fixed, so
the upgrade that installs the validation must also offer the repair.

## Requirements

- [!] Script rewrites retired command names to their current equivalents
  - Mapping is declared in the script and matches the migration table in `references/guides/upgrade-to-v5.md`
  - A retired name with no current equivalent is reported, never guessed
  - Migration guides are skipped: their "old reference" columns are correct as written

- [!] Script repoints convention references at vendored local copies
  - A reference to a convention under the toolchain's `references/standards/conventions/` is rewritten to the project's vendored copy when that copy exists
  - Nothing is rewritten when no vendored copy is present
  - This is what makes vendoring useful: the project's own specs stop pointing into the toolchain

- [!] Changes are visible before they are made
  - `--check` reports every rewrite it would perform, grouped by file, and changes nothing
  - Without `--check` the rewrites are applied and counted
  - Both modes report what could not be remediated and why

- [!] Script never edits outside the project
  - Operates only on files within the current repository
  - Skips `CHANGELOG.md` and any registry entry, where a retired name is a historical record rather than an instruction

## Validation

- `--check` in a project with stale command names lists them with file and line, and modifies nothing
- Applying the rewrites leaves `validate-constraints.sh` reporting fewer errors
- A retired name with no mapping is reported as unremediable rather than rewritten
- A convention reference is repointed only where the vendored copy exists
- CHANGELOG.md and registries are unchanged by either mode
