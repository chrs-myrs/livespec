---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Configuration drifts out of agreement across files, so the version or settings a project works to depend on which file is read
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
supports:
  - specs/artifacts/skills/init.spec.md
---

# Project Configuration

Covers the committed configuration files that describe the project to its
toolchain. Referenced by AGENTS.md as the spec covering config files and
auto-generated lock files.

## Requirements

- [!] `project.yaml` is the single source of truth for project identity and version
  - Carries `livespec.version`, methodology decisions, taxonomy and agent configuration
  - No second file restates the version as its own source of truth

- [!] The settings LiveSpec reads are declared in `project.yaml` and nowhere else
  - A missing key, or a missing `project.yaml`, means the default applies

  | Key | Values | Default |
  |-----|--------|---------|
  | `livespec.methodology.context_compression` | `light`, `moderate`, `aggressive` | `moderate` |
  | `livespec.methodology.tdd` | `mandatory`, `mandatory_with_escape`, `encouraged`, `optional` | `optional` |
  | `agent.context_budget` | size, e.g. `100KB` | `100KB` |

  - A spec, frontmatter included, may refer to a setting but never declares one: two declarations of the same setting drift apart
  - Keys belonging to other tools are left alone
  - `/livespec:upgrade` reports a `context_compression` declared in spec frontmatter and moves it to `project.yaml` once the user accepts

- [!] A project records the LiveSpec version it has accepted
  - `/livespec:init` writes `livespec.version` into `project.yaml`, creating the file when it is absent
  - `/livespec:upgrade` updates `livespec.version` only once the user has accepted the upgrade
  - Recording the version changes nothing else in an existing `project.yaml`
  - Upgrade detection reports the accepted version beside every other version signal (vendored `source-version` stamps, the generated agent context, a legacy `.livespec-version`) and flags any that disagree

- [!] Plugin manifests agree with `project.yaml`
  - `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` carry the same version as `project.yaml` `livespec.version`
  - Disagreement is an ERROR reported by validation, naming every file that differs

- [!] Auto-generated and vendored files are covered by this spec rather than each carrying one
  - Lock files and similar generated configuration need no individual specification
  - Their presence is governed here, so spec-first checks do not demand a spec per file

## Validation

- All three files report the same version string
- A project initialised with `/livespec:init` has a `project.yaml` naming the toolchain version
- No spec frontmatter in this repository or in `templates/` declares `context_compression`
- On a project whose constitution declares `context_compression: light`, upgrade reports it and, once accepted, `project.yaml` holds `light` and the constitution no longer declares it
- `upgrade-to-v5.sh --detect-only` names the accepted version and every vendored file whose version differs
- `/livespec:audit validate` reports an ERROR when any disagrees
- A lock file added to the repository does not trigger a missing-spec finding
