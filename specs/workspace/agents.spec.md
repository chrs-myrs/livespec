---
applies_to:
  - all_ai_agents
  - AGENTS.md
derives_from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
supports:
  - prompts/4-evolve/4d-regenerate-agents.md
criticality: CRITICAL
failure_mode: Agents lack persistent context, forcing users to manually explain LiveSpec methodology each session, defeating voluntary adoption model
constrained_by:
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
- specs/requirements.spec.md (core requirements summary)
- specs/constraints.spec.md (critical boundaries summary)
- specs/strategy/architecture.spec.md (technical approach summary)

**Content structure:**
1. Summary section (purpose, success criteria)
2. Quick start for 80% of cases (new project, existing project)
3. Decision tree (which phase/prompt to use)
4. 5 phases overview (entry/exit conditions, key prompts)
5. MSL format quick reference
6. Folder structure pattern
7. Essential templates (workspace, behavior, contract)
8. Core principles (from constitution.spec.md)
9. Constraints (critical boundaries)
10. Dependency structure (frontmatter conventions)
11. Common anti-patterns
12. When to fetch full prompts (table mapping needs to prompts):
    - Includes all phase prompts (0a through 4e)
    - Includes upgrade-methodology.md with note about proof-of-work requirements
    - Note explains: Upgrade process requires showing evidence (git clone output, backup ls, validation tests)
    - Emphasizes: Cannot fake the process - evidence required for each phase

**Design principles:**
- Single file <100KB for efficient caching
- 80/20 rule: Cover 80% of use cases without agent fetching additional context
- Self-contained: Agent can guide new user without web search
- Regeneratable: Script rebuilds from source specs when they change
- Agent-agnostic: Same content works for Claude, Copilot, Cursor (different filename)
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
  - File size remains under 100KB
  - Regeneration script exists and works
