# Proposals

Staged by the residue harvester (residue-harvest.spec.md). Nothing here is
part of the record: no proposal carries a GAP or ISSUE id, and none carries
a status. Each is a machine's reading of a residue line it did not observe.
Promotion happens through a session.

## Runs

| Run | Records read | Proposed | Outcome |
|---|---|---|---|
| 2026-10-26 12:57 | 0 | 0 | ok |
| 2026-10-17 14:49 | 1 | 1 | ok |
| 2026-10-14 12:27 | 0 | 0 | ok |
| 2026-10-06 08:37 | 0 | 0 | ok |
| 2026-10-05 21:24 | 0 | 0 | ok |
| 2026-10-02 16:00 | 0 | 0 | ok |
| 2026-10-02 15:39 | 0 | 0 | ok |
| 2026-10-01 16:30 | 0 | 0 | ok |

## Proposal: validate-constraints flags a sentence denying a script exists as an instruction to run it

**Reported by**: amp:mcp:talevenforge@tmp-crt2zd3:edb5d1c0-f5ed-4559-b641-6300ecb6e0c8
**Staged**: 2026-10-12
**Reconstructed**: by an AMP worker after a read-only check; this project did not observe it

> validate-constraints flags a sentence denying a script exists as an instruction to run it
> 
> Observed: check 5 in `scripts/validate-constraints.sh` (rule `unshipped-script`, around line 186) treats any backticked `scripts/<name>.sh` in project context (`AGENTS.md`, `CLAUDE.md`, `ctxt/`) as an instruction. It does not tell an instruction apart from a sentence saying the script is absent. In a consumer project (talevenforge), `ctxt/modes/evolve.md:33` reads "There is no project-local `scripts/validate-frontmatter.sh` ..." and produces `ERROR: project context instructs 'scripts/validate-frontmatter.sh' which the project does not ship`. That is a false positive. The other error reported with it (`scripts/check-requires-spec.sh`) did not come from the line quoted for it, because that line names the script without the `scripts/` prefix. It probably comes from the inlined spec-first template, which would make it a correct error. Since v5.11, `scripts/setup-hooks.sh` copies (vendors) both scripts into consumer projects, so the consumer can clear both errors itself.
> 
> What this project might do: decide in a session how project context should say a script is absent. The preferred direction is to settle it in `specs/artifacts/validators/validate-constraints.spec.md` the same way the plugin-root check does: context that denies a script exists names it in words, without the `scripts/` path. The spec already rejects heuristics that try to tell illustration from assertion (lines 43-51). A negation filter on the matcher would be one, and a naive one would let through real instructions such as "do not commit without running `scripts/x.sh`". Change the matcher only if a narrower rule can be shown to keep genuine instructions failing.
> 
> Date: 2026-10-12
> 
> Agreed terms:
> 
> > Stage one proposal in registries/proposals.md, with no GAP/ISSUE id and no status. It records that check 5 (unshipped-script) in validate-constraints.sh treats a backticked scripts/x.sh in a sentence denying the script exists as an instruction to run it, citing talevenforge ctxt/modes/evolve.md:33 as the verified case. A later LiveSpec session decides the fix. The preferred direction is to settle it in validate-constraints.spec.md the same way the plugin-root check does: context that denies a script exists names it without the scripts/ path. A change to the matcher is acceptable only if it keeps genuine instructions failing, including negated ones such as 'do not commit without running scripts/x.sh', with a validation case for each side. No other checks and no retired-layout handling are in scope.

## Proposal: skills.sh indexes public skills/*/SKILL.md without submission; 7 of LiveSpec's 8 skills reference ${…

**Source**: archived/20261017-082556__wm5qev__session · R2
**Observed**: 2026-10-17 13:57 · 74e1986 · agent · inherited: none
**Staged**: 2026-10-17
**Reconstructed**: by the harvester, which did not observe this
**Verification**: cites `skills/*/SKILL.md`, no longer present (checked at 74e1986)

> skills.sh indexes public skills/*/SKILL.md without submission; 7 of LiveSpec's 8 skills reference ${CLAUDE_PLUGIN_ROOT}, so an npx skills add install likely breaks. Not checked live.

## Proposal: init writes workspace specs that fail LiveSpec's own frontmatter validator

**Reported by**: amp:mcp:brefdom@tmp-crt2zd3:b88fa8ca-cd6e-4c5f-aa9d-017c3f2c546e
**Staged**: 2026-10-18
**Reconstructed**: by an AMP worker after a read-only check; this project did not observe it

> init writes workspace specs that fail LiveSpec's own frontmatter validator
> 
> Observed: brefdom noticed this in session s6wjm6 (residue R2) and did not look into it further. A read-only check here at 74e1986 (v5.12.0) confirmed it. Step 5 of `skills/init/SKILL.md` writes `specs/workspace/constitution.spec.md` and `specs/workspace/taxonomy.spec.md`. Their frontmatter has `criticality` and `failure_mode` and nothing else from the base six. `type`, `category`, `fidelity` and `governed-by` are missing, so `scripts/validate-frontmatter.sh` reports 4 errors per file, 8 in all. Adding those four fields is not enough. The check for fields a category requires runs only once `category` is present, so `category: workspace` then brings up a missing `applies_to` error in each file. With no `derives-from: PURPOSE.md`, `scripts/validate-crossrefs.sh` also warns `unlinked` (an error under `--strict`). The skill's "MSL Format Quick Reference" shows the same incomplete frontmatter, so it teaches the defect too. brefdom added the fields by hand and now passes.
> 
> What this project might do: `skills/init/SKILL.md` has no governing spec (`scripts/validate-coverage.sh --which` exits 1). So a session first decides which spec governs it. The closest existing requirement is the templates criterion in `specs/features/mandatory-frontmatter.spec.md` ("`templates/` include full frontmatter schema for target projects"). The session then corrects the templates. Every spec init writes, and the quick-reference example, would carry the full base six plus the workspace fields. Both would pass `validate-frontmatter.sh` and `validate-crossrefs.sh` as written. The check is to run both validators on a freshly initialised project. The validators stay as they are.
> 
> Date: 2026-10-18
> 
> Agreed terms:
> 
> > Stage one proposal in registries/proposals.md, with no GAP/ISSUE id and no status, crediting brefdom s6wjm6 R2. It records, as verified at 74e1986 (v5.12.0): init step 5's constitution.spec.md and taxonomy.spec.md templates omit type, category, fidelity and governed-by (8 validate-frontmatter errors). Once category is added, a missing applies_to adds another error per file, and without derives-from: PURPOSE.md validate-crossrefs warns unlinked. The skill's MSL Format Quick Reference shows the same incomplete frontmatter. skills/init/SKILL.md has no governing spec, so a later LiveSpec session first decides which spec governs it (mandatory-frontmatter.spec.md's templates criterion is the nearest), then makes the fix. The preferred direction is that every spec init writes, and the reference example, carries the full base-six plus workspace fields and passes validate-frontmatter.sh and validate-crossrefs.sh unchanged. This is checked by running both on a freshly initialised project. The validators are not to be relaxed. Out of scope: taxonomy's hard-coded domain, full-setup customisation, and any other init step.

## Proposal: init stops as "already initialised" in a project that has only specs/ and PURPOSE.md

**Reported by**: amp:mcp:fylgwick@tmp-crt2zd3:c3e6852d-075e-427e-ad8b-c5194a05e507
**Staged**: 2026-10-24
**Reconstructed**: by an AMP worker after a read-only check; this project did not observe it

> init stops as "already initialised" in a project that has only specs/ and PURPOSE.md
> 
> Observed: fylgwick noticed this in session v3753j (residue R3) and did not look into it further. A read-only check here at 74e1986 (v5.12.0) confirmed it and found it reaches further. Step 1 of `skills/init/SKILL.md` checks only whether `specs/` and `PURPOSE.md` exist. When both do, it reports "Project already initialized" and stops. A project in that state never gets the workspace constitution and taxonomy, the required registries or the pre-commit hook. fylgwick met this after forgewick's `/forge`, but LiveSpec produces the same state itself: the incubate path of `skills/birth/SKILL.md` (Steps I-4 and I-5) writes `PURPOSE.md` and `specs/workspace/`, with no registries and no hook. Running init afterwards stops at Step 1. Birth's Step I-5 constitution and taxonomy templates also have the same incomplete frontmatter as init's Step 5 templates (`criticality` and `failure_mode` only). The staged proposal "init writes workspace specs that fail LiveSpec's own frontmatter validator" (brefdom, 2026-10-18) covers init's copies only.
> 
> What this project might do: in a session, decide what init does in a project that is part-initialised. The preferred direction is that init checks each artefact it creates and fills in only what is missing, without overwriting anything. It reports "already initialised" only when all of them are present. Whoever makes the brefdom template fix should apply it to birth's copies too. The check is to run init on a freshly born project, then run `validate-frontmatter.sh`, `validate-crossrefs.sh` and `setup-hooks.sh --check`.
> 
> Date: 2026-10-24
> 
> Agreed terms:
> 
> > Stage one proposal in registries/proposals.md, with no GAP/ISSUE id and no status, crediting fylgwick v3753j R3. As checked at 74e1986 (v5.12.0), it records three things. First, /livespec:init Step 1 treats specs/ plus PURPOSE.md as fully initialised and stops, so such a project never gets the constitution, taxonomy, required registries or pre-commit hook. Second, LiveSpec's own /livespec:birth leaves exactly that state, with no registries and no hook. Third, birth's Step I-5 constitution and taxonomy templates carry the same incomplete frontmatter as init's, so the fix in the existing brefdom proposal of 2026-10-18 should reach them too. A later LiveSpec session decides the fix. The preferred direction is that init checks each artefact it creates, fills in only what is missing without overwriting anything, and reports 'already initialised' only when all of them are present. This is checked by running init on a freshly born project and then running validate-frontmatter.sh, validate-crossrefs.sh and setup-hooks.sh --check. Out of scope: the template-frontmatter fix itself (already staged), forgewick's /forge, and full-setup customisation.
