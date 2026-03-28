---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Product-specific content accumulates in workspace/ blurring operating context vs deliverable boundary
governed-by:
  - dist/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/features/workspace-governance.spec.md
specifies: dist/prompts/utils/audit-workspace-scope.md
implements: specs/features/validation/workspace-scope-audit.spec.md
---

# Prompt Behavior: Audit Workspace Scope

## Requirements

- [!] Prompt guides AI agent to apply "about vs in" test to all workspace/ files, detecting deliverable content that violates workspace operating context principle.
  - Reads specs/workspace/taxonomy.spec.md Workspace Scope section first
  - Applies "about vs in" test to each workspace/ file: "Is this ABOUT the workspace or IN the workspace?"
  - Scans file content for deliverable indicators (feature names, product terminology, API definitions)
  - Cross-references files against taxonomy declared workspace scope
  - Reports violations with specific line numbers and examples
  - Suggests relocations (foundation/, 2-strategy/, features/)
  - Generates actionable audit report showing what to move where
  - Preserves operating context while removing deliverables

## Context

Use when:
- After Phase 0 (DEFINE) to verify workspace setup
- Before releases (ensure clean workspace boundary)
- Monthly maintenance (detect scope creep)
- After adding files to workspace/ (verify "about vs in" test)
- User reports confusion about workspace vs product boundary

## Prerequisites

- workspace/ directory exists with specs
- taxonomy.spec.md exists with Workspace Scope section
- Agent understands "about vs in" test concept
- Git clean state (easy rollback if relocations needed)

## Outputs

- Workspace scope audit report ("about vs in" test results per file)
- Violation list (deliverable content in workspace/)
- Relocation recommendations (where files should move)
- Updated taxonomy.spec.md if workspace scope section incomplete
- Checklist of remediation actions

## Validation

- Audit correctly applies "about vs in" test
- Violations are genuine (not false positives)
- Relocation suggestions preserve functionality
- Taxonomy Workspace Scope accurately reflects current state
- Operating context files correctly pass audit
- Deliverable files correctly flagged
- Recommendations include specific line references

## Success Criteria

- All workspace/ files pass "about vs in" test (are ABOUT the workspace)
- taxonomy.spec.md Workspace Scope section accurate and complete
- Deliverable content relocated to appropriate specs/ directories
- Workspace boundary clear to agents
- Audit completes in <20 minutes

## Example Violations to Detect

**Product taxonomy in workspace/:**
```markdown
# specs/workspace/taxonomy.spec.md

## TMP Project Classification
- Nature: library, application
- Type: code, agentic, hybrid
```
❌ Fail: TMP-specific taxonomy (deliverable content, not operating context)
→ Move to: specs/strategy/project-classification.spec.md

**Architecture constraints in workspace/:**
```markdown
# specs/workspace/patterns.spec.md

## Requirements
- [!] All Lambda functions use handler pattern
```
❌ Fail: Lambda-specific (product architecture, not operating context)
→ Move to: specs/strategy/lambda-architecture.spec.md

**Valid workspace content:**
```markdown
# specs/workspace/constitution.spec.md

## Requirements
- [!] All development follows spec-first principle
```
✅ Pass: Spec-first describes HOW we operate (operating context)
