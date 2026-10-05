---
type: contract
category: interfaces
fidelity: full-detail
criticality: CRITICAL
failure_mode: Consumers that gate CI on LiveSpec's validators parse free text that changes between releases, so a reworded message silently breaks or disables their enforcement
governed-by:
  - specs/foundation/constraints.spec.md
derives-from:
  - specs/strategy/validation.spec.md
supports:
  - specs/artifacts/validators/validate-constraints.spec.md
  - specs/artifacts/validators/validate-context.spec.md
  - specs/artifacts/validators/validate-coverage.spec.md
  - specs/artifacts/validators/validate-purpose.spec.md
  - specs/artifacts/validators/validate-registries.spec.md
  - specs/artifacts/validators/validator-output.spec.md
  - specs/features/mandatory-frontmatter.spec.md
  - specs/features/validation/cross-reference-validation.spec.md
---

# Validator Output Contract

The machine-readable output every LiveSpec validator offers, so a consumer can
gate CI on findings without parsing text. This is schema version 1.

## Requirements

- [!] Every validator accepts `--json` and then writes exactly one JSON document to stdout
  - Nothing else is written to stdout; diagnostics that are not findings go to stderr
  - Exit codes are those of the text mode: 0 when no finding is an error, 1 when at least one is, 2 on a usage error
  - On a usage error the validator writes no document
  - Options that change severity apply first: under `--strict` a promoted finding is reported as `error`

- [!] The document is one object with these keys, in this order
  - `schema_version`: integer, `1`
  - `validator`: the validator's file name without `.sh`
  - `livespec_version`: the release the validator came from, as recorded by its `source-version` stamp when vendored or by the toolchain's `project.yaml` otherwise; `unknown` when neither is available
  - `findings`: an array of finding objects, empty when nothing was found
  - Optional keys a validator adds after `findings`, named in its rule-code table below

- [!] Each finding is an object with these keys, in this order
  - `id`: `<rule>:<path>`, followed by `:<subject>` for rules that name a subject
  - `rule`: a rule code from the table below
  - `severity`: `error` or `warning`
  - `path`: the file the finding is about, relative to the repository root and `/`-separated; a file outside the repository, which can only be named explicitly, is reported as given
  - `message`: a human-readable explanation

- [!] A finding's `id` says what it is about, not where it sits
  - Line numbers and message wording are not part of the `id`, so unrelated edits do not change it and consumers can compare base and head by `id`
  - When a rule fires on the same subject more than once in one file, each occurrence is a finding with the same `id`; consumers compare occurrence counts
  - Message wording may change in any release

- [!] Output is deterministic
  - Findings are ordered by `id`, then `message`, under byte-wise collation; identical findings appear once
  - The document contains no timestamps, absolute paths, user or host names, or terminal colour codes
  - Strings are JSON-escaped; non-ASCII text passes through as UTF-8
  - The same tree and options give byte-identical output on Linux and macOS. The one input outside the tree is the current date, which registry staleness depends on

- [!] Rule codes are part of the contract
  - Adding a rule, or an optional top-level key, is compatible and leaves `schema_version` unchanged
  - Renaming or removing a rule or key, changing a key's type or meaning, or changing how `id` is composed increments `schema_version`

## Rule Codes

| Validator | Rule | Severity | Subject |
|-----------|------|----------|---------|
| `validate-frontmatter` | `no-frontmatter` | error | none |
| | `missing-field` | error | field name |
| | `invalid-value` | error | field name |
| | `category-mismatch` | error | none |
| | `metaspec-in-governed-by` | warning | the entry |
| | `underscore-field` | warning | none |
| | `empty-mandatory-field` | warning; error under `--strict` | field name |
| `validate-crossrefs` | `broken-reference` | error | field and target, `<field>:<target>` |
| | `relative-path` | error | field and target |
| | `unparseable` | warning; error under `--strict` | the field |
| | `not-a-spec` | warning; error under `--strict` | field and target |
| | `self-reference` | warning; error under `--strict` | the field |
| | `wrong-layer` | warning; error under `--strict` | field and target |
| | `unlinked` | warning; error under `--strict` | none |
| | `no-chain` | warning; error under `--strict` | none |
| | `cycle` | warning; error under `--strict` | none |
| | `missing-backlink` | warning; error under `--strict` | the child missing from `supports:` |
| | `stale-backlink` | warning; error under `--strict` | the `supports:` entry |
| | `retired-field` | warning; error under `--strict` | the field |
| `validate-coverage` | `ungoverned` | warning | none |
| | `multiply-governed` | warning | none |
| | `dead-pattern` | warning | the `specifies:` value |
| | optional key `governed` | | object: each spec path → sorted array of the tracked files its `specifies:` matches |
| | optional key `coverage` | | object: `files` needing a spec, and how many are `governed` |
| `validate-context` | `stale` | warning; error under `--strict` | none |
| | `unstamped` | warning; error under `--strict` | none |
| `validate-constraints` | `unknown-command` | error | the command as referenced, `/livespec:` and its name |
| | `missing-script` | error | the script path |
| | `missing-route` | error | none |
| | `broken-route` | error | the route target |
| | `retired-layout` | warning | the retired path, `.livespec/` or `.livespec-version` |
| | `toolchain-root-reference` | error | none |
| | `unshipped-script` | error | the script path |
| | `ignored-shipped-file` | error | none |
| `validate-registries` | `missing-registry-dir` | error | none |
| | `missing-registry` | error | none |
| | `unknown-registry-type` | warning | none |
| | `missing-key` | error | the key |
| | `type-mismatch` | error | none |
| | `invalid-date` | error | the key |
| | `stale` | warning | none |
| | `wrong-prefix` | error | the entry id |
| | `index-without-body` | error | the entry id |
| | `body-without-index` | error | the entry id |
| | `work-item-summary` | warning | the entry id |
| `validate-purpose` | `frontmatter-present` | error | none |
| | `too-long` | error | none |
| | `near-limit` | warning | none |
| | `missing-section` | error | `why` or `success` |
| | `misplaced-content` | warning | `constraint`, `technology` or `process` |
| | `long-list` | warning | none |
| | `extra-sections` | warning | none |

## Validation

- Each validator run with `--json` writes a document that parses as JSON and nothing else on stdout
- Running a validator twice on the same tree with `--json` gives byte-identical output
- A path passed from a subdirectory is reported relative to the repository root
- Every finding's `rule` appears in the table for its validator
- The exit code with `--json` matches the exit code without it
