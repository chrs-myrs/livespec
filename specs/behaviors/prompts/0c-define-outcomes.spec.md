---
specifies: prompts/0-define/0c-define-outcomes.md
criticality: CRITICAL
failure_mode: Projects lack high-level requirements, leading to disconnected features
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Prompt Behavior: Define Outcomes

## Requirements
- [!] Prompt guides AI agent to create outcomes specification that defines high-level project requirements derived from PURPOSE.md.
  - Prompt produces specs/mission/outcomes.spec.md file
  - Outcomes spec follows MSL format
  - Contains 3-6 high-level outcome requirements
  - Each outcome traces to PURPOSE.md success criteria
  - Each outcome has validation criteria
  - Outcomes are high-level (not detailed behaviors)
  - No implementation details included

## Prompt Outputs

- `specs/mission/outcomes.spec.md` - High-level requirements specification

## Validation

- Prompt produces specs/mission/outcomes.spec.md file
- Outcomes spec follows MSL format
- Contains 3-6 high-level outcomes
- Each outcome derives from PURPOSE.md
- Each outcome has testable validation criteria
- Outcomes are appropriately high-level (not feature-level)
