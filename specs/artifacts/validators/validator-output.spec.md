---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Each validator renders JSON its own way, so the output contract drifts per validator and consumers integrate each one separately
governed-by:
  - specs/interfaces/formats/validator-output.spec.md
specifies:
  - scripts/validator-output.sh
---

# Validator Output Helper

The one implementation of the output contract, sourced by every validator so
the envelope cannot differ between them.

## Requirements

- [!] Helper renders the document defined by `specs/interfaces/formats/validator-output.spec.md`
  - A validator records each finding with its severity, rule, path, subject and message, and the helper composes the `id`
  - Paths are rewritten relative to the repository root whatever directory the validator runs from
  - Colour codes are stripped from messages
  - Silences the validator's text output while `--json` is active, so stdout carries only the document

- [!] Helper is shipped with the validators that source it
  - Vendored alongside them with the same provenance stamps
  - A validator asked for `--json` without the helper present exits 2 and says why; text mode never needs it
  - Runs under the bash that ships with macOS (3.2), so it uses no associative arrays or other bash 4 features

## Validation

- Output of every validator that sources the helper satisfies the contract's validation criteria
- Removing the helper leaves every validator's text mode unchanged
