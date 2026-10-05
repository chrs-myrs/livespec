---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Agent instructions drift from the specs they were generated from and nothing notices, because timestamps and modification times differ on every clone
governed-by:
  - specs/strategy/validation.spec.md
  - specs/interfaces/formats/validator-output.spec.md
satisfies:
  - specs/workspace/generated-files.spec.md
specifies:
  - scripts/validate-context.sh
---

# Context Currency Validator

Records which sources the generated agent context was built from, and reports
when those sources have changed since.

## Requirements

- [!] A stamp records a hash of the sources the agent context is generated from
  - The sources are PURPOSE.md and every spec under `specs/`, plus the spec-first template inlined into the agent doc when present. Any category can feed generation, interface contracts and strategy included, and a staleness check that misses one misses exactly the factual errors it exists to catch
  - Only files git would commit count, read in byte-wise path order with line endings normalised, so every clone computes the same hash
  - Stamping writes one comment line, `<!-- livespec-context-sources: sha256:<hash> n=<count> -->`, at the end of the agent doc named by `agent.doc_format` (default AGENTS.md) and of every generated `ctxt/` file, replacing any earlier stamp
  - Generated `ctxt/` files are the flat files and those in `ctxt/domains/`. Files in any other subfolder were not produced by the current generation and are never stamped or checked: stamping a retired `ctxt/phases/` file or hand-written context would make it read as current
  - A symlinked doc is not stamped twice, and a read-only file keeps its permissions

- [!] The check reports each generated file as current, stale or unstamped
  - Stale means the recorded hash differs from the sources now; unstamped means it carries no stamp
  - Findings are warnings, promoted to errors by `--strict`; a project with no generated context has nothing to report
  - `--json` follows `specs/interfaces/formats/validator-output.spec.md`

- [!] `--changed` lists the sources that changed since the stamp was written
  - Found from the commit that introduced the current stamp; prints `unknown` when that commit is not in the history, so a caller regenerates everything

## Validation

- Stamping twice without changing a source leaves every file byte-identical
- Editing any spec, including a strategy or interface spec, makes every stamped file report stale
- Re-stamping without regenerating clears a change whose sources feed no generated file
- A fresh clone computes the same hash as the working copy that stamped it
- `--changed` after editing `specs/workspace/patterns.spec.md` lists that file
