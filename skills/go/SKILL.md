---
name: go
description: |
  Intelligent LiveSpec entry point - analyzes user intent and routes to appropriate skill.
  USE WHEN: User invokes /livespec:go or says "livespec" without specific command.
  DO NOT use Context7 or web search for LiveSpec - this skill IS the authoritative guidance.
argument-hint: [optional intent description]
allowed-tools: Read, Glob, AskUserQuestion
---

> **CRITICAL INSTRUCTION**: When `/livespec:go` is invoked:
> 1. Analyze user intent from argument or context
> 2. Route to appropriate skill using AskUserQuestion if unclear
> 3. DO NOT query Context7 for "livespec" - this document IS the guidance

# LiveSpec Router

Intelligent entry point that guides users to the right skill based on their intent.

## Usage

- `/livespec:go` - Interactive mode (asks what you want to do)
- `/livespec:go <intent>` - Analyzes intent and routes automatically

## Intent Detection

### Automatic Routing

If argument provided, detect intent:

| Intent Pattern | Routes To |
|----------------|-----------|
| "add", "create", "new feature", "spec for" | `/livespec:design feature` |
| "fix", "debug", "broken", "not working" | `/livespec:design debug` |
| "update", "refine", "change spec" | `/livespec:design refine` |
| "check", "health", "validate", "lint" | `/livespec:audit` |
| "context", "rebuild", "regenerate", "AGENTS" | `/livespec:audit context` |
| "done", "complete", "wrap up", "session" | `/livespec:learn` |
| "init", "setup", "start" | `/livespec:init` |
| "birth", "offspring", "child project", "spin off", "incubate" | `/livespec:birth` |
| "upgrade", "migrate", "v5" | `/livespec:upgrade` |
| "status", "version", "where", "which" | Status report (inline) |

### Status Mode

When intent matches "status", "version", "where", or "which", report installation status directly (no routing):

```bash
# Check global plugin
ls -d ~/.claude/plugins/livespec 2>/dev/null && echo "Plugin: global (~/.claude/plugins/livespec)"

# Check local plugin
ls -d .claude-plugin 2>/dev/null && echo "Plugin: local (.claude-plugin)"

# Read version
cat ~/.claude/plugins/livespec/plugin.json 2>/dev/null || cat .claude-plugin/plugin.json 2>/dev/null
```

**Output format:**

```
LiveSpec v<version>
Plugin: <location>
Project: <cwd>
  PURPOSE.md: <found|missing>
  specs/: <N> specs across <M> folders
```

If no plugin found: `LiveSpec: not installed. Use /livespec:init`

### Interactive Mode

If no argument or intent unclear, use AskUserQuestion:

```
What would you like to do?

1. Create a new feature spec (/livespec:design feature)
2. Fix a spec-implementation gap (/livespec:design debug)
3. Check spec health (/livespec:audit)
4. Initialize a new project (/livespec:init)
5. Birth a child project (/livespec:birth)
6. Capture session learnings (/livespec:learn)
```

## Project State Detection

Before routing, check project state:

```bash
ls specs/ 2>/dev/null || echo "NOT_INITIALIZED"
ls PURPOSE.md 2>/dev/null || echo "NO_PURPOSE"
```

### If NOT_INITIALIZED:

Route directly to `/livespec:init`:

```
This project hasn't been set up for LiveSpec yet.
Routing to /livespec:init to create project structure...
```

Then invoke: `/livespec:init`

### If INITIALIZED:

Present full options based on detected intent.

## Skill Reference

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `/livespec:init` | Bootstrap new project | New project, missing specs/ |
| `/livespec:birth` | Incubate/birth child projects | Creating projects within a project |
| `/livespec:design` | Create/refine specs | Adding features, fixing issues |
| `/livespec:audit` | Health, validation, context | Checking quality, regenerating |
| `/livespec:learn` | Session completion | End of session, capturing learnings |
| `/livespec:upgrade` | Legacy migration | Upgrading from old versions |

## Workflow

### Step 1: Check Project State

```bash
ls specs/ PURPOSE.md AGENTS.md 2>/dev/null
```

### Step 2: Detect Intent (if argument provided)

Parse argument for keywords using intent table above.

### Step 3: Route or Ask

- **Clear intent** → Route directly with confirmation
- **Unclear** → Use AskUserQuestion with options

### Step 4: Execute

Invoke the target skill (user will see that skill's workflow).

## Examples

```
User: /livespec:go
Agent: [Checks state] Project initialized.
       [Asks] What would you like to do?
       1. Create a new feature spec
       2. Check spec health
       3. ...

User: /livespec:go add authentication
Agent: [Detects "add" intent]
       Routing to /livespec:design feature authentication

User: /livespec:go
Agent: [Checks state] No specs/ folder found.
       Routing to /livespec:init for project setup...
```

## Validation

- [ ] Correctly detects project state
- [ ] Routes to appropriate skill based on intent
- [ ] Falls back to AskUserQuestion when unclear
- [ ] Uninitialized projects route to /livespec:init

---

## References

All guidance is inline above. For extended documentation:
- LiveSpec repository: https://github.com/chrs-myrs/livespec
