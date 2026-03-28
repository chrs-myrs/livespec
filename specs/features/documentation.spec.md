---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Users create wrong folder structures and misplace specs; AI agents generate incorrect code due to missing context; projects fail to adopt spec-first workflow
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (voluntary adoption, AI agent support)
guided-by:
  - specs/strategy/architecture.spec.md
  - specs/strategy/ai-discoverability.spec.md
---

# Documentation Requirements

## Requirements

### Core Identity
- [!] LiveSpec is positioned as an **information architecture and context generation system**, not merely a folder structure.
  - Primary value: Structured specifications that generate optimized AI agent context (AGENTS.md)
  - Secondary value: Bidirectional sync between specs and code
  - README opens with what LiveSpec IS: "An information architecture that generates context trees for AI agents"
  - README explicitly states: "Not just folders - a system for organizing intent that AI agents can consume"
  - The folder structure is a MEANS, the context tree (AGENTS.md generation) is the END

### Problem Statement
- [!] README clearly explains the problem LiveSpec solves.
  - Spec drift: Specifications and code inevitably diverge
  - Context loss: AI agents lack structured understanding of project intent
  - Manual burden: Keeping docs synchronized is tedious and often skipped
  - LiveSpec's solution: Bidirectional sync, minimal specs, continuous evolution, AND generated context

### Core Concepts (User Mental Model)
- [!] README includes Core Concepts section BEFORE architecture diagram that explains:
  - Value Structure (PURPOSE → requirements → strategy → behaviors) with traceability explanation
  - Context Tree (workspace vs product specs) with clear separation of concerns
  - The Three Layers (requirements/strategy/behaviors) with their driving questions
  - Why this matters for AI agents: Structured context enables better assistance

### Architecture Visualization
- [!] Architecture diagram shows the information flow.
  - Vertical flow: PURPOSE → requirements → constraints → architecture → behaviors → code
  - Validation loop: tests validate both specs and code
  - Workspace separation: development process applies to all
  - Color coding with legend: Foundation (blue) → Design (yellow) → Implementation (green)
  - Note clarifying phases are iterative, not waterfall

### Self-Documentation (Dogfooding)
- [!] README demonstrates LiveSpec applied to itself as proof of concept.
  - Self-documenting diagram: Framework → Project Specs → Deliverables (3 nodes)
  - Notes: Framework extends MSL Standard via base.spec.md
  - Shows dogfooding loop: deliverables define the framework
  - Distinguishes how LiveSpec documents itself vs how YOU use it

### AI-Powered Development
- [!] README explains AI agent integration before Quick Start.
  - Spec-to-code: Phase 1-2 (specs→code), Phase 4 (code→specs)
  - Context generation: AGENTS.md regenerated from specs
  - Agent-agnostic: Works with Claude, Copilot, Cursor, any agent
  - Comparison to alternatives (spec-kit: no CLI vs CLI-based)

### Quick Start
- [!] README provides clear onboarding paths.
  - 5-minute quick start for new projects
  - Existing project path (extract specs from code)
  - Upgrade path for existing .livespec/ installations
  - docs/quickstart.md provides detailed phase walkthrough

### Troubleshooting and Common Pitfalls
- [!] Documentation addresses setup confusion proactively.
  - Common mistake: Creating files before understanding taxonomy.spec.md
  - Common mistake: Putting workspace concerns in product specs (or vice versa)
  - Common mistake: Skipping Phase 0 and jumping to implementation
  - Common mistake: Not regenerating AGENTS.md after spec changes
  - Resolution guidance for each pitfall

## Documentation Structure

**Reading order by user type:**

| User Type | Start Here | Then | Deep Dive |
|-----------|------------|------|-----------|
| New to LiveSpec | README.md | docs/quickstart.md | docs/methodology.md |
| Setting up project | docs/quickstart.md | specs/workspace/taxonomy.spec.md | AGENTS.md |
| AI Agent | AGENTS.md | (self-contained) | llms.txt (Context7) |
| Contributor | specs/workspace/ | AGENTS.md | specs/features/ |

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

### Workspace Specs Documentation
- [!] Each workspace spec must be explained with practical examples, not just definitions.
  - **taxonomy.spec.md**: Example showing Software vs Governance vs Hybrid classification
  - **constitution.spec.md**: Example showing principle like "specs before implementation"
  - **patterns.spec.md**: Example showing naming convention or folder rule
  - **workflows.spec.md**: Example showing commit process or review requirement
  - Examples demonstrate WHEN and WHY to customize, not just WHAT each file contains

## Agent-Specific Documentation

### AGENTS.md
- [!] AGENTS.md provides comprehensive, cacheable agent context.
  - Single file <100KB (cacheable by AI agents)
  - Covers 80% of use cases without fetching additional context
  - Decision tree for which phase/prompt to use
  - MSL format quick reference
  - Essential templates and patterns
  - Regeneratable from source specs via prompts/utils/regenerate-contexts.md

### llms.txt
- [!] llms.txt enables Context7 integration for remote methodology access.
  - Context7-compatible format
  - Links to repository and MSL specification
  - 5-phase overview with purpose of each
  - Folder structure pattern
  - Quick references to detailed prompts
