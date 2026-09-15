---
type: validator
category: artifacts
fidelity: behavioral
criticality: CRITICAL
failure_mode: Documented commands, scripts and paths drift from what ships, so agents are instructed to run things that do not exist and constraint violations reach release unnoticed
governed-by:
  - specs/foundation/constraints.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
specifies:
  - scripts/validate-constraints.sh
---

# Constraint Validator

Checks the assertions LiveSpec makes about itself. Every defect this catches was
previously found only by a user hitting it.

## Requirements

- [!] Script verifies every referenced command exists
  - Each `/livespec:<name>` appearing in README, skills, commands or agent context resolves to `commands/<name>.md`
  - Reports the referencing file and line for each unresolved command
  - Prevents documenting a command set before it ships

- [!] Script verifies every referenced script exists
  - Each `scripts/<name>.sh` referenced in documentation or agent instructions resolves to a file
  - Prevents instructing an agent to run a gate that was deleted

- [!] Script verifies command-to-skill routing integrity
  - Each `commands/*.md` declares `routes-to:` naming a `skills/*/SKILL.md` that exists

- [!] Script detects references to retired distribution layouts
  - Flags `.livespec/` and `.livespec-version` outside migration guides and changelog history
  - Enforces the toolchain independence boundary: a project artefact must not point into a layout the project does not have

- [!] Script reports severity and exits accordingly
  - ERROR for an unresolved command, script or route; exit 1
  - WARNING for a retired-layout reference; exit 0
  - Summary states counts per category

## Validation

- A `/livespec:` command referenced but absent from `commands/` produces an ERROR naming the referencing file
- A `scripts/*.sh` referenced but absent produces an ERROR
- A `commands/*.md` whose `routes-to:` target is missing produces an ERROR
- A `.livespec/` reference outside `references/guides/` and `CHANGELOG.md` produces a WARNING
- Clean repository exits 0 with zero errors
