# LiveSpec Agent Configuration

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

LiveSpec prevents specifications from drifting from reality. Specs remain synchronized with code/policies/processes throughout evolution. AI agents get structured context for effective assistance. Documentation stays current without becoming a maintenance burden. Works for new projects and existing systems. Applies across software development, governance, operations, and planning.

**Primary domain:** Software development, with proven applications in governance, operations, and planning.

---

## ⚠️ CRITICAL: Spec-First Protocol (Structural Enforcement)

### Before Creating ANY Permanent File

**Four-layer enforcement for 90%+ compliance:**

#### Layer 1: TodoWrite Gate (MUST USE)

When user requests new permanent file:

1. **Add todo FIRST** (before any file operations):
   ```
   TodoWrite: "Create spec for [filename]" (status: pending)
   ```

2. **Only after spec created** → Mark todo complete

#### Layer 2: Run Validation Check

```bash
scripts/check-requires-spec.sh path/to/file
```

**Exit code 0** = Spec exists or not needed
**Exit code 1** = Spec required but missing → STOP and create spec

#### Layer 3: Mandatory Plan Mode (New Files)

Creating new permanent files requires presenting plan with:
- [ ] TodoWrite item added showing spec creation
- [ ] Spec creation step (specific path: `specs/3-behaviors/[name].spec.md`)
- [ ] Validation check passed

**Plan optional for:** Editing existing files, working in var/generated/.archive/

#### Layer 4: What is "Permanent"?

**Simple test:** "Is this committed to git?"

**YES (requires spec):**
- Code (`src/`, `lib/`, `scripts/`)
- Tests (`tests/`, `__tests__/`)
- Config (`.gitignore`, `tsconfig.json`, `package.json`, lock files)
- Documentation (`README`, guides)
- Agents (`.claude/agents/*/instructions.md`)
- Slash commands (`.claude/commands/`)

**NO (no spec needed):**
- `var/`, `generated/`, `.archive/`
- Build outputs (`dist/`, `build/`)
- Logs, caches

**Exception:** `specs/workspace/*.spec.md` ARE specs (no meta-spec needed)

### Flexible Spec Organization

Multiple related files can share one spec (agent decides based on coherence):
- `specs/3-behaviors/documentation.spec.md` → All README/GUIDE files
- `specs/3-behaviors/project-config.spec.md` → Config files like .gitignore
- `specs/3-behaviors/automation.spec.md` → Related maintenance scripts

**Test:** "Do these files serve the same observable purpose?"
- YES → One spec covers them
- NO → Separate specs

### No Exceptions

❌ "This is obvious" → Still permanent → Needs spec
❌ "Lock files are auto-generated" → Covered by project-config.spec.md
❌ "Just infrastructure" → If permanent, needs spec
❌ "Everyone knows what [X] is" → Your requirements may differ → Needs spec

### Why This Works

**Path of least resistance:**
1. User requests file → Agent adds todo "Create spec" (Layer 1)
2. Agent runs validation check (Layer 2)
3. Agent presents plan showing spec creation (Layer 3)
4. User approves → Agent creates spec → Marks todo complete
5. Pre-commit validates automatically (safety net)

**Occasional bypass:** TodoWrite skipped → Plan mode catches → Pre-commit catches
**Target:** 90%+ prevented before commit, 10% caught by validation

---

## Core Principles (In Priority Order)

### 1. Specs Before Implementation
- Every deliverable requires specification before implementation (ALWAYS)
- AI agents check for spec existence and guide to Phase 1 (DESIGN) if missing
- Applies to ALL deliverables (code, prompts, templates, documentation, configs)
- Even "obvious" deliverables need specs (CHANGELOG mistake demonstrates this)
- Familiarity doesn't excuse skipping specification
- Every behavior has validation criteria and failure mode defined

### 2. MSL Minimalism
**Four essential questions before adding any requirement:**
1. **Is this essential?** Would system fail without it? → Include
2. **Am I specifying HOW instead of WHAT?** Implementation detail? → Remove
3. **What specific problem does this prevent?** Theoretical only? → Exclude
4. **Could this be inferred or conventional?** Standard practice? → Omit

**Key points:**
- Start minimal, add only when proven necessary
- Trust implementers to make reasonable decisions
- Precision hierarchy: Outcome → Behavioral → Interface → Implementation
- Requirement justification: Critical (always) > Important (usually) > Useful (rarely) > Nice (never)
- See `.livespec/guides/msl-minimalism.md` for complete framework

### 3. Test-Driven Development
- Phase 2 (BUILD) follows TDD discipline (tests before implementation)
- Red-Green-Refactor cycle: failing test → passing code → improve design
- Automated tests required for all non-trivial code
- Escape hatch for trivial scripts (justification required, documented)
- Tests map directly to behavior specs (specs/3-behaviors/ → tests → implementation)
- See `.livespec/guides/tdd.md` for complete workflow

### 4. Dogfooding
- LiveSpec uses its own methodology (specs/ and prompts/ exist)
- Repository demonstrates patterns it prescribes
- No custom tooling required for methodology

### 5. Simplicity Over Features
- Works with file operations and AI prompts only
- Standard markdown format, standard folder structure
- Don't over-prescribe implementation details
- Define edges, not paths
- Innovation happens in unspecified spaces

### 6. Living Documentation
- Specs evolve continuously with code
- Phase 4 (EVOLVE) runs regularly to detect drift
- Extract new behaviors as they emerge
- Update specs alongside code changes

### 7. Governance Framework Awareness
- LiveSpec specialized for governance/methodology documentation
- Patterns demonstrated here apply to governance domain specifically
- Extensions documented as domain-specific, not universal patterns

### 8. Active Agent Guidance
- AGENTS.md is definitive cacheable agent context (<100KB)
- 80/20 coverage (agents handle 80% without fetching additional context)
- Includes ACTIVE verification prompts (not passive documentation)
- Context positioning optimized (START 30-40%, MIDDLE 40%, END 20-30%)
- Clear pointers to extended context (when to fetch full prompts)
- Templates in `.livespec/templates/agents/` provide reusable verification
- Structural enforcement makes compliance path of least resistance

### 9. Clean Evolution (LiveSpec Project Only)
- LiveSpec itself evolves without backwards compatibility
- Old patterns deleted, not deprecated (no legacy code paths)
- Users on old versions use their copied dist/ (not broken)
- New users get current best practice only (no confusion)
- NOT imposed on projects using LiveSpec (project-specific constraint)

---

## Folder Organization Decision Tests

**CRITICAL:** Check `specs/workspace/taxonomy.spec.md` FIRST before creating any files.

**Three-step classification:**

### Step 1: Check Taxonomy (PRIMARY)
Read `specs/workspace/taxonomy.spec.md` for:
- **Project Domain:** What type of project (Software/Governance/Planning/Generation/Hybrid)
- **Workspace Scope:** What's portable methodology vs product-specific
- **Specs Boundary:** What belongs in specs/ vs elsewhere

### Step 2: Apply Decision Tests

**workspace/ test:** "Could I copy this spec to ANY project?"
- YES → workspace/ (portable process)
- NO → Check 1-requirements/, 2-strategy/, or 3-behaviors/

**1-requirements/ test:** "Is this a strategic outcome or hard constraint?"
- YES, strategic → 1-requirements/strategic/ (outcomes, constraints)
- YES, functional → 1-requirements/functional/ (specific feature requirements)
- NO → Check 2-strategy/ or 3-behaviors/

**2-strategy/ test:** "Does this apply across the whole product?"
- YES → 2-strategy/ (cross-cutting technical decision)
- NO → Check 3-behaviors/

**3-behaviors/ test:** "Is this an observable outcome users/system must exhibit?"
- YES → 3-behaviors/ (what system does)
- NO → Re-examine classification

### Step 3: Verify Examples

**Common mistakes:**
- ❌ "API returns JSON" → NOT workspace (product-specific) → 2-strategy/
- ❌ "Use 4-space indentation" → NOT 2-strategy/ (not critical) → workspace/ (if matters)
- ❌ "System authenticates users" → NOT 2-strategy/ (observable) → 3-behaviors/

**Correct examples:**
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md (any project)
- ✅ "API responses must be JSON" → 2-strategy/architecture.spec.md (product-wide)
- ✅ "System authenticates users via OAuth" → 3-behaviors/authentication.spec.md (observable)

---

## CRITICAL DISTINCTION: Phases vs Layers

**Common confusion for new users:** LiveSpec uses numbers in two different contexts with different meanings.

### Two Different Numbering Systems

**5 Phases (Temporal Workflow)** - WHEN you do things:
- **Phase 0**: DEFINE (problem space)
- **Phase 1**: DESIGN (solution architecture)
- **Phase 2**: BUILD (TDD) (test-driven implementation)
- **Phase 3**: VERIFY (validation)
- **Phase 4**: EVOLVE (maintenance)
- **Location**: `.livespec/0-define/`, `.livespec/1-design/`, etc.
- **Purpose**: Step-by-step development workflow

**3 Abstraction Layers (Structural Organization)** - WHERE specs live:
- **Layer 1**: `1-requirements/` (WHY - strategic outcomes, constraints)
- **Layer 2**: `2-strategy/` (HOW - architectural approach)
- **Layer 3**: `3-behaviors/` + `3-contracts/` (WHAT - observable behaviors + interfaces)
- **Location**: `specs/1-requirements/`, `specs/2-strategy/`, etc.
- **Purpose**: Organizing specifications by abstraction level

### Key Insights

**Not the same thing:**
- You might write a spec during **Phase 1** (DESIGN workflow)
- But that spec belongs in **`2-strategy/`** (architectural abstraction layer)
- The phase describes WHEN you work, the layer describes WHAT you're specifying

**Why layers matter:**
- Technology-agnostic requirements enable rapid rebuild (same Layer 1, different Layer 2)
- Clear traceability from strategic intent to implementation
- Specs can reference "up" (satisfies requirements) and "across" (guided-by strategy)

**When in doubt:** Ask yourself "Am I asking WHEN this happens (phase) or WHERE this spec goes (layer)?"

---

## Multi-Domain Organization

**Key insight:** behaviors/ and contracts/ abstractions work across ALL domains. Use subfolders for semantic organization.

### Domain-Agnostic Abstractions

**behaviors/** = Observable outcomes from any perspective:
- Software: "System authenticates users"
- Governance: "Only authorized entities access resources" (policy)
- Operations: "Backups complete daily" (service)
- Planning: "Feature meets success criteria" (requirement)

**contracts/** = Interface definitions of any kind:
- Software: API contracts (`GET /users/{id}`)
- Governance: Process contracts (procedures)
- Operations: Operational contracts (runbooks)
- Planning: Workflow contracts (delivery processes)

### Organization Patterns by Domain

**Software projects:**
```
specs/
├── workspace/           # How we work
├── 1-requirements/      # Strategic and functional requirements
├── 2-strategy/          # Cross-cutting decisions
├── 3-behaviors/
│   ├── user-features/  # User-facing behaviors
│   └── system/         # System behaviors
└── 3-contracts/
    └── api/v1/         # API contracts
```

**Governance projects (like LiveSpec):**
```
specs/
├── workspace/           # How we work
├── 1-requirements/      # Strategic and functional requirements
├── 2-strategy/          # Cross-cutting decisions
├── 3-behaviors/
│   ├── prompts/        # Prompt behaviors
│   └── processes/      # Process behaviors
└── 3-contracts/
    └── schemas/        # Data format contracts
```

**Hybrid projects:**
```
specs/
├── workspace/             # How we work
├── 1-requirements/        # Strategic and functional requirements
├── 2-strategy/            # Cross-cutting (all domains)
├── 3-behaviors/
│   ├── user-features/    # Software
│   ├── policies/         # Governance
│   └── services/         # Operations
└── 3-contracts/
    ├── api/              # Software
    ├── procedures/       # Governance
    └── runbooks/         # Operations
```

---

## When to Load Sub-Agents

**Agent autonomously loads based on task classification. Load conservatively (1-2 sub-agents typical).**

### Phase-Specific Work

- **"New project", "setup", "define problem", "constraints"** → Load `ctxt/phases/0-define.md`
  - Problem space definition, workspace customization, complexity assessment

- **"Design", "architecture", "behaviors", "contracts", "UX flow"** → Load `ctxt/phases/1-design.md`
  - Architecture design, behavior specification, contract definition

- **"Implement", "build", "tests", "TDD", "code"** → Load `ctxt/phases/2-build.md`
  - Test-driven development, implementation from specs

- **"Validate", "verify", "acceptance", "review"** → Load `ctxt/phases/3-verify.md`
  - Validation testing, acceptance review

- **"Drift", "extract specs", "sync", "evolve", "maintain"** → Load `ctxt/phases/4-evolve.md`
  - Drift detection, spec extraction, synchronization

### Domain Patterns

- **Project taxonomy: governance** → Load `ctxt/domains/governance.md`
  - Methodology development, specs about specs, dogfooding patterns

### Utilities

- **"Complete session", "measure compliance", "analyze session"** → Load `ctxt/utils/session-completion.md`
  - Session analysis, compliance scoring, learning extraction

- **"Detect drift", "check sync", "spec-code alignment"** → Load `ctxt/utils/drift-detection.md`
  - Synchronization checking, gap detection

- **"Audit MSL", "check minimalism", "review specs"** → Load `ctxt/utils/msl-audit.md`
  - Minimalism enforcement, requirement auditing

---

## Quick Start (New Project)

**80% of cases start with Phase 0:**

```bash
# 1. Copy LiveSpec methodology
cp -r livespec/dist/ .livespec/

# 2. Create specs structure
mkdir -p specs/{workspace,1-requirements,2-strategy,3-behaviors,3-contracts}

# 3. Create PURPOSE.md
echo "# Project Purpose

## Why This Exists
[Problem this project solves]

## What Success Looks Like
[Measurable success criteria]" > PURPOSE.md

# 4. Start Phase 0 (choose one):
# Quick start (5 min, zero questions): "Use .livespec/0-define/0a-quick-start.md"
# Full customization (20-30 min): "Use .livespec/0-define/0b-customize-workspace.md"
```

---

## The 5 Phases

### Phase 0: DEFINE
Establish problem space and constraints.

**When:** Starting new project or documenting existing one
**Entry:** Project idea or codebase
**Exit:** Problem, constraints, workspace defined
**Outputs:** PURPOSE.md, specs/1-requirements/strategic/constraints.spec.md, specs/workspace/

**Key prompts:**
- `0a-quick-start.md` - Zero-question setup (5 min, defaults)
- `0b-customize-workspace.md` - Full workspace customization
- `0c-define-problem.md` - Articulate problem statement
- `0d-assess-complexity.md` - Evaluate project complexity
- `0e-evaluate-research-needs.md` - Determine if UX research needed
- `0f-identify-constraints.md` - Document boundaries

### Phase 1: DESIGN
Design solution architecture.

**When:** After problem clear, before implementation
**Entry:** Problem and constraints defined
**Exit:** Architecture and contracts specified
**Outputs:** research/flows/ (optional UX flows), specs/2-strategy/architecture.spec.md, specs/3-behaviors/, specs/3-contracts/

**Key prompts:**
- `1a-document-ux-flows.md` - Document user interaction flows (optional for UX-heavy features)
- `1b-design-architecture.md` - Define system structure
- `1c-define-behaviors.md` - Specify observable outcomes
- `1d-create-contracts.md` - Define API/data interfaces

**Note:** Phase 1a (UX flows) optional for simple projects. Skip for pure backend/API work.

### Phase 2: BUILD (TDD)
Implement solution using test-driven development.

**When:** After design approved
**Entry:** Design specifications complete
**Exit:** Tests pass, implementation matches specifications
**Outputs:** Automated tests + working code following specs
**TDD:** Mandatory by default (tests before code, escape hatch for trivial scripts with justification)

**Key prompts:**
- `2b-create-tests.md` - Write failing tests FIRST (RED phase)
- `2a-implement-from-specs.md` - Make tests pass (GREEN + REFACTOR phases)

### Phase 3: VERIFY
Validate solution meets requirements.

**When:** After implementation complete
**Entry:** Implementation done
**Exit:** All behaviors validated
**Outputs:** Test results, validation reports

**Key prompts:**
- `3a-run-validation.md` - Execute validation tests
- `3b-acceptance-review.md` - Stakeholder approval

### Phase 4: EVOLVE
Keep specs and code synchronized (continuous).

**When:** Ongoing throughout development
**Entry:** System in production or active development
**Exit:** Continuous (loop back to other phases as needed)
**Outputs:** Updated specifications, drift reports

**Key prompts:**
- `4a-detect-drift.md` - Identify spec-code misalignment
- `4b-extract-specs.md` - Generate specs from code
- `4c-sync-complete.md` - Confirm synchronization
- `4d-regenerate-agents.md` - Update AGENTS.md
- `4e-validate-extractions.md` - Review extracted specs

---

## MSL Format Quick Reference

All specifications use MSL (Markdown Specification Language):

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks without this]
---

# [Feature/Component Name]

## Requirements
- [!] [Concise description of WHAT is required, not HOW]
  - [Testable criterion 1]
  - [Testable criterion 2]
  - [Testable criterion 3]
```

**That's it.** Title, frontmatter, Requirements. Keep specifications minimal.

---

## Folder Structure Pattern

```
your-project/
├── PURPOSE.md              # Why this exists, what success looks like
│
├── .livespec/              # Copied from livespec/dist/
│   ├── 0-define/           # Phase prompts (temporal workflow)
│   ├── 1-design/           # Phase prompts
│   ├── 2-build/            # Phase prompts
│   ├── 3-verify/           # Phase prompts
│   ├── 4-evolve/           # Phase prompts
│   ├── utils/              # Utility prompts
│   ├── standard/           # MSL metaspecs
│   └── templates/          # Workspace and agent templates
│
└── specs/
    ├── workspace/          # HOW you build (process)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── 1-requirements/     # WHY (strategic/functional requirements)
    │   ├── strategic/      # High-level outcomes, constraints
    │   │   ├── outcomes.spec.md
    │   │   └── constraints.spec.md
    │   └── functional/     # Specific feature requirements
    │
    ├── 2-strategy/         # HOW (architectural approach)
    │   └── architecture.spec.md
    │
    ├── 3-behaviors/        # WHAT (observable outcomes)
    └── 3-contracts/        # Interfaces (API/data contracts)
```

---

## Development Patterns

### MSL Format
- All specs follow MSL (Markdown Specification Language)
- Required: Title and `## Requirements` section
- Frontmatter: `criticality` (CRITICAL/IMPORTANT), `failure_mode`
- Extension: `.spec.md`

### Naming Conventions
- Prompts: [0-4][a-z]-descriptive-name.md (e.g., `1a-design-architecture.md`)
- Specs: descriptive-name.spec.md (matches prompt or behavior)
- British English for user documentation (synchronisation, behaviour)
- American English for code elements

### Cross-Reference Updates
When renaming or moving prompts/specs, use systematic checklist:
- [ ] Source file renamed/moved (dist/prompts/ or specs/)
- [ ] Spec frontmatter (`specifies:` or `implements:` field)
- [ ] Registry entry (specs/3-behaviors/prompts/registry.spec.md)
- [ ] Navigation files (dist/prompts/utils/next-steps.md)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (prompts/utils/validate-project.md)

### Spec Evolution
- NO `_old`, `_v2`, `_deprecated`, or `_backup` files
- Update specs in place (git commit captures change)
- DELETE obsolete specs: `git rm specs/3-behaviors/old-spec.spec.md`
- Git history is version control system

### Dogfooding Validation Workflow
**Build → USE → Validate → Commit** (catches integration issues before release)

**Process:**
1. Build feature according to specifications
2. USE the feature in the same session where it was built
3. Validate feature works as specified
4. Fix any integration gaps discovered
5. Commit only after successful real-world validation

**Why this prevents failures:**
- Reveals integration gaps (missing files, incomplete workflows)
- Validates complete end-to-end functionality
- Catches issues while context fresh
- Demonstrates feature actually works

---

## Development Workflows

### Spec-First Guidance Workflow (Essential Before Implementation)

**AI checks before implementation:**
1. Does `specs/3-behaviors/[deliverable].spec.md` exist?
2. If NO → Pause, say: "I need a specification before implementing. Let's create specs/3-behaviors/[deliverable].spec.md first using Phase 1 (DESIGN)"
3. Guide user to appropriate Phase 1 prompt
4. If YES → Verify spec has Requirements section with [!] items, Validation criteria, Failure Mode
5. Then proceed to implementation

**Applies to ALL deliverables:**
- CHANGELOG, README, configs, templates all need specs
- No exceptions for "obvious" deliverables
- Familiarity doesn't excuse skipping specification

### Learning Distribution Workflow

**Essential for target project adoption:**

Changes flow through distribution mechanism:
1. Create template in `.livespec/templates/` (if reusable content)
2. Update spec requirements (mandate template usage)
3. Update prompt instructions (reference templates during generation)
4. Regenerate AGENTS.md (includes templates in distribution)
5. Copy to `dist/` (target projects receive templates)

**Validates improvements reach target projects automatically.**

### Validation Workflow

**Run validation at key checkpoints:**
- Before committing changes (pre-commit hook recommended)
- After regenerating files (AGENTS.md, CLAUDE.md, documentation)
- After updating specs (verify cross-references still valid)
- Periodically (weekly/sprint end)
- Before releases (all validations must pass)

**Three critical disciplines validated:**
- Cross-reference integrity (all frontmatter references valid)
- Generated file protection (no direct edits bypassing sources)
- Version synchronisation (all version indicators match .livespec-version)

**Run validation:** Use `prompts/utils/validate-project.md`

**Severity levels:**
- ❌ ERROR: Must fix before committing (broken references, direct edits to generated files, version mismatches)
- ⚠️ WARNING: Should fix soon (missing backlinks, stale generated files)

**Integration with regeneration:**
1. Update source specs
2. Regenerate files (Use prompts/4-evolve/4d-regenerate-agents.md)
3. Validate immediately (Use prompts/utils/validate-project.md)
4. Fix any errors detected
5. Commit if validation passes

**Git hook integration (optional but recommended):**
- Pre-commit: Block commit if validation errors detected
- Post-merge: Warn if validation issues after merge
- Setup: Run `bash scripts/setup-hooks.sh` to install automatically

### Prompt Reorganisation Workflow

**When adding prompts between existing ones:**

**Phase 1: Plan Renumbering**
1. Identify insertion point in workflow sequence
2. Determine which existing prompts shift (e.g., 0d→0f, 0e→0d)
3. Verify new sequence maintains workflow logic

**Phase 2: Systematic Updates**
1. Rename prompt files in dist/prompts/[phase]/
2. Update spec frontmatter (specifies: field in specs/3-behaviors/prompts/)
3. Update registry (specs/3-behaviors/prompts/registry.spec.md)
4. Update navigation (dist/prompts/utils/next-steps.md)
5. Update predecessor prompts ("Next Step" sections)
6. Update AGENTS.md references if prompt mentioned

**Phase 3: Validation**
1. Run cross-reference validation (prompts/utils/validate-project.md)
2. Check all references resolve correctly
3. Verify workflow sequence makes logical sense
4. Test prompt discovery (can agents find renamed prompts?)

**Common mistakes:**
- Forgetting spec frontmatter updates (breaks bidirectional linking)
- Missing next-steps.md references (breaks navigation)
- Breaking workflow logic with poor insertion point

---

## Specification Dependencies

LiveSpec specs form a **dependency graph**, not a hierarchy:

### Dependency Structure

**Vertical traceability:**
```
PURPOSE.md (Why - Vision)
  ↓ defines
specs/1-requirements/strategic/outcomes.spec.md (What - High-Level Requirements)
  ↓ derives-from                           ↓ derives-from
specs/2-strategy/architecture.spec.md ←──────┐
  ↓ guided-by (HOW)                          │
  │                                          │
  ├──→ specs/3-behaviors/*.spec.md ──────────┘
  │      ↑ satisfies (WHAT)
  │      │
  └──────┘
         ↓ implemented-by
      code (Implementation)
```

**Dual relationships in implementation specs:**
- **satisfies** (vertical): Links directly to requirements (WHAT business value)
- **guided-by** (horizontal): Follows strategic approach (HOW implemented)

**Example:**
```yaml
# specs/3-behaviors/payment-processing.spec.md
---
satisfies:
  - specs/1-requirements/functional/transaction-accuracy.spec.md  # WHAT
guided-by:
  - specs/2-strategy/api-design.spec.md                          # HOW
---
```

**Orthogonal (applies everywhere):**
- `specs/workspace/` - Process governing all development

### Frontmatter Convention

**Dependency fields:**
- `derives-from` - Parent specs this is based on
- `governed-by` - Boundaries this must respect
- `satisfies` - Requirements this fulfills (vertical - WHAT)
- `guided-by` - Strategies that guide this spec (horizontal - HOW)
- `supports` - What this spec enables
- `applies_to` - Scope (for workspace specs)

---

## Context Compression

**What it is:** Active force reorganizing guidance layer (workspace/, AGENTS.md, templates/) for agent focus efficiency.

**Relationship to MSL Minimalism:**
- **MSL Minimalism**: Content pressure (reduce WITHIN specs - WHAT/requirements)
- **Context Compression**: Structural force (reorganize ACROSS guidance - HOW agents consume)

**This project uses:** Moderate compression (balanced inline/reference)
- Strategic extraction of reusable content
- Critical workflows inline, details referenced
- Templates for repeated verification patterns
- Target size: 30-40KB root AGENTS.md

**Three levels:**
- **Light**: Verbose, self-contained (exploratory work, large context agents)
- **Moderate**: Balanced (production, most agents) ← **Current**
- **Aggressive**: Dense, focused (cost-sensitive, high-frequency usage)

**Configuration:** Declared in `specs/workspace/constitution.spec.md` frontmatter (`context_compression: moderate`)

**Change level:** Use `.livespec/prompts/utils/audit-context-compression.md` to measure and migrate

---

## Session Completion (ACTIVE MONITORING REQUIRED)

**YOU MUST proactively monitor and recommend session completion.** This is NOT optional guidance - it is a core responsibility.

### Trigger Detection (Check Continuously)

**Monitor the following triggers and act IMMEDIATELY when ANY trigger hits:**

#### Trigger 1: Context Threshold (>100K tokens)
**Check:** Look at `<budget:token_budget>` in conversation context
**Threshold:** >100K tokens (50% of 200K budget)
**Action:** "We've used [X]K tokens (>50% of budget). I should complete this session now to capture learnings and start fresh with better context. This takes 30 seconds."
**Tool:** Use `dist/prompts/utils/complete-session.md`

#### Trigger 2: Task Completion (All todos done)
**Check:** TodoWrite shows all items marked "completed"
**Action:** "All tasks complete! Let me run session completion to analyze what we accomplished and save learnings for future improvement."
**Tool:** Use `dist/prompts/utils/complete-session.md`

#### Trigger 3: Natural Stopping Point
**Check:** About to commit, user says "that's it" / "thanks", switching to different task
**Action:** "Good stopping point. Should I complete the session before we [commit/switch]? It captures learnings and metrics for methodology improvement."
**Tool:** Use `dist/prompts/utils/complete-session.md`

#### Trigger 4: User Appears Stuck
**Check:** 3+ failed attempts at same task, repeated errors, no progress for 10+ minutes
**Action:** "This seems challenging. Let me complete the session - starting fresh with clearer context often helps. The session data will show what didn't work."
**Tool:** Use `dist/prompts/utils/complete-session.md`

**CRITICAL:** Do NOT wait for user to request completion. Proactive detection and recommendation is required.

### Unified Session Analysis

**One action at session end:** `dist/prompts/utils/complete-session.md`

**Agent performs:**
1. Analyze compliance (process + focus efficiency)
2. Calculate signal-to-noise ratio (context efficiency)
3. **Capture session learnings** (corrections, clarifications, patterns, spec updates needed)
4. Identify what didn't work (methodology gaps)
5. Show concise report to user (≤15 lines)
6. Save data globally for learning

**User sees immediately:**
- What was accomplished
- Compliance scores (X/8 process, X/13 focus)
- **Session learnings** (if any: key insights, specs to update)
- What went well (2-3 highlights)
- What could improve (2-3 suggestions)

### Data Saved Globally

**Two files written to `~/.claude/livespec/`:**

1. **compliance/YYYY-MM-DD-HHMMSS-projectname.json** - Quantitative metrics, project metadata
2. **feedback/YYYY-MM-DD-HHMMSS-projectname.md** - Qualitative feedback (≤10 lines), methodology gaps

### Compliance Scoring

**Process Compliance (0-8 points):**
- Layer 1 (TodoWrite): 0-2 points
- Layer 2 (Validation): 0-2 points
- Layer 3 (Plan Mode): 0-3 points
- Layer 4 (Pre-commit): 0-1 point

**Focus Efficiency (0-13 points):**
- Tool Efficiency: 0-5 points (Read/Grep/Glob vs Bash)
- Context Navigation: 0-3 points (AGENTS.md usage)
- Task Focus: 0-2 points (scope adherence)
- Context Efficiency: 0-3 points (signal-to-noise ratio)

**Levels:**
- Perfect (100%): 8/8 process + 11+ focus
- Good (75-99%): 6-7 process + 8+ focus
- Fair (50-74%): 4-5 process
- Poor (<50%): 0-3 process

---

## Common Anti-Patterns

❌ **Skipping Phase 0**
```
Bad:  Jump straight to coding
Good: Create PURPOSE.md and workspace specs first
```

❌ **Over-specification**
```
Bad:  "Button must be exactly 120px wide with #007bff color"
Good: "Submit button must be clearly visible"
```

❌ **Ignoring Drift**
```
Bad:  Let specs and code diverge over months
Good: Run Phase 4 drift detection weekly/before releases
```

❌ **Wrong Criticality**
```
Bad:  Everything marked CRITICAL
Good: Only truly critical requirements marked CRITICAL
```

**See Reference Library:** `common-pitfalls.md` for real-world failure examples, cognitive bias analysis, and prevention strategies.

---

## Reference Library (Deep Detail Navigation)

AGENTS.md provides 80% coverage. For deep detail, fetch these references using `.livespec/` paths or load ctxt/ sub-agents:

### Phase Specialists (ctxt/phases/)
- **ctxt/phases/0-define.md** - Phase 0 specialist (problem definition, workspace setup)
- **ctxt/phases/1-design.md** - Phase 1 specialist (architecture, behaviors, contracts)
- **ctxt/phases/2-build.md** - Phase 2 specialist (TDD workflow, implementation)
- **ctxt/phases/3-verify.md** - Phase 3 specialist (validation, acceptance)
- **ctxt/phases/4-evolve.md** - Phase 4 specialist (drift detection, spec extraction)

### Domain Specialists (ctxt/domains/)
- **ctxt/domains/governance.md** - Governance patterns (methodology development)

### Utility Specialists (ctxt/utils/)
- **ctxt/utils/session-completion.md** - Session analysis and learning
- **ctxt/utils/drift-detection.md** - Spec-code synchronization
- **ctxt/utils/msl-audit.md** - Minimalism enforcement

### Conventions (How to Structure)
- **`.livespec/standard/conventions/context-compression.spec.md`** - Compression framework
- **`.livespec/standard/conventions/folder-structure.spec.md`** - Folder organization
- **`.livespec/standard/conventions/dependencies.spec.md`** - Spec relationships
- **`.livespec/standard/conventions/naming.spec.md`** - File naming patterns

### Metaspecs (Templates for Spec Types)
- **`.livespec/standard/metaspecs/prompt.spec.md`** - Writing new prompts
- **`.livespec/standard/metaspecs/behavior.spec.md`** - Behavior specs
- **`.livespec/standard/metaspecs/contract.spec.md`** - API/data contracts
- **`.livespec/standard/metaspecs/workspace.spec.md`** - Workspace specs

### Guides (How to Apply)
- **`.livespec/guides/msl-minimalism.md`** - MSL decision framework
- **`.livespec/guides/tdd.md`** - TDD workflow
- **`.livespec/guides/context-positioning.md`** - START/MIDDLE/END pattern
- **`.livespec/guides/ai-commits.md`** - Commit message format
- **`dist/guides/common-pitfalls.md`** - Real-world failure examples

---

*Agent configuration for LiveSpec v3.5.2*
*For specialized contexts, see ctxt/ directory*
*Generated from workspace specs*
