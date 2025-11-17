---
specifies: dist/prompts/utils/audit-workspace-scope.md
criticality: IMPORTANT
failure_mode: Product-specific content accumulates in workspace/ breaking portability and confusing agents
governed-by:
  - dist/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/workspace-governance.spec.md
implements: specs/3-behaviors/validation/workspace-scope-audit.spec.md
---

# Prompt Behavior: Audit Workspace Scope

## Requirements

- [!] Prompt guides AI agent to apply portability test to all workspace/ files, detecting product-specific content that violates workspace methodology principle.
  - Reads specs/workspace/taxonomy.spec.md Workspace Scope section first
  - Applies portability test to each workspace/ file: "Could I use this in ANY project?"
  - Scans file content for product-specific indicators (feature names, product terminology, domain constraints)
  - Cross-references files against taxonomy declared workspace scope
  - Reports violations with specific line numbers and examples
  - Suggests relocations (1-requirements/, 2-strategy/, 3-behaviors/)
  - Generates actionable audit report showing what to move where
  - Preserves portable methodology while removing product specifics

## Context

Use when:
- After Phase 0 (DEFINE) to verify workspace setup
- Before releases (ensure clean workspace boundary)
- Monthly maintenance (detect scope creep)
- After adding files to workspace/ (verify portability)
- User reports confusion about workspace vs product boundary
- Preparing project for methodology reuse in other projects

## Prerequisites

- workspace/ directory exists with specs
- taxonomy.spec.md exists with Workspace Scope section
- Agent understands portability test concept
- Git clean state (easy rollback if relocations needed)

## Outputs

- Workspace scope audit report (portability test results per file)
- Violation list (product-specific content in workspace/)
- Relocation recommendations (where files should move)
- Updated taxonomy.spec.md if workspace scope section incomplete
- Checklist of remediation actions

## Validation

- Audit correctly applies portability test
- Violations are genuine (not false positives)
- Relocation suggestions preserve functionality
- Taxonomy Workspace Scope accurately reflects current state
- Portable files correctly pass audit
- Product-specific files correctly flagged
- Recommendations include specific line references

## Success Criteria

- All workspace/ files pass portability test
- taxonomy.spec.md Workspace Scope section accurate and complete
- Product-specific content relocated to appropriate specs/ directories
- Workspace boundary clear to agents
- Methodology reusable in other projects
- Audit completes in <20 minutes

## Example Violations to Detect

**Product taxonomy in workspace/:**
```markdown
# specs/workspace/taxonomy.spec.md

## TMP Project Classification
- Nature: library, application
- Type: code, agentic, hybrid
```
❌ Fail: TMP-specific taxonomy (product feature, not portable methodology)
→ Move to: specs/2-strategy/project-classification.spec.md

**Architecture constraints in workspace/:**
```markdown
# specs/workspace/patterns.spec.md

## Requirements
- [!] All Lambda functions use handler pattern
```
❌ Fail: Lambda-specific (architecture constraint, not portable)
→ Move to: specs/2-strategy/lambda-architecture.spec.md

**Valid workspace content:**
```markdown
# specs/workspace/constitution.spec.md

## Requirements
- [!] All development follows spec-first principle
```
✅ Pass: Spec-first applies to ANY project (portable methodology)
