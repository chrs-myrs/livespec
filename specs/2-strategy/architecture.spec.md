---
derives-from:
  - PURPOSE.md
  - specs/1-requirements/strategic/outcomes.spec.md
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear architecture, LiveSpec becomes incoherent collection of files
---

# LiveSpec Architecture

## Requirements
- [!] LiveSpec separates specifications into workspace (development process) and prompts (methodology documentation), provides phase-based prompts as methodology source that users copy to .livespec/, includes version tracking for safe upgrades, and supports domain-agnostic abstractions with subfolder organization.
  - PURPOSE.md exists at root level
  - specs/workspace/ contains our development methodology
  - specs/3-behaviors/prompts/ documents what each prompt does
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

### specs/3-behaviors/prompts/
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

### specs/1-requirements/strategic/
Top-level product definition:
- outcomes.spec.md - High-level requirements
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

## External Dependencies

LiveSpec depends on these external tools and services:

- **MSL (Markdown Specification Language)** (https://github.com/chrs-myrs/msl-specification) - Spec format providing minimalist requirements structure
- **Context7** (https://context7.com) - Remote methodology reference enabling AI agent discovery (detailed strategy: specs/2-strategy/ai-discoverability.spec.md)
- **Git** (https://git-scm.com) - Version control enabling drift detection, synchronization workflows, and upgrade tracking
- **GitHub** (https://github.com) - Repository hosting, release distribution, and CI/CD platform

**Integration approach:**
- All dependencies use standard patterns (no custom integration behaviors needed)
- External documentation referenced, not duplicated
- Context7 integration strategy detailed in separate spec due to architectural significance

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

## Active Enforcement Pattern

**Problem:** Passive documentation in AGENTS.md is insufficient. Agents violate methodology even with full context (evidenced by violation report analysis).

**Solution:** Structural enforcement makes compliance path of least resistance.

**Implementation:**
1. **Templates provide active verification content** (`.livespec/templates/agents/`):
   - pre-implementation-verification.md - Checklist before implementing
   - no-plumbing-exception.md - Warning against "just wiring" categorization
   - self-check-questions.md - Questions agents ask themselves
   - plan-review-checklist.md - Compliance verification before execution

2. **Specs require templates** (`specs/workspace/workspace-agent.spec.md`):
   - Mandates verification sections in AGENTS.md START section
   - References templates explicitly by path
   - Defines context positioning (START 30-40%, MIDDLE 40%, END 20-30%)

3. **Prompts insert templates** (`prompts/4-evolve/4d-regenerate-agents.md`):
   - Reads templates during AGENTS.md generation
   - Inserts in START section (primacy bias)
   - Validates presence during review

4. **Generated AGENTS.md includes enforcement**:
   - Pre-implementation checklists visible to agents
   - Red flag warnings for common mental traps
   - Self-check triggers during plan creation
   - Compliance reporting requirements

**Result:** Agents have structural guidance preventing methodology violations, not just philosophical descriptions of what they should do.

**Evidence:** Principle #7 (Active Agent Guidance) in constitution.spec.md validates this architectural shift from documentation to enforcement.

## Interactions

1. **Dogfooding** (LiveSpec uses its own methodology):
   - We maintain PURPOSE.md, specs/workspace/, specs/3-behaviors/prompts/
   - .livespec/ symlink lets us use prompts/ on ourselves
   - Tests validate our specs follow our own rules

2. **Distribution** (Users adopting LiveSpec):
   - **Complete adoption** (recommended): `cp -r livespec/dist/ my-project/.livespec/`
     - Gets prompts/, templates/, standard/, guides/, version templates
     - Single command, no missing dependencies
   - **Selective adoption** (if customizing distribution):
     - Copy `dist/prompts/` → `.livespec/prompts/` (methodology prompts)
     - Copy `dist/templates/` → `.livespec/templates/` (workspace bootstrap + agent verification)
     - Copy `dist/standard/` → `.livespec/standard/` (MSL metaspecs)
   - Create `.livespec-version` from `.livespec/.livespec-version.template`
   - Create `customizations.yaml` from `.livespec/customizations.yaml.template`
   - Organize specs/ with subfolders for domain clarity (optional)
   - Generate AGENTS.md using `.livespec/prompts/4-evolve/4d-regenerate-agents.md`
     - Reads templates from `.livespec/templates/agents/`
     - Inserts verification content into AGENTS.md START section
     - Creates project-specific agent configuration

3. **Context7/Remote Reference**:
   - Context7 indexes prompts/ and docs/
   - AI agents read methodology remotely
   - Users create specs locally with AI help
   - Detailed strategy in specs/2-strategy/ai-discoverability.spec.md

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
- specs/3-behaviors/prompts/ documents what each prompt does
- prompts/ contains all 5 phases (0-define through 4-evolve) plus utils/
- standard/ contains canonical metaspecs
- templates/ contains workspace, governance, and operations templates
- .livespec-version.template and customizations.yaml.template exist
- .livespec/ symlink points to prompts/
- docs/domain-organization.md explains multi-domain patterns
- behaviors/ and contracts/ abstractions work across all domains
- Tests validate our own specs
- No user copies specs/ folder (only prompts/)
