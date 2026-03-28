---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Skills reference non-existent files or AI ignores skill workflows, preventing methodology adoption
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by: []
updated-by:
  - specs/features/ambient-architecture.spec.md (Simplified Skill Set, Dynamic Plugin Reference)
---

# Plugin Skills Architecture

## Status

**Partially updated by ambient-architecture.spec.md**

Key changes:
- Self-Contained Content → SUPERSEDED by Dynamic Plugin Reference (read at runtime)
- Bootstrap Detection → SUPERSEDED by /livespec:go router + /livespec:init
- Skill set reduced to 5 skills: go, init, design, audit, learn

Retained requirements: Authority Headers, Checkpoint Enforcement, Graceful Degradation, Context Priority Override, Hook-Based Skill Suggestion.

## Requirements

### Dynamic Plugin Reference (Replaces Self-Contained)

- [!] Skills read templates and detailed guides from plugin at runtime, not inlined
  - Metaspec templates fetched via Read tool when creating specs
  - Detailed workflow guides in plugin, loaded when skill invoked
  - Essential rules (spec-first, layer boundaries) inlined in generated CLAUDE.md
  - Enables plugin updates without regenerating project files

### Authority Headers

- [!] Skills command behavior with explicit directive blocks
  - Authority header at start of each SKILL.md (after frontmatter)
  - Explicit prohibition against searching external files for "livespec" guidance
  - Explicit prohibition against querying Context7 for "livespec"
  - Override statement for conflicting context sources

### Skill Description Enhancement

- [!] Skill descriptions include auto-invocation triggers
  - "USE WHEN:" clause in description field
  - List trigger keywords that should activate the skill
  - Explicit "DO NOT use Context7" statement
  - Multi-line YAML description format (using `|`)

### Checkpoint Enforcement

- [!] Skills include checkpoint markers for sequential execution
  - **[CHECKPOINT]** markers at critical decision points
  - **[NEXT]** markers guiding to subsequent steps
  - Prevents skipping steps or parallel execution of dependent steps

### Graceful Degradation

- [!] Skills work without AGENTS.md or ctxt/ in target project
  - AGENTS.md is optional enhancement, not requirement
  - Skills provide complete workflow inline
  - Context tree generation is opt-in improvement

### Context Priority Override

- [!] Project-level `.claude/CLAUDE.md` overrides global routing
  - Explicit skill routing table (intent → skill mapping)
  - Auto-invocation triggers listed
  - Clear statement: "DO NOT use Context7 for livespec queries"
  - Defers to root CLAUDE.md for non-skill guidance

### Hook-Based Skill Suggestion

- [!] UserPromptSubmit hook suggests skills when keywords detected
  - `.claude/hooks/skill-evaluator.sh` script
  - Pattern matching for each skill's trigger keywords
  - Outputs suggestion text (non-blocking)
  - Skips suggestion if skill already being invoked

### Simplified Skill Set

- [!] Plugin provides exactly 5 skills with clear, non-overlapping purposes
  - `/livespec:go` - Intelligent router, guides user via AskUserQuestion
  - `/livespec:init` - Bootstrap new project (interactive scaffold)
  - `/livespec:design` - Create/refine specs (guided flow)
  - `/livespec:audit` - Check health, detect drift (was: evolve)
  - `/livespec:learn` - Capture session learnings, update specs

## Validation

- [ ] Skills work in fresh project with no prior setup
- [ ] Skills read templates from plugin path successfully
- [ ] No broken file references in any skill
- [ ] AI follows skill workflow without external searches
- [ ] Hook suggests appropriate skills when keywords detected
- [ ] Project-level CLAUDE.md takes priority over global routing
- [ ] All 5 skills have distinct, non-overlapping purposes
