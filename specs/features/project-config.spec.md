---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Configuration files drift out of agreement, so the version a project reports depends on which file is read
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
specifies:
  - project.yaml
  - .claude-plugin/plugin.json
  - .claude-plugin/marketplace.json
---

# Project Configuration

Covers the committed configuration files that describe the project to its
toolchain. Referenced by AGENTS.md as the spec covering config files and
auto-generated lock files.

## Requirements

- [!] `project.yaml` is the single source of truth for project identity and version
  - Carries `livespec.version`, methodology decisions, taxonomy and agent configuration
  - No second file restates the version as its own source of truth

- [!] Plugin manifests agree with `project.yaml`
  - `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` carry the same version as `project.yaml` `livespec.version`
  - Disagreement is an ERROR reported by validation, naming every file that differs

- [!] Auto-generated and vendored files are covered by this spec rather than each carrying one
  - Lock files and similar generated configuration need no individual specification
  - Their presence is governed here, so spec-first checks do not demand a spec per file

## Validation

- All three files report the same version string
- `/livespec:audit validate` reports an ERROR when any disagrees
- A lock file added to the repository does not trigger a missing-spec finding
