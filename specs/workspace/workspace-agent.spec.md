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
- specs/1-requirements/strategic/outcomes.spec.md (core requirements summary)
- specs/1-requirements/strategic/constraints.spec.md (critical boundaries summary)
- specs/2-strategy/architecture.spec.md (technical approach summary)

**Content structure** (optimized for context positioning):

**START section (30-40% - primacy bias):**
1. Summary section (purpose, success criteria)
2. Core principles from constitution.spec.md (spec-first #1, MSL minimalism #2 with decision framework)
3. Critical constraints (boundaries that must never be violated)
4. **Spec-first protocol** (from `.livespec/templates/agents/spec-first-enforcement.md` - combines four-layer enforcement: TodoWrite gate, validation tool, mandatory plan mode, permanent file test)

- [!] AGENTS.md uses critical warnings (⚠️) sparingly with strict criteria to prevent warning fatigue.
  - **Maximum 3 critical sections** in AGENTS.md START section
  - **Critical criteria**: Violating this causes methodology failure (not just poor quality)
  - **Critical status examples**:
    - ⚠️ CRITICAL: Spec-First Guidance (without this, drift is inevitable)
    - ⚠️ CRITICAL: Pre-Implementation Verification (without this, violations go undetected)
  - **Non-critical examples** (important but not failure-mode):
    - Visible Methodology Compliance (quality improvement, not failure prevention)
    - Real-Time Learning Capture (enhancement, not core requirement)
  - **Status levels available**:
    - ⚠️ CRITICAL - Methodology fails without this (max 3)
    - ## Important - Recommended but system survives without it
    - ## Optional - Nice-to-have enhancement
  - **Audit process**: During MSL audits, review critical status
  - **Downgrade criterion**: If methodology can survive without it → remove ⚠️
  - **Prevention**: Adding new critical section requires removing or downgrading existing critical section

**MIDDLE section (40% - supporting details):**
9. Quick start for 80% of cases (new project, existing project)
10. Decision tree (which phase/prompt to use)
11. 5 phases overview (entry/exit conditions, key prompts)
12. MSL format quick reference
13. Folder structure pattern
14. Essential templates (workspace, behavior, contract)
15. Dependency structure (frontmatter conventions)
16. Common anti-patterns
17. Reference Library (navigation to deep detail via `.livespec/` paths)
    - Categories: Conventions, Metaspecs, Guides
    - Each entry: "Fetch when" + "Provides" + "Cross-ref"
    - Enables 80/20 navigation

**END section (20-30% - recency bias):**
18. When to fetch full prompts (table mapping needs to prompts):
    - Includes all phase prompts (0a through 4e)
    - Includes upgrade-methodology.md with note about proof-of-work requirements
    - Note explains: Upgrade process requires showing evidence (git clone output, backup ls, validation tests)
    - Emphasizes: Cannot fake the process - evidence required for each phase
19. Current priorities (what agent should focus on based on project state)

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
  - See .livespec/guides/context-positioning.md for complete positioning framework
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
  - **Agent includes spec-first protocol with structural enforcement** (ESSENTIAL - from template):
    - Four-layer enforcement: TodoWrite gate, validation tool, mandatory plan mode, permanent file test
    - Template: `.livespec/templates/agents/spec-first-enforcement.md`
    - Provides structural enforcement (TodoWrite + Plan Mode + validation tool), not just passive documentation
    - Target: 90%+ compliance before commit, pre-commit hook catches remaining 10%
  - **Agent facilitates continuous improvement** (utilities):
    - When user requests "self-improvement" or "suggest improvements", agent checks for prompts/generated/self-improve.md
    - When user requests "capture learnings" or "internalise learnings", agent checks for prompts/generated/internalise-learnings.md
    - If utilities missing, agent offers to generate using prompts/utils/generate-self-improvement.md or generate-internalise-learnings.md
    - Generated utilities are customized to project's PURPOSE, principles, and spec structure
    - Self-improvement: Strategic project-wide analysis (periodic health checks)
    - Internalise learnings: Tactical conversation analysis (immediate learning capture after corrections)
    - Both use project-specific context (not generic templates)
  - **Reference Library section** enables 80/20 navigation (AGENTS.md → deep detail):
    - **Purpose**: Tell agents where the other 20% lives (80/20 principle)
    - **Path convention**: Use `.livespec/` prefix (works in livespec repo via symlink, target projects via copy)
    - **Categories**: Conventions (structure), Metaspecs (spec types), Guides (application)
    - **Navigation pattern**: "Fetch when: [trigger condition]" for each reference
    - **Location**: MIDDLE or END section (detailed navigation, not critical rules)
    - **Cross-references**: Link from AGENTS.md summary sections back to Reference Library
  - File size remains under 100KB
  - Regeneration script exists and works
