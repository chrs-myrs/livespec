---
criticality: CRITICAL
failure_mode: Without prompt spec requirements, prompt specs lack essential structure for guiding AI agents
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
extends:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Prompt Specification Requirements

## Requirements

- [!] Prompt specifications define AI agent guidance with essential structural sections that ensure complete, actionable prompts.
  - Spec follows behavior.spec.md requirements (observable outcomes, validation criteria)
  - Spec located in `specs/3-behaviors/prompts/` folder
  - Spec uses `specifies:` frontmatter field pointing to actual prompt file path
  - File name matches prompt filename (e.g., `0a-setup-workspace.spec.md` specifies `0a-setup-workspace.md`)

  **Essential sections (required):**
  - **Context section requirement**: Spec requires generated prompt include Context explaining when to use prompt (conditions, triggers, phase alignment)
  - **Prerequisites section requirement**: Spec requires generated prompt include Prerequisites listing what must exist before running (minimal necessary context)
  - **Task section requirement**: Spec requires generated prompt include Task with step-by-step agent guidance
  - **Outputs section requirement**: Spec defines files/artifacts prompt creates (with paths and format specifications)
  - **Validation section requirement**: Spec defines how to verify prompt succeeded (specific, testable criteria)
  - **Success Criteria section requirement**: Spec defines what "done well" means for this prompt (quality indicators beyond correctness)
  - **Error Handling section requirement**: Spec requires generated prompt include Error Handling defining what to do when prerequisites missing or execution fails
  - **Constraints section requirement**: Spec requires generated prompt include Constraints defining what prompt should NOT do (scope boundaries, anti-patterns)

  **Optional sections (when applicable):**
  - **Examples section**: For complex patterns, spec may require generated prompt include Examples demonstrating good/bad patterns (show don't tell)
  - Prompt references appropriate templates when bootstrapping (e.g., `.livespec/templates/`)

## Prompt Spec Structure Pattern

**Minimal prompt spec** (after inheriting metaspec requirements):

```markdown
---
specifies: prompts/[phase]/[name].md
criticality: CRITICAL | IMPORTANT
failure_mode: [What fails without this prompt]
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Prompt Behavior: [Name]

## Requirements
- [!] Prompt guides [specific outcome].
  - [Specific files created with paths and formats]
  - [Specific agent behaviors]
  - [Specific validation performed]
  - [Reference to templates if applicable]

## Context

Use when:
- [Condition 1]
- [Condition 2]
- [Phase/workflow alignment]

## Prerequisites

- [prerequisite 1]
- [prerequisite 2]
- [prerequisite 3]

## Outputs

- `path/to/file1.ext` - [description, format: YAML with frontmatter]
- `path/to/file2.ext` - [description, format: markdown with MSL structure]

## Validation

- [Specific verification 1]
- [Expected outcome 2]
- [Testable criterion 3]

## Success Criteria

- [Quality indicator 1 beyond correctness]
- [Quality indicator 2]

## Error Handling

**If prerequisites missing:**
- [Recovery action or clear error message]

**If execution fails:**
- [Troubleshooting steps or fallback]

## Constraints

What this prompt should NOT do:
- ❌ [Anti-pattern 1]
- ❌ [Scope boundary]

## Examples (optional)

**Good pattern:**
[Example showing desired behavior]

**Anti-pattern:**
[Example showing what to avoid]
```

## Notes

**What NOT to include in individual prompt specs** (inherited from metaspec):
- ❌ "Prompt must have Context section" (metaspec requires this)
- ❌ "Prompt must have Task section" (metaspec requires this)
- ❌ "Prompt must include validation" (metaspec requires this)
- ❌ "Prompt must have Error Handling" (metaspec requires this)
- ❌ "Prompt must have Constraints" (metaspec requires this)
- ❌ "Prompt must include Success Criteria" (metaspec requires this)

**What to include in individual prompt specs** (prompt-specific):
- ✅ Specific files created with paths and format specifications
- ✅ Specific prerequisites for THIS prompt
- ✅ Specific validation criteria for THIS prompt
- ✅ Specific error handling for THIS prompt's failure scenarios
- ✅ Specific constraints for THIS prompt's scope
- ✅ Specific agent behaviors for THIS prompt
- ✅ References to templates used by THIS prompt
- ✅ Examples if pattern is complex (optional)

**Hierarchy**:
```
base.spec.md (MSL + LiveSpec frontmatter)
  ↓ governs
behavior.spec.md (observable outcomes, validation)
  ↓ governs
prompt.spec.md (THIS - prompt structural requirements)
  ↓ governs
[individual prompt specs] (specific outcomes only)
```

**Benefit**: Individual prompt specs focus on WHAT prompt achieves, not HOW prompt is structured. Structure inherited from metaspec.
