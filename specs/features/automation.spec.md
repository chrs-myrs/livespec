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

## Validation

- Sweep run against a project directory produces a report and leaves the project unchanged
- `upgrade-to-v5.sh --detect-only` on a current plugin-era project reports nothing to migrate and exits 0
- `upgrade-to-v5.sh --detect-only` on a project with legacy artifacts lists them
