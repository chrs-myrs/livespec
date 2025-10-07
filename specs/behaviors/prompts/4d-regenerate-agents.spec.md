---
specifies: prompts/4-evolve/4d-regenerate-agents.md
derives_from:
  - specs/workspace/agents.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: AGENTS.md becomes stale, agents lack current methodology context, users must repeatedly explain LiveSpec process
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Regenerate Agent Configuration Prompt

## Requirements
- Prompt guides user or agent through regenerating AGENTS.md from current workspace specifications, ensuring AI agents have up-to-date methodology context without requiring manual updates.

**Triggers:**
- Workspace specs change (constitution, patterns, workflows)
- PURPOSE.md updated
- Strategy architecture significantly changes
- After LiveSpec version upgrade

**Process:**
1. Gather source content from PURPOSE.md and specs/workspace/
2. Structure content following specs/workspace/agents.spec.md template
3. Generate AGENTS.md with frontmatter (generated timestamp, version, spec reference)
4. Validate file size <100KB and section completeness
5. Commit regenerated file with descriptive message

**Ensures:**
- AGENTS.md reflects current methodology
- Agent can guide users without additional context
- Persistent context mechanism remains functional
- File stays cacheable for agent efficiency
  - AGENTS.md regenerated successfully from current workspace specs
  - File size under 100KB (cacheable)
  - All required sections present (Summary, Decision Tree, 5 Phases, MSL Format, etc.)
  - Frontmatter includes spec reference, generation timestamp, version
  - Agent can guide new user through LiveSpec without fetching additional context
  - Regeneration process completes in under 5 minutes

## Prompt Outputs

**Primary outputs:**
- AGENTS.md (regenerated with updated content)

**Validation checks:**
- File size verification (<100KB)
- Section completeness check
- Frontmatter validation (generated, generator, version, spec fields)
- Manual review checklist for agent guidance capability

**Success criteria:**
- Agent can answer "what phase should I use?" from regenerated file
- Decision tree covers common scenarios
- All 5 phases present with entry/exit conditions
- MSL format template complete

## Validation

- AGENTS.md regenerated successfully from current workspace specs
- File size under 100KB (cacheable)
- All required sections present (Summary, Decision Tree, 5 Phases, MSL Format, etc.)
- Frontmatter includes spec reference, generation timestamp, version
- Agent can guide new user through LiveSpec without fetching additional context
- Regeneration process completes in under 5 minutes
