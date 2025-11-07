---
governed-by:
  - specs/workspace/constitution.spec.md
  - dist/standard/metaspecs/behavior.spec.md
criticality: CRITICAL
failure_mode: Without purpose traceability validation, artifacts exist without business justification, breaking the Value Hierarchy from PURPOSE → requirements → implementation
---

# Purpose Traceability Validation

## Requirements
- [!] System validates that every artifact traces back to PURPOSE.md through specification chain.
  - PURPOSE.md exists at repository root (foundation of Value Hierarchy)
  - Every spec has `derives-from:` OR `governed-by:` creating path to PURPOSE
  - No orphaned specs (specs without upstream traceability)
  - No orphaned implementations (files without specs without purpose)
  - Validation runs as part of full test suite
  - Exit code 0 if pyramid complete, 1 if broken
  - Clear error messages showing which artifacts lack purpose traceability

## Value Hierarchy Structure
- [!] Value Hierarchy defines hierarchical traceability from purpose to implementation.

  **Five levels**:
  ```
  Level 1: PURPOSE.md
      ↓ (why)
  Level 2: specs/1-requirements/ (strategic outcomes, constraints)
      ↓ (derives-from)
  Level 3: specs/2-strategy/ (architectural approach)
      ↓ (guided-by)
  Level 4: specs/3-behaviors/ + specs/3-contracts/ (observable outcomes, interfaces)
      ↓ (implements/satisfies)
  Level 5: Implementation (code, documentation, configs)
  ```

  **Orthogonal governance**:
  - `specs/workspace/` applies across all levels (HOW we work)
  - Workspace specs governed-by PURPOSE.md

## Traceability Rules
- [!] Every spec must establish purpose traceability through frontmatter.
  - **Specs in 1-requirements/**: `derives-from: PURPOSE.md`
  - **Specs in 2-strategy/**: `derives-from: [specs/1-requirements/...]`
  - **Specs in 3-behaviors/**: `satisfies: [specs/1-requirements/...]` AND `guided-by: [specs/2-strategy/...]` (dual linkage)
  - **Specs in 3-contracts/**: `satisfies: [specs/3-behaviors/...]` (parameters link to behaviors)
  - **Specs in workspace/**: `governed-by: PURPOSE.md` (applies everywhere)
  - At least ONE upstream link required (derives-from, governed-by, satisfies, or guided-by)

## Validation Algorithm
- [!] Validation traverses dependency graph from implementations to PURPOSE.

  **For each spec file**:
  1. Extract frontmatter (`derives-from`, `governed-by`, `satisfies`, `guided-by`)
  2. Verify at least one upstream reference exists
  3. Follow references recursively to PURPOSE.md
  4. Report if no path to PURPOSE found

  **For each implementation file**:
  1. Check for corresponding spec (scripts/check-requires-spec.sh)
  2. If spec exists, verify spec has purpose traceability
  3. Report if implementation → spec → PURPOSE chain broken

## Example Valid Chains

### Software Project
```yaml
# PURPOSE.md
"Build secure API for user authentication"

# specs/1-requirements/strategic/outcomes.spec.md
derives-from:
  - PURPOSE.md
"Users can authenticate securely"

# specs/2-strategy/architecture.spec.md
derives-from:
  - specs/1-requirements/strategic/outcomes.spec.md
"OAuth 2.0 + JWT architecture"

# specs/3-behaviors/authentication.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
"System authenticates users via OAuth"

# src/auth/oauth-handler.ts
implements: specs/3-behaviors/authentication.spec.md
```

**Validation**: oauth-handler.ts → authentication.spec.md → outcomes.spec.md → PURPOSE.md ✓

### Documentation Project
```yaml
# PURPOSE.md
"Document TMP architecture for developer onboarding"

# specs/1-requirements/strategic/outcomes.spec.md
derives-from:
  - PURPOSE.md
"Developers can understand TMP architecture within 2 hours"

# specs/3-behaviors/documentation/architecture-docs.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
"Architecture documentation covers: overview, components, data flow"

# docs/architecture/README.md
implements: specs/3-behaviors/documentation/architecture-docs.spec.md
```

**Validation**: docs/architecture/README.md → architecture-docs.spec.md → outcomes.spec.md → PURPOSE.md ✓

### Workspace Spec
```yaml
# PURPOSE.md
"Build secure API"

# specs/workspace/patterns.spec.md
governed-by:
  - PURPOSE.md
"All specs follow MSL format"
```

**Validation**: patterns.spec.md → PURPOSE.md ✓ (orthogonal governance)

## Example Invalid Chains

### Orphaned Spec (No Upstream)
```yaml
# specs/3-behaviors/caching.spec.md
# (Missing: derives-from, governed-by, satisfies, or guided-by)
```

**Validation**: caching.spec.md → ❌ NO PATH TO PURPOSE

**Fix**: Add `satisfies: specs/1-requirements/...` linking to requirement

### Broken Chain (Missing Parent)
```yaml
# specs/3-behaviors/authentication.spec.md
satisfies:
  - specs/1-requirements/security.spec.md  # Does not exist!
```

**Validation**: authentication.spec.md → security.spec.md → ❌ FILE NOT FOUND

**Fix**: Create security.spec.md or update reference to existing requirement

### Implementation Without Spec
```yaml
# src/cache/redis-client.ts
# (No spec file exists)
```

**Validation**: redis-client.ts → ❌ NO SPEC FOUND

**Fix**: Create specs/3-behaviors/caching.spec.md implementing requirement

## Error Messages
- [!] Validation provides actionable error messages for broken chains.
  - File path where chain breaks
  - Expected upstream reference (missing frontmatter)
  - Suggested fixes (which frontmatter to add)
  - Complete path attempted (showing where break occurred)
  - Count of broken chains found

**Example error output**:
```
ERROR: Spec without purpose traceability
  File: specs/3-behaviors/caching.spec.md
  Issue: No upstream references found
  Missing: One of [derives-from, governed-by, satisfies, guided-by]
  Fix: Add frontmatter linking to requirement or strategy spec

ERROR: Broken reference chain
  File: specs/3-behaviors/authentication.spec.md
  Satisfies: specs/1-requirements/security.spec.md
  Issue: Referenced file does not exist
  Fix: Create security.spec.md OR update reference to existing file

ERROR: Implementation without spec
  File: src/cache/redis-client.ts
  Issue: No spec found for implementation
  Fix: Create specs/3-behaviors/caching.spec.md
```

## Integration Points
- [!] Purpose traceability validation integrates with existing validation suite.
  - Called by `tests/structure/test_full_validation.sh` (Section 9)
  - Blocks pre-commit if pyramid broken (optional via hook)
  - Can be run standalone: `scripts/validate-value-pyramid.sh`
  - Runs after spec-implementation validation (builds on existing checks)

## Validation
- Script exists at `scripts/validate-value-pyramid.sh`
- Script has execute permission (chmod +x)
- Exit code 0 when all artifacts trace to PURPOSE
- Exit code 1 when orphaned artifacts found
- Error messages show file, missing reference, and fix
- Script integrated into `tests/structure/test_full_validation.sh`
- Reports summary (X specs checked, Y implementations, Z broken chains)
- Validation covers all spec types (requirements, strategy, behaviors, contracts, workspace)
- PURPOSE.md existence verified first (validation fails immediately if missing)
