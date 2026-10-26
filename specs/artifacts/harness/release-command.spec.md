---
type: command
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: A release ships with version files disagreeing, documentation naming commands that do not exist, or no tag, so users cannot tell which LiveSpec they installed
governed-by: []
satisfies:
  - specs/workspace/version-management.spec.md
specifies:
  - .claude/commands/release.md
---

# Release Command

`/release` publishes a LiveSpec version from what the changelog records.

## Requirements

- [!] Command releases only what the changelog records
  - Stops, changing nothing, when the Unreleased section is empty
  - Chooses the increment from the Unreleased entries by semantic versioning, and asks the maintainer when the entries do not settle it

- [!] Command refuses to release documentation describing what does not ship
  - A failing `validate-constraints.sh` stops the release before any file changes

- [!] Every file carrying the version moves to the new version in the release commit
  - `project.yaml` is the source of truth
  - Unreleased becomes a dated version heading, with a new empty Unreleased above it
  - Agent context current before the release is still current after it: the version is a context source, so the footers move and the context is re-stamped
  - The pre-commit hook runs; it is never bypassed

- [!] The release is published and reported
  - The commit is pushed and tagged `vX.Y.Z` on origin
  - Reports the old and new version, the increment type and the tag

## Validation

- With an empty Unreleased section, no file changes and the command says there is nothing to release
- With a constraint violation, no file changes and the violations are reported
- After a release, the old version appears nowhere except the changelog's history, and the working tree is clean
- Context reported current by `validate-context.sh` before a release is reported current after it
- Tag `vX.Y.Z` on origin points at the release commit
