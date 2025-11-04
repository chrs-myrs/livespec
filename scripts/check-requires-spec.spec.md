---
criticality: IMPORTANT
failure_mode: Agents cannot validate spec requirements before file creation, reducing enforcement effectiveness
implements: scripts/check-requires-spec.sh
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

- [!] Script checks for existing spec coverage
  - Searches `specs/` directory for filename mentions (grep)
  - Checks for colocated spec files (`[filename].spec.md`)
  - Reports which specs reference the file

- [!] Script provides actionable guidance when spec missing
  - Suggests spec locations (colocated, behaviors/, contracts/)
  - References Phase 1 prompt for spec creation
  - Clear messaging distinguishes permanent vs temporary files

## Validation

- Running `./scripts/check-requires-spec.sh var/temp.txt` → Exit 0 (temporary, no spec needed)
- Running `./scripts/check-requires-spec.sh src/main.py` without spec → Exit 1 with suggestions
- Running `./scripts/check-requires-spec.sh src/main.py` with spec → Exit 0 with confirmation
- Error messages are clear and actionable
- Colored output helps distinguish status (green/red/yellow/blue)
