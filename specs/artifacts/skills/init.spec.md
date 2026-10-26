---
type: prompt
category: artifacts
fidelity: behavioral
criticality: CRITICAL
failure_mode: A project that already holds some LiveSpec files is reported as initialised while its workspace specs, registries and hook are missing, and a fresh project gets workspace specs that fail LiveSpec's own validators and no context-architecture spec, so /livespec:audit context stops at its first step
governed-by:
  - specs/foundation/constraints.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 3: Universal Applicability)
  - specs/features/project-config.spec.md
specifies:
  - skills/init/SKILL.md
---

# Init Skill

Bootstraps a project for LiveSpec, or finishes the bootstrap of one that
already holds part of it, such as a project another tool created.

## Requirements

- [!] Init checks each bootstrap artefact on its own and creates only those that are missing
  - The artefacts: the `specs/` folders; `PURPOSE.md`; the constitution, taxonomy and context-architecture workspace specs; the required registries and `registries/README.md`; the vendored conventions; the pre-commit hook; `livespec.version` in `project.yaml`
  - No existing file is overwritten, `PURPOSE.md` included
  - The only edit to an existing file adds keys `project.yaml` lacks: `livespec.version`, and in full setup the methodology settings chosen. A value already there is kept; changing an accepted version is `/livespec:upgrade`'s job
  - A project that holds every artefact has nothing written and is told it is already initialised
  - Init works at the root of the project's repository. Below the root of an enclosing repository it stops, rather than split the bootstrap across two projects

- [!] Init installs toolchain copies only where that changes nothing the project has accepted
  - The vendored conventions, the vendored scripts and the hook come from the toolchain. Where installing them would update an existing copy, or where the project has accepted a LiveSpec version other than the toolchain's, init leaves them to `/livespec:upgrade` and says so

- [!] Init reports every bootstrap artefact as created or kept

- [!] A freshly initialised project can generate its agent context
  - `specs/workspace/context-architecture.spec.md` is created from `templates/workspace/context-architecture.spec.md.template`, so `/livespec:audit context` gets past its prerequisites

- [!] Every spec init writes passes LiveSpec's validators as written
  - `validate-frontmatter.sh` and `validate-crossrefs.sh` report no errors, and each spec reaches PURPOSE.md
  - Frontmatter examples the skill shows carry the same fields, so it does not teach a form the validators reject

- [!] Settings chosen in full setup are recorded in `project.yaml` under `livespec.methodology`, per `specs/features/project-config.spec.md`
  - A setting not chosen is left out, so its default applies

## Validation

- In a directory holding PURPOSE.md, foundation and strategy specs, and a `project.yaml` with only `forgewick.version`, init creates only the missing artefacts, leaves PURPOSE.md byte-identical, adds `livespec.version` beside `forgewick.version`, and reports each artefact as created or kept
- Run a second time on the same directory, init writes nothing and reports every artefact as kept
- A `project.yaml` holding an older `livespec.version` keeps it after init, and gets no vendored copies at the toolchain's version
- A `project.yaml` whose `livespec:` block holds no version, followed by another tool's block that does, gets `livespec.version` recorded
- With the hook installed but a vendored validator deleted, init restores the validator
- Run from a subdirectory of a repository, init stops and names the root
- In an empty directory, init followed by `/livespec:audit context` gets past the prerequisites step, and `validate-frontmatter.sh` and `validate-crossrefs.sh` report no errors on the result
