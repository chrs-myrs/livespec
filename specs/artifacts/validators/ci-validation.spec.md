---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: A contributor who never installs the hook pushes unvalidated specs, and nothing catches them before review
governed-by:
  - specs/strategy/validation.spec.md
specifies:
  - .github/workflows/validate.yml
---

# CI Validation

Runs this repository's validators on every push and pull request, so enforcement
does not depend on each clone having installed the hook.

## Requirements

- [!] Every push and pull request runs the seven validators against the whole tree
  - Cross-reference validation runs with `--strict`, since this repository traces every spec to PURPOSE.md: a new traceability warning fails the run
  - The other validators run in their default mode; coverage is reported and never fails the run, and context currency is reported until the generated context is next regenerated
  - Every validator runs even when an earlier one fails, so one run reports everything
  - Any failing validator fails the run

- [!] The run needs nothing beyond the repository and a stock runner
  - No toolchain install, package registry or secret
  - Read-only access to the repository

## Validation

- The run passes on the current tree
- A pushed spec with a broken link, or with no upward link, fails the run
