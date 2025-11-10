---
criticality: IMPORTANT
failure_mode: Product-specific content in workspace/ violates portability principle, breaks methodology reuse, confuses agents about workspace vs product boundary
governed-by:
  - dist/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/functional/workspace-governance.spec.md
guided-by:
  - specs/2-strategy/validation.spec.md
  - specs/2-strategy/dogfooding.spec.md
---

# Workspace Scope Audit

## Requirements

- [!] System audits workspace/ directory to ensure all files are portable methodology (not product-specific content), enforcing clear workspace vs product boundary.
  - Applies portability test to each workspace/ file: "Could I use this in ANY project?"
  - Reports files that fail portability test (product-specific content in workspace/)
  - Validates workspace/ files against taxonomy.spec.md Workspace Scope declarations
  - Checks for common violations (feature requirements, product behaviors, product strategy in workspace/)
  - Provides remediation guidance (where file should move: 1-requirements/, 2-strategy/, 3-behaviors/)
  - Can run on-demand or during Phase 4 (EVOLVE) drift detection
  - Respects taxonomy.spec.md explicit inclusions/exclusions

## Validation

- Audit scans all files in specs/workspace/ directory
- Audit applies portability test to each file
- Audit detects product-specific indicators (feature names, product terminology, domain-specific constraints)
- Audit cross-references with taxonomy.spec.md Workspace Scope section
- Audit reports violations with specific relocation suggestions
- Audit output actionable (tells user where to move file)
- Audit can be run non-destructively (report only, no moves)

## Examples

**Portable workspace/ file (valid):**
```markdown
# specs/workspace/constitution.spec.md
---
criticality: CRITICAL
failure_mode: Development becomes inconsistent without core principles
---

# Development Constitution

## Requirements
- [!] All development follows spec-first principle
  - Specifications created before implementation
  - MSL format for all specs
  - Behaviors testable and observable
```
✅ **Portability test: PASS**
- "Spec-first" applies to ANY project
- MSL format is universal
- Testable behaviors are universal principle
- **Verdict**: Properly in workspace/

**Product-specific file in workspace/ (invalid):**
```markdown
# specs/workspace/taxonomy.spec.md
---
criticality: IMPORTANT
---

# TMP Project Taxonomy

## Requirements
- [!] TMP projects classified using dimensional taxonomy
  - Nature: library, application
  - Type: code, agentic, hybrid
  - Deployment: deployed, internal
  - Runtime: lambda, container, server
  - Language: typescript, javascript, php, python
```
❌ **Portability test: FAIL**
- "TMP projects" is organization-specific
- Taxonomy dimensions are TMP product features
- Cannot use in non-TMP projects
- **Verdict**: Should be in specs/2-strategy/ or specs/3-behaviors/
- **Remediation**: Move to specs/2-strategy/project-classification.spec.md

**Another violation example:**
```markdown
# specs/workspace/patterns.spec.md contains:

## Requirements
- [!] All Lambda functions follow standard structure
  - Handler in src/handlers/
  - Shared logic in src/lib/
  - Environment config in .env.lambda
```
❌ **Portability test: FAIL**
- "Lambda functions" is architecture-specific (not portable to container projects)
- **Verdict**: Product constraint, not workspace methodology
- **Remediation**: Move to specs/2-strategy/lambda-architecture.spec.md

## Failure Scenarios

**If product features in workspace/:**
- Audit reports ERROR
- Identifies: "Feature requirements in workspace/"
- Example: "User authentication behavior" found in workspace/patterns.spec.md
- Suggests: "Move to specs/3-behaviors/authentication.spec.md"
- Rationale: "Workspace = HOW we build, not WHAT we build"

**If product-specific taxonomy in workspace/:**
- Audit reports ERROR
- Identifies: "Product taxonomy definition in workspace/taxonomy.spec.md"
- Suggests: "taxonomy.spec.md should classify THIS project using taxonomy metaspec, not define product taxonomies"
- Remediation: "Move TMP taxonomy dimensions to specs/2-strategy/project-classification.spec.md"
- Rationale: "THIS is the exact issue found in project-governance"

**If architecture decisions in workspace/:**
- Audit reports WARNING or ERROR (depending on severity)
- Identifies: "Technology-specific constraints in workspace/"
- Example: "Lambda-specific patterns" or "React-specific conventions"
- Suggests: "Move to specs/2-strategy/architecture.spec.md"
- Rationale: "Architecture is product strategy, not portable methodology"

**If file explicitly included in taxonomy Workspace Scope:**
- Audit allows file even if borderline
- Reports: "Explicitly included in taxonomy.spec.md Workspace Scope section"
- Does not block
- Suggests: "Verify file still passes portability test"

## Implementation Notes

**Portability test indicators:**

**PASS indicators (portable methodology):**
- "spec-first", "TDD", "MSL format", "phases", "validation"
- "development principles", "naming conventions", "file patterns"
- "commit process", "branching strategy", "documentation standards"
- References to .livespec/, dist/, LiveSpec concepts

**FAIL indicators (product-specific):**
- Organization names (TMP, Acme Corp, etc.)
- Product names or features (authentication, payment processing, data pipeline)
- Technology stacks (Lambda, React, PostgreSQL) as requirements
- Domain terminology (lending, fintech, e-commerce)
- User-facing features or business logic

**Detection strategy:**
1. Parse file content
2. Extract key terms
3. Check against portability indicators
4. Cross-reference taxonomy.spec.md
5. Calculate confidence score (0-100%)
6. Report violations >70% confidence as ERROR
7. Report 40-70% as WARNING
8. Report <40% as INFO

**Remediation mapping:**
- Feature requirements → `specs/1-requirements/functional/`
- Feature behaviors → `specs/3-behaviors/`
- Architecture decisions → `specs/2-strategy/`
- Strategic outcomes → `specs/1-requirements/strategic/`

**Cross-reference with taxonomy:**
- Read `specs/workspace/taxonomy.spec.md` Workspace Scope section first
- If file explicitly listed in "What IS workspace", allow it
- If file matches "What is NOT workspace" examples, flag it
- Use taxonomy as project-specific override

**Historical context:**
This audit addresses real failure in project-governance where:
- taxonomy.spec.md contained TMP product taxonomy (Nature, Type, Deployment dimensions)
- This is product-specific classification system, not portable methodology
- Violated portability test ("Could I use TMP taxonomy in a React library?" → NO)
- Should have been in specs/2-strategy/project-classification.spec.md
- User reported: "taxonomy doesn't have the content it was designed to hold (what is workspace or not)"
- Missing Workspace Scope section prevented detection of this violation
