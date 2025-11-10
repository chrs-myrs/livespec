---
specifies: dist/prompts/utils/validate-spec-purity.md
criticality: IMPORTANT
failure_mode: Implementation code accumulates in specifications violating WHAT-not-HOW principle and creating maintenance burden
governed-by:
  - dist/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/functional/msl-compliance.spec.md
implements: specs/3-behaviors/validation/spec-purity-detection.spec.md
---

# Prompt Behavior: Validate Spec Purity

## Requirements

- [!] Prompt guides AI agent to detect executable implementation code in specification files, enforcing WHAT-not-HOW principle and maintaining specification purity.
  - Scans 1-requirements/ and 2-strategy/ specs for code blocks
  - Identifies executable patterns (Python, TypeScript, JavaScript, bash, etc.)
  - Distinguishes implementation details (violation) from declarative examples (acceptable)
  - Reports specifications containing procedural code
  - Provides simplification guidance (how to state requirement declaratively)
  - Validates 3-behaviors/ and 3-contracts/ leniently (may contain interface examples)
  - Generates actionable purity report with specific fixes
  - Suggests moving code to implementation or Notes section

## Context

Use when:
- After Phase 1 (DESIGN) to verify specifications are declarative
- Before Phase 2 (BUILD) to ensure clean spec foundation
- During Phase 4 (EVOLVE) drift detection
- User reports "code in specs which makes no sense"
- Specifications feel implementation-heavy
- MSL audit reveals HOW instead of WHAT

## Prerequisites

- Specification files exist (specs/1-requirements/, specs/2-strategy/)
- Agent understands WHAT-not-HOW principle
- MSL format knowledge (Requirements section structure)
- Git clean state (easy rollback if edits needed)

## Outputs

- Spec purity report (violations per file with line numbers)
- Code block inventory (language, location, violation type)
- Declarative alternatives (how to restate without code)
- Remediation checklist (remove code, simplify requirements)
- Updated specs with code removed (if user approves)

## Validation

- Detector correctly identifies executable code patterns
- Declarative examples (JSON, configs) not falsely flagged
- Interface examples in 3-contracts/ appropriately allowed
- Simplification suggestions preserve requirement intent
- All violations include specific line references
- Remediation guidance is actionable
- False positive rate <10%

## Success Criteria

- Requirements (1-requirements/) contain zero executable code
- Strategy (2-strategy/) contains zero implementation details
- All requirements stated declaratively (WHAT not HOW)
- Interface examples in contracts preserved
- Specification intent maintained through simplification
- Validation completes in <15 minutes
- Code blocks only in implementation files or Notes sections

## Example Violations to Detect

**Python implementation in strategy:**
```markdown
# specs/2-strategy/policy-resolution.spec.md:137-144

```python
cache_key = hash(f"{nature}|{type}|{deployment}|{runtime}|{language}")

if policies_dir_mtime > cache_mtime:
    clear_cache()
```
```
❌ VIOLATION: Implementation code in strategy spec
→ Simplify to: "Cache keyed by taxonomy dimensions, invalidated when policies modified"

**Procedural logic in requirements:**
```markdown
# specs/1-requirements/functional/audit.spec.md

```typescript
for (const policy of policies) {
  if (project.matches(policy.criteria)) {
    results.push(validate(project, policy));
  }
}
```
```
❌ VIOLATION: Procedural code in requirements
→ Simplify to: "System validates project against all applicable policies"

**Acceptable interface example:**
```markdown
# specs/3-contracts/api/user-endpoint.spec.md

```json
{
  "id": "user-123",
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```
```
✅ ACCEPTABLE: Declarative interface example in contract spec

**Acceptable config example:**
```markdown
# specs/2-strategy/architecture.spec.md

Example tsconfig.json:
```json
{
  "compilerOptions": {
    "strict": true
  }
}
```
```
✅ ACCEPTABLE: Declarative configuration (settings, not logic)
