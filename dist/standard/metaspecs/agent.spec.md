---
criticality: CRITICAL
failure_mode: Without agent spec requirements, agent specs lack essential structure for guiding AI agent implementations
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
extends:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Agent Specification Requirements

## Requirements

- [!] Agent specifications define AI sub-agent implementations with essential structural sections that ensure complete, isolated, and effective agent behavior.
  - Spec follows behavior.spec.md requirements (observable outcomes, validation criteria)
  - Spec located in `specs/3-artifacts/agents/` folder
  - Spec uses `specifies:` frontmatter field pointing to actual agent instructions file path
  - File name matches agent directory name (e.g., `context-builder.spec.md` specifies `.claude/agents/context-builder/instructions.md`)

  **Essential sections (required):**
  - **Prerequisites Validation requirement**: Spec requires agent validate all required inputs/files exist before starting work
  - **Source Content Extraction requirement**: Spec requires agent systematically read and extract content from source specifications
  - **Generation/Processing requirement**: Spec requires agent perform its core task with specific outputs and structure
  - **Validation requirement**: Spec requires agent validate its outputs before reporting success (structure, size, content checks)
  - **Results Reporting requirement**: Spec requires agent provide comprehensive report to calling session with all relevant details
  - **Isolation requirement**: Spec requires agent run in isolated context via Task tool without polluting parent session

  **Agent-specific requirements:**
  - **Size budgets**: If agent generates files, spec defines size budgets and enforcement
  - **Structure requirements**: If agent generates structured content, spec defines structure validation
  - **Compression**: If agent applies context compression, spec requires respecting configuration
  - **Error handling**: Spec defines clear error messages and recovery guidance

  **Optional sections (when applicable):**
  - **Examples section**: For complex patterns, spec may require agent provide examples of outputs or behaviors
  - Agent references appropriate templates when generating content (e.g., `.livespec/templates/`)

## Agent Spec Structure Pattern

**Minimal agent spec** (after inheriting metaspec requirements):

```markdown
---
specifies: .claude/agents/[name]/instructions.md
criticality: CRITICAL | IMPORTANT
failure_mode: [What fails without this agent]
derives_from:
  - specs/3-behaviors/[behavior].spec.md
governed-by:
  - .livespec/standard/metaspecs/agent.spec.md
satisfies:
  - specs/1-requirements/[requirement].spec.md
guided-by:
  - specs/2-strategy/[strategy].spec.md
---

# [Agent Name] Agent

## Requirements

### Prerequisites Validation

- [!] Agent validates all required inputs before starting
  - [Required file 1]
  - [Required file 2]
  - [Configuration 1]
  - Clear error messages if missing
  - Guidance to resolve missing prerequisites

### [Core Task Name]

- [!] Agent performs [core function]
  - [Specific behavior 1]
  - [Specific output 1 with path and format]
  - [Validation performed]
  - [Size budget if applicable]

### Validation

- [!] Agent validates outputs before reporting success
  - [Validation check 1]
  - [Validation check 2]
  - Reports validation results

### Results Reporting

- [!] Agent provides comprehensive report to calling session
  - [What's included in report]
  - [Format of report]
  - [Next steps provided]

### Isolation and Context Management

- [!] Agent runs in isolated context without polluting parent session
  - Launched via Task tool as sub-agent
  - Performs work in isolation
  - Returns only final report
  - No intermediate details leak to parent

## Validation

### Prerequisites Validation
- [ ] Agent checks for [prerequisite 1]
- [ ] Agent stops with clear error if prerequisites missing
- [ ] Agent provides guidance to resolve issues

### [Core Task] Validation
- [ ] [Output 1] generated correctly
- [ ] [Structure validation check]
- [ ] [Size budget check if applicable]

### Reporting Validation
- [ ] Comprehensive report generated
- [ ] Report includes all required details
- [ ] Agent runs in isolated context
```

## Notes

**What NOT to include in individual agent specs** (inherited from metaspec):
- ❌ "Agent must validate prerequisites" (metaspec requires this)
- ❌ "Agent must run in isolation" (metaspec requires this)
- ❌ "Agent must report results" (metaspec requires this)
- ❌ "Agent must validate outputs" (metaspec requires this)

**What to include in individual agent specs** (agent-specific):
- ✅ Specific files/inputs required for THIS agent
- ✅ Specific outputs generated with paths and formats
- ✅ Specific validation criteria for THIS agent's outputs
- ✅ Specific size budgets if THIS agent generates files
- ✅ Specific error scenarios for THIS agent
- ✅ Specific agent behaviors for THIS agent's task
- ✅ References to templates used by THIS agent
- ✅ Structure requirements for THIS agent's outputs

**Key differences from prompts**:
- **Isolation**: Agents run as sub-agents via Task tool (isolated context)
- **Autonomy**: Agents execute complete tasks, not just guidance
- **Outputs**: Agents create files/artifacts, prompts guide users
- **Validation**: Agents validate their own outputs before reporting
- **Reporting**: Agents report results to calling session

**Hierarchy**:
```
base.spec.md (MSL + LiveSpec frontmatter)
  ↓ governs
behavior.spec.md (observable outcomes, validation)
  ↓ governs
agent.spec.md (THIS - agent structural requirements)
  ↓ governs
[individual agent specs] (specific outcomes only)
```

**Benefit**: Individual agent specs focus on WHAT agent achieves, not HOW agent is structured. Structure inherited from metaspec.
