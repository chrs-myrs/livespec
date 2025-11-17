---
implements: specs/3-artifacts/prompts/utils-validate-spec-purity.spec.md
implements: specs/3-behaviors/validation/spec-purity-detection.spec.md
derives-from:
  - dist/guides/msl-minimalism.md
  - specs/workspace/patterns.spec.md
---

# Validate Spec Purity

**Purpose**: Detect executable implementation code in specifications to enforce WHAT-not-HOW principle and maintain MSL purity.

**When to use:**
- After Phase 1 (DESIGN) to verify declarative specs
- Before Phase 2 (BUILD) to ensure clean foundation
- During Phase 4 (EVOLVE) drift detection
- User reports "code in specs which makes no sense"
- Specifications feel implementation-heavy

**What it validates:**
1. **Code blocks in requirements/strategy**: Executable patterns (Python, TypeScript, JavaScript, bash)
2. **WHAT vs HOW violations**: Procedural code in declarative specs
3. **Acceptable patterns**: Declarative examples (JSON, YAML, configs) and interface definitions

---

## Validation Process

### Step 1: Run Automated Detection

```bash
bash scripts/detect-code-in-specs.sh
```

The script scans for executable patterns:
- Function definitions (`def`, `function`, `const =`)
- Control flow (`if`, `for`, `while`, `return`)
- Procedural operations (assignments, mutations, loops)

### Step 2: Review Flagged Violations

For each violation:
1. Read code block in context
2. Determine if implementation detail (HOW) or requirement (WHAT)
3. Consider if this belongs in implementation or Notes section

### Step 3: Simplify to Declarative Requirements

**Conversion patterns:**

| Procedural Code (HOW) | Declarative Requirement (WHAT) |
|-----------------------|----------------------------------|
| `cache_key = hash(dims)` | "Cache keyed by taxonomy dimensions" |
| `if mtime > cache: clear()` | "Cache invalidated when policies modified" |
| `for policy in policies: validate()` | "System validates all applicable policies" |
| `def compose(dims): ...` | "System composes policies from dimensions" |

### Step 4: Move or Remove Code

**Decision matrix:**

| Code Type | Violation? | Action |
|-----------|------------|--------|
| Python implementation | ❌ YES | Remove, state declaratively |
| TypeScript procedures | ❌ YES | Remove, simplify to WHAT |
| JSON config example | ✅ NO | Keep (declarative) |
| API response example | ✅ NO | Keep if in 3-contracts/ |
| Mermaid diagram | ✅ NO | Keep (visualization) |

---

## Examples from Real Failures

### ❌ VIOLATION: Python Implementation in Strategy

**File**: `specs/2-strategy/policy-resolution.spec.md:137-144`

```python
cache_key = hash(f"{nature}|{type}|{deployment}|{runtime}|{language}")

Cache invalidation: Monitor policies/ directory mtime
if policies_dir_mtime > cache_mtime:
    clear_cache()
```

**Problem**: Specifies HOW to implement (Python dict, hash function, mtime check)

**Fix**: Remove code, state requirement declaratively:
```markdown
## Requirements
- [!] System caches composed policy sets for performance
  - Cache keyed by taxonomy dimension combination
  - Cache invalidated when policies/ directory modified
  - Cache miss triggers recomposition
```

### ✅ ACCEPTABLE: Interface Example

**File**: `specs/3-contracts/api/user-endpoint.spec.md`

```json
{
  "id": "user-123",
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

**Reason**: Declarative interface definition (shows WHAT, not HOW)
**Location**: 3-contracts/ (interfaces expected)

---

## Common Code-in-Specs Violations

**Where code doesn't belong:**
- ❌ `specs/1-requirements/` - Pure WHAT (strategic outcomes)
- ❌ `specs/2-strategy/` - Architectural HOW (not implementation HOW)

**Where examples are acceptable:**
- ✅ `specs/3-contracts/` - Interface definitions (API schemas, data contracts)
- ✅ Notes sections - Illustrative examples for clarity
- ✅ Validation sections - Test criteria examples

**MSL Principle**: Specifications must justify their existence at the highest level of abstraction.

---

## Expected Outcomes

- Requirements (1-requirements/) contain zero executable code
- Strategy (2-strategy/) contains zero implementation details
- All requirements stated declaratively (WHAT not HOW)
- Interface examples in contracts preserved
- Specification intent maintained through simplification

---

## Historical Context

This validation prevents the exact issue found in project-governance where:
- User reported: "there is also code in the specs which makes no sense"
- Found: `specs/2-strategy/policy-resolution.spec.md:137-144` contains Python caching implementation
- Violation: Strategy spec should describe approach, not Python code
- Should be: "Cache keyed by taxonomy dimensions, invalidated when policies modified"
- This is HOW violation in strategy layer (implementation details instead of architectural approach)
