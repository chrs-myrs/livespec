---
type: taxonomy
category: workspace
fidelity: process
criticality: IMPORTANT
failure_mode: Without taxonomy, LiveSpec development becomes inconsistent and agents confuse framework distribution with specifications
governed-by: []
applies_to: this_project
---

# LiveSpec Project Taxonomy

## Project Domain

LiveSpec produces methodology frameworks for specification-driven development.

**Domain classification**: Governance
- Primary pattern: specs/ (source) → dist/ (distributable framework) + AGENTS.md (generated)
- Dogfooding: LiveSpec uses its own methodology to develop itself
- Framework is about HOW to build other projects, not a software product itself

## Workspace Scope

**Test**: "Is this about the workspace or in the workspace?"

✅ **workspace/** = ABOUT the workspace (operating context):
- workspace/constitution.spec.md - Development principles
- workspace/patterns.spec.md - Naming, formatting conventions
- workspace/workflows.spec.md - 5-phase development process
- workspace/taxonomy.spec.md - Classification rules (this document)
- workspace/context-compression.spec.md - Context optimization strategy
- workspace/context-architecture.spec.md - Rules for AGENTS.md content, ctxt/ tree structure

❌ **NOT workspace** (deliverables and behaviors IN the workspace):
- Framework architecture → specs/strategy/ (cross-cutting decisions)
- Prompt artifacts → specs/artifacts/prompts/ (methodology deliverables)
- Agent artifacts → specs/artifacts/agents/ (methodology deliverables)
- Methodology behaviors → specs/features/ (drift detection, validation, phase guidance)
- Format contracts → specs/interfaces/ (MSL syntax, AGENTS.md format, discovery)

**Key insight**: workspace/ defines **operating context** - how agents, humans, and the workspace interact. The artifacts and tools the workspace uses/produces go elsewhere. Workspace specs can be bespoke to the project; there's no requirement for them to be "portable to any project".

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
- ✅ specs/artifacts/prompts/0a-quick-start.spec.md (defines prompt artifact)
- ❌ dist/prompts/0-define/0a-quick-start.md (distributable prompt implementation)

## Specs Folder Structure

**For governance/methodology projects like LiveSpec**, specs/ uses five top-level categories:

### foundation/
*"Why does this exist? What must it achieve?"*
- Strategic outcomes (what success looks like)
- Hard constraints (non-negotiable boundaries)
- Examples: outcomes.spec.md, constraints.spec.md

### strategy/
*"What cross-cutting decisions apply everywhere?"*
- Architectural approach
- AI discoverability strategy
- Phase workflow design
- Examples: architecture.spec.md, ai-discoverability.spec.md, phase-workflow.spec.md

### features/
*"What observable behaviors does the methodology exhibit?"*
- Drift detection behavior
- Context generation behavior
- Validation behaviors
- Session completion behavior
- Examples: context-generation.spec.md, validation/*.spec.md, improvement-analysis.spec.md

### artifacts/
*"What things does the methodology produce?"*
- Prompt definitions
- Agent definitions
- Command definitions
- Validator definitions
- Examples: prompts/*.spec.md, agents/*.spec.md, commands/*.spec.md

### interfaces/
*"What contracts must implementations follow?"*
- Format definitions (MSL syntax, prompt structure)
- Context contracts (AGENTS.md format)
- Distribution contracts (dist/ package structure)
- Discovery interfaces (llms.txt, Context7)
- Examples: formats/msl-syntax.spec.md, context/agents-md.spec.md, discovery/llms-txt.spec.md

### workspace/ (orthogonal)
*"How do we work?"*
- Operating context (constitution, patterns, workflows)
- Not product specs - process specs
- Applies to all other categories

## Decision Tests

**Five-way classification for specs/**:

1. "Is this a strategic outcome or hard constraint?" → **foundation/**
2. "Does this apply across the whole product?" → **strategy/**
3. "Does this describe observable methodology behavior?" → **features/**
4. "Does this describe something we build and distribute?" → **artifacts/**
5. "Does this define a format, contract, or discovery interface?" → **interfaces/**

**Orthogonal test**: "Is this ABOUT how we work?" → **workspace/** (in addition to above)

## AI agents must

Before creating ANY file, agents must:
- ✅ Check this taxonomy.spec.md FIRST
- ✅ Use "about vs in" test for workspace/ ("Is this ABOUT the workspace?" → YES = workspace/)
- ✅ Use five-way test for specs/ placement (foundation/strategy/features/artifacts/interfaces)
- ✅ Keep distributable framework OUT of specs/ (specs define, dist/ distributes)
- ✅ Place framework architecture in specs/strategy/, NOT workspace/
- ✅ Place prompt artifacts in specs/artifacts/prompts/, NOT workspace/ or features/
- ✅ Place agent artifacts in specs/artifacts/agents/, NOT workspace/ or features/
- ✅ Place methodology behaviors in specs/features/ (drift detection, validation, etc.)
- ✅ Place format contracts in specs/interfaces/, NOT features/ or artifacts/
- ✅ Distinguish between framework specifications (specs/) and framework distribution (dist/)
- ✅ Understand dogfooding: specs/ governs LiveSpec's own development using LiveSpec methodology
- ✅ Generated files (AGENTS.md, prompts/generated/*) include standard markers showing sources
- ✅ Update this taxonomy when LiveSpec's project classification fundamentally changes

## Requirements

- [!] Taxonomy structure validates via automated checks.
  - All section headings present (Project Domain, Workspace Scope, Specs Boundary, Specs Folder Structure, Decision Tests, AI agents must)
  - Domain classification declared
  - Workspace scope explicitly defined with "about vs in" test
  - Five-way split explained (foundation/strategy/features/artifacts/interfaces)
  - Specs boundary clearly stated with artifact locations
  - Agent obligations documented as checklist

## Validation

- All workspace/ files pass "about the workspace" test (meta-governance only)
- specs/ contains only .spec.md files (framework source, not distribution)
- Distributable framework clearly separated in dist/ folder
- Framework architecture placed in specs/strategy/, not workspace/
- Prompt artifacts placed in specs/artifacts/prompts/, not workspace/ or features/
- Agent artifacts placed in specs/artifacts/agents/, not workspace/ or features/
- Methodology behaviors placed in specs/features/, not artifacts/
- Format contracts placed in specs/interfaces/, not features/ or artifacts/
- Dogfooding validated: LiveSpec uses its own Phase 0-4 methodology
- Distribution pattern followed: specs/ → dist/ (users copy dist/ to their .livespec/)
