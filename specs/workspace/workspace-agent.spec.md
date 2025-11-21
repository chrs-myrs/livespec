---
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 5: Voluntary Adoption)
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 6: Sustainable Evolution)
applies_to:
  - all_ai_agents
  - AGENTS.md
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
  - specs/workspace/agent-contexts.spec.md
supports:
  - prompts/4-evolve/4d-regenerate-context.md
  - .livespec/prompts/utils/regenerate-contexts.md
criticality: CRITICAL
failure_mode: Agents lack persistent context, forcing users to manually explain LiveSpec methodology each session, defeating voluntary adoption model
governed-by:
  - .livespec/standard/conventions/context-tree.spec.md
  - .livespec/guides/context-positioning.md
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Agent Configuration Structure

## Requirements

- [!] LiveSpec AGENTS.md provides AI agents with methodology context following context tree convention
  - **Context tree pattern**: Root AGENTS.md + ctxt/ sub-agents (see `.livespec/standard/conventions/context-tree.spec.md`)
  - **Evolution**: Monolithic (50-60KB) → Hierarchical tree (root 30-40KB + ctxt/)
  - **Generation**: Use `.livespec/prompts/utils/regenerate-contexts.md` to build tree
  - **Distribution**: dist/AGENTS.md is bootstrap (~5KB), instructs generation after Phase 0
  - **Benefits**: Better focus (specialized contexts), reduced overload (load what's needed), improved signal-to-noise (60% vs 20%)

- [!] LiveSpec AGENTS.md content generated from project specifications
  - **Sources**: PURPOSE.md, workspace/*.spec.md, 1-requirements/strategic/*.spec.md, 2-strategy/architecture.spec.md
  - **Content structure**: Optimized for context positioning (START/MIDDLE/END) per `.livespec/guides/context-positioning.md`
  - **Compression**: Moderate level (balanced inline/reference) per workspace/constitution.spec.md
  - **No frontmatter**: Clean context for agents (convention requirement)
  - **Inline edit warning**: Instructs regeneration (not separate section - clean context)

- [!] LiveSpec AGENTS.md uses START/MIDDLE/END positioning for optimal agent processing
  - **START section (30-40%)**: Core principles, critical warnings, spec-first protocol, constraints
  - **MIDDLE section (40%)**: Quick start, decision tree, phases overview, MSL format, folder structure, templates, dependencies, anti-patterns, Reference Library
  - **END section (20-30%)**: Prompt registry (when to fetch full prompts), current priorities
  - **Rationale**: Exploits primacy bias (START) and recency bias (END) per Liu et al. "Lost in the Middle" (2023)
  - **Performance improvement**: 20-30% better recall through strategic positioning

- [!] LiveSpec AGENTS.md enforces critical warnings limitation for focus
  - **Maximum 3 critical sections** in START (prevents warning fatigue)
  - **Critical criteria**: Methodology fails without this (not just poor quality)
  - **Current critical sections**: Spec-First Protocol
  - **Downgrade process**: Adding new critical requires removing/downgrading existing
  - **Status levels**: ⚠️ CRITICAL (max 3) | ## Important (recommended) | ## Optional (nice-to-have)

- [!] LiveSpec AGENTS.md incorporates specialized structural enforcement templates
  - **Spec-first enforcement**: From `.livespec/templates/agents/spec-first-enforcement.md`
  - **Template insertion**: Full content inline during generation (not reference - critical for adoption)
  - **Four-layer enforcement**: TodoWrite gate, validation tool, plan mode, permanent file test
  - **Target**: 90%+ compliance before commit, pre-commit hook catches 10%

## Validation

- AGENTS.md generated from project sources (PURPOSE.md, workspace specs)
- Content structure follows START/MIDDLE/END positioning pattern
- Moderate compression applied (balanced inline/reference)
- Maximum 3 critical warnings in START section
- Spec-first enforcement template included inline
- No frontmatter (clean context per convention)
- Inline edit warning at top (not separate section)
- File size 30-40KB (compressed from typical 50-60KB)
- Regeneration workflow documented and functional
- Agent can answer "what should I do next?" without additional context
- Agent enforces MSL format without being reminded
- Agent suggests relevant phase based on project state
- Agent guides spec-first development proactively
