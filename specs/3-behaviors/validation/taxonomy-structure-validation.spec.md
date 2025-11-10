---
criticality: IMPORTANT
failure_mode: Incomplete taxonomy specs leave agents without guidance on file placement, workspace scope, and specs boundary decisions
governed-by:
  - dist/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/functional/workspace-governance.spec.md
guided-by:
  - specs/2-strategy/validation.spec.md
  - specs/2-strategy/dogfooding.spec.md
---

# Taxonomy Structure Validation

## Requirements

- [!] System validates that every project's taxonomy.spec.md contains all required sections per the taxonomy metaspec to guide AI agents on file placement and project classification.
  - Validates presence of **Project Domain** section (Software, Documentation, Planning, Generation, Governance, or Hybrid classification)
  - Validates presence of **Workspace Scope** section (explicit listing of portable vs product-specific content)
  - Validates presence of **Specs Boundary** section (declares specs/ contains only specifications)
  - Validates presence of **AI agents must** section (agent obligations)
  - Reports missing sections with specific guidance on what to add
  - Validation can run pre-commit, on-demand, or during Phase 0 (DEFINE)
  - Reports include references to taxonomy metaspec for remediation

## Validation

- Validator detects taxonomy.spec.md files in specs/workspace/ directory
- Validator checks for all four required section headings
- Validator reports which specific sections are missing
- Validator provides remediation guidance (references metaspec, template)
- Validator distinguishes ERROR (missing sections) vs WARNING (incomplete sections)
- Validator output actionable (tells user exactly what sections to add)

## Examples

**Complete taxonomy.spec.md:**
```markdown
# Project Taxonomy

## Project Domain
Software - Produces TypeScript library for data validation

## Workspace Scope
**What IS workspace (portable methodology):**
- constitution.spec.md - Development principles
- patterns.spec.md - Naming conventions
- workflows.spec.md - Development process
- taxonomy.spec.md - Project classification

**What is NOT workspace (product-specific):**
- Validation rules are product behavior (3-behaviors/)
- API design is product strategy (2-strategy/)
- Feature requirements (1-requirements/)

Test: "Portable to any project?" → YES = workspace/, NO = elsewhere

## Specs Boundary
specs/ contains ONLY .spec.md files defining system behavior.

**Non-spec content locations:**
- Test data → tests/fixtures/
- Build artifacts → dist/
- Generated outputs → generated/

## AI agents must
- Check taxonomy.spec.md FIRST before creating files
- Verify workspace/ additions pass portability test
- Keep data/research/outputs OUT of specs/
```
✅ Contains all four required sections

**Incomplete taxonomy.spec.md:**
```markdown
# Project Taxonomy

## Project Classification
This project defines TMP's project classification system:
- Nature: library, application
- Type: code, agentic, hybrid
- Deployment: deployed, internal
- Runtime: lambda, container, server
- Language: typescript, javascript, php, python
```
❌ ERROR: Missing required sections:
  - Project Domain (classify THIS project, not define classification system)
  - Workspace Scope (what's portable vs product-specific)
  - Specs Boundary (where non-spec content lives)
  - AI agents must (agent obligations)

Reference: dist/standard/metaspecs/taxonomy.spec.md

## Failure Scenarios

**If Project Domain section missing:**
- Validation fails with ERROR
- Reports: "taxonomy.spec.md missing 'Project Domain' section"
- Suggests: "Add section classifying project as Software/Documentation/Planning/Generation/Governance/Hybrid"
- Blocks commit if running in git hook
- References taxonomy metaspec lines 11-15

**If Workspace Scope section missing:**
- Validation fails with ERROR
- Reports: "taxonomy.spec.md missing 'Workspace Scope' section"
- Suggests: "Add section listing what IS workspace (portable) vs what is NOT (product-specific)"
- Blocks commit if running in git hook
- References taxonomy metaspec lines 15-19
- This was the EXACT issue in project-governance that prompted this validation

**If Specs Boundary section missing:**
- Validation fails with ERROR
- Reports: "taxonomy.spec.md missing 'Specs Boundary' section"
- Suggests: "Add section declaring specs/ contains only .spec.md files and where data/research/artifacts live"
- Blocks commit if running in git hook
- References taxonomy metaspec lines 20-23

**If AI agents must section missing:**
- Validation fails with ERROR
- Reports: "taxonomy.spec.md missing 'AI agents must' section"
- Suggests: "Add section listing agent obligations (check taxonomy FIRST, verify workspace portability, etc.)"
- Blocks commit if running in git hook
- References taxonomy metaspec lines 24-28

**If section headers present but content incomplete:**
- Validation warns with WARNING
- Reports: "Section '[Name]' exists but may be incomplete"
- Does not block commit (content quality is harder to validate)
- Suggests manual review against metaspec

## Implementation Notes

**Detection patterns:**
- Search for heading patterns: `## Project Domain`, `## Workspace Scope`, `## Specs Boundary`, `## AI agents must`
- Case-insensitive heading matching
- Allow minor variations (e.g., "AI Agents Must" vs "AI agents must")
- Core test: Does each required concept have a dedicated section?

**Remediation guidance:**
- Link to taxonomy metaspec: `dist/standard/metaspecs/taxonomy.spec.md`
- Link to taxonomy template: `dist/templates/workspace/taxonomy-*.spec.md.template`
- Reference LiveSpec's own taxonomy as example: `specs/workspace/taxonomy.spec.md`
- Suggest: "Use .livespec/prompts/0-define/0b-customize-workspace.md to regenerate taxonomy"

**Historical context:**
This validation addresses real failure discovered in ../tmp/project-governance/ where:
- taxonomy.spec.md defined a product classification system (TMP taxonomy dimensions)
- BUT was missing Project Domain, Workspace Scope, Specs Boundary sections
- Agent had no guidance on file placement decisions
- User reported having to "re-iterate many fundamental LiveSpec principles"
- Missing Workspace Scope section specifically prevented determining what belongs in workspace/ vs specs/
