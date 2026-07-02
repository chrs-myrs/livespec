# Feature: Incremental Context Update Mode

## Summary
Add a scoped/incremental path to context tree regeneration so a minor workspace-spec edit doesn't force a full rebuild of AGENTS.md + all of ctxt/. The context-builder classifies each change (minor vs full) itself, states its reasoning, and defaults to acting on that classification — patching only the affected file(s) for minor changes, recommending (but not blocking on) full regeneration for structural ones.

## Requirements (Confirmed)
- Classification is judgement-based, not a rigid deterministic rule spec — the agent reasons about each diff and states why, so behaviour can be reviewed/overridden rather than being locked to a checklist.
- The minor/scoped path still runs through the existing context-builder agent (background-agent isolation), just with a narrower target — no new ad hoc direct-edit mechanism outside that pattern.
- This is an extension of `specs/features/context-generation.spec.md` (same observable purpose: keep the context tree in sync with workspace specs) plus a companion mode on the existing entry point — not a new dedicated spec or a parallel prompt file.
- No confirmation gate is forced before acting — the agent proceeds on its classification and reports it, since re-litigating every single spec edit was explicitly rejected in favour of speed.

## Approach

1. **`specs/workspace/context-architecture.spec.md`** — add a compact "Spec → Generated File Map" so the agent has a documented basis for scoping a patch (which generated file(s) each workspace spec/PURPOSE.md/taxonomy feeds). This is structural content the spec already partially implies but doesn't state explicitly.

2. **`specs/features/context-generation.spec.md`** — add an "Incremental Update Mode" requirement:
   - Before generating, agent diffs workspace specs/PURPOSE.md against the last generation.
   - Classifies **MINOR** (scoped patch) when the change is confined to existing content in a single mapped area — wording/example/detail — with no file added/removed, no taxonomy-domain change, no compression-level change, no structural change to context-architecture.spec.md itself.
   - Classifies **FULL** otherwise (new/removed spec, domain change, compression change, structural change, multiple unrelated specs touched, or the mapping is unclear) — proceeds with full regen but flags why.
   - States the classification + one-line reasoning in its report either way; doesn't block on confirmation.
   - MINOR path only touches/validates the mapped target file(s); still logs to `var/context-generation.log`; report explicitly says "scoped update" vs "full regeneration".

3. **`specs/artifacts/agents/context-builder.spec.md`** — agent accepts a scope (`full` or a specific file list); scoped runs only touch/validate those files; final report states which mode ran and why.

4. **`agents/context-builder/AGENT.md`** — add a "Step 0: Determine Scope" ahead of the existing steps, using the new map + git diff; branch the existing generation/validation steps to operate on the full tree or just the mapped targets. Also correct the stale edit-warning pointer (currently `.livespec/prompts/utils/regenerate-contexts.md`, which is a broken/legacy path) to point at the real entry point, `/livespec:audit context`.

5. **`skills/audit/SKILL.md`** (Mode: context) — before spawning the background agent, show the classification ("Detected: wording change in patterns.spec.md → scoped update to ctxt/domains/governance.md. Say 'full regenerate' to force a full rebuild instead.") and pass the scope through to the agent prompt.

## Files to Modify
- `specs/workspace/context-architecture.spec.md` — add spec→file map
- `specs/features/context-generation.spec.md` — add Incremental Update Mode requirements + validation
- `specs/artifacts/agents/context-builder.spec.md` — add scope parameter requirement
- `agents/context-builder/AGENT.md` — add Step 0 classification, branch generation steps, fix stale pointer text
- `skills/audit/SKILL.md` — surface classification to user, pass scope to agent

## Out of Scope
- Legacy `references/prompts/utils/regenerate-contexts.md`, `references/prompts/evolve/4d-regenerate-context.md`, `.claude/agents/context-builder/instructions.md` and their specs (`specs/artifacts/prompts/utils-regenerate-context.spec.md`, `4d-regenerate-context.spec.md`) — these look superseded by the `skills/audit` + top-level `agents/` pathway already in production use, but reconciling or deleting them is a separate cleanup, not part of this feature.
- Fixing the broken `.livespec -> dist` symlink.
- Reintroducing `chmod 444` read-only protection on generated files — the current implementation doesn't use it; not adding it back.

## Assumptions
- `agents/context-builder/AGENT.md` + `/livespec:audit context` is the real, current generation entry point (not the older `references/prompts/` + `.claude/agents/` pair) — CONFIRMED by tracing `skills/audit/SKILL.md`.
- "Agent judges each time" means reasoning must be visible in the report but does not require a blocking AskUserQuestion gate before acting — flagging for explicit confirmation since it's a judgement call on your intent.
