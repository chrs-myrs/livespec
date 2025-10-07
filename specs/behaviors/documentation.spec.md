---
criticality: CRITICAL
failure_mode: Without effective documentation, users cannot adopt LiveSpec and agents cannot assist effectively
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/requirements.spec.md (voluntary adoption, AI agent support)
---

# Documentation Requirements

## Requirements
- [!] LiveSpec documentation enables users and AI agents to quickly understand and adopt methodology, with clear architecture visualization, MSL integration, circularity demonstration, and example of LiveSpec applied to non-coding project (itself).
  - README.md starts with mermaid architecture diagram showing spec relationships
  - Architecture diagram includes legend explaining color-coded flow
  - README includes circularity diagram (MSL → base → metaspecs → specs → deliverables)
  - Circularity diagram demonstrates complete self-documentation (every deliverable has spec, every spec constrained by metaspec)
  - Circularity diagram shows dogfooding loop (deliverables define the framework)
  - README links to MSL specification (github.com/chrs-myrs/msl-specification)
  - README demonstrates LiveSpec is example of methodology applied to non-coding project
  - README provides 5-minute quick start for both new and existing projects
  - docs/quickstart.md provides step-by-step instructions for each phase
  - Documentation optimized for AI agent consumption (AGENTS.md, llms.txt)
  - All docs explain distribution model (copy dist/* to .livespec/)
  - Target audiences addressed: new users, contributors, AI agents

## Documentation Structure

**Root documentation:**
- README.md - Primary entry point (architecture, quick start, links)
- PURPOSE.md - Why LiveSpec exists, success criteria
- AGENTS.md - Comprehensive agent reference (<100KB, cacheable)
- llms.txt - Context7 integration, condensed methodology

**docs/ detailed guides:**
- docs/quickstart.md - Step-by-step phase walkthrough
- docs/methodology.md - 5-phase methodology deep dive
- docs/msl-guide.md - MSL format explanation with examples
- docs/livespec-conventions.md - LiveSpec-specific conventions
- docs/validation-patterns.md - Testing and validation approach

## Key Messaging

**README must convey:**
1. LiveSpec is folder structure + MSL format + 5-phase methodology
2. Not a framework or tool - just information architecture
3. Works with any AI agent (Claude, Copilot, Cursor)
4. This repository is dogfooding example (methodology applied to itself)
5. No installation required, no dependencies

**Architecture diagram must show:**
- Vertical flow: PURPOSE → requirements → constraints → architecture → behaviors → code
- Validation loop: tests validate both specs and code
- Workspace separation: development process applies to all
- Color coding: Foundation (blue) → Design (yellow) → Implementation (green)

**Distribution model must explain:**
- Users copy `dist/*` to `.livespec/` in their projects
- dist/ contains three components:
  - standard/ - MSL metaspecs and conventions
  - prompts/ - 5-phase methodology guidance
  - templates/ - Spec starter files for bootstrapping projects
- LiveSpec repo uses `.livespec` symlink to `dist/` for dogfooding
- Templates are .spec.md.template files users copy and customize

## Agent-Specific Documentation

**AGENTS.md requirements:**
- Single cacheable file <100KB
- Covers 80% of use cases without fetching additional context
- Decision tree for which phase/prompt to use
- MSL format quick reference
- Essential templates and patterns
- Regeneratable from source specs

**llms.txt requirements:**
- Context7-compatible format
- Links to repository and MSL specification
- 5-phase overview with purpose of each
- Folder structure pattern
- Quick references to detailed prompts
