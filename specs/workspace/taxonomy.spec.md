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

**Test**: "Is this about the workspace or in the workspace?"

✅ **workspace/** = ABOUT the workspace (meta-governance, how workspace operates):
- workspace/constitution.spec.md - Development principles
- workspace/patterns.spec.md - Naming, formatting conventions
- workspace/workflows.spec.md - 5-phase development process
- workspace/taxonomy.spec.md - Classification rules (this document)
- workspace/context-compression.spec.md - Context optimization strategy
- workspace/context-structure.spec.md - Rules for AGENTS.md content, ctxt/ tree structure

❌ **NOT workspace** (deliverables and behaviors IN the workspace):
- Framework architecture → specs/2-strategy/ (cross-cutting decisions)
- Prompt artifacts → specs/3-artifacts/prompts/ (methodology deliverables)
- Agent artifacts → specs/3-artifacts/agents/ (methodology deliverables)
- Methodology behaviors → specs/3-behaviors/ (drift detection, validation, phase guidance)

**Key insight**: workspace/ governs how the workspace behaves and maintains itself (context building, documentation generation). The artifacts and tools the workspace uses/produces go in 3-artifacts/ and 3-behaviors/.

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
- ✅ specs/3-artifacts/prompts/0a-quick-start.spec.md (defines prompt artifact)
- ❌ dist/prompts/0-define/0a-quick-start.md (distributable prompt implementation)

## Layer 3 Structure (Behaviors vs Artifacts vs Contracts)

**For governance/methodology projects like LiveSpec**, Layer 3 uses a three-way split:

**3-behaviors/** = Observable behaviors of the methodology
- *"What does the methodology DO?"*
- Examples: drift-detection.spec.md, phase-guidance.spec.md, validation/*, session-completion.spec.md
- These define HOW the methodology guides and assists development

**3-artifacts/** = Components that make up the methodology
- *"What is the methodology MADE OF?"*
- Examples: prompts/*, agents/*, commands/*, validators/*
- These are deliverable artifacts (files we build and distribute)

**3-contracts/** = Interfaces and format definitions
- *"What are the standard interfaces?"*
- Examples: prompt-structure.spec.md, agent-interface.spec.md, msl-format.spec.md
- These define contracts that artifacts and behaviors must follow

**Simple three-way test**:
1. "Does this describe behavior of the methodology?" → 3-behaviors/
2. "Does this describe an artifact we build?" → 3-artifacts/
3. "Does this describe an interface/format?" → 3-contracts/

**Note**: Software projects may use different Layer 3 organization (e.g., behaviors/ for user features, contracts/ for APIs, no artifacts/ needed).

## AI agents must

Before creating ANY file, agents must:
- ✅ Check this taxonomy.spec.md FIRST
- ✅ Use "about vs in" test for workspace/ ("Is this ABOUT the workspace?" → YES = workspace/)
- ✅ Use three-way Layer 3 test (behavior/artifact/contract) for specs/3-*/ placement
- ✅ Keep distributable framework OUT of specs/ (specs define, dist/ distributes)
- ✅ Place framework architecture in specs/2-strategy/, NOT workspace/
- ✅ Place prompt artifacts in specs/3-artifacts/prompts/, NOT workspace/ or 3-behaviors/
- ✅ Place agent artifacts in specs/3-artifacts/agents/, NOT workspace/ or 3-behaviors/
- ✅ Place methodology behaviors in specs/3-behaviors/ (drift detection, validation, etc.)
- ✅ Distinguish between framework specifications (specs/) and framework distribution (dist/)
- ✅ Understand dogfooding: specs/ governs LiveSpec's own development using LiveSpec methodology
- ✅ Generated files (AGENTS.md, prompts/generated/*) include standard markers showing sources
- ✅ Update this taxonomy when LiveSpec's project classification fundamentally changes

## Requirements

- [!] Taxonomy structure validates via automated checks.
  - All five section headings present (Project Domain, Workspace Scope, Specs Boundary, Layer 3 Structure, AI agents must)
  - Domain classification declared
  - Workspace scope explicitly defined with "about vs in" test
  - Layer 3 split explained (behaviors/artifacts/contracts)
  - Specs boundary clearly stated with artifact locations
  - Agent obligations documented as checklist

## Validation

- All workspace/ files pass "about the workspace" test (meta-governance only)
- specs/ contains only .spec.md files (framework source, not distribution)
- Distributable framework clearly separated in dist/ folder
- Framework architecture placed in specs/2-strategy/, not workspace/
- Prompt artifacts placed in specs/3-artifacts/prompts/, not workspace/ or 3-behaviors/
- Agent artifacts placed in specs/3-artifacts/agents/, not workspace/ or 3-behaviors/
- Methodology behaviors placed in specs/3-behaviors/, not 3-artifacts/
- Layer 3 follows three-way split (behaviors/artifacts/contracts)
- Dogfooding validated: LiveSpec uses its own Phase 0-4 methodology
- Distribution pattern followed: specs/ → dist/ (users copy dist/ to their .livespec/)
