---
derives_from:
  - PURPOSE.md
  - specs/requirements.spec.md
constrained_by:
  - specs/constraints.spec.md
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear architecture, LiveSpec becomes incoherent collection of files
---

# LiveSpec Architecture

## Requirements
- [!] LiveSpec separates specifications into workspace (development process) and prompts (methodology documentation), provides phase-based prompts as methodology source that users copy to .livespec/, and includes templates within prompts/ for workspace bootstrapping.
  - PURPOSE.md exists at root level
  - specs/workspace/ contains our development methodology
  - specs/behaviors/prompts/ documents what each prompt does
  - prompts/ contains all 5 phases (0-define through 4-evolve)
  - prompts/templates/ contains workspace templates
  - .livespec/ symlink points to prompts/
  - Tests validate our own specs
  - No user copies specs/ folder (only prompts/)

## Components

### PURPOSE.md
Root-level purpose statement defining why LiveSpec exists and what success looks like.

### prompts/
Methodology source (users copy this to .livespec/):
- 0-define/ - Problem definition prompts
- 1-design/ - Solution design prompts
- 2-build/ - Implementation prompts
- 3-verify/ - Validation prompts
- 4-evolve/ - Synchronization prompts
- templates/ - Workspace specification templates

### specs/workspace/
Development process specifications defining HOW LiveSpec is built:
- constitution.spec.md - Governance principles
- patterns.spec.md - Code and specification patterns
- workflows.spec.md - Development workflows

### specs/behaviors/prompts/
Meta-specifications defining WHAT each prompt accomplishes:
- Prompt specs (0a-4c) - What each prompt does, expected outputs
- Core behavior specs (folder-structure, msl-format, five-phases, drift-detection)

### specs/strategy/
Technical approach and architectural decisions:
- architecture.spec.md - This file (structural design)
- ai-discoverability.spec.md - AI agent discoverability strategy
- dogfooding.spec.md - Self-application validation strategy
- validation.spec.md - Testing and verification approach
- distribution.spec.md - Packaging and versioning strategy
- phase-workflow.spec.md - Hybrid workflow strategy (waterfall + iterative)

### specs/
Root-level product specifications:
- requirements.spec.md - High-level requirements
- constraints.spec.md - Hard boundaries

### .livespec/
Symlink to prompts/ (enables dogfooding - we use our own methodology).

### docs/
User documentation (not specifications):
- quickstart.md - Getting started guide
- msl-guide.md - MSL format reference
- methodology.md - Philosophy and approach

### tests/
Validation suite proving specs are correct:
- prompts/ - Tests for folder structure, MSL format, prompt behaviors
- run-all-tests.sh - Test runner

## Interactions

1. **Dogfooding** (LiveSpec uses its own methodology):
   - We maintain PURPOSE.md, specs/workspace/, specs/behaviors/prompts/
   - .livespec/ symlink lets us use prompts/ on ourselves
   - Tests validate our specs follow our own rules

2. **Distribution** (Users adopting LiveSpec):
   - Users copy prompts/ to their-project/.livespec/
   - Users copy prompts/templates/ to their-project/specs/workspace/
   - Users customize templates for their project
   - Users create their specs using .livespec/ prompts

3. **Context7/Remote Reference**:
   - Context7 indexes prompts/ and docs/
   - AI agents read methodology remotely
   - Users create specs locally with AI help
   - Detailed strategy in specs/strategy/ai-discoverability.spec.md

## Validation

- PURPOSE.md exists at root level
- specs/workspace/ contains our development methodology
- specs/behaviors/prompts/ documents what each prompt does
- prompts/ contains all 5 phases (0-define through 4-evolve)
- prompts/templates/ contains workspace templates
- .livespec/ symlink points to prompts/
- Tests validate our own specs
- No user copies specs/ folder (only prompts/)
