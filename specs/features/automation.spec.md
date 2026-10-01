---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Maintenance scripts accumulate without specified behaviour, so their exit codes and side effects drift and callers cannot rely on them
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
specifies:
  - scripts/sweep-projects.sh
  - scripts/upgrade-to-v5.sh
---

# Maintenance Automation

Covers the scripts that act across projects or migrate a project between LiveSpec
versions. Validators are specified separately under `specs/artifacts/validators/`.

## Requirements

- [!] Portfolio sweep reports maintenance signals across multiple projects
  - Scores each candidate project against maintenance signals including version lag
  - Reads a project's version from `project.yaml` `livespec.version`
  - Reports without modifying any project it inspects

- [!] Version migration is detection-first and reversible in intent
  - Detects current installation state before proposing any change
  - Identifies a LiveSpec project by its own artifacts, independently of whether the toolchain is installed
  - Supports `--detect-only` and `--dry-run` so state can be inspected without modification
  - Reports "already current, nothing to migrate" rather than "not installed" for a project that is current
  - Recognises a retired install from the git index as well as the working tree, so a fresh clone without its submodule initialised is still recognised

- [!] Spec folder migration is table-driven, never overwrites, and asks where judgement is needed
  - One table maps each retired folder to its current home, and detection, moves, reference rewriting and verification all read it; the portfolio sweep takes its layout detection from this script rather than keeping its own
  - Folders whose mapping is documented (`1-requirements/`, `2-strategy/`, `3-behaviors/`, `3-contracts/`, `4-contracts/`) move automatically
  - For every other retired folder the table proposes a target, and nothing moves until that target is confirmed folder by folder
  - Folders in neither the table nor the current layout are reported by name and never moved
  - Reports the layout as current, retired, retired and mixed (current folders also present), or absent
  - A file whose destination already exists stays where it is; the conflict is reported and the migration does not claim success
  - References to every moved folder are rewritten, and verification checks every folder that moved
  - Never deletes spec content: removing copies or regenerable reports is left to the person confirming

## Validation

- Sweep run against a project directory produces a report and leaves the project unchanged
- `upgrade-to-v5.sh --detect-only` on a current plugin-era project reports nothing to migrate and exits 0
- `upgrade-to-v5.sh --detect-only` on a project with legacy artifacts lists them
- `upgrade-to-v5.sh --detect-only` on a project with `specs/learnings/` reports it as needing a decision, not as already current
- Migrating into a folder that already holds a same-named file leaves both files and reports the conflict
- `--map specs/meta=specs/workspace` moves that folder and rewrites references to it
