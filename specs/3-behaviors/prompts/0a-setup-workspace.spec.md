---
specifies: prompts/0-define/0a-setup-workspace.md
criticality: CRITICAL
failure_mode: Users cannot create workspace specifications without guidance
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Setup Workspace

## Requirements
- [!] Prompt guides creation of three workspace specifications customized to target project, defining HOW project is developed (not WHAT to build).
  - Produces `specs/workspace/constitution.spec.md` with 3-5 development principles
  - Produces `specs/workspace/patterns.spec.md` with code/spec naming and format conventions
  - Produces `specs/workspace/workflows.spec.md` with development processes
  - References `.livespec/templates/workspace/` for bootstrap templates
  - Explains workspace defines HOW to build, not WHAT to build
  - Customizes specs to target project context (not generic templates)

## Context

Use when:
- Starting new project with LiveSpec
- Adding LiveSpec to existing codebase
- Establishing development methodology baseline

## Prerequisites

- `.livespec/` directory exists with LiveSpec methodology copied
- `specs/workspace/` directory created
- Agent understands MSL format (title, frontmatter, Requirements section)

## Outputs

- `specs/workspace/constitution.spec.md` - Development principles and governance (format: MSL with criticality, failure_mode, Requirements)
- `specs/workspace/patterns.spec.md` - Code and specification patterns (format: MSL with pattern sections)
- `specs/workspace/workflows.spec.md` - Development process workflows (format: MSL with workflow descriptions)

## Validation

- Three workspace spec files exist in `specs/workspace/`
- Each follows MSL format (criticality, failure_mode, Requirements with [!])
- Constitution includes 3-5 specific principles for target project
- Patterns include project-specific naming/format conventions
- Workflows include project-specific development processes
- Specs reference project context (not generic "any project" language)

## Success Criteria

- Workspace specs capture project's actual methodology (not theoretical)
- Principles are actionable and observable (not vague aspirations)
- Patterns eliminate ambiguity for common decisions
- Workflows provide clear guidance for development phases
- Specs readable and maintainable by project team

## Error Handling

**If `.livespec/` directory missing:**
- Guide user to copy LiveSpec distribution: `cp -r livespec/dist/ .livespec/`
- Explain `.livespec/` contains methodology prompts and templates

**If `specs/workspace/` directory missing:**
- Create directory: `mkdir -p specs/workspace`
- Explain this directory contains HOW-to-build methodology

**If agent lacks MSL format knowledge:**
- Reference `.livespec/standard/metaspecs/` for format requirements
- Provide inline MSL structure reminder: title, frontmatter (criticality, failure_mode), Requirements section

## Constraints

What this prompt should NOT do:
- ❌ Create WHAT-to-build specifications (those belong in specs/3-behaviors/, specs/3-contracts/)
- ❌ Generate generic templates without project customization
- ❌ Include implementation-specific patterns (focus on portable methodology)
- ❌ Over-specify details that should be left to implementer judgment
