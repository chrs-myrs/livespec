# LiveSpec Agent Configuration

> **Generated file** - Do not edit directly. Regenerate using `/livespec:audit context`

## Summary

LiveSpec provides information architecture where upper layers are durable assets and code is disposable. Shared foundation (purpose, requirements, strategy) derives into two branches: product branch (behaviors → code) and workspace branch (workspace specs → context tree). Workspace specs generate AI agent context (AGENTS.md, ctxt/). Code can be regenerated from specs at any time. Works for new projects and existing systems across any domain.

**Primary domain:** Governance — methodology framework for specification-driven development.

**Distribution:** LiveSpec ships as a Claude Code plugin (skills + commands + agents), not a copied `dist/` folder. There is no `.livespec/` directory in this repo or in target projects.

---

## CRITICAL: Spec-First Protocol (Structural Enforcement)

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
- [ ] Spec creation step (specific path: `specs/features/[name].spec.md`)
- [ ] Validation check passed

**Plan optional for:** Editing existing files, working in var/generated/.archive/

#### Layer 4: What is "Permanent"?

**Simple test:** "Is this committed to git?"

**YES (requires spec):**
- Code (`src/`, `lib/`, `scripts/`)
- Tests (`tests/`, `__tests__/`)
- Config (`.gitignore`, `tsconfig.json`, `package.json`, lock files)
- Documentation (`README`, guides)
- Skills (`skills/*/SKILL.md`), commands (`commands/*.md`), agents (`agents/*.md`)

**NO (no spec needed):**
- `var/`, `generated/`, `.archive/`
- Build outputs (`build/`)
- Logs, caches

**Exception:** `specs/workspace/*.spec.md` ARE specs (no meta-spec needed)

### Flexible Spec Organization

Multiple related files can share one spec (agent decides based on coherence):
- `specs/features/documentation.spec.md` → All README/GUIDE files
- `specs/features/project-config.spec.md` → Config files like .gitignore
- `specs/features/automation.spec.md` → Related maintenance scripts

**Test:** "Do these files serve the same observable purpose?"
- YES → One spec covers them
- NO → Separate specs

### No Exceptions

- "This is obvious" → Still permanent → Needs spec
- "Lock files are auto-generated" → Covered by project-config.spec.md
- "Just infrastructure" → If permanent, needs spec
- "Everyone knows what [X] is" → Your requirements may differ → Needs spec

### Why This Works

**Path of least resistance:**
1. User requests file → Agent adds todo "Create spec" (Layer 1)
2. Agent runs validation check (Layer 2)
3. Agent presents plan showing spec creation (Layer 3)
4. User approves → Agent creates spec → Marks todo complete
5. Pre-commit validates automatically (safety net)

**Target:** 90%+ prevented before commit, 10% caught by validation

### PURPOSE.md Boundary Enforcement

**Hard limit: <20 content lines** (target: 10-15 lines)

PURPOSE.md captures vision only. All other content goes directly to proper specs at capture time.

**Content Routing:**
| Content Type | Correct Location |
|--------------|-----------------|
| "Must comply with X" | `specs/foundation/constraints.spec.md` |
| "Users can do X" | `specs/foundation/outcomes.spec.md` |
| "Will use X tech" | `specs/strategy/architecture.spec.md` |
| "System does X" | `specs/features/[feature].spec.md` |
| "Team follows X" | `specs/workspace/workflows.spec.md` |

**Decision test:** "Can I explain this in an elevator pitch to a non-technical stakeholder?"
- YES → PURPOSE.md
- NO → Route to appropriate spec

**Validation:** `scripts/validate-purpose.sh`

---

## Core Principles (In Priority Order)

### 1. Specs Before Implementation
- Every deliverable requires specification before implementation (ALWAYS)
- AI agents check for spec existence and guide to DESIGN mode if missing
- Applies to ALL deliverables (code, skills, commands, agents, documentation, configs)
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
- See `references/guides/msl-minimalism.md` for complete framework

### 3. Test-Driven Development
- Phase 2 (BUILD) follows TDD discipline (tests before implementation)
- Red-Green-Refactor cycle: failing test → passing code → improve design
- Automated tests required for all non-trivial code
- Escape hatch for trivial scripts (justification required, documented)
- Tests map directly to behavior specs (specs/features/ → tests → implementation)

### 4. Dogfooding
- LiveSpec uses its own methodology (specs/ and skills/ exist)
- Repository demonstrates patterns it prescribes
- No custom tooling required for methodology

### 5. Simplicity Over Features
- Works with file operations and AI prompts only
- Standard markdown format, standard folder structure
- Define edges, not paths; innovation happens in unspecified spaces

### 6. Living Documentation
- Specs evolve continuously; code is regenerable from specs
- Phase 4 (EVOLVE) detects regeneration signals (not just drift)
- Extract discoveries as they emerge, level them up to appropriate spec layer

### 7. Governance Framework Awareness
- LiveSpec specialized for governance/methodology documentation
- Patterns here apply to governance domain specifically
- Extensions documented as domain-specific, not universal patterns

### 8. Active Agent Guidance
- AGENTS.md is definitive cacheable agent context (<100KB)
- 80/20 coverage (agents handle 80% without fetching additional context)
- Includes ACTIVE verification prompts (not passive documentation)
- Structural enforcement makes compliance path of least resistance

### 9. Clean Evolution (LiveSpec Project Only)
- LiveSpec evolves without backwards compatibility
- Old patterns deleted, not deprecated (no legacy code paths)
- Users upgrade via `/livespec:upgrade`; older versions aren't "broken", they're superseded
- NOT imposed on projects using LiveSpec

### 10. Progressive Disposability
- PURPOSE most durable → REQUIREMENTS → STRATEGY → BEHAVIORS → CODE most disposable
- Essential knowledge lives in specs, not code
- Maintenance energy invested proportional to layer durability

### 11. Spec Health
- Maintain spec quality through validation and evolution
- "Time to refine specs" is a positive signal, not a failure state
- EVOLVE mode runs continuously to maintain spec quality

---

## Folder Organization Decision Tests

**CRITICAL:** Check `specs/workspace/taxonomy.spec.md` FIRST before creating any files.

**Three-step classification:**

### Step 1: Check Taxonomy (PRIMARY)
Read `specs/workspace/taxonomy.spec.md` for:
- **Project Domain:** What type of project (Software/Governance/Planning/Generation/Hybrid)
- **Workspace Scope:** What's operating context vs deliverable
- **Specs Boundary:** What belongs in specs/ vs elsewhere

### Step 2: Apply Decision Tests

**workspace/ test:** "Is this ABOUT the workspace or IN the workspace?"
- ABOUT (meta-governance, how workspace operates) → workspace/
- IN (deliverables, behaviors) → Check foundation/, strategy/, or features/

**foundation/ test:** "Is this a strategic outcome or hard constraint?"
- YES → foundation/ (outcomes, constraints)
- NO → Check strategy/ or features/

**strategy/ test:** "Does this apply across the whole product?"
- YES → strategy/ (cross-cutting technical decision)
- NO → Check features/, artifacts/, or interfaces/

**Layer 3 test (three-way split):** "Behavior, artifact, or interface?"
- "What does the methodology DO?" → features/ (drift detection, validation, phase guidance)
- "What is the methodology MADE OF?" → artifacts/ (prompts, agents, commands, validators)
- "What are the standard interfaces?" → interfaces/ (format definitions)

### Step 3: Verify Examples

**Common mistakes:**
- "API returns JSON" → NOT workspace (product-specific) → strategy/
- "Agent definitions" → NOT workspace (deliverables IN workspace) → artifacts/agents/
- "Slash commands" → NOT features/ (artifacts, not behaviors) → artifacts/commands/
- "Prompt files" → NOT features/ (artifacts, not behaviors) → artifacts/prompts/

**Correct examples:**
- "Use MSL format for all specs" → workspace/patterns.spec.md (ABOUT workspace)
- "AGENTS.md content rules" → workspace/context-architecture.spec.md (ABOUT workspace)
- "Drift detection behavior" → features/drift-detection.spec.md (methodology behavior)
- "Individual prompt specs" → artifacts/prompts/*.spec.md (methodology artifacts)

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
- **Location**: `references/prompts/define/`, `references/prompts/design/`, `references/prompts/evolve/`
- **Invocation**: `/livespec:design`, `/livespec:audit`, `/livespec:learn` (skills route to these prompts; no phase-numbered folders to browse manually)

**3 Abstraction Layers (Structural Organization)** - WHERE specs live:
- **Layer 1**: `foundation/` (WHY — strategic outcomes, constraints)
- **Layer 2**: `strategy/` (HOW — architectural approach)
- **Layer 3**: `features/` + `interfaces/` (WHAT — observable behaviors + interfaces)
- **Location**: `specs/foundation/`, `specs/strategy/`, etc.

### Key Insight

**Not the same thing:** You might write a spec during Phase 1 (DESIGN workflow), but that spec belongs in `strategy/` (architectural abstraction layer). The phase describes WHEN you work, the layer describes WHAT you're specifying.

**When in doubt:** Ask "Am I asking WHEN this happens (phase) or WHERE this spec goes (layer)?"

---

## Multi-Domain Organization

**Key insight:** features/ and interfaces/ abstractions work across ALL domains. Use subfolders for semantic organization.

### Organization Patterns by Domain

**Software projects:**
```
specs/
├── workspace/           # How we work
├── foundation/          # Strategic outcomes and constraints
├── strategy/            # Cross-cutting decisions
├── features/
│   ├── user-features/  # User-facing behaviors
│   └── system/         # System behaviors
└── interfaces/
    └── api/v1/         # API contracts
```

**Governance projects (like LiveSpec):**
```
specs/
├── workspace/           # How we work
├── foundation/          # Strategic outcomes and constraints
├── strategy/            # Cross-cutting decisions
├── features/
│   ├── prompts/        # Prompt behaviors
│   └── processes/      # Process behaviors
├── artifacts/          # Prompts, agents, commands
└── interfaces/
    └── schemas/        # Data format contracts
```

---

## When to Load Sub-Agents

**Decision rule:** AGENTS.md (this file) provides 80% coverage. Only load sub-agents when task requires phase-specific workflow detail or specialized guidance not covered here.

**Load conservatively:** 1-2 sub-agents typical, not 3+. Most tasks use AGENTS.md alone.

### When NOT to Load Sub-Agents

**AGENTS.md is sufficient for:**
- Reading/understanding existing specs
- Making small edits to files
- Basic questions about LiveSpec structure
- Running validation scripts
- Creating simple specs following templates
- General development work

### Phase-Specific Work (Load When Actually Performing Phase Workflow)

- **"New project", "setup", "define problem", "constraints"** → Load `ctxt/define.md`
  - ONLY when: Starting brand new project, defining problem space, customizing workspace
  - NOT for: Reading existing PURPOSE.md, understanding constraints

- **"Design", "architecture", "behaviors", "contracts", "UX flow"** → Load `ctxt/design.md`
  - ONLY when: Creating new architecture, specifying new behaviors, designing contracts
  - NOT for: Reading existing design specs, understanding architecture

- **"Implement", "build", "tests", "TDD", "validate", "verify", "drift", "regenerate", "extract specs", "evolve"** → Load `ctxt/evolve.md`
  - ONLY when: Implementation concerns, validation, TDD cycle, detecting regeneration signals
  - NOT for: Reading code or existing specs

### Domain Patterns (Load Only for Specialized Contexts)

- **"Methodology", "dogfooding", "governance", "framework development"** → Load `ctxt/domains/governance.md`
  - ONLY when: Developing methodology, writing specs about specs, dogfooding patterns
  - NOT for: Using LiveSpec normally

### Utilities (Load When Running Specialized Workflows)

- **"Complete session", "measure compliance", "analyze session"** → Load `ctxt/session.md`
  - ONLY when: Ending session, measuring compliance, analyzing work

- **"Audit MSL", "check minimalism", "review specs", "spec quality"** → Load `ctxt/msl-audit.md`
  - ONLY when: Auditing minimalism, reviewing spec quality
  - NOT for: Writing specs (use AGENTS.md MSL guidance)

- **"Health", "drift", "spec health", "validation", "context regeneration"** → Load `ctxt/audit.md`
  - ONLY when: Running spec health checks, context validation, extraction

---

## Quick Start (New Project)

**80% of cases start with `/livespec:init`:**

```bash
# 1. Install the LiveSpec plugin (once), then in the target project:
/livespec:init            # Quick setup with sensible defaults
/livespec:init full       # Interactive: domain, compression level, workspace specs

# Creates: PURPOSE.md, specs/{workspace,foundation,strategy,features,interfaces}/,
#          initial AGENTS.md
```

No `.livespec/` copy step, no submodule, no manual folder scaffolding — the `init` skill does this. Existing legacy installations (submodule or directory copy) migrate via `/livespec:upgrade`.

---

## The 5 Phases

### Phase 0: DEFINE
Establish problem space and constraints.

**When:** Starting new project or documenting existing one
**Entry:** Project idea or codebase
**Exit:** Problem, constraints, workspace defined
**Outputs:** PURPOSE.md, specs/foundation/constraints.spec.md, specs/workspace/
**Skill:** `/livespec:init`, `/livespec:design workspace`

**Key prompts** (`references/prompts/define/`):
- `0a-quick-start.md` - Zero-question setup (5 min, defaults)
- `0b-customize-workspace.md` - Full workspace customization
- `0c-define-problem.md` / `0c-define-outcomes.md` - Articulate problem and outcomes
- `0d-assess-complexity.md` - Evaluate project complexity
- `0e-evaluate-research-needs.md` - Determine if UX research needed
- `0f-identify-constraints.md` - Document boundaries

### Phase 1: DESIGN
Design solution architecture.

**When:** After problem clear, before implementation
**Entry:** Problem and constraints defined
**Exit:** Architecture and contracts specified
**Outputs:** specs/strategy/architecture.spec.md, specs/features/, specs/interfaces/
**Skill:** `/livespec:design feature <name>`, `/livespec:design spec <type>`

**Key prompts** (`references/prompts/design/`):
- `1a-document-ux-flows.md` - Document user interaction flows (optional)
- `1b-design-architecture.md` - Define system structure
- `1c-define-behaviors.md` - Specify observable outcomes
- `1d-create-contracts.md` - Define API/data interfaces

### Phase 2: BUILD (TDD)
Implement solution using test-driven development.

**When:** After design approved
**Exit:** Tests pass, implementation matches specifications
**TDD:** Mandatory by default (tests before code, escape hatch for trivial scripts with justification)

**Key prompts** (`references/prompts/evolve/`):
- `2b-create-tests.md` - Write failing tests FIRST (RED phase)
- `2a-implement-from-specs.md` - Make tests pass (GREEN + REFACTOR phases)

### Phase 3: VERIFY
Validate solution meets requirements.

**Key prompts** (`references/prompts/evolve/`):
- `3a-run-validation.md` - Execute validation tests
- `3b-acceptance-review.md` - Stakeholder approval

### Phase 4: EVOLVE
Maintain specs; regenerate code and context when needed (continuous).

**Skill:** `/livespec:audit` (health, validate, context, extract)

**Key prompts** (`references/prompts/evolve/`):
- `4a-detect-drift.md` - Detect regeneration signals
- `4b-extract-specs.md` - Level up discoveries to specs
- `4c-sync-complete.md` - Confirm regeneration complete
- `4e-validate-extractions.md` - Review extracted specs
- `4f-document-implementation.md` - Document implementation outcomes

**Context regeneration:** `/livespec:audit context` classifies each run as MINOR (scoped patch to the affected file) or FULL (whole-tree rebuild) based on the Spec → Generated File Map in `specs/workspace/context-architecture.spec.md`, then delegates to `agents/context-builder.md` — a dedicated sub-agent that keeps this large generation task out of your session's context window.

---

## MSL Format Quick Reference

All specifications use MSL (Markdown Specification Language) with LiveSpec frontmatter extensions.

### Full Frontmatter Schema (IMP-005)

```yaml
---
type: behavior          # spec subtype — implies metaspec template
category: features      # matches directory: workspace|foundation|strategy|features|interfaces|artifacts
fidelity: behavioral    # full-detail|behavioral|decisions-only|process
criticality: CRITICAL   # CRITICAL|IMPORTANT
failure_mode: Concrete description of what breaks without this
governed-by:            # content governance only — NOT metaspec refs
  - specs/foundation/constraints.spec.md
# Per-category required fields (add whichever apply):
satisfies:              # features, foundation — what requirements this fulfills
  - specs/foundation/outcomes.spec.md (Requirement N)
guided-by:              # features — strategies that guide this spec
  - specs/strategy/architecture.spec.md
derives-from:           # strategy, foundation — parent specs
  - specs/foundation/outcomes.spec.md
supports:               # interfaces, foundation — what this enables
  - specs/features/some-feature.spec.md
applies_to:             # workspace — governance scope
  - all_projects
specifies:              # artifacts — path to deliverable
  - skills/init/SKILL.md
---
```

### Type Values

| Type | Category | Implies |
|------|----------|---------|
| `outcomes` | foundation | outcomes metaspec |
| `constraints` | foundation | constraints metaspec |
| `purpose` | foundation | purpose metaspec |
| `strategy` | strategy | strategy metaspec |
| `behavior` | features | behavior metaspec |
| `domain-model` | varies | domain-model metaspec |
| `contract` | interfaces | contract metaspec |
| `taxonomy` | workspace | taxonomy metaspec |
| `workspace` | workspace | workspace metaspec |
| `prompt` | artifacts | prompt metaspec |
| `agent` | artifacts | agent metaspec |
| `validator` | artifacts | (base) |
| `command` | artifacts | (base) |
| `diagram` | artifacts | (base) |
| `registry` | artifacts | (base) |

**Full vocabulary:** See `references/standards/vocabulary.spec.md` for all controlled terms with descriptions and usage context.

**governed-by semantics:** References content governance only (higher-level specs constraining WHAT this spec can say). Metaspec template is implied by `type` — do NOT add metaspec paths to governed-by.

### Per-Category Mandatory Fields

| Category | Required beyond base six |
|----------|--------------------------|
| workspace | `applies_to` |
| foundation | `derives-from`, `supports` |
| strategy | `derives-from` |
| features | `satisfies`, `guided-by` |
| interfaces | `supports` |
| artifacts | `specifies` |

### Minimal Spec Body

```markdown
# [Feature/Component Name]

## Requirements
- [!] [Concise description of WHAT is required, not HOW]
  - [Testable criterion 1]
  - [Testable criterion 2]
```

**Controlled vocabulary:** `references/standards/vocabulary.spec.md` — canonical definitions for all type values, category values, fidelity levels, relationship fields, phase/layer vocabulary, and registry vocabularies. Check here when unsure of correct term usage.

**Validate frontmatter:** `scripts/validate-frontmatter.sh`

---

## Folder Structure Pattern

```
your-project/
├── PURPOSE.md              # Why this exists, what success looks like
│
└── specs/
    ├── workspace/          # HOW you build (process)
    │   ├── constitution.spec.md
    │   ├── patterns.spec.md
    │   └── workflows.spec.md
    │
    ├── foundation/         # WHY (strategic outcomes and constraints)
    │   ├── outcomes.spec.md
    │   └── constraints.spec.md
    │
    ├── strategy/           # HOW (architectural approach)
    │   └── architecture.spec.md
    │
    ├── features/           # WHAT (observable outcomes)
    ├── artifacts/          # Prompts, agents, commands, validators
    └── interfaces/         # Interfaces (API/data contracts)
```

**No `.livespec/` directory.** LiveSpec methodology (skills, commands, agents) is provided by the installed Claude Code plugin, invoked via `/livespec:*` commands — not copied into the project.

---

## Development Patterns

### Naming Conventions
- Prompts: [0-4][a-z]-descriptive-name.md (e.g., `1b-design-architecture.md`)
- Specs: descriptive-name.spec.md (matches prompt or behavior)
- British English for user documentation (synchronisation, behaviour)
- American English for code elements

### Cross-Reference Updates
When renaming or moving prompts/specs, use systematic checklist:
- [ ] Source file renamed/moved (`references/prompts/[mode]/` or specs/)
- [ ] Spec frontmatter (`specifies:` or `guided-by:` field) — note: hyphenated, not underscored
- [ ] Registry entry (specs/artifacts/prompts/registry.spec.md)
- [ ] Navigation files (`references/prompts/utils/next-steps.md`)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (`scripts/validate-frontmatter.sh`)

### Spec Evolution
- NO `_old`, `_v2`, `_deprecated`, or `_backup` files
- Update specs in place (git commit captures change)
- DELETE obsolete specs: `git rm specs/features/old-spec.spec.md`
- Git history is version control system
- All relationship field names use hyphenated form (`derives-from`, `guided-by`) — never underscored

### Dogfooding Validation Workflow
**Build → USE → Validate → Commit** (catches integration issues before release)

1. Build feature according to specifications
2. USE the feature in the same session where it was built
3. Validate feature works as specified
4. Fix any integration gaps discovered
5. Commit only after successful real-world validation

---

## Development Workflows

### Spec-First Guidance Workflow (Essential Before Implementation)

**AI checks before implementation:**
1. Does `specs/features/[deliverable].spec.md` exist?
2. If NO → Pause, say: "I need a specification before implementing. Let's create specs/features/[deliverable].spec.md first using DESIGN mode"
3. Guide user to `/livespec:design`
4. If YES → Verify spec has Requirements section with [!] items, full frontmatter (type, category, fidelity, criticality, failure_mode, governed-by, plus per-category fields)
5. Then proceed to implementation

**New spec frontmatter checklist:**
- [ ] `type` set to correct subtype value
- [ ] `category` matches directory
- [ ] `fidelity` set (default by category)
- [ ] `criticality` is CRITICAL or IMPORTANT
- [ ] `failure_mode` is concrete (not vague)
- [ ] `governed-by` contains only content governance (no metaspec paths)
- [ ] Per-category mandatory fields present

### Validation Workflow

**Run validation at key checkpoints:**
- Before committing: `scripts/validate-frontmatter.sh`
- After regenerating files: `scripts/validate-purpose.sh`
- Cross-reference integrity: `references/prompts/utils/validate-project.md`

**Severity levels:**
- ERROR: Must fix before committing (missing mandatory fields, wrong type values, underscore field names)
- WARNING: Should fix soon (governed-by contains metaspec paths, missing backlinks)

### Learning Distribution Workflow

Changes flow through distribution mechanism:
1. Create template in `templates/` (if reusable content)
2. Update spec requirements (mandate template usage)
3. Update skill/prompt instructions (reference templates during generation)
4. Regenerate AGENTS.md (`/livespec:audit context`) — includes templates in distribution
5. Plugin update propagates to target projects (no manual copy step)

---

## Specification Dependencies

LiveSpec specs form a **dependency graph**, not a hierarchy.

### Dependency Structure

```
PURPOSE.md (Why - Vision)
  ↓ derives-from
specs/foundation/outcomes.spec.md (What - High-Level Requirements)
  ↓                                           ↓
specs/strategy/architecture.spec.md    (derives-from)
  ↓ guided-by (HOW)                          │
  │                                          │
  ├──→ specs/features/*.spec.md ─────────────┘
  │      satisfies (WHAT)
  │      guided-by (HOW)
  └──→ specs/interfaces/*.spec.md
```

### Frontmatter Relationship Fields (hyphenated form required)

**Upward (pointing to more abstract/durable specs):**

| Field | Meaning |
|-------|---------|
| `governed-by` | Content governance — specs constraining WHAT this spec can say |
| `satisfies` | Requirements this fulfills (WHAT business value) |
| `guided-by` | Strategies informing approach (HOW) |

**Backward (pointing to prior/source specs):**

| Field | Meaning |
|-------|---------|
| `derives-from` | Based on or evolved from another spec |
| `extends` | Extends a metaspec template |
| `informed-by` | Sourced from external research or standard |
| `supersedes` | Replaces an older spec |

**Downward (pointing to implementations):**

| Field | Meaning |
|-------|---------|
| `specifies` | Path to deliverable this spec governs (artifacts only) |
| `implements` | Realises a behaviour in code or configuration |
| `supports` | Enables or makes possible |

**Scope:**

| Field | Meaning |
|-------|---------|
| `applies_to` | Governance scope (workspace specs only) |
| `updated-by` | Agent or process that modifies this spec |

**Full vocabulary:** `references/standards/vocabulary.spec.md` — all fields with direction semantics and common usage.

**Field naming:** All relationship fields use hyphenated form. `derives-from` not `derives_from`. Validation rejects underscore variants.

---

## Context Compression

**This project uses:** Moderate compression (balanced inline/reference)
- Strategic extraction of reusable content
- Critical workflows inline, details referenced
- Target size: 30-40KB root AGENTS.md

**MSL Minimalism vs Context Compression:**
- MSL Minimalism: Content pressure (reduce WITHIN specs)
- Context Compression: Structural force (reorganize ACROSS guidance)

**Change level:** Use `/livespec:audit` (compression audit workflow)

---

## Session Completion (ACTIVE MONITORING REQUIRED)

**YOU MUST proactively monitor and recommend session completion.**

### Trigger Detection

- **Context Threshold (>100K tokens):** "We've used [X]K tokens (>50% of budget). I should complete this session now."
- **Task Completion (all todos done):** "All tasks complete! Let me run session completion."
- **Natural Stopping Point:** "Good stopping point. Should I complete the session?"
- **User Appears Stuck (3+ failed attempts):** "This seems challenging. Let me complete the session — starting fresh often helps."

**Tool:** `/livespec:learn`

### Unified Session Analysis

**One action at session end:** `/livespec:learn`

**Compliance Scoring:**

Process Compliance (0-8 points):
- Layer 1 (TodoWrite): 0-2 points
- Layer 2 (Validation): 0-2 points
- Layer 3 (Plan Mode): 0-3 points
- Layer 4 (Pre-commit): 0-1 point

Focus Efficiency (0-13 points):
- Tool Efficiency: 0-5 points (Read/Grep/Glob vs Bash)
- Context Navigation: 0-3 points (AGENTS.md usage)
- Task Focus: 0-2 points (scope adherence)
- Context Efficiency: 0-3 points (signal-to-noise ratio)

**Levels:** Perfect (100%): 8/8 + 11+ focus | Good (75-99%): 6-7 + 8+ | Fair (50-74%): 4-5 | Poor (<50%): 0-3

### Post-Session Flow

```
/livespec:learn → commit → fresh session
```

**Data saved to:** `~/.claude/livespec/compliance/` and `~/.claude/livespec/feedback/`

---

## Common Anti-Patterns

**Skipping Phase 0**
- Bad: Jump straight to coding
- Good: Create PURPOSE.md and workspace specs first (`/livespec:init`)

**Over-specification**
- Bad: "Button must be exactly 120px wide with #007bff color"
- Good: "Submit button must be clearly visible"

**Ignoring Regeneration Signals**
- Bad: Let specs and code diverge, patching code instead of specs
- Good: Level up discoveries to specs, regenerate code when needed

**Wrong Criticality**
- Bad: Everything marked CRITICAL
- Good: Only truly critical requirements marked CRITICAL

**Metaspec paths in governed-by**
- Bad: `governed-by: [references/standards/metaspecs/behavior.spec.md]`
- Good: `governed-by: []` (format implied by `type: behavior`)

**Underscore field names**
- Bad: `derives_from:`, `guided_by:`
- Good: `derives-from:`, `guided-by:`

**Assuming a `.livespec/` folder exists**
- Bad: `cp -r livespec/dist/ .livespec/` or reading `.livespec/prompts/...`
- Good: LiveSpec is a plugin — use `/livespec:*` skill commands; reference `references/prompts/` only when working inside the LiveSpec repo itself

---

## Reference Library (Deep Detail Navigation)

AGENTS.md provides 80% coverage. For deep detail, fetch these references:

### Mode Specialists (ctxt/)
- **ctxt/define.md** - Define mode (problem definition, workspace setup)
- **ctxt/design.md** - Design mode (architecture, behaviors, contracts)
- **ctxt/evolve.md** - Evolve mode (implementation, validation, drift, extraction)
- **ctxt/audit.md** - Audit mode (spec health, frontmatter compliance, learning capture, context regeneration)

### Domain Specialists (ctxt/domains/)
- **ctxt/domains/governance.md** - Governance patterns (methodology development)

### Utility Specialists (ctxt/)
- **ctxt/session.md** - Session analysis and learning
- **ctxt/msl-audit.md** - Minimalism enforcement

### Conventions (How to Structure)
- **`references/standards/vocabulary.spec.md`** - Canonical controlled vocabulary (type values, fidelity levels, relationship fields, phases, layers)
- **`references/standards/metaspecs/base.spec.md`** - Base frontmatter schema
- **`references/standards/conventions/context-tree.spec.md`** - Context tree structure and generation governance
- **`specs/workspace/folder-organization.spec.md`** - Folder organization
- **`references/standards/conventions/dependencies.spec.md`** - Spec relationships (if present) or see Specification Dependencies above
- **`references/standards/conventions/naming.spec.md`** - File naming patterns (if present) or see Development Patterns above

### Metaspecs (Templates for Spec Types)
- **`references/standards/metaspecs/base.spec.md`** - Base frontmatter schema for all specs
- **`references/standards/metaspecs/prompt.spec.md`** - Prompt artifacts
- **`references/standards/metaspecs/agent.spec.md`** - Agent artifacts

### Guides (How to Apply)
- **`references/guides/msl-minimalism.md`** - MSL decision framework
- **`references/guides/terminology.md`** - Controlled vocabulary usage guide

### Validation Scripts
- **`scripts/validate-frontmatter.sh`** - Check all spec frontmatter (IMP-005)
- **`scripts/upgrade-to-v5.sh`** - Migrate legacy submodule/copy installs to the v5 plugin

### Plugin Skills (Invoke Directly)
- **`/livespec:init`** - Initialize a new project
- **`/livespec:design`** - Create and refine specifications (Phase 0 + 1)
- **`/livespec:audit`** - Spec health, validation, context generation (Phase 3 + 4)
- **`/livespec:learn`** - Session completion, compliance, learning capture
- **`/livespec:sweep`** - Multi-project portfolio audit
- **`/livespec:birth`** - Incubate/birth child projects from a parent LiveSpec project
- **`/livespec:go`** - Intent-based router to the right skill
- **`/livespec:upgrade`** - Migrate legacy (submodule/copy) installs to the v5 plugin

---

*Agent configuration for LiveSpec v5.5.0*
*For specialized contexts, see ctxt/ directory*
*Generated from workspace specs*
