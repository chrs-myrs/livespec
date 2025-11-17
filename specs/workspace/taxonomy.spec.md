---
criticality: IMPORTANT
failure_mode: Without taxonomy, LiveSpec development becomes inconsistent and agents confuse framework distribution with specifications
applies_to: this_project
governed-by:
  - .livespec/standard/metaspecs/taxonomy.spec.md
---

# LiveSpec Project Taxonomy

## Project Domain

LiveSpec produces methodology frameworks for specification-driven development.

**Domain classification**: Governance
- Primary pattern: specs/ (source) → dist/ (distributable framework) + AGENTS.md (generated)
- Dogfooding: LiveSpec uses its own methodology to develop itself
- Framework is about HOW to build other projects, not a software product itself

## Workspace Scope

**Portable methodology** (dogfooding LiveSpec on LiveSpec):

✅ **Workspace files** (works in ANY LiveSpec-using project):
- workspace/constitution.spec.md - LiveSpec development principles
- workspace/patterns.spec.md - LiveSpec development conventions
- workspace/workflows.spec.md - LiveSpec development process
- workspace/taxonomy.spec.md - This classification document
- workspace/context-compression.spec.md - Context optimization strategy

❌ **NOT workspace** (framework-specific architecture):
- Framework architecture → specs/2-strategy/ (e.g., distribution.spec.md)
- Prompt behaviors → specs/3-behaviors/prompts/ (e.g., prompt-behaviors.spec.md)
- Framework structure → specs/2-strategy/ (e.g., framework-structure.spec.md)

**Test**: "Could a React library use this exact spec?"
- YES → Workspace (portable methodology)
- NO → Product-specific (goes in 2-strategy/ or 3-behaviors/)

**Special case**: workspace/ specs in governance projects demonstrate the framework (dogfooding), but they define HOW LIVESPEC DEVELOPS ITSELF, not the framework being distributed.

## Specs Boundary

**specs/ contains ONLY .spec.md files** defining framework behavior.

**Framework artifacts live OUTSIDE specs/**:
- Distributable framework → `dist/` (prompts, templates, metaspecs, guides - what users copy)
- Generated configuration → `AGENTS.md`, `CLAUDE.md` (generated from specs/workspace/)
- Project-specific prompts → `prompts/generated/` (generated, committed - tailored to LiveSpec)
- Examples → `examples/` (demonstration projects)
- Tests → `tests/` (validation, not distributed)
- Transient work → `var/` (gitignored)

**Key distinctions**:
- specs/ defines WHAT the framework does (requirements, behaviors, prompt contracts)
- specs/ IS source of truth but NOT the distributed product
- dist/ IS the framework users receive (copied to their projects as .livespec/)

**Dogfooding principle**: Framework development follows same specs/ → implementation pattern it prescribes.

**Example**:
- ✅ specs/3-behaviors/prompts/0a-setup-workspace.spec.md (defines prompt behavior)
- ❌ dist/prompts/0-define/0a-setup-workspace.md (distributable prompt implementation)

## AI agents must

Before creating ANY file, agents must:
- ✅ Check this taxonomy.spec.md FIRST
- ✅ Verify workspace/ additions pass portability test ("works in ANY project?" → YES = workspace)
- ✅ Keep distributable framework OUT of specs/ (specs define, dist/ distributes)
- ✅ Place framework architecture in specs/2-strategy/, NOT workspace/
- ✅ Place prompt behaviors in specs/3-behaviors/prompts/, NOT workspace/
- ✅ Distinguish between framework specifications (specs/) and framework distribution (dist/)
- ✅ Understand dogfooding: specs/ governs LiveSpec's own development using LiveSpec methodology
- ✅ Generated files (AGENTS.md, prompts/generated/*) include standard markers showing sources
- ✅ Update this taxonomy when LiveSpec's project classification fundamentally changes

## Requirements

- [!] Taxonomy structure validates via automated checks.
  - All four section headings present (Project Domain, Workspace Scope, Specs Boundary, AI agents must)
  - Domain classification declared
  - Workspace scope explicitly listed with portability test
  - Specs boundary clearly stated with artifact locations
  - Agent obligations documented as checklist

## Validation

- All workspace/ files are portable methodology (pass "any project" test)
- specs/ contains only .spec.md files (framework source, not distribution)
- Distributable framework clearly separated in dist/ folder
- Framework architecture placed in specs/2-strategy/, not workspace/
- Prompt behaviors placed in specs/3-behaviors/prompts/, not workspace/
- Dogfooding validated: LiveSpec uses its own Phase 0-4 methodology
- Distribution pattern followed: specs/ → dist/ (users copy dist/ to their .livespec/)
