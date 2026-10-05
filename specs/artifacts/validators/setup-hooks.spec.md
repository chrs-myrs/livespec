---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Validation never runs automatically in target projects, so spec drift and broken references reach commits despite validators existing
governed-by:
  - specs/foundation/constraints.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
specifies:
  - scripts/setup-hooks.sh
---

# Git Hook Installer

Installs LiveSpec validation as a pre-commit hook in a target project. Layer 4 of
spec-first enforcement is worthless if every project has to wire it by hand.

## Requirements

- [!] Script installs a pre-commit hook without displacing an existing one
  - Writes `.git/hooks/pre-commit` and makes it executable
  - Preserves any unrelated existing hook as `pre-commit.local` and chains to it
  - Never discards a hook it did not install; credential scanners installed via
    `init.templateDir` must keep running
  - Recognises a hook it previously installed and replaces it without prompting
  - Is idempotent: running twice leaves the same result

- [!] Installed hook runs the project's own version-controlled checks
  - When `scripts/pre-commit-local.sh` exists, the hook runs it after `pre-commit.local`, before LiveSpec validation, and blocks the commit when it fails
  - Unlike `.git/hooks/pre-commit.local`, which git does not track, it travels with a clone, so a project's own checks come back wherever the installer runs
  - `--check` reports whether it is present

- [!] Script vendors into the project the validators the hook runs, the scripts generated project context instructs, the output helper they source, the coverage validator the spec-first gate relies on, and the context-currency check
  - Hook validation works at commit time with no toolchain environment: `CLAUDE_PLUGIN_ROOT` is not set in a shell or an agent's shell tool
  - Each vendored script records `vendored-from`, `source-version` and `source-hash` in a comment block, with the hash covering the script without those lines
  - Distinguishes unchanged, locally edited, upstream changed and diverged, as convention vendoring does; only absent and upstream-changed-but-unedited scripts are written
  - A same-named project script without provenance belongs to the project and is left alone
  - Inert where the project is the toolchain source

- [!] Installed hook degrades gracefully when the toolchain is absent
  - Resolves validators from the project's own `scripts/` first, then `${CLAUDE_PLUGIN_ROOT}/scripts/`
  - Skips with a notice and exit 0 when neither is available
  - A contributor without LiveSpec installed is never blocked from committing

- [!] Installed hook validates what is being committed and blocks on error
  - Frontmatter and cross-reference validation run on the staged `*.spec.md` files only, and block the commit on exit 1
  - Historical drift elsewhere in the tree never blocks a commit: blocking on it trains contributors to bypass the hook, and `/livespec:audit validate` still reports it
  - Constraint validation runs whole-tree and is advisory: a failure is summarised and never blocks
  - Names the failing validator

- [!] Script reports what it did
  - States the hook path written and which validators the hook will run
  - `--check` reports current install state and makes no change
  - `--check` reports where each hooked validator resolves, and states plainly when none resolve without the toolchain environment, since that hook skips every commit

## Validation

- Running in a repository with no hook installs one and reports the path
- Running twice produces no change on the second run
- Running where an unrelated pre-commit hook exists preserves it as `pre-commit.local` and the installed hook still runs it
- A credential-scanning hook installed by `init.templateDir` continues to run after installation
- In a fresh clone of a project that commits `scripts/pre-commit-local.sh`, running the installer makes that script run on every commit, and its failure blocks the commit
- Installed hook exits 0 with a notice when no validators resolve
- Installed hook exits 1 when a staged spec fails frontmatter or cross-reference validation
- A commit that stages no invalid spec succeeds in a tree that contains invalid specs
- A constraint violation is reported and the commit still succeeds
- In a project installed from the plugin, a commit of an invalid spec from a shell with `CLAUDE_PLUGIN_ROOT` unset is blocked
- Editing a vendored script causes it to report as locally edited and be left alone on reinstall
- Running inside the LiveSpec repository vendors nothing
