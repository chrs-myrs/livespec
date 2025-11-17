---
specifies: prompts/4-evolve/4d-regenerate-context.md
derives-from:
  - specs/workspace/workspace-agent.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: AGENTS.md becomes stale, agents lack current methodology context, users must repeatedly explain LiveSpec process
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
  - specs/2-strategy/ai-discoverability.spec.md
---

# Prompt Behavior: Regenerate Context Tree

## Requirements
- [!] Prompt guides user or agent through regenerating AGENTS.md from current workspace specifications, ensuring AI agents have up-to-date methodology context.
  - Produces AGENTS.md (format: markdown with frontmatter referencing workspace-agent.spec.md, sections per that spec, <100KB size)
  - Gathers content from PURPOSE.md and specs/workspace/ (constitution, patterns, workflows)
  - Structures content per specs/workspace/workspace-agent.spec.md template
  - Includes frontmatter (generated timestamp, generator, version, spec reference)
  - File size stays under 100KB (cacheable by AI agents)
  - All required sections present (Summary, Decision Tree, 5 Phases, MSL Format, etc.)

- [!] Regeneration applies MSL minimalism to prevent AGENTS.md bloat.
  - Tests each section: "Would AGENTS.md fail without this?"
  - Consolidates duplicate/overlapping sections
  - Enforces critical warning budget (maximum 3)
  - Targets <80KB (not just <100KB limit)
  - Removes redundant examples, verbose explanations
  - Preserves 80/20 coverage while minimizing size

## Context

Use when:
- Workspace specs change (constitution, patterns, workflows updated)
- PURPOSE.md updated significantly
- Strategy architecture changes affect agent guidance
- After LiveSpec version upgrade
- AGENTS.md missing or outdated
- Periodic refresh (quarterly or on major methodology evolution)

## Prerequisites

- specs/workspace/ exists with at least constitution.spec.md
- PURPOSE.md exists (project vision)
- specs/workspace/workspace-agent.spec.md exists (defines AGENTS.md structure)
- .livespec/templates/agents/ exists (verification templates)
- Agent understands markdown generation and frontmatter
- Git available for committing regenerated file

## Outputs

- `AGENTS.md` at project root (format: markdown with YAML frontmatter, structured sections per workspace-agent.spec.md, includes agent verification templates from .livespec/templates/agents/, <100KB size)
- Git commit with regeneration details (optional but recommended)

## Validation

- AGENTS.md regenerated successfully from current specs
- File size under 100KB (verify with `ls -lh AGENTS.md`)
- All required sections present (Summary, Decision Tree, 5 Phases, MSL Format Quick Reference, Folder Structure Pattern, Essential Templates, Core Principles, Constraints)
- Frontmatter complete (implements, generated, generator, version fields)
- Visible generated file warning present (blockquote after frontmatter, before first heading)
- Agent verification templates included (from .livespec/templates/agents/)
- Content reflects current workspace specs (not outdated)
- Agent can guide new user through LiveSpec using this file alone

## Success Criteria

- AGENTS.md self-contained (agent doesn't need additional context)
- Decision tree covers common scenarios
- Phase guidance clear and actionable
- MSL format template usable
- File cacheable (size appropriate)
- Regeneration fast (<5 minutes)

## Error Handling

**If workspace specs incomplete:**
- Guide to Phase 0a: Create missing workspace specs first
- Cannot regenerate without constitution/patterns/workflows

**If templates missing (.livespec/templates/agents/):**
- Warn: AGENTS.md will lack verification content
- Guide to copy complete dist/ distribution
- Reference specs/2-strategy/architecture.spec.md Distribution section

**If generated file exceeds 100KB:**
- Identify large sections (verbose templates, excessive examples)
- Condense while preserving essential guidance
- Consider extracting detailed content to separate files

**If section structure unclear:**
- Reference specs/workspace/workspace-agent.spec.md for required structure
- Follow template exactly
- Include all mandatory sections

## Constraints

What this prompt should NOT do:
- ❌ Include implementation code in AGENTS.md (guidance only, not code)
- ❌ Exceed 100KB file size (must stay cacheable)
- ❌ Skip frontmatter (traceability required)
- ❌ Omit required sections (per workspace-agent.spec.md)
- ❌ Generate without reading current specs (must reflect current state)
