---
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
  - specs/foundation/outcomes.spec.md (Requirement 6: Sustainable Evolution)
applies_to:
  - all_ai_agents
  - AGENTS.md
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
  - specs/workspace/context-architecture.spec.md
supports:
  - skills/audit/SKILL.md (context regeneration)
criticality: CRITICAL
failure_mode: Agents lack persistent context, forcing users to manually explain LiveSpec methodology each session, defeating voluntary adoption model
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
updated-by:
  - specs/features/ambient-architecture.spec.md (Plugin distribution, skill-based regeneration)
---

# Agent Configuration Structure

## Status

**Updated for ambient architecture.**

Key changes:
- Context regeneration via `/livespec:audit` skill (not prompt)
- CLAUDE.md generated with inline essential rules
- Plugin provides templates at runtime (not copied)

## Requirements

- [!] LiveSpec AGENTS.md provides AI agents with methodology context following context tree convention
  - **Context tree pattern**: Root AGENTS.md + ctxt/ sub-agents
  - **Evolution**: Monolithic (50-60KB) → Hierarchical tree (root 30-40KB + ctxt/)
  - **Generation**: Via `/livespec:audit context` or `/livespec:init` (initial)
  - **Benefits**: Better focus (specialized contexts), reduced overload (load what's needed), improved signal-to-noise (60% vs 20%)

- [!] LiveSpec AGENTS.md content generated from project specifications
  - **Sources**: PURPOSE.md, workspace/*.spec.md, foundation/*.spec.md, strategy/architecture.spec.md
  - **Content structure**: Optimized for context positioning (START/MIDDLE/END)
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

- [!] LiveSpec AGENTS.md incorporates specialized structural enforcement rules
  - **Spec-first enforcement**: Inline rules in generated CLAUDE.md and AGENTS.md
  - **Template source**: Plugin provides templates, read at generation time
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
