# LiveSpec Project Override

> **MANDATORY**: This file overrides global `~/.claude/CLAUDE.md` rules for LiveSpec development.

## Plugin Skill Routing (CRITICAL)

**DO NOT** look LiveSpec up on the web (wscrape or otherwise) when working in this project.

**ALWAYS** use the local plugin skills instead:

| User Intent | Skill to Invoke | NOT This |
|-------------|-----------------|----------|
| Create/refine specs | `/livespec:design` | Web lookup |
| Health, validation, context | `/livespec:audit` | Web search |
| Initialize project | `/livespec:init` | External docs |
| Session completion | `/livespec:learn` | ~/.claude/context/ |
| Upgrade methodology | `/livespec:upgrade` | Web lookup |

## Auto-Invocation Triggers

When user mentions ANY of these, invoke the appropriate skill **BEFORE** any other action:

- **"design", "spec", "specification", "feature"** → `/livespec:design`
- **"health", "validate", "context", "AGENTS.md", "audit"** → `/livespec:audit`
- **"init", "initialize", "setup", "bootstrap"** → `/livespec:init`
- **"complete", "session", "learn", "capture"** → `/livespec:learn`
- **"upgrade", "migrate", "v5"** → `/livespec:upgrade`

## Why This Override Exists

The global `~/.claude/CLAUDE.md` makes wscrape the default for docs lookup.
For LiveSpec that finds the published repository, which lags this working tree
and bypasses the installed plugin skills.

**This project IS LiveSpec** - use the local skills, not external references.

## Deferred to AGENTS.md

For all other guidance (MSL format, folder structure, spec-first protocol), see:
- `AGENTS.md` (project root, loaded alongside this rule)
- Skill content when skills are invoked
