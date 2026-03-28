---
type: contract
category: interfaces
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without llms.txt, AI tools cannot discover LiveSpec methodology content, reducing adoption
governed-by: []
supports:
  - specs/strategy/ai-discoverability.spec.md
---

# llms.txt Discovery Interface Contract

## Requirements

### File Location

- [!] llms.txt provides AI-discoverable project summary at standard location
  - Located at repository root (llms.txt)
  - Plain text format (not markdown)
  - Human and AI readable
  - Follows llms.txt community convention

### Content Structure

- [!] llms.txt contains project metadata for AI discovery
  - Project name and brief description
  - Primary documentation entry points
  - Key concepts and terminology
  - Links to detailed documentation (AGENTS.md, README)

### Size Budget

- [!] llms.txt optimized for quick AI consumption
  - Maximum 4KB (typical 1-2KB)
  - Essential information only
  - Points to detailed content rather than duplicating

## Validation

- [ ] llms.txt exists at repository root
- [ ] File size under 4KB
- [ ] Contains project name
- [ ] Contains links to AGENTS.md and/or README
- [ ] Plain text format (no markdown headers)
