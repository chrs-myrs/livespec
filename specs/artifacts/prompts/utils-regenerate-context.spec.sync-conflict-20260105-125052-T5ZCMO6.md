---
specifies: .livespec/prompts/utils/regenerate-contexts.md
derives-from:
  - specs/workspace/agent-contexts.spec.md
  - specs/workspace/workspace-agent.spec.md
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Agent contexts become stale or monolithic AGENTS.md remains, agents suffer from context overload and lack specialized guidance
governed-by:
  - .livespec/standard/conventions/context-tree.spec.md
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/3-behaviors/context-generation.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
  - specs/2-strategy/ai-discoverability.spec.md
---

# Prompt Behavior: Regenerate Agent Contexts

## Requirements
- [!] Prompt guides user or agent through generating hierarchical agent context tree (AGENTS.md + ctxt/) from workspace specifications, enabling specialized proactive context loading for improved agent focus efficiency.

  **Outputs Produced:**
  - Root AGENTS.md (20-30KB, no frontmatter, routing to sub-agents)
  - ctxt/phases/*.md (5 files, 8-12KB each, phase specialists)
  - ctxt/domains/*.md (1-3 files, 6-10KB each, domain patterns)
  - ctxt/utils/*.md (3 files, 6-10KB each, utility specialists)
  - Total tree <150KB, typical loaded <50KB

  **Generation Process:**
  - Validates prerequisites (workspace specs, PURPOSE.md, templates)
  - Launches context-builder agent (.claude/agents/context-builder/) via Task tool
  - Agent runs in isolated context (doesn't pollute parent session)
  - Receives generation report with file sizes and validation status
  - Validates generated structure and content
  - Commits generated context tree

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

- [!] Prompt validates prerequisites before launching context builder to prevent incomplete generation.
  - Checks workspace specs exist (constitution, patterns, workflows, agent-contexts)
  - Checks PURPOSE.md exists
  - Checks templates exist (.livespec/templates/agents/spec-first-enforcement.md)
  - Stops with clear guidance if any prerequisites missing
  - Reports what's missing and how to fix (e.g., "Run Phase 0 first")

- [!] Prompt uses Task tool to launch context-builder agent in isolated context, preventing session context pollution.
  - Launches .claude/agents/context-builder/ as sub-agent
  - Agent runs in separate context bubble
  - Parent session remains focused on user's task
  - Receives results report when agent completes
  - No intermediate generation details pollute parent context

## Context

Use when:
- **CRITICAL: After Phase 0 workspace setup** (workspace specs established, need full context tree)
- Workspace specs modified (constitution, patterns, workflows, agent-contexts)
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
- specs/workspace/workflows.spec.md exists (5 phases)
- specs/workspace/agent-contexts.spec.md exists (context tree structure)
- PURPOSE.md exists (project vision)
- .livespec/templates/agents/spec-first-enforcement.md exists (structural enforcement template)
- .claude/agents/context-builder/instructions.md exists (context builder agent definition)
- Agent understands Task tool for launching sub-agents
- Git available for committing generated files

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

**If workspace specs incomplete:**
- Stop immediately with clear message
- Report what's missing
- Guide: "Run Phase 0 (0a-quick-start or 0b-customize-workspace) first"
- Do not attempt partial generation

**If templates missing (.livespec/templates/agents/):**
- Stop immediately
- Report: "Templates missing - copy dist/ → .livespec/"
- Reference: specs/2-strategy/architecture.spec.md Distribution section
- Do not proceed without spec-first-enforcement.md

**If context-builder agent missing:**
- Stop immediately
- Report: ".claude/agents/context-builder/instructions.md not found"
- This indicates LiveSpec installation issue
- User should verify LiveSpec installation integrity

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

**If generation fails midway:**
- Context builder agent will report error
- Review error message for specific failure
- Fix source issue (e.g., malformed workspace spec)
- Re-run generation after fix

## Constraints

What this prompt should NOT do:
- ❌ Generate without validating prerequisites (incomplete sources cause failures)
- ❌ Pollute parent session context with generation details (use isolated sub-agent)
- ❌ Include frontmatter in root AGENTS.md or sub-agents (clean context required - frontmatter wastes tokens)
- ❌ Exceed size budgets (root 20-30KB, sub-agents 8-12KB max)
- ❌ Use technical jargon in load triggers (natural user language required)
- ❌ Generate monolithic AGENTS.md (use context tree structure)
- ❌ Proceed with missing agent-contexts.spec.md (structure undefined)

## Notes

**Frequency**: Run after workspace changes (like 4d-regenerate-context), also when compression level changes or context tree feels stale.

**Distribution**: Bootstrap dist/AGENTS.md is minimal (instructs to run this prompt). Project AGENTS.md + ctxt/ generated locally from workspace specs. ctxt/ NOT distributed (generated per-project).

**Agent isolation**: Context builder runs as sub-agent via Task tool. Parent session stays focused on user's task. Generation happens in isolated context bubble.

**Evolution path**: Replaces monolithic AGENTS.md pattern with hierarchical context tree. Enables proactive specialized loading for improved focus efficiency. Respects context compression framework from constitution.
