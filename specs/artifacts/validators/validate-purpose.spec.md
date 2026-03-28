---
type: validator
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without PURPOSE.md boundary validation, documents expand beyond minimal vision statements
governed-by:
  - specs/strategy/validation.spec.md
specifies: []
implements: 
---

# PURPOSE.md Boundary Validator

## Requirements
- [!] Script validates PURPOSE.md files stay within <20 content line limit and maintain correct structure.
  - Counts content lines (excludes blank lines and markdown headers)
  - FAIL if content lines exceed 20
  - WARN if content lines exceed 15 (approaching limit)
  - PASS if content lines within limit
  - Checks for required sections ("Why" and "What Success")
  - Detects prohibited patterns indicating misplaced content
  - Suggests routing for detected violations
  - No YAML frontmatter allowed (PURPOSE is not a spec)
  - Exit codes: 0 (valid), 1 (violations found)

## Pattern Detection

Script detects content that belongs elsewhere:
- Constraint/requirements language → constraints.spec.md
- Technical/architecture language → architecture.spec.md
- Process/workflow language → workflows.spec.md
- Bullet lists >6 items → outcomes.spec.md
- Extra sections beyond Why/What → extract to specs

## Usage

```bash
# Validate current project PURPOSE.md
./scripts/validate-purpose.sh

# Validate specific file
./scripts/validate-purpose.sh path/to/PURPOSE.md

# Expected output for valid file
# PASS: Content lines (7) within limit
# PASS: 'Why' section found
# PASS: 'Success' section found
# PURPOSE.md validation PASSED
```

## Integration

- Used by `dist/tests/structure/test_full_validation.sh` Section 10
- Referenced by `dist/prompts/utils/extract-purpose-overflow.md`
- Supports `dist/prompts/0-define/0c-define-problem.md` exit criteria
