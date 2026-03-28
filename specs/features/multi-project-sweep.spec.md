---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Projects accumulate undetected LiveSpec drift, framework misuse goes unnoticed, maintenance debt grows across portfolio invisibly
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
  - specs/workspace/workflows.spec.md
---

# Multi-Project Sweep

Cross-portfolio LiveSpec audit that discovers, prioritises, analyses, and remediates projects needing framework maintenance.

## Requirements

- [!] Sweep discovers all LiveSpec-adjacent projects under `~/projects/` excluding `~/projects/tmp/`
  - A project qualifies if it contains any of: `specs/`, `.livespec/`, `AGENTS.md`, `PURPOSE.md`
  - `~/projects/tmp/` and all descendants are unconditionally excluded
  - Discovery completes in <10 seconds via bash script (no agent spawning at this stage)

- [!] Each candidate project is fingerprinted against five maintenance signals
  - **Version lag**: Project's `.livespec-version` or `.livespec/` contents behind current plugin version
  - **Missing required files**: Expected files absent (`AGENTS.md`, `specs/workspace/`, `PURPOSE.md`, plugin manifest if applicable)
  - **Stale specs**: No spec-related git commits in 60+ days while project has other activity
  - **Structure violations**: Spec files present but not following current MSL format or folder conventions
  - **Incomplete/unlinked specs**: Specs lacking frontmatter, validation sections, or cross-references where expected
  - Each signal scored 0-2 (0=healthy, 1=warning, 2=critical); total score 0-10

- [!] Discovery output is a scored priority list presented to the user before any deep analysis begins
  - Projects sorted by score descending (highest maintenance need first)
  - Each entry shows: project name, path, score, triggered signals
  - User approves which projects to include before deep audit agents are spawned
  - Hard gate: no project-write operations before approval

- [!] Approved projects are audited by parallel agents leveraging `/livespec:audit` logic
  - Each project agent is independent with isolated context (no cross-contamination)
  - Each agent performs the full single-project audit workflow (health + validate + extract if unspecified code directories are detected)
  - Agents compile per-project findings to `.livespec-audit/issues.md` within each project
  - Issues format matches health report format from `/livespec:audit health`

- [!] Agents explicitly inspect AGENTS.md and agent definition files for outdated framework usage
  - Checks AGENTS.md references current skill invocation patterns (e.g. `/livespec:design` not legacy command names)
  - Checks AGENTS.md ctxt/ paths exist and match current plugin structure
  - Checks agent definitions in `.claude/agents/` or `agents/` for references to removed/renamed prompts or commands
  - Flags mismatches between AGENTS.md workflow descriptions and the actual skill/prompt files present
  - Agent inspection findings are categorised as Tier 3 (framework usage pattern problems) and compiled to `.livespec-audit/issues.md`

- [!] Remediation operates in three configurable tiers
  - **Default mode: tiered**
    - Tier 1 (auto-apply): Missing boilerplate files, version number bumps, trivial format fixes
    - Tier 2 (require approval): Spec structure changes, AGENTS.md regeneration, cross-reference updates
    - Tier 3 (report only): Architectural misalignment, framework usage pattern problems, strategic concerns
  - **Conservative mode** (`--conservative`): All findings reported only, no auto-apply
  - **Aggressive mode** (`--aggressive`): Tier 1 and Tier 2 auto-apply; Tier 3 requires approval
  - Remediation actions are idempotent (safe to re-run)

- [!] Sweep produces three output artefacts
  - **Per-project issues** (local): `{project}/.livespec-audit/issues.md` — structured findings that persist across runs
  - **Global consolidated report**: `{cwd}/var/audit-reports/YYYY-MM-DD-sweep.md` — all projects, severity-ordered, with remediation status
  - **Meta-report**: `{cwd}/var/audit-reports/YYYY-MM-DD-meta.md` — cross-project patterns flagged as framework improvement candidates
  - `{cwd}/var/audit-reports/` created if absent; reports use date prefix so existing reports are never overwritten

- [!] Cross-project patterns are surfaced in the meta-report as framework improvement candidates
  - A pattern is cross-project if the same issue category appears in 3+ distinct projects
  - Meta-report entries include: pattern description, affected project count, example projects, suggested framework fix
  - Meta-report does not duplicate per-project details; it references the consolidated report

## Validation

- [ ] Running sweep on a directory with 3+ LiveSpec projects produces a scored list within 10 seconds
- [ ] Approval gate prevents any agent spawning or file writes when user declines
- [ ] Parallel agents produce independent `.livespec-audit/issues.md` files per project without cross-contamination
- [ ] Consolidated report contains entries for all approved projects
- [ ] Meta-report is only generated when 3+ projects share a pattern; absent otherwise
- [ ] Conservative mode produces zero file writes across all projects
- [ ] Aggressive mode auto-applies Tier 1 and Tier 2 fixes and reports changes made
- [ ] `~/projects/tmp/` contents are never included regardless of signal scores
- [ ] A project with outdated AGENTS.md skill references produces at least one Tier 3 finding in its issues file
- [ ] Agent definition files referencing removed commands produce findings distinct from structural spec issues
