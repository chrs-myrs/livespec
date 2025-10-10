---
specifies: prompts/0-define/0b-define-problem.md
criticality: CRITICAL
failure_mode: Projects lack clear purpose and vision, leading to misaligned solutions
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Prompt Behavior: Define Purpose

## Requirements
- [!] Prompt guides AI agent to create purpose document that clearly articulates project vision and success criteria.
  - Prompt produces PURPOSE.md file at project root
  - Purpose document is minimal (<20 lines)
  - Contains "Why [Project] Exists" section (1-3 sentences)
  - Contains "What Success Looks Like" section (3-6 observable criteria)
  - No frontmatter (free-form markdown, not MSL spec)
  - Success criteria are observable and testable
  - User can explain the vision in their own words

## Prompt Outputs

- `PURPOSE.md` - Project vision and success criteria

## Validation

- Prompt produces PURPOSE.md file at project root
- Purpose document is minimal (<20 lines)
- Contains "Why Exists" section (1-3 sentences)
- Contains "Success Looks Like" section (3-6 criteria)
- No frontmatter (simple markdown)
- Success criteria are observable and testable
