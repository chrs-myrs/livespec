---
type: contract
category: interfaces
fidelity: full-detail
criticality: CRITICAL
failure_mode: Without consistent AGENTS.md format, AI agents receive malformed context, reducing effectiveness and causing methodology violations
governed-by: []
derives-from:
  - specs/features/context-generation.spec.md
supports:
  - specs/workspace/context-architecture.spec.md
---

# AGENTS.md Format Contract

## Requirements

### File Requirements

- [!] AGENTS.md is the primary AI agent context file with specific format requirements
  - Located at project root (AGENTS.md)
  - No YAML frontmatter (clean context for token efficiency)
  - Edit warning as HTML comment at top (not frontmatter)
  - Size budget: 20-30KB for root file

### Content Structure

- [!] AGENTS.md organized for optimal AI consumption
  - START section (30-40%): Critical protocols, enforcement, what to do first
  - MIDDLE section (40%): Core principles, patterns, workflows
  - END section (20-30%): Reference library, navigation pointers

### Required Sections

- [!] Specific sections must be present for methodology adherence
  - Summary (brief project/methodology overview)
  - Critical warnings/protocols (spec-first enforcement)
  - Core principles (in priority order)
  - Folder organization (decision tests)
  - Quick start (entry point for new sessions)
  - Reference library (pointers to detailed content)

### Context Tree Integration

- [!] Root AGENTS.md integrates with context tree for specialized loading
  - "When to Load Sub-Agents" section with decision triggers
  - Load triggers match natural user language
  - Conservative loading guidance (1-2 sub-agents typical)
  - Paths to ctxt/ sub-agents for specialized contexts

### Regeneration Markers

- [!] Generated files marked for regeneration governance
  - Edit warning at top (HTML comment or plain text)
  - Source attribution (generated from specs/workspace/)
  - Regeneration command reference

## Validation

- [ ] File exists at project root as AGENTS.md
- [ ] No YAML frontmatter present
- [ ] Edit warning present at top
- [ ] Summary section exists
- [ ] Critical warnings section exists
- [ ] Reference library section exists
- [ ] Size within 20-30KB budget
- [ ] "When to Load Sub-Agents" section present (if context tree exists)
