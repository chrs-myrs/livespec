---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Agents cannot validate spec requirements before file creation, reducing enforcement effectiveness
governed-by: []
guided-by:
  - specs/strategy/architecture.spec.md
derives-from:
  - specs/features/validation/spec-purity-detection.spec.md
specifies:
  - scripts/check-requires-spec.sh
---

# Spec Requirement Validation Tool

## Requirements

- [!] Script validates whether a given file path requires a specification
  - Takes single file path argument
  - Returns exit code 0 if spec exists or not required
  - Returns exit code 1 if spec required but missing
  - Provides helpful error messages with suggested spec locations

- [!] Script identifies files that don't need specs (exceptions)
  - Temporary directories: `var/`, `generated/`, `.archive/`, `.git/`, `node_modules/`, `.cache/`, `build/`, `dist/`
  - Workspace specs are self-defining: `specs/workspace/` files ARE specs
  - Pure data/log files: `.log`, `.lock`, `.cache` extensions
  - Vendored files: a file recording `vendored-from` provenance is specified where it was vendored from, so it needs no local spec

- [!] Script finds the governing spec the way the coverage validator does
  - A path is governed only when a spec's `specifies:` names it, as a file, a directory or a glob; it may not exist yet
  - A colocated spec or a mention in a spec's text is not governance
  - Exemptions and matching come from `scripts/validate-coverage.sh --which`, so the gate and the coverage report cannot disagree
  - Reports which specs govern the file

- [!] Script provides actionable guidance when spec missing
  - Suggests spec locations (features/, artifacts/, interfaces/), or adding the path to an existing spec's `specifies:`
  - References Phase 1 prompt for spec creation
  - Clear messaging distinguishes permanent vs temporary files

## Validation

- Running `./scripts/check-requires-spec.sh var/temp.txt` → Exit 0 (temporary, no spec needed)
- Running `./scripts/check-requires-spec.sh src/main.py` without spec → Exit 1 with suggestions
- Running `./scripts/check-requires-spec.sh src/main.py` with a spec whose `specifies:` names it, or a directory or glob containing it → Exit 0 with confirmation
- Running it on a file only mentioned in a spec's text, or with only a colocated spec → Exit 1
- Running it on a script vendored by `setup-hooks.sh` → Exit 0 (vendored, specified upstream)
- Error messages are clear and actionable
- Colored output helps distinguish status (green/red/yellow/blue)
