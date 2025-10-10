---
applies_to:
  - all_ai_agents
  - AGENTS.md
derives-from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
supports:
  - prompts/4-evolve/4d-regenerate-agents.md
criticality: CRITICAL
failure_mode: Agents lack persistent context, forcing users to manually explain LiveSpec methodology each session, defeating voluntary adoption model
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Agent Configuration Structure

## Requirements
- [!] Root AGENTS.md file provides AI agents with complete LiveSpec methodology context in single cacheable document, enabling agents to guide users through all 5 phases without requiring slash commands or CLI tools.

**Generated from:**
- PURPOSE.md (project vision and success criteria)
- specs/workspace/constitution.spec.md (development principles)
- specs/workspace/patterns.spec.md (naming, format, structure conventions)
- specs/workspace/workflows.spec.md (5 phases, when to use each)
- specs/mission/outcomes.spec.md (core requirements summary)
- specs/mission/constraints.spec.md (critical boundaries summary)
- specs/strategy/architecture.spec.md (technical approach summary)

**Content structure** (optimized for context positioning):

**START section (30-40% - primacy bias):**
1. Summary section (purpose, success criteria)
2. Core principles from constitution.spec.md (spec-first #1, MSL minimalism #2 with decision framework)
3. Critical constraints (boundaries that must never be violated)
4. Spec-first guidance workflow (essential before implementation)

**MIDDLE section (40% - supporting details):**
5. Quick start for 80% of cases (new project, existing project)
6. Decision tree (which phase/prompt to use)
7. 5 phases overview (entry/exit conditions, key prompts)
8. MSL format quick reference
9. Folder structure pattern
10. Essential templates (workspace, behavior, contract)
11. Dependency structure (frontmatter conventions)
12. Common anti-patterns

**END section (20-30% - recency bias):**
13. When to fetch full prompts (table mapping needs to prompts):
    - Includes all phase prompts (0a through 4e)
    - Includes upgrade-methodology.md with note about proof-of-work requirements
    - Note explains: Upgrade process requires showing evidence (git clone output, backup ls, validation tests)
    - Emphasizes: Cannot fake the process - evidence required for each phase
14. Current priorities (what agent should focus on based on project state)

**Design principles:**
- Single file <100KB for efficient caching
- 80/20 rule: Cover 80% of use cases without agent fetching additional context
- Self-contained: Agent can guide new user without web search
- Regeneratable: Script rebuilds from source specs when they change
- Agent-agnostic: Same content works for Claude, Copilot, Cursor (different filename)
- **Context positioning** (CRITICAL - 20-30% performance improvement):
  - START section (30-40%): Critical rules, spec-first principle, core constraints, high-priority principles
  - MIDDLE section (40%): Phase details, examples, workflows, procedures, templates
  - END section (20-30%): Prompt registry (when to fetch full prompts), decision tree, current priorities
  - Research-backed: Stanford "Lost in the Middle" study shows middle-context performance degradation
  - Exploits primacy bias (START) and recency bias (END) for optimal AI processing
  - See dist/guides/context-positioning.md for complete positioning framework
  - AGENTS.md generated from workspace specs plus PURPOSE.md
  - Agent can answer "what should I do next?" without additional context
  - Agent enforces MSL format without being reminded
  - Agent suggests relevant phase based on project state
  - **Agent guides spec-first development** (CRITICAL - principle #1):
    - Agent checks for spec existence before implementation
    - Agent pauses implementation if spec doesn't exist
    - Agent guides user to Phase 1 (DESIGN) to create spec first
    - Agent applies this to all deliverables (README, CHANGELOG, config)
    - Agent explains WHY spec-first matters (prevents drift, ensures requirements captured)
    - Agent references LiveSpec's CHANGELOG mistake (commit 40411e3) as cautionary example
  - **Agent facilitates continuous improvement** (utilities):
    - When user requests "self-improvement" or "suggest improvements", agent checks for prompts/utils/self-improve.md
    - When user requests "capture learnings" or "internalise learnings", agent checks for prompts/utils/internalise-learnings.md
    - If utilities missing, agent offers to generate using prompts/utils/generate-self-improvement.md or generate-internalise-learnings.md
    - Generated utilities are customized to project's PURPOSE, principles, and spec structure
    - Self-improvement: Strategic project-wide analysis (periodic health checks)
    - Internalise learnings: Tactical conversation analysis (immediate learning capture after corrections)
    - Both use project-specific context (not generic templates)
  - File size remains under 100KB
  - Regeneration script exists and works
