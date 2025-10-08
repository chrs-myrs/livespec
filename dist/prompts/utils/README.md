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

### upgrade-methodology.md - Safe Methodology Upgrade
**Use when:** LiveSpec releases new version and you want latest improvements

Guides through backup, fetch, diff, and selective application of methodology updates while preserving your customizations.

```bash
# Example:
claude-code "Use .livespec/utils/upgrade-methodology.md"
```

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

### generate-feedback-report.md - LiveSpec Evaluation Report
**Use when:** You want to provide feedback or perform health check

Generates structured feedback report combining automated adoption analysis with qualitative user experience. Helps LiveSpec maintainers improve methodology and provides users with reflection on their LiveSpec journey.

```bash
# Example:
claude-code "Use .livespec/utils/generate-feedback-report.md"
```

**Report includes:**
- Project context and adoption metrics
- Quality assessment (drift, MSL adherence, tests)
- Usage patterns (which prompts used most)
- Your experience (what works, pain points, suggestions)

**Can be run anytime** - after milestones, quarterly, or when you have feedback to share.

## Philosophy

**Core prompts (Phase 0-4)** handle 80% of projects.

**Utils** handle the other 20% - complexity, uncertainty, recovery.

Don't use utils "just in case" - use them when you have a specific problem they solve.
