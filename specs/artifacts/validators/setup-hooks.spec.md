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

- [!] Installed hook degrades gracefully when the toolchain is absent
  - Resolves validators from the project's own `scripts/` first, then `${CLAUDE_PLUGIN_ROOT}/scripts/`
  - Skips with a notice and exit 0 when neither is available
  - A contributor without LiveSpec installed is never blocked from committing

- [!] Installed hook runs the validators that exist and blocks on error
  - Runs whichever of frontmatter, cross-reference and constraint validation it can resolve
  - Blocks the commit on any validator exit 1
  - Names the failing validator

- [!] Script reports what it did
  - States the hook path written and which validators the hook will run
  - `--check` reports current install state and makes no change

## Validation

- Running in a repository with no hook installs one and reports the path
- Running twice produces no change on the second run
- Running where an unrelated pre-commit hook exists preserves it as `pre-commit.local` and the installed hook still runs it
- A credential-scanning hook installed by `init.templateDir` continues to run after installation
- Installed hook exits 0 with a notice when no validators resolve
- Installed hook exits 1 when a resolvable validator fails
