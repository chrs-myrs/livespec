# Feature: Project Birthing

## Summary

Add `offspring/` convention and `/livespec:birth` skill to allow livespec projects to incubate and birth child projects.

## Requirements (Confirmed)

- Folder: `offspring/` inside parent project
- Sub-projects get full LiveSpec init structure (PURPOSE.md + full specs/ hierarchy)
- `/livespec:birth` skill handles both incubation and extraction
- Birth action: creates git repo, copies specs, signals readiness

## Approach

Two-phase workflow within one skill:

1. **Incubate** (`/livespec:birth new <name>`): Creates `offspring/<name>/` with full LiveSpec structure
2. **Birth** (`/livespec:birth <name>`): Extracts `offspring/<name>/` to standalone git repo at user-specified path, optionally removes from offspring/

## Files to Create

| File | Purpose |
|------|---------|
| `specs/features/project-birthing.spec.md` | Feature spec (MSL format) |
| `skills/birth/SKILL.md` | Birth skill implementation |
| `commands/birth.md` | Command routing (mirrors go.md/init.md pattern) |

## Files to Modify

| File | Change |
|------|--------|
| `skills/go/SKILL.md` | Add birth intent routing ("birth", "new project", "offspring") |
| `commands/go.md` | Add birth to intent routing table |

## Skill Design

### Incubate mode (`/livespec:birth new <name>`)

1. Check `offspring/<name>/` doesn't already exist
2. `mkdir -p offspring/<name>/specs/{workspace,foundation,strategy,features,interfaces}`
3. Ask for project purpose (via AskUserQuestion - same as /livespec:init)
4. Create `offspring/<name>/PURPOSE.md`
5. Create `offspring/<name>/specs/workspace/constitution.spec.md`
6. Create `offspring/<name>/specs/workspace/taxonomy.spec.md`
7. Report: "Offspring `<name>` incubating in offspring/<name>/. Run /livespec:birth <name> when ready."

### Birth mode (`/livespec:birth <name>` or `/livespec:birth` interactive)

1. If no name: list `offspring/` contents, ask which to birth
2. Confirm destination path (default: `../../../<name>` - sibling of current project)
3. `mkdir -p <destination>`
4. `cp -r offspring/<name>/. <destination>/`
5. `git init <destination>`
6. `git -C <destination> add -A && git -C <destination> commit -m "Initial commit from LiveSpec offspring"`
7. Ask: "Remove offspring/<name>/ from this project?" (optional cleanup)
8. Report success with next steps

### No-args mode (`/livespec:birth`)

Interactive menu:
- "Incubate new project" → prompts for name, runs incubate
- "Birth existing offspring" → lists offspring/, runs birth flow

## Assumptions

- `offspring/` is at project root (not nested deeper) - CONFIRMED by user request
- Full LiveSpec init = PURPOSE.md + specs/workspace/ constitution + taxonomy - CONFIRMED (same as /livespec:init)
- Birth creates git repo and makes initial commit - CONFIRMED
- `commands/birth.md` auto-discovered by Claude Code plugin system (no plugin.json change needed) - INFERRED from existing pattern

## Out of Scope

- Remote repository creation (GitHub/GitLab push)
- Inheriting parent constraints into offspring specs
- Cross-reference tracking between parent and offspring
- Monorepo management (offspring stay as standalone repos once birthed)
