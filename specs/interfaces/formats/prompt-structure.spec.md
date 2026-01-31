---
criticality: IMPORTANT
failure_mode: Without consistent prompt structure, AI agents can't reliably execute prompts, reducing methodology effectiveness
governed-by:
  - .livespec/standard/metaspecs/contract.spec.md
supports:
  - specs/artifacts/prompts/
---

# Prompt Structure Contract

## Requirements

### File Structure

- [!] Prompts follow consistent structure enabling reliable AI execution
  - YAML frontmatter with prompt metadata
  - H1 title describing prompt purpose
  - Clear sections for context, instructions, and expected outputs
  - Markdown formatting for readability

### Frontmatter Contract

- [!] Prompt frontmatter provides execution context
  - `implements`: Path to spec this prompt implements (optional)
  - `phase`: Phase number (0-4) or "utils" (required)
  - `estimated_time`: Human-readable duration (optional)
  - `prerequisites`: List of required preconditions (optional)

### Content Sections

- [!] Prompt content organized for AI comprehension
  - Purpose section explaining when to use this prompt
  - Prerequisites section listing required context
  - Step-by-step instructions with clear actions
  - Expected outputs describing deliverables
  - "Next Step" section pointing to follow-up prompts

### Instruction Style

- [!] Instructions written for AI agent execution
  - Imperative voice ("Create", "Verify", "Update")
  - Specific actions, not vague guidance
  - Decision trees for conditional paths
  - Clear completion criteria

## Validation

- [ ] Frontmatter includes `phase` field
- [ ] H1 title exists and is descriptive
- [ ] Instructions use imperative voice
- [ ] Expected outputs clearly defined
- [ ] "Next Step" section present (for phase prompts)
