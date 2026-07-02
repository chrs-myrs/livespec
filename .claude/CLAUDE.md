# LiveSpec Project Override

> **MANDATORY**: This file overrides global `~/.claude/CLAUDE.md` rules for LiveSpec development.

## Plugin Skill Routing (CRITICAL)

**DO NOT** use Context7 or web search for "livespec" queries when working in this project.

**ALWAYS** use the local plugin skills instead:

| User Intent | Skill to Invoke | NOT This |
|-------------|-----------------|----------|
| Create/refine specs | `/livespec:design` | Context7 query |
| Health, validation, context | `/livespec:audit` | Web search |
| Initialize project | `/livespec:init` | External docs |
| Session completion | `/livespec:learn` | ~/.claude/context/ |
| Upgrade methodology | `/livespec:upgrade` | Context7 query |

## Auto-Invocation Triggers

When user mentions ANY of these, invoke the appropriate skill **BEFORE** any other action:

- **"design", "spec", "specification", "feature"** → `/livespec:design`
- **"health", "validate", "context", "AGENTS.md", "audit"** → `/livespec:audit`
- **"init", "initialize", "setup", "bootstrap"** → `/livespec:init`
- **"complete", "session", "learn", "capture"** → `/livespec:learn`
- **"upgrade", "migrate", "v5"** → `/livespec:upgrade`

## Why This Override Exists

The global `~/.claude/CLAUDE.md` contains:
```
| livespec, LiveSpec | github.com/chrs-myrs/livespec | keyword |
```

This routes "livespec" queries to Context7, which:
1. Searches for an npm package that doesn't exist
2. Returns outdated or irrelevant information
3. Bypasses the installed plugin skills entirely

**This project IS LiveSpec** - use the local skills, not external references.

## Deferred to Root CLAUDE.md

For all other guidance (MSL format, folder structure, spec-first protocol), see:
- `/home/chris/projects/livespec/CLAUDE.md` (project root)
- Skill content when skills are invoked
