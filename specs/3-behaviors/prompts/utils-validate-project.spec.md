---
criticality: IMPORTANT
failure_mode: Without validation specification, validate-project behavior is undefined and cannot be verified
specifies: dist/prompts/utils/validate-project.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Prompt Behavior: Validate Project

## Requirements
- [!] Prompt validates LiveSpec project structure and methodology compliance, producing actionable error reports with file paths and line numbers for any violations detected.
  - Validates folder structure matches conventions (workspace/, 1-requirements/, 2-strategy/, 3-behaviors/, 3-contracts/)
  - Validates all specs follow MSL format (.spec.md extension, frontmatter, Requirements section)
  - Validates bidirectional links consistency (implements: ↔ specifies:)
  - Validates version consistency across files (.livespec-version, AGENTS.md, README.md, llms.txt)
  - Validates generated file protection (files with generation markers not directly edited)
  - Validates prompt-spec count matches registry claims
  - Validates taxonomy.spec.md exists and defines required classifications
  - Reports errors with specific file paths, line numbers, and remediation guidance
  - Exit code 0 if all validations pass, 1 if any violations detected
  - Output suitable for CI/CD integration (machine-readable format option)

## Validation
- Prompt produces validation report identifying all methodology violations
- Error messages include file paths and line numbers
- Validation catches missing specs, broken links, version mismatches
- Report distinguishes ERROR (blocks) vs WARNING (advisory)
- Validation completes in <10 seconds for typical project
- CI/CD integration works (exit codes, output format)
