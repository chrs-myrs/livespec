---
description: LiveSpec entry point - intelligent routing based on intent
---

# LiveSpec Go

The entry point for LiveSpec. Understands your intent and routes to the appropriate workflow.

## Usage

```
/livespec:go                    # Interactive - asks what you need
/livespec:go <natural request>  # Routes based on intent
```

## Examples

```
/livespec:go                         # "What would you like to do?"
/livespec:go I need to add auth      # → design skill (feature mode)
/livespec:go check my specs          # → evolve skill (health mode)
/livespec:go what should I do next   # → analyzes state, suggests next step
/livespec:go wrap up this session    # → learn skill
```

## Intent Routing

| Intent Pattern | Routes To |
|----------------|-----------|
| "add", "create", "new feature" | `/livespec:design feature` |
| "fix", "debug", "why is X broken" | `/livespec:design debug` |
| "update", "refine", "change spec" | `/livespec:design refine` |
| "check", "health", "validate", "audit" | `/livespec:evolve` |
| "context", "rebuild", "regenerate" | `/livespec:evolve context` |
| "done", "complete", "wrap up", "session" | `/livespec:learn` |
| "what next", "help", "stuck" | Analyze state, suggest action |

## When No Intent Detected

Shows interactive menu:

```
What would you like to do?

1. Design - Create or refine specifications
2. Evolve - Check health, regenerate context
3. Learn - Complete session, capture insights
4. Help - Explain LiveSpec concepts
```

## Quick Reference

For direct access (power users):

| Command | Purpose |
|---------|---------|
| `/livespec:design` | Spec creation and refinement |
| `/livespec:evolve` | Health, validation, context |
| `/livespec:learn` | Session completion and learning |
