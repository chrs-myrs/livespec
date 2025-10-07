# LiveSpec Utility Prompts

These are **optional advanced prompts** for complex scenarios. Most projects won't need them.

## When to Use Utils

**Simple projects** (single developer, clear requirements, < 3 months):
- Skip these entirely
- Use core Phase 0-4 prompts only

**Complex projects** (teams, uncertainty, AI/ML, > 3 months):
- Use utils when you hit specific challenges
- Opt-in based on need

## Available Utilities

### next-steps.md - Workflow Orchestrator
**Use when:** You're lost or unsure what to do next

Analyzes your project state and recommends next actions based on what exists and what's missing.

```bash
# Example:
claude-code "Use .livespec/utils/next-steps.md"
```

### run-spike.md - Discovery Spike
**Use when:** You have unknowns that need time-boxed exploration

For complex technical questions that can't be answered without building a prototype. Creates spike report documenting learnings.

```bash
# Example:
claude-code "Use .livespec/utils/run-spike.md to explore how OpenAI streaming works with our architecture"
```

### analyze-failure.md - Process Failure Analysis
**Use when:** LiveSpec adoption failed and you need diagnostic help

Forensic analysis of what went wrong, why specs drifted, and how to recover. Provides specific recommendations.

```bash
# Example:
claude-code "Use .livespec/utils/analyze-failure.md - specs became outdated after 2 sprints"
```

## Philosophy

**Core prompts (Phase 0-4)** handle 80% of projects.

**Utils** handle the other 20% - complexity, uncertainty, recovery.

Don't use utils "just in case" - use them when you have a specific problem they solve.
