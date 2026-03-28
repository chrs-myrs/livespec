---
specifies: skills/audit/SKILL.md (context regeneration behavior)
derives-from:
  - specs/workspace/context-architecture.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Agent contexts become stale or monolithic AGENTS.md remains, agents suffer from context overload and lack specialized guidance
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/features/context-generation.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
  - specs/strategy/ai-discoverability.spec.md
updated-by:
  - specs/features/ambient-architecture.spec.md (Skill-based context regeneration)
---

# Behavior: Regenerate Agent Contexts

## Status

**Updated for ambient architecture.**

Key changes:
- Context regeneration now via `/livespec:audit` skill (not prompt)
- Templates read from plugin at runtime (not copied .livespec/)
- CLAUDE.md generated with inline rules (not just AGENTS.md)

## Requirements

- [!] Skill regenerates hierarchical agent context tree (CLAUDE.md, AGENTS.md, ctxt/) from workspace specifications, enabling specialized proactive context loading for improved agent focus efficiency.

  **Outputs Produced:**
  - CLAUDE.md (inline essential rules: spec-first, layer boundaries)
  - Root AGENTS.md (20-30KB, no frontmatter, routing to sub-agents)
  - ctxt/phases/*.md (phase specialists: define, design, evolve)
  - ctxt/domains/*.md (domain patterns based on taxonomy)
  - ctxt/utils/*.md (utility specialists: session, msl-audit)
  - Total tree <150KB, typical loaded <50KB

  **Generation Process:**
  - Validates prerequisites (workspace specs, PURPOSE.md)
  - Reads templates from plugin at runtime
  - Generates CLAUDE.md with inline essential rules
  - Generates AGENTS.md with project-specific context
  - Generates ctxt/ sub-agents for specialized guidance
  - Validates generated structure and content

  **Root AGENTS.md Structure:**
  - NO frontmatter (clean context for agents)
  - Inline edit warning (not in frontmatter)
  - Project summary (from PURPOSE.md)
  - Core principles (compressed from constitution)
  - "When to Load Sub-Agents" section (routing decision tree)
  - Quick start (80% of cases)
  - MSL format quick reference
  - Reference Library (navigation to ctxt/ and .livespec/)

  **Sub-Agent Structure:**
  - Complete frontmatter (generated, parent, applies_to, load_triggers, compression, derives_from, governed_by, version)
  - Edit warning in frontmatter (not body - clean context)
  - Specialized methodology for scope
  - References to parent AGENTS.md
  - Cross-references to other sub-agents
  - Links to .livespec/ detailed specs

  **Proactive Loading:**
  - Load triggers defined in root AGENTS.md (keyword patterns)
  - Agent matches user query to triggers
  - Agent loads relevant sub-agent(s) autonomously
  - User doesn't manage contexts explicitly
  - Sub-agents have NO frontmatter (clean context when loaded)

- [!] Skill validates prerequisites before generating to prevent incomplete context.
  - Checks workspace specs exist (constitution, patterns, workflows)
  - Checks context-architecture.spec.md if present (optional content sources)
  - Checks PURPOSE.md exists
  - Templates read from plugin (no local template check needed)
  - Stops with clear guidance if workspace specs missing
  - Reports what's missing and how to fix (e.g., "Run /livespec:init first")

## Context

Use when:
- **CRITICAL: After Phase 0 workspace setup** (workspace specs established, need full context tree)
- Workspace specs modified (constitution, patterns, workflows, context-architecture)
- PURPOSE.md updated (project vision changed)
- New workspace spec added
- After LiveSpec version upgrade (new methodology)
- Switching compression levels (light ↔ moderate ↔ aggressive)
- Context tree feels stale or misaligned with current specs

**Why critical after Phase 0**: Bootstrap AGENTS.md is minimal (5KB). Full context tree with specialized sub-agents requires workspace specs to generate from.

**Relation to 4d-regenerate-context**:
- Old: Generates monolithic AGENTS.md (~50-60KB)
- New: Generates context tree (root + ctxt/) for specialized loading
- Both read same workspace specs as source
- Context tree enables better focus efficiency through proactive loading

## Prerequisites

- specs/workspace/constitution.spec.md exists (core principles)
- specs/workspace/patterns.spec.md exists (conventions)
- specs/workspace/workflows.spec.md exists (workflows)
- PURPOSE.md exists (project vision)
- LiveSpec plugin installed (provides templates at runtime)
- specs/workspace/context-architecture.spec.md optional (custom content sources)

## Outputs

**Root AGENTS.md** (20-30KB):
- No frontmatter (clean context)
- Inline edit warning
- Routing to sub-agents
- Compressed methodology

**ctxt/phases/** (5 files, 8-12KB each):
- 0-define.md, 1-design.md, 2-build.md, 3-verify.md, 4-evolve.md
- Phase-specific methodology
- Frontmatter with load_triggers

**ctxt/domains/** (1-3 files, 6-10KB each):
- Based on taxonomy.spec.md domain classification
- governance.md, software.md, hybrid.md as applicable
- Domain-specific patterns

**ctxt/utils/** (3 files, 6-10KB each):
- session-completion.md, drift-detection.md, msl-audit.md
- Utility-specific workflows
- Frontmatter with load_triggers

**Git commit** (optional but recommended):
- All generated files (AGENTS.md, ctxt/*)
- Commit message explaining context tree structure

## Validation

**Structure validation:**
- [ ] Root AGENTS.md exists (20-30KB)
- [ ] Root has NO frontmatter (clean context)
- [ ] Root has inline edit warning
- [ ] Root has "When to Load Sub-Agents" section
- [ ] ctxt/phases/ contains 5 files
- [ ] ctxt/domains/ contains domain-specific files
- [ ] ctxt/utils/ contains 3 files
- [ ] Total tree <150KB

**Content validation** (spot-check 2-3 sub-agents):
- [ ] NO frontmatter (clean context - frontmatter wastes tokens)
- [ ] Inline edit warning at top
- [ ] Content immediately accessible (no metadata overhead)
- [ ] References to parent root AGENTS.md present in content
- [ ] Links to .livespec/ detailed specs present

**Proactive loading validation**:
- [ ] Load triggers are intuitive keywords
- [ ] Root AGENTS.md routing matches sub-agent triggers
- [ ] Keywords match natural user language
- [ ] Agent can match queries to sub-agents

## Success Criteria

- Root AGENTS.md compressed 30-40% (from typical 50-60KB monolithic)
- Full context tree generated successfully
- All sub-agents have complete frontmatter
- Load triggers functional (clear keyword patterns)
- Proactive loading works (agent loads without user managing contexts)
- Context builder runs in isolated context (no session pollution)
- Commit successful with all generated files
- Agent guidance improved (more focused, less context overload)
- Generation completes in 5-10 minutes

## Error Handling

**If workspace specs missing:**
- Stop immediately with clear message
- Report what's missing (constitution, patterns, workflows)
- Guide: "Run /livespec:init first to create workspace specs"
- Do not attempt partial generation

**If PURPOSE.md missing:**
- Stop immediately
- Report: "PURPOSE.md not found"
- Guide: "Run /livespec:init to create project scaffold"

**If plugin not installed:**
- Skill won't be available
- User sees: "Command not found: /livespec:audit"
- Guide: "Install plugin: claude plugin install livespec"

**If generated files too large:**
- Check compression level in constitution.spec.md frontmatter
- Consider switching to aggressive compression
- Review workspace specs for redundancy
- Re-run generation with adjusted compression

**If load triggers not working:**
- Check keywords in root AGENTS.md "When to Load Sub-Agents" section
- Verify triggers match natural user language patterns
- Test with real user queries, not technical jargon
- Regenerate if triggers feel unnatural

## Constraints

What this skill should NOT do:
- ❌ Generate without validating prerequisites (incomplete sources cause failures)
- ❌ Include frontmatter in root AGENTS.md or sub-agents (clean context required)
- ❌ Exceed size budgets (root 20-30KB, sub-agents 8-12KB max)
- ❌ Use technical jargon in load triggers (natural user language required)
- ❌ Generate monolithic AGENTS.md (use context tree structure)
- ❌ Copy files from plugin (read templates at runtime)

## Notes

**Frequency**: Run after workspace changes, compression level changes, or context tree feels stale.

**Invocation**: Via `/livespec:audit` skill (select "regenerate context" option).

**Distribution**: Project CLAUDE.md + AGENTS.md + ctxt/ generated locally from workspace specs. Plugin provides templates at runtime (not copied).

**Evolution path**: Replaces monolithic AGENTS.md pattern with hierarchical context tree. Enables proactive specialized loading for improved focus efficiency. Respects context compression framework from constitution.
