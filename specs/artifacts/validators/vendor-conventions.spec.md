---
type: validator
category: artifacts
fidelity: behavioral
criticality: CRITICAL
failure_mode: Projects restate generic conventions inline and drift from them silently, or depend on a version-pinned toolchain path that changes behaviour underneath them without deliberate action
governed-by:
  - specs/foundation/constraints.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
specifies:
  - scripts/vendor-conventions.sh
---

# Convention Vendoring

Gives a project a local, addressable copy of the conventions it derives from, so
project specs can reference rather than restate them. Satisfies "no action at a
distance": the copy is inert, and updates arrive only when accepted.

## Requirements

- [!] Conventions are vendored into the project as real local files
  - Copied from the toolchain into `specs/standards/`
  - A project spec can reference a vendored convention by a stable repository-relative path
  - No project spec resolves through a version-pinned or machine-local toolchain path

- [!] Each vendored file records its provenance
  - `vendored-from` names the source path, `source-version` the toolchain version, `source-hash` the hash of the source body as vendored
  - The hash covers the body only, never the provenance keys, so it remains verifiable after stamping
  - Provenance is merged into the file's existing frontmatter rather than added as a sidecar

- [!] Script distinguishes four states per vendored file
  - Unchanged: local body matches `source-hash`, upstream body matches `source-hash`
  - Locally edited: local body differs from `source-hash`
  - Upstream changed: upstream body differs from `source-hash`
  - Diverged: both differ, requiring a three-way decision

- [!] Updates are never silent
  - `--check` reports state per file and changes nothing
  - Without `--check`, only absent and upstream-changed-but-unedited files are written
  - A locally edited or diverged file is reported and left alone
  - Running twice produces no further change

- [!] Script is inert where the project is the convention source
  - Detects source and target resolving to the same tree and exits 0 without copying

## Validation

- First run in a project with no `specs/standards/` vendors every convention and stamps provenance
- Second run reports all files unchanged and writes nothing
- Editing a vendored body causes that file to report as locally edited and be left alone on update
- A changed upstream body with an unedited local copy reports upstream-changed and is updated
- Running inside the LiveSpec repository exits 0 without copying
