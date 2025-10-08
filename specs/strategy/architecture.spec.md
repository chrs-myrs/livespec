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
- [!] LiveSpec separates specifications into workspace (development process) and prompts (methodology documentation), provides phase-based prompts as methodology source that users copy to .livespec/, includes version tracking for safe upgrades, and supports domain-agnostic abstractions with subfolder organization.
  - PURPOSE.md exists at root level
  - specs/workspace/ contains our development methodology
  - specs/behaviors/prompts/ documents what each prompt does
  - prompts/ contains all 5 phases (0-define through 4-evolve)
  - templates/ contains workspace templates and domain-specific templates
  - .livespec/ symlink points to prompts/ (dogfooding)
  - .livespec-version.template and customizations.yaml.template enable version tracking
  - standard/ contains canonical metaspecs (never customized)
  - behaviors/ and contracts/ abstractions work across all domains
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
- utils/ - Utility prompts (upgrade-methodology.md)

### standard/
Canonical metaspecs (always overwritten on upgrade):
- metaspecs/base.spec.md - Core MSL requirements
- metaspecs/behavior.spec.md - Behavior specification metaspec
- metaspecs/contract.spec.md - Contract specification metaspec
- metaspecs/strategy.spec.md - Strategy specification metaspec

### templates/
Specification templates for bootstrapping:
- workspace/ - Workspace specification templates (constitution, patterns, workflows)
- governance/ - Governance domain templates (policy, procedure)
- operations/ - Operations domain templates (runbook, playbook)

### Version Tracking
Files enabling safe AI-assisted upgrades:
- .livespec-version.template - Version marker (users copy to .livespec-version)
- customizations.yaml.template - Customization tracker (users copy to customizations.yaml)

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
- domain-organization.md - Multi-domain organization patterns

### tests/
Validation suite proving specs are correct:
- prompts/ - Tests for folder structure, MSL format, prompt behaviors
- run-all-tests.sh - Test runner

## Domain Organization Patterns

LiveSpec's abstractions work across all domains without configuration:

**behaviors/** = Observable outcomes from any perspective:
- Software: "System authenticates users via OAuth"
- Governance: "Only authorized entities access resources" (policy)
- Operations: "Backups complete daily" (service)
- Planning: "Feature meets success criteria" (requirement)

**contracts/** = Interface definitions of any kind:
- Software: API contracts (`GET /users/{id}` returns User object)
- Governance: Process contracts (procedures defining steps)
- Operations: Operational contracts (runbooks defining responses)
- Planning: Workflow contracts (delivery processes)

**strategy/** = Cross-cutting decisions applying everywhere:
- Technical: "Use PostgreSQL for persistence"
- Organizational: "All policies reviewed quarterly"
- Architectural: "Microservices architecture"

**Subfolder organization enables domain clarity:**
```
specs/
├── workspace/           # How we work (any project)
├── behaviors/
│   ├── user-features/  # Software domain
│   ├── policies/       # Governance domain
│   ├── services/       # Operations domain
│   └── requirements/   # Planning domain
├── contracts/
│   ├── api/            # Software domain
│   ├── procedures/     # Governance domain
│   ├── runbooks/       # Operations domain
│   └── workflows/      # Planning domain
└── strategy/           # Cross-cutting decisions
```

**Key insight:** No config needed. Abstractions are domain-agnostic. Use subfolders for semantic organization.

## Interactions

1. **Dogfooding** (LiveSpec uses its own methodology):
   - We maintain PURPOSE.md, specs/workspace/, specs/behaviors/prompts/
   - .livespec/ symlink lets us use prompts/ on ourselves
   - Tests validate our specs follow our own rules

2. **Distribution** (Users adopting LiveSpec):
   - Users copy prompts/ to their-project/.livespec/
   - Users create .livespec-version from template (enables upgrade detection)
   - Users create customizations.yaml from template (tracks modifications)
   - Users copy templates/ to their-project/specs/workspace/
   - Users customize templates for their project
   - Users organize specs/ with subfolders for domain clarity (optional)
   - Users create their specs using .livespec/ prompts

3. **Context7/Remote Reference**:
   - Context7 indexes prompts/ and docs/
   - AI agents read methodology remotely
   - Users create specs locally with AI help
   - Detailed strategy in specs/strategy/ai-discoverability.spec.md

4. **Upgrade** (AI-assisted progressive merge):
   - AI reads customizations.yaml to identify custom vs canonical files
   - Phase 1: Auto-update standard/ (canonical, never customized)
   - Phase 2: Auto-update non-customized prompts
   - Phase 3: Interactive review of customized prompts (AI helps merge)
   - Phase 4: Merge templates (add new, preserve custom)
   - Phase 5: Skip never_overwrite paths
   - Phase 6: Offer new files for approval
   - AI explains changes, proposes intelligent merges, respects user decisions
   - Backup created before upgrade, rollback instructions provided
   - Detailed process in prompts/utils/upgrade-methodology.md

## Validation

- PURPOSE.md exists at root level
- specs/workspace/ contains our development methodology
- specs/behaviors/prompts/ documents what each prompt does
- prompts/ contains all 5 phases (0-define through 4-evolve) plus utils/
- standard/ contains canonical metaspecs
- templates/ contains workspace, governance, and operations templates
- .livespec-version.template and customizations.yaml.template exist
- .livespec/ symlink points to prompts/
- docs/domain-organization.md explains multi-domain patterns
- behaviors/ and contracts/ abstractions work across all domains
- Tests validate our own specs
- No user copies specs/ folder (only prompts/)
