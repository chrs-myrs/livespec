---
criticality: IMPORTANT
failure_mode: Without template guidance, users struggle to bootstrap workspace specs with correct structure and content
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/requirements.spec.md (minimal maintenance, voluntary adoption)
---

# Workspace Templates

## Requirements
- [!] LiveSpec provides workspace spec templates that enable users to quickly bootstrap development methodology specifications with correct MSL format and appropriate content structure.
  - Templates distributed in dist/templates/workspace/
  - Three templates provided: constitution, patterns, workflows
  - Templates use .spec.md.template extension
  - Templates follow MSL format (frontmatter + ## Requirements section)
  - Templates include placeholder guidance ([PROJECT_NAME], [Describe...])
  - Templates provide examples of appropriate content for each type
  - Templates have correct criticality (constitution CRITICAL, patterns/workflows IMPORTANT)
  - Users copy templates to specs/workspace/ and customize
  - dist/templates/README.md explains usage (copy, customize, rename)
  - Each template maps to workspace.spec.md requirements

## Template Coverage

**constitution.spec.md.template:**
- Defines project governance principles
- Placeholder for 3-5 core development principles
- Examples: MSL minimalism, bidirectional sync, simplicity over features
- Validation criteria placeholders

**patterns.spec.md.template:**
- Defines coding and specification patterns
- Placeholder for file naming, code organization, documentation standards
- Examples: kebab-case, .spec.md extension, MSL format
- Pattern verification placeholders

**workflows.spec.md.template:**
- Defines development workflows
- Placeholder for feature development, bug fixes, spec updates, releases
- Examples: spec → implement → test → review
- Workflow adherence placeholders

## Validation

- Three templates exist in dist/templates/workspace/
- Each template follows MSL format
- Each template has appropriate criticality
- Each template provides clear placeholder instructions
- dist/templates/README.md explains template usage
- Templates referenced in Phase 0 prompt (0a-setup-workspace.md)
