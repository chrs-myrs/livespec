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
