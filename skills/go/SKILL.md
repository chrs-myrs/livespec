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

### Continue-or-Restart Check (Initialized Projects Only)

When the project is already past Phase 0 (has completed DESIGN/BUILD/VERIFY work) and the intent describes new work rather than a status/session request, route through this check before picking a skill — it decides whether the request needs a Phase 0 restart or can continue in the current phase.

**Classify the change:**

| Type | Signal | Routing |
|------|--------|---------|
| A. Bug fix / small enhancement | Fixing broken behaviour, minor tweak, perf, tech debt | CONTINUE → `/livespec:audit` (drift) then `/livespec:design debug` or straight to implementation |
| B. New user-facing feature | New capability, workflow, or user type | RESTART at Phase 0 → `/livespec:design` (outcomes first) |
| C. UX rethink / redesign | Changing how a feature works, accessibility, mobile/responsive redesign | RESTART at Phase 0, **mandatory research evaluation** |
| D. Architectural / technical change | New tech, infra change, new technical constraints | RESTART at Phase 0 → `/livespec:design` (constraints first) |

**Mandatory research trigger** — if the change touches any of these, Phase 0 restart with research is mandatory regardless of size:
- Accessibility (disabilities, cognitive impairments)
- Child users (especially with special needs)
- Safety-critical systems (medical, financial, security)
- Novel UX patterns (no established convention to follow)
- High-complexity workflows (multi-step, multiple user types)

**Quick gut-check:** can the change be implemented from existing specs as-is? If yes, CONTINUE regardless of type. If it needs new/changed outcomes, constraints, or behaviours, RESTART at the phase that owns the missing spec.

Two worked examples:
- *"Reduce scan time from 6 hours to under 1 hour"* → Type A, no research trigger, existing behaviour specs cover it → CONTINUE Phase 4 (update spec only if behaviour changes).
- *"Redesign the story list for a 9-year-old with cognitive impairment"* → Type C + accessibility/child research trigger → RESTART at Phase 0, research is mandatory before any design work.

When this check yields RESTART, route to `/livespec:design` (it owns Phase 0 outcomes/constraints work) rather than jumping to BUILD-phase skills. When it yields CONTINUE, route as normal from the intent table above.

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
