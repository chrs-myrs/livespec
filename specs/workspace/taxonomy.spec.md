---
criticality: IMPORTANT
failure_mode: Without taxonomy, LiveSpec development becomes inconsistent and agents confuse framework distribution with specifications
applies_to: this_project
governed-by:
  - .livespec/standard/metaspecs/taxonomy.spec.md
---

# LiveSpec Project Taxonomy

## Requirements
- [!] LiveSpec is classified as GOVERNANCE domain with explicit workspace scope and specs boundary to prevent organizational confusion and demonstrate dogfooding pattern.

  **Project Domain**: Governance
  - LiveSpec produces methodology frameworks for specification-driven development
  - Primary pattern: specs/ (source) → dist/ (distributable framework) + AGENTS.md (generated)
  - Dogfooding: LiveSpec uses its own methodology to develop itself
  - Framework is about HOW to build other projects, not a software product itself

  **Workspace Scope** (portable methodology - dogfooding LiveSpec on LiveSpec):
  - ✅ workspace/constitution.spec.md - LiveSpec development principles (portable to LiveSpec users)
  - ✅ workspace/patterns.spec.md - LiveSpec development conventions (portable to LiveSpec users)
  - ✅ workspace/workflows.spec.md - LiveSpec development process (portable to LiveSpec users)
  - ✅ workspace/taxonomy.spec.md - This classification document (portable to LiveSpec users)
  - ❌ NOT workspace: Framework-specific architecture or distribution patterns
    - Examples: "distribution.spec.md", "framework-structure.spec.md", "prompt-behaviors.spec.md"
    - These define THIS FRAMEWORK's architecture (product strategy/behaviors), not HOW to build any project (methodology)
    - Correct location: specs/2-strategy/ (framework architecture) or specs/3-behaviors/ (prompt behaviors)
    - Test: "Could a React library use this exact spec?" → NO → Not workspace
  - Special case: workspace/ specs in governance projects ARE demonstrating the framework (dogfooding)
    - But they still define HOW LIVESPEC DEVELOPS ITSELF, not the framework being distributed

  **Specs Boundary** (specifications only, not distributable framework):
  - specs/ contains ONLY .spec.md files defining framework behavior
  - Framework artifacts live OUTSIDE specs/:
    - Distributable framework → dist/ folder (prompts, templates, metaspecs, guides - what users copy)
    - Generated configuration → AGENTS.md, CLAUDE.md (generated from specs/workspace/)
    - Project-specific prompts → prompts/generated/ (generated, committed - tailored to LiveSpec)
    - Examples → examples/ folder (demonstration projects)
    - Tests → tests/ folder (validation, not distributed)
    - Transient work → var/ folder (gitignored)
  - specs/ defines WHAT the framework does (requirements, behaviors, prompt contracts)
  - specs/ IS source of truth but NOT the distributed product
  - dist/ IS the framework users receive (copied to their projects as .livespec/)
  - Dogfooding principle: Framework development follows same specs/ → implementation pattern it prescribes
  - Example: ✅ specs/3-behaviors/prompts/0a-setup-workspace.spec.md (defines prompt behavior), ❌ dist/prompts/0-define/0a-setup-workspace.md (distributable prompt implementation)

  **AI agents must**:
  - Check this taxonomy.spec.md FIRST before creating files
  - Verify workspace/ additions pass portability test ("works in ANY project?" → YES = workspace)
  - Keep distributable framework OUT of specs/ (specs define, dist/ distributes)
  - Place framework architecture in specs/2-strategy/, NOT workspace/
  - Place prompt behaviors in specs/3-behaviors/prompts/, NOT workspace/
  - Distinguish between framework specifications (specs/) and framework distribution (dist/)
  - Understand dogfooding: specs/ governs LiveSpec's own development using LiveSpec methodology
  - Generated files (AGENTS.md, prompts/generated/*) include standard markers showing sources
  - Update this taxonomy when LiveSpec's project classification fundamentally changes

## Validation
- All workspace/ files are portable methodology (pass "any project" test - LiveSpec users can use these)
- specs/ contains only .spec.md files (framework source, not distribution)
- Distributable framework clearly separated in dist/ folder
- Framework architecture placed in specs/2-strategy/, not workspace/
- Prompt behaviors placed in specs/3-behaviors/prompts/, not workspace/
- Dogfooding validated: LiveSpec uses its own Phase 0-4 methodology
- Distribution pattern followed: specs/ → dist/ (users copy dist/ to their .livespec/)
