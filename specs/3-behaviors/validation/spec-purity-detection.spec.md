---
criticality: IMPORTANT
failure_mode: Implementation code in specifications violates WHAT-not-HOW principle, creates maintenance burden, confuses specification purpose
governed-by:
  - dist/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/functional/msl-compliance.spec.md
guided-by:
  - specs/2-strategy/validation.spec.md
  - specs/2-strategy/msl-minimalism.spec.md
---

# Spec Purity Detection

## Requirements

- [!] System detects implementation code in specification files to enforce WHAT-not-HOW principle and maintain specification purity.
  - Scans Requirements (1-requirements/) and Strategy (2-strategy/) specs for code blocks
  - Identifies executable code patterns (Python, TypeScript, JavaScript, shell scripts, etc.)
  - Distinguishes between illustrative examples (acceptable) vs implementation details (violation)
  - Reports specifications violating WHAT-not-HOW principle
  - Provides guidance on moving code to implementation or simplifying to declarative requirements
  - Validates Behaviors (3-behaviors/) and Contracts (3-contracts/) may contain interface examples
  - Can run during Phase 1 (DESIGN) review or Phase 4 (EVOLVE) drift detection

## Validation

- Detector scans all .spec.md files in 1-requirements/ and 2-strategy/
- Detector identifies code fence blocks (```language)
- Detector analyzes block content for executable patterns
- Detector distinguishes Requirements/Strategy (strict) vs Behaviors/Contracts (lenient)
- Detector reports file path, line number, and code block excerpt
- Detector suggests remediation (remove, simplify, or move to Notes section)
- Detector output actionable (shows exact violation location)

## Examples

**Valid specification (WHAT, no HOW):**
```markdown
# specs/2-strategy/policy-resolution.spec.md

## Requirements
- [!] System caches composed policy sets for performance
  - Cache keyed by taxonomy dimension combination
  - Cache invalidated when policies/ directory modified
  - Cache miss triggers recomposition
```
✅ **WHAT-not-HOW**: Describes caching behavior without implementation

**Invalid specification (contains HOW):**
```markdown
# specs/2-strategy/policy-resolution.spec.md (lines 137-144)

## Requirements
- [!] System caches composed policy sets for performance
  - Implementation uses Python dict:

```python
cache_key = hash(f"{nature}|{type}|{deployment}|{runtime}|{language}")

Cache invalidation: Monitor policies/ directory mtime
if policies_dir_mtime > cache_mtime:
    clear_cache()
```
```
❌ **VIOLATION**: Contains Python implementation code
- **Location**: specs/2-strategy/policy-resolution.spec.md:137-144
- **Issue**: Specifies HOW to implement (Python dict, hash function, mtime check)
- **Should be**: "Cache keyed by taxonomy dimensions, invalidated on policy changes"
- **Remediation**: Remove code block, state requirement declaratively

**Acceptable illustrative example:**
```markdown
# specs/3-contracts/api/user-endpoint.spec.md

## Requirements
- [!] User endpoint returns JSON with required fields

Example response structure:
```json
{
  "id": "user-123",
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```
```
✅ **ACCEPTABLE**: JSON example in contract spec (shows interface, not implementation)
- Contracts (3-contracts/) can contain interface examples
- This shows WHAT the API returns, not HOW it's generated

**Acceptable configuration example:**
```markdown
# specs/2-strategy/architecture.spec.md

## Requirements
- [!] Project uses TypeScript with strict mode enabled

Example tsconfig.json settings:
```json
{
  "compilerOptions": {
    "strict": true,
    "esModuleInterop": true
  }
}
```
```
✅ **ACCEPTABLE**: Configuration example (declarative, not procedural)
- JSON config is declarative (settings, not logic)
- Shows required settings, not implementation steps

## Failure Scenarios

**If executable code in Requirements (1-requirements/):**
- Detector reports ERROR (highest severity)
- Identifies: "Implementation code in requirements specification"
- Example from project-governance: Python caching code in policy-resolution.spec.md
- Suggests: "Requirements must be declarative. Remove code, state requirement as observable behavior."
- Blocks commit if running in git hook

**If executable code in Strategy (2-strategy/):**
- Detector reports ERROR
- Identifies: "Implementation details in strategy specification"
- Suggests: "Strategy defines HOW (approach), not implementation. Simplify to architectural decision."
- Example: Python cache invalidation logic → "Cache invalidated when policies modified"
- Blocks commit if running in git hook

**If code in Behaviors but not interface examples:**
- Detector reports WARNING
- Identifies: "Procedural code in behavior specification"
- Suggests: "Behaviors specify WHAT outcomes, not HOW to achieve them. Consider if this belongs in implementation."
- Does not block (behaviors may need algorithmic descriptions)

**If interface examples in Contracts:**
- Detector allows (no report)
- Contracts (3-contracts/) expected to contain API examples, schemas, interface definitions
- These are declarative specifications of interfaces

**If examples in Notes section:**
- Detector allows (no report)
- Notes sections can contain illustrative code for clarity
- Not part of formal requirements

## Implementation Notes

**Code detection patterns:**

**Executable code indicators (flag as violations):**
- Function definitions: `def`, `function`, `const functionName =`
- Control flow: `if`, `else`, `for`, `while`, `switch`, `return`
- Variable operations: assignments (`=`, `+=`), mutations
- Imperative logic: step-by-step procedures

**Declarative patterns (allow):**
- JSON/YAML configuration (key-value pairs)
- API request/response examples
- Data schemas (TypeScript interfaces, JSON Schema)
- Command invocations showing usage (e.g., `git commit -m "..."`)
- Mermaid diagrams

**Detection strategy:**
1. Find code fence blocks: ` ```language`
2. Parse language identifier (python, typescript, javascript, bash, etc.)
3. Analyze block content for executable patterns
4. Check file location (Requirements/Strategy strict, Behaviors/Contracts lenient)
5. Check if in Notes section (allow)
6. Score violation confidence (0-100%)
7. Report >70% as ERROR, 40-70% as WARNING

**File-type specific rules:**
- **1-requirements/**: NO executable code (pure WHAT)
- **2-strategy/**: NO executable code (architectural HOW, not implementation HOW)
- **3-behaviors/**: Lenient (may need algorithm descriptions, but flag procedural code)
- **3-contracts/**: Allow (interface definitions expected)

**Remediation suggestions:**
- "Remove code block and state requirement declaratively"
- "Move implementation details to actual implementation file"
- "Simplify to observable behavior or constraint"
- "If this is an example, move to Notes section with 'Example:' prefix"

**Common violations and fixes:**

| Violation | Fix |
|-----------|-----|
| `if mtime > cache_mtime: clear()` | "Cache invalidated when policies modified" |
| `def compose_policies(dims): ...` | "System composes policies from taxonomy dimensions" |
| `for policy in policies: ...` | "All applicable policies included in composition" |
| Python dict operations | "Cache keyed by dimension combination" |
| Loop logic | "System processes all items meeting criteria" |

**Historical context:**
This detector addresses issue found in project-governance:
- User reported: "there is also code in the specs which makes no sense"
- Found: specs/2-strategy/policy-resolution.spec.md:137-144 contains Python caching implementation
- Violation: Strategy spec should describe approach, not Python code
- Example code:
  ```python
  cache_key = hash(f"{nature}|{type}|{deployment}|{runtime}|{language}")
  if policies_dir_mtime > cache_mtime:
      clear_cache()
  ```
- Should be: "Cache keyed by taxonomy dimensions, invalidated when policies directory modified"
- This is HOW violation in strategy layer (implementation details instead of architectural approach)
