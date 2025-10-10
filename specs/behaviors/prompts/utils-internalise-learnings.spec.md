---
derives-from:
  - specs/strategy/architecture.spec.md
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
specifies:
  - prompts/generated/internalise-learnings.md (when generated)
generated_by:
  - prompts/utils/generate-internalise-learnings.md
criticality: IMPORTANT
failure_mode: Without learning capture, mistakes repeat and valuable insights from conversations are lost
---

# Internalise Learnings Prompt

## Requirements
- [!] Generated internalise-learnings.md prompt captures conversation-specific learnings using ultrathink, scanning current session for corrections, clarifications, and discoveries to update project specifications immediately.
  - Prompt uses ultrathink for pattern extraction from conversation
  - Scans conversation history for user corrections
  - Identifies clarification requests and ambiguities
  - Notes incorrect assumptions that were corrected
  - Finds patterns that emerged during work
  - Spots knowledge gaps that caused issues
  - Classifies learnings by target spec location:
    - workspace/ (process improvements)
    - strategy/ (architectural insights)
    - behaviors/ (new behaviors discovered)
    - mission/ (constraints or outcomes refined)
  - Proposes specific spec file updates with locations
  - Suggests new specs to create if needed
  - Documents corrections to existing specifications
  - Provides implementation plan with actual file edits
  - Prevents repeated mistakes by codifying learnings
  - Focuses on actionable documentation updates

## Validation
- Ultrathink block analyzes THIS conversation (not pre-filled examples)
- Learnings extracted are specific to current session
- Spec update locations match project structure
- Proposed changes are actionable (specific files, specific edits)
- Classification aligns with project's spec taxonomy
- Implementation plan includes validation steps
- Graceful degradation if ultrathink unsupported by agent
