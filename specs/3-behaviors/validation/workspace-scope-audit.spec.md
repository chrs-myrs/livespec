---
criticality: IMPORTANT
failure_mode: Product-specific content in workspace/ blurs operating context vs deliverable boundary, confuses agents about workspace purpose
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

- [!] System audits workspace/ directory to ensure all files define operating context (not product deliverables), enforcing the "about vs in" boundary.
  - Applies "about vs in" test to each workspace/ file: "Is this ABOUT the workspace or IN the workspace?"
  - Reports files that fail the test (product deliverables in workspace/)
  - Validates workspace/ files against taxonomy.spec.md Workspace Scope declarations
  - Checks for common violations (feature requirements, product behaviors, product strategy in workspace/)
  - Provides remediation guidance (where file should move: 1-requirements/, 2-strategy/, 3-behaviors/)
  - Can run on-demand or during Phase 4 (EVOLVE) drift detection
  - Respects taxonomy.spec.md explicit inclusions/exclusions

## Validation

- Audit scans all files in specs/workspace/ directory
- Audit applies "about vs in" test to each file
- Audit detects deliverable indicators (feature names, product terminology, API definitions)
- Audit cross-references with taxonomy.spec.md Workspace Scope section
- Audit reports violations with specific relocation suggestions
- Audit output actionable (tells user where to move file)
- Audit can be run non-destructively (report only, no moves)

## Examples

**Valid workspace/ file (operating context):**
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
✅ **About vs In test: PASS (ABOUT)**
- "Spec-first" describes HOW we operate
- MSL format is an operating convention
- This is meta-governance - ABOUT the workspace
- **Verdict**: Correctly in workspace/

**Invalid workspace/ file (product deliverable):**
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
```
❌ **About vs In test: FAIL (IN)**
- "TMP projects" describes WHAT we deliver, not HOW we operate
- Taxonomy dimensions are product features
- This is a deliverable - IN the workspace
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
❌ **About vs In test: FAIL (IN)**
- "Lambda functions" describes product architecture, not operating context
- **Verdict**: Product constraint, not workspace
- **Remediation**: Move to specs/2-strategy/lambda-architecture.spec.md

## Failure Scenarios

**If product features in workspace/:**
- Audit reports ERROR
- Identifies: "Feature requirements in workspace/"
- Example: "User authentication behavior" found in workspace/patterns.spec.md
- Suggests: "Move to specs/3-behaviors/authentication.spec.md"
- Rationale: "Workspace = operating context, not WHAT we build"

**If product-specific taxonomy in workspace/:**
- Audit reports ERROR
- Identifies: "Product taxonomy definition in workspace/taxonomy.spec.md"
- Suggests: "taxonomy.spec.md should classify THIS project, not define product taxonomies"
- Remediation: "Move product taxonomy to specs/2-strategy/project-classification.spec.md"
- Rationale: "THIS is the exact issue found in project-governance"

**If architecture decisions in workspace/:**
- Audit reports WARNING or ERROR (depending on severity)
- Identifies: "Technology-specific constraints in workspace/"
- Example: "Lambda-specific patterns" or "React-specific conventions"
- Suggests: "Move to specs/2-strategy/architecture.spec.md"
- Rationale: "Architecture is product strategy, not operating context"

**If file explicitly included in taxonomy Workspace Scope:**
- Audit allows file even if borderline
- Reports: "Explicitly included in taxonomy.spec.md Workspace Scope section"
- Does not block
- Suggests: "Verify file describes operating context"

## Implementation Notes

**"About vs In" test indicators:**

**ABOUT indicators (operating context - valid for workspace/):**
- Development principles (spec-first, TDD, MSL format)
- Operating conventions (naming, format, structure)
- Agent behaviour rules (how agents interact with workspace)
- Human workflow processes (how humans interact with workspace)
- Context building rules (AGENTS.md structure, compression)
- Classification of THIS project (not product taxonomies)

**IN indicators (deliverables - should NOT be in workspace/):**
- Product names or features (authentication, payment processing)
- Technology stacks as requirements (Lambda, React, PostgreSQL)
- Domain terminology (lending, fintech, e-commerce)
- User-facing features or business logic
- API definitions or data contracts
- Organisation-specific taxonomies (TMP, Acme Corp)

**Detection strategy:**
1. Parse file content
2. Extract key terms
3. Check against "about vs in" indicators
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
- This was a product-specific classification system, not operating context
- Failed the "about vs in" test ("Is TMP taxonomy ABOUT the workspace?" → NO)
- Should have been in specs/2-strategy/project-classification.spec.md
- User reported: "taxonomy doesn't have the content it was designed to hold"
- Missing Workspace Scope section prevented detection of this violation
