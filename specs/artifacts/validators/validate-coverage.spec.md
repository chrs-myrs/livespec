---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Nobody can say which files a spec governs, so coverage is guessed from mentions, a consumer's ratchet has nothing to count, and the spec-first gate passes any file a spec happens to name
governed-by:
  - specs/strategy/validation.spec.md
  - specs/interfaces/formats/validator-output.spec.md
satisfies:
  - specs/features/mandatory-frontmatter.spec.md
specifies:
  - scripts/validate-coverage.sh
---

# Coverage Validator

Measures how much of the project the specs govern, from `specifies:` alone, and
answers which spec governs a given file.

## Requirements

- [!] A file is governed only when a spec's `specifies:` names it
  - A value is a file path, a directory (every file beneath it) or a glob, where `*` and `?` stay within one path segment and `**` crosses segments; all are written from the repository root
  - A colocated spec or a mention in a spec's text confers nothing
  - Specs vendored from the toolchain describe the toolchain's files and govern nothing in the project
  - A spec written but not yet committed governs too, since the spec-first gate runs between writing the spec and committing

- [!] Coverage is reported over the tracked files that need a spec, never enforced
  - Files exempt from needing a spec: anything under `var/`, `generated/`, `.archive/`, `.git/`, `node_modules/`, `.cache/`, `build/`, `dist/` or `worktrees/`; workspace specs and every other spec; `.log`, `.lock` and `.cache` files; files carrying `vendored-from` provenance
  - Reports how many of the remaining files are governed, which are not, which are governed by more than one spec, and which `specifies:` values match no tracked file
  - Every finding is a warning; the exit code is 0 unless the invocation is wrong

- [!] `--json` follows `specs/interfaces/formats/validator-output.spec.md` and adds the governed-set map
  - `governed` maps each spec to the sorted tracked files its `specifies:` matches
  - `coverage` gives the counts of files needing a spec and of those governed

- [!] `--which <path>` answers which spec governs a path, existing or not yet created
  - Prints each governing spec, or why the path needs none, and exits 0; exits 1 when the path needs a spec and none governs it
  - Uses the same exemptions and matching as the coverage report

## Validation

- A spec with `specifies: [skills/]` governs `skills/a/SKILL.md`, including before that file exists
- `specifies: [scripts/*.sh]` governs `scripts/a.sh` but not `scripts/sub/b.sh`; `scripts/**/*.sh` governs both
- A file mentioned in a spec's body, or with a colocated `.spec.md`, is reported as not governed
- A `specifies:` value matching no tracked file is reported
- Running twice on the same tree with `--json` gives byte-identical output
