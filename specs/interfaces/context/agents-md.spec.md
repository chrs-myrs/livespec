---
type: contract
category: interfaces
fidelity: full-detail
criticality: CRITICAL
failure_mode: Without consistent AGENTS.md format, AI agents receive malformed context, reducing effectiveness and causing methodology violations
governed-by: []
derives-from:
  - specs/features/context-generation.spec.md
supports: []
---

# AGENTS.md Format Contract

## Requirements

### File Requirements

- [!] AGENTS.md is the primary AI agent context file with specific format requirements
  - Located at project root (AGENTS.md)
  - No YAML frontmatter (clean context for token efficiency)
  - Edit warning as HTML comment at top (not frontmatter)
  - Size within the root ceiling the project declares in `specs/workspace/context-architecture.spec.md`

### Content Structure

- [!] AGENTS.md organized for optimal AI consumption
  - START section (30-40%): Critical protocols, enforcement, the project's own constraints, what to do first
  - MIDDLE section (40%): Core principles, patterns, workflows
  - END section (20-30%): Reference library, navigation pointers

### Required Sections

- [!] Specific sections must be present for methodology adherence
  - Summary (brief project/methodology overview)
  - Critical warnings/protocols (spec-first enforcement)
  - The project's constraints
  - Core principles (in priority order)
  - Folder organization (decision tests)
  - Reference library (pointers to detailed content)
  - LiveSpec method sections (the five phases, phases vs layers, multi-domain organisation, session completion) appear only where the project declares them

### Context Tree Integration

- [!] Where the project declares ctxt/ files, root AGENTS.md routes to them
  - "When to Load Sub-Agents" section with decision triggers, absent when no ctxt/ files are declared
  - Load triggers match natural user language
  - Conservative loading guidance (1-2 sub-agents typical)
  - Paths to ctxt/ sub-agents for specialized contexts

### Regeneration Markers

- [!] Generated files marked for regeneration governance
  - Edit warning at top (HTML comment or plain text)
  - Source attribution (generated from specs/workspace/)
  - Regeneration command reference
  - Footer names the accepted LiveSpec version, and omits it when `project.yaml` records none

## Validation

- [ ] File exists at project root as AGENTS.md
- [ ] No YAML frontmatter present
- [ ] Edit warning present at top
- [ ] Summary section exists
- [ ] Critical warnings section exists
- [ ] The project's constraints appear in the START section
- [ ] Reference library section exists
- [ ] Size within the declared root ceiling
- [ ] "When to Load Sub-Agents" section present if and only if ctxt/ files are declared
