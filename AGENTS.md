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

A file is governed only when a spec's `specifies:` names it (file, directory or glob). The gate asks `scripts/validate-coverage.sh --which <path>`, so the gate and the coverage report cannot disagree. A mention in a spec's text or a colocated spec confers nothing.

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

Related files may share one spec (e.g. `specs/features/documentation.spec.md` for all README/GUIDE files). Test: "Do these files serve the same observable purpose?" Yes → one spec; no → separate specs.

### No Exceptions

- "This is obvious" → Still permanent → Needs spec
- "Lock files are auto-generated" → Covered by project-config.spec.md
- "Just infrastructure" → If permanent, needs spec
- "Everyone knows what [X] is" → Your requirements may differ → Needs spec

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

### 3. Spec-First Bootstrap, Not Implementation Methodology
- LiveSpec's involvement in Phase 2 (BUILD) stops at spec-first enforcement (a spec must exist before implementation starts)
- LiveSpec does not mandate TDD or any other implementation methodology — that's the coding agent's domain
- `project.yaml` → `methodology.tdd: optional` governs this per-project; default is optional, not mandatory
- `references/guides/tdd.md` is optional reference material for teams who want structured TDD discipline — call on it deliberately, don't treat it as a default
- Tests, when written, should map to behavior specs (specs/features/ → tests → implementation) regardless of methodology chosen

### 4-11. Remaining principles
- **Dogfooding:** LiveSpec uses its own methodology; no custom tooling required
- **Simplicity Over Features:** file operations and AI prompts only; standard markdown and folders; define edges, not paths
- **Living Documentation:** specs evolve continuously, code is regenerable; level discoveries up to the right spec layer
- **Governance Framework Awareness:** patterns here are domain-specific, not universal
- **Active Agent Guidance:** AGENTS.md is definitive cacheable context (<100KB), 80/20 coverage, active verification prompts, structural enforcement
- **Clean Evolution (LiveSpec only):** no backwards compatibility; old patterns deleted, not deprecated; users upgrade via `/livespec:upgrade`; NOT imposed on projects using LiveSpec
- **Progressive Disposability:** PURPOSE most durable, then requirements, strategy, behaviours; code most disposable
- **Spec Health:** "time to refine specs" is a positive signal; EVOLVE runs continuously

---

## CRITICAL: Toolchain vs Project — Agent-Agnostic Boundary

LiveSpec binds every project to eight constraints (`specs/foundation/constraints.spec.md`). The one agents get wrong most often:

**Agent-agnostic applies to the PROJECT, not the authoring toolchain.**

| Layer | Covers | Harness coupling |
|-------|--------|-------------------|
| Authoring toolchain | `/livespec:init`, workspace design, `/livespec:audit` | May be harness-specific (Claude Code plugin) |
| Project artefacts | `PURPOSE.md`, `specs/`, `AGENTS.md`, `ctxt/` | Must be harness-neutral — buildable, reviewable, deliverable by an agent with NO LiveSpec tooling installed |

**Toolchain Independence:** the toolchain enhances LiveSpec work; it is never a hard dependency for building a project's deliverables. Generated `AGENTS.md` must be self-sufficient for the 80% case without fetching toolchain files, and must never instruct the reader to run a command the project doesn't ship.

**No Action at a Distance:** a project's behaviour is a function of what it has *accepted*, never of what its toolchain happens to be today. Conventions a project depends on are vendored as local files (`scripts/vendor-conventions.sh` → `specs/workspace/standards/`, stamped with `vendored-from`/`source-version`/`source-hash` provenance) — never resolved through a version-pinned or machine-local plugin path. Upgrades present changes for explicit acceptance; they never apply silently.

**Remaining five constraints** (MSL Minimalism, No Framework Lock-in, Testable Behaviors, Spec Durability, Abstraction Purity) are detailed in `specs/foundation/constraints.spec.md`.

**Before asserting a path in project context, ask:** does it resolve inside the project, or only inside the installed plugin? If only the plugin, it doesn't belong in `AGENTS.md`/`ctxt/`. `scripts/validate-constraints.sh` checks this mechanically.

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
- "What are the standard interfaces?" → interfaces/ (format definitions, e.g. the validator output contract)

**Five-way test for specs/:** outcome or hard constraint → foundation/; applies across the whole product → strategy/; observable behavior → features/; something built and distributed → artifacts/; format, contract or discovery interface → interfaces/. Distributable framework (skills/, commands/, agents/, templates/, references/) lives OUTSIDE specs/.

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

**Note:** `registries/` (project root, not specs/) holds accepted-current-state data, tiered by requirement: required (decisions, debt, security), recommended (conflicts, gaps), optional (dependencies, issues) — see Reference Library below. It is not a specs/ category and isn't part of this classification.

---

## CRITICAL DISTINCTION: Phases vs Layers

**Common confusion for new users:** LiveSpec uses numbers in two different contexts with different meanings.

### Two Different Numbering Systems

**5 Phases (Temporal Workflow)** - WHEN you do things:
- **Phase 0**: DEFINE (problem space)
- **Phase 1**: DESIGN (solution architecture)
- **Phase 2**: BUILD (implementation — spec-first enforcement only; methodology e.g. TDD is optional and the coding agent's choice)
- **Phase 3**: VERIFY (validation)
- **Phase 4**: EVOLVE (maintenance)
- **Invocation**: `/livespec:init`, `/livespec:design`, `/livespec:audit`, `/livespec:learn` (skills carry the phase workflow directly; no phase-numbered prompt folders to browse manually)

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

**Software:** `features/user-features/`, `features/system/`, `interfaces/api/v1/`. **Governance (LiveSpec):** `features/prompts/`, `features/processes/`, `artifacts/` (prompts, agents, commands), `interfaces/schemas/`. workspace/, foundation/ and strategy/ are the same in every domain.

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
#          registries/{decisions,debt,security}.md (required tier),
#          specs/workspace/standards/ (vendored conventions, with provenance),
#          project.yaml (livespec.version = the accepted LiveSpec version),
#          .git/hooks/pre-commit (installed validation hook), initial AGENTS.md
```

No `.livespec/` copy step, no submodule, no manual folder scaffolding — the `init` skill does this. Existing legacy installations (submodule or directory copy) migrate via `/livespec:upgrade`: `scripts/upgrade-to-v5.sh` reads one folder-migration table (documented retired folders move automatically; any other folder gets a proposed target and nothing moves until you confirm it, via `--map old=new`; unknown folders are reported, never moved; no move overwrites a file). Upgrade then brings links to the current model (`scripts/validate-crossrefs.sh --fix`) and records the accepted version in `project.yaml` (`livespec.version`) only once you accept the upgrade. `--detect-only` reports the layout and every version signal, flagging disagreement.

---

## The 5 Phases

### Phase 0: DEFINE
Establish problem space and constraints.

**When:** Starting new project or documenting existing one
**Entry:** Project idea or codebase
**Exit:** Problem, constraints, workspace defined
**Outputs:** PURPOSE.md, specs/foundation/constraints.spec.md, specs/workspace/
**Skill:** `/livespec:init` (quick-start or full interactive setup), `/livespec:design workspace`

### Phase 1: DESIGN
Design solution architecture.

**When:** After problem clear, before implementation
**Entry:** Problem and constraints defined
**Exit:** Architecture and contracts specified
**Outputs:** specs/strategy/architecture.spec.md, specs/features/, specs/interfaces/
**Skill:** `/livespec:design feature <name>` (architecture, behaviors, contracts, optional UX flow docs and research-needs check — all inline in the skill), `/livespec:design spec <type>` for direct creation

### Phase 2: BUILD
Implement the solution.

**When:** After design approved
**Exit:** Implementation matches specifications
**LiveSpec's role here is narrow:** spec-first bootstrap enforcement only (see Spec-First Protocol above) — checking a spec exists before implementation begins. LiveSpec does not prescribe *how* you implement (TDD, other test strategies, or none) — that choice belongs to the coding agent and team.
**TDD:** Optional, not mandated (`project.yaml` → `methodology.tdd: optional`). Use `references/guides/tdd.md` deliberately if you want structured TDD discipline; it is reference material, not a default workflow.

### Phase 3: VERIFY
Validate solution meets requirements.

**Skill:** `/livespec:audit validate` (the seven validators: frontmatter compliance, cross-reference integrity and traceability to PURPOSE.md, constraint integrity, registry integrity, PURPOSE.md boundary, spec coverage, context currency). CI (`.github/workflows/validate.yml`) runs all seven on every push and pull request, cross-references with `--strict`.

### Phase 4: EVOLVE
Maintain specs; regenerate code and context when needed (continuous).

**Skill:** `/livespec:audit` (health, validate, context, extract)

**Context regeneration:** `/livespec:audit context` checks `scripts/validate-context.sh` (each generated file is current, stale or unstamped; `--changed` lists sources changed since the stamp; the hash covers PURPOSE.md and every spec, strategy and interfaces included, ; only flat `ctxt/` files and `ctxt/domains/` are stamped). It classifies each run as MINOR (scoped patch to the affected file) or FULL (whole-tree rebuild) using the Spec → Generated File Map in `specs/workspace/context-architecture.spec.md`. Any unstamped file, `--changed` printing `unknown`, or a missing map means FULL. When no changed source feeds a generated file, it re-stamps without regenerating. Otherwise it delegates to `agents/context-builder.md`, a dedicated sub-agent that keeps this large generation task out of your session's context window. The builder's last step is `scripts/validate-context.sh --stamp`, which writes a source-hash comment line at the end of every generated file; never write or edit that line by hand.

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
satisfies:              # features, artifacts — requirement or spec this fulfils (upward)
  - specs/foundation/outcomes.spec.md (Requirement N)
guided-by:              # features — strategies that guide this spec
  - specs/strategy/architecture.spec.md
derives-from:           # strategy, foundation — parent specs
  - specs/foundation/outcomes.spec.md
supports:               # GENERATED (any parent) — specs whose upward links reach this one; never hand-write
  - specs/features/some-feature.spec.md
applies_to:             # workspace — governance scope
  - all_projects
specifies:              # artifacts (also features, interfaces) — files governed: path, directory or glob
  - skills/init/SKILL.md
---
```

### Type Values

By category (each type implies its metaspec template): foundation `outcomes`, `constraints`, `purpose`; strategy `strategy`; features `behavior`; interfaces `contract`; workspace `workspace`, `taxonomy`; artifacts `prompt`, `agent`, `validator`, `command`, `diagram`, `registry`; `domain-model` varies.

**Full vocabulary:** See `references/standards/vocabulary.spec.md` for all controlled terms with descriptions and usage context.

**governed-by semantics:** References content governance only (higher-level specs constraining WHAT this spec can say). Metaspec template is implied by `type` — do NOT add metaspec paths to governed-by.

### Per-Category Mandatory Fields

| Category | Required beyond base six |
|----------|--------------------------|
| workspace | `applies_to` |
| foundation | `derives-from` |
| strategy | `derives-from` |
| features | `satisfies`, `guided-by` |
| interfaces | none (crossrefs validation checks they link upward) |
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

**Validate frontmatter:** `scripts/validate-frontmatter.sh`. `supports` is never mandatory: `scripts/validate-crossrefs.sh --fix` generates it, never write it by hand.

---

## Folder Structure Pattern

`PURPOSE.md` plus `specs/{workspace,foundation,strategy,features,artifacts,interfaces}/`. workspace = HOW you build (constitution, patterns, workflows, taxonomy); foundation = WHY; strategy = HOW (architecture); features = WHAT (behaviours); artifacts = prompts, agents, commands, validators; interfaces = contracts. **No `.livespec/` directory:** methodology is provided by the installed plugin via `/livespec:*` commands.

---

## Development Patterns

### Naming Conventions
- Prompts (LiveSpec repo only, under `references/prompts/`): [0-4][a-z]-descriptive-name.md
- Specs: descriptive-name.spec.md
- British English for user documentation, American for code elements

### Cross-Reference Updates
When renaming or moving prompts/specs, use systematic checklist:
- [ ] Source file renamed/moved (`references/prompts/[mode]/` or specs/)
- [ ] Spec frontmatter (`specifies:` and any upward link naming the moved spec) — hyphenated, not underscored
- [ ] Registry entry (specs/artifacts/prompts/registry.spec.md)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (`scripts/validate-crossrefs.sh --fix`, then `scripts/validate-frontmatter.sh`)

### Spec Evolution
- NO `_old`, `_v2`, `_deprecated`, or `_backup` files
- Update specs in place; delete obsolete ones with `git rm` (git history is the version control)
- All relationship field names use hyphenated form (`derives-from`, `guided-by`) — never underscored

### Dogfooding Validation Workflow
**Build → USE → Validate → Commit:** build per the specs, use the feature in the same session, fix integration gaps found, commit only after real-world validation.

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

**Run validation at key checkpoints (seven validators, all in `scripts/`):**
- Frontmatter compliance: `scripts/validate-frontmatter.sh` (accepts `[--verbose] [--strict] [path]`; scans `specs/` by default)
- Cross-reference integrity and traceability: `scripts/validate-crossrefs.sh` (accepts `[--verbose] [--strict] [--fix [--prune]] [path]`) — targets resolve from the repository root, upward links reach PURPOSE.md (specs with `vendored-from` provenance are exempt), `supports:` mirrors them
- Constraint integrity: `scripts/validate-constraints.sh` (accepts `[--verbose]`) — every `/livespec:` command, `scripts/*.sh` reference, and `routes-to:` target resolves; flags retired-layout references (`.livespec/`, `.livespec-version`); in the toolchain repo only, `ignored-shipped-file` errors on git-ignored shipped files
- Registry integrity: `scripts/validate-registries.sh` (required registries present, entries well-formed, no work-item-style summaries, staleness flagged)
- PURPOSE.md boundary: `scripts/validate-purpose.sh` (accepts `[path]`, defaults to `./PURPOSE.md`)
- Spec coverage: `scripts/validate-coverage.sh` — which tracked files a spec's `specifies:` governs; reported, never enforced (exit 0). `--which <path>` answers which spec governs a path (exit 1 when a spec is needed and none governs it)
- Context currency: `scripts/validate-context.sh [--strict] [--json] | --stamp | --changed` — each generated context file is current, stale or unstamped against the hash of its sources; findings are warnings, errors under `--strict`
- Full sweep: `/livespec:audit validate`

**Machine-readable output:** every validator accepts `--json` and then writes exactly one JSON document to stdout (`schema_version`, `validator`, `livespec_version`, `findings`; each finding has `id`, `rule`, `severity`, `path`, `message`). Exit codes match text mode (0 no errors, 1 errors, 2 usage error). Output is deterministic, so consumers compare findings by `id`. Contract: `specs/interfaces/formats/validator-output.spec.md`; shared helper `scripts/validator-output.sh` (sourced, not run directly).

**Installed automatically:** `scripts/setup-hooks.sh` writes `.git/hooks/pre-commit`, chaining to (not replacing) any existing hook, and vendors the hooked validators and the scripts this context instructs into the project's `scripts/` with `vendored-from`/`source-version`/`source-hash` provenance. The hook validates only staged `*.spec.md` files: frontmatter and cross-references block the commit, constraints is advisory. It also runs the project's own tracked pre-commit script when it has one. Skips with a notice when no validators resolve; `--check` reports where each resolves.

**Severity levels:**
- ERROR: Must fix before committing (missing mandatory fields, wrong type values, unresolved link targets, unresolved `/livespec:` command/script/route reference)
- WARNING: Should fix soon (governed-by contains metaspec paths, `supports:` out of step with upward links, spec not reaching PURPOSE.md, link pointing down a layer, retired `implements:`, per-category mandatory field declared empty, stale or unstamped context, ungoverned file). `--strict` promotes the traceability and empty-field warnings to errors

**Empty relationship fields:** a declared field with no values asserts the relationship does not exist: normal for optional fields (empty `governed-by`), a warning where the category mandates it. `--strict` promotes those to errors once the graph is populated.

### Learning Distribution Workflow

Template in `templates/` (if reusable; research templates under `templates/research/`) → spec requirement mandating it → skill instructions referencing it → regenerate AGENTS.md (`/livespec:audit context`) → plugin update reaches target projects (no copy step).

---

## Specification Dependencies

LiveSpec specs form a **dependency graph**, not a hierarchy.

**The one rule: write links upward only.** Each spec names what it serves; the reverse direction (`supports:`) is generated, so it cannot drift.

### Dependency Structure

```
PURPOSE.md (Why - Vision)
  ↑ derives-from (foundation and workspace specs only)
specs/foundation/*  specs/workspace/*
  ↑ derives-from / satisfies / governed-by
specs/strategy/*
  ↑ guided-by / derives-from
specs/features/*  specs/interfaces/*  specs/artifacts/*
  ↓ specifies (to deliverable files)
```

### Frontmatter Relationship Fields (hyphenated form required)

**Upward (authored by hand, pointing to the same layer or higher):**

| Field | Meaning |
|-------|---------|
| `derives-from` | Based on a parent spec (strategy → outcomes, workspace → PURPOSE.md or constitution) |
| `governed-by` | Content governance — specs constraining WHAT this spec can say (constraints, workspace patterns, contracts) |
| `satisfies` | Requirement, outcome or spec this fulfils (WHAT business value). A spec that realises another spec `satisfies` it |
| `guided-by` | Strategy or interface informing approach (HOW). Not for requirements |

**Downward:**

| Field | Meaning |
|-------|---------|
| `specifies` | Files the spec governs: a path, directory or glob (`*` within a segment, `**` across). Features, interfaces and artifacts. Files carry no link back; a file's governing spec is the one whose `specifies:` names it |
| `supports` | **Generated** — specs whose upward links resolve to this one. Written by `scripts/validate-crossrefs.sh --fix`, never by hand |

**Retired:** `implements` no longer exists. `--fix` moves existing values into `satisfies:`.

**Other:** `informed-by` (external research or standards, never a parent), `extends` (metaspec template), `supersedes`, `updated-by`, `applies_to` (workspace scope).

### Link Rules (checked by validate-crossrefs.sh)

- Links are written from the repository root and must resolve to a real spec (or PURPOSE.md)
- An upward link points to the same layer or higher; a strategy may not derive from a feature (the lower spec links up)
- PURPOSE.md is a direct parent only of foundation and workspace specs; features reach it through them
- Every spec must reach PURPOSE.md through its upward links; cycles, self-references and links to non-specs are reported
- Behaviours carry dual linkage: `satisfies` (outcome, WHAT) plus `guided-by` (strategy, HOW)
- Edit the child's upward link, then run `bash scripts/validate-crossrefs.sh --fix`; `--fix` keeps a `supports:` entry with no upward link back and reports it (add the link, or run `--fix --prune` to remove it)

**Field naming:** All relationship fields use hyphenated form. `derives-from` not `derives_from`. Validation rejects underscore variants.

**Full guide:** `references/guides/frontmatter-relationships.md`; vocabulary in `references/standards/vocabulary.spec.md`.

---

## Context Compression

**This project uses:** Moderate compression (balanced inline/reference)
- Strategic extraction of reusable content
- Critical workflows inline, details referenced
- Target size: 30-40KB root AGENTS.md

MSL Minimalism reduces content WITHIN specs; Context Compression reorganises ACROSS guidance. Change level via `/livespec:audit`.

---

## Session Completion (ACTIVE MONITORING REQUIRED)

**Proactively recommend completion** when: context passes ~100K tokens, all todos are done, a natural stopping point is reached, or the user is stuck after 3+ failed attempts. Say so plainly ("All tasks complete. Let me run session completion.").

**Tool:** `/livespec:learn` (one action: compliance scoring, learning capture), then commit and start a fresh session. Process compliance is scored 0-8 (TodoWrite gate 0-2, validation 0-2, plan mode 0-3, pre-commit 0-1) and focus efficiency 0-13 (tool efficiency, AGENTS.md navigation, task focus, signal-to-noise). Data is saved under `~/.claude/livespec/compliance/` and `feedback/`. Detail: `ctxt/session.md`.

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

**Metaspec paths in governed-by**
- Bad: `governed-by: [references/standards/metaspecs/behavior.spec.md]`
- Good: `governed-by: []` (format implied by `type: behavior`)

**Assuming a `.livespec/` folder exists**
- Bad: `cp -r livespec/dist/ .livespec/` or reading `.livespec/prompts/...`
- Good: LiveSpec is a plugin — use `/livespec:*` skill commands; reference `references/prompts/` only when working inside the LiveSpec repo itself

**Coupling project artefacts to the toolchain**
- Bad: `AGENTS.md` instructs the reader to run a plugin-only script the project doesn't ship, or a spec resolves through the plugin's install path
- Good: Vendor the convention (`scripts/vendor-conventions.sh` → `specs/workspace/standards/`) so the project carries its own local copy with provenance

**Hand-writing `supports:` or using `implements:`**
- Bad: Editing a parent's `supports:` list, or declaring `implements:` on a spec
- Good: Add the upward link (`satisfies`, `guided-by`, `derives-from`, `governed-by`) on the child, then `scripts/validate-crossrefs.sh --fix`

**Linking a feature straight to PURPOSE.md, or a strategy down to a feature**
- Good: Features `satisfies` a foundation outcome and are `guided-by` a strategy; links point to the same layer or higher

**Hand-editing the context source stamp (`livespec-context-sources` line)**
- Good: Regenerate context, then `scripts/validate-context.sh --stamp`

**Treating registries as backlogs**
- Bad: Registry entry reads "implement X" or "fix Y" (that's a ticket, not a state observation)
- Good: Registry entry reads "X is missing because..." or "Y is accepted as a known limitation because..." — see `specs/features/registry-specs.spec.md`

---

## Reference Library (Deep Detail Navigation)

AGENTS.md provides 80% coverage. For deep detail, fetch these:

**Sub-agents (ctxt/):** `ctxt/define.md` (problem definition, workspace setup), `ctxt/design.md` (architecture, behaviors, contracts), `ctxt/evolve.md` (implementation, validation, drift, extraction), `ctxt/audit.md` (spec health, validators, learning capture, context regeneration), `ctxt/session.md` (session analysis), `ctxt/msl-audit.md` (minimalism), `ctxt/domains/governance.md` (methodology development).

**Conventions:** `references/standards/vocabulary.spec.md` (canonical controlled vocabulary), `references/standards/metaspecs/{base,behavior,strategy,prompt,agent}.spec.md` (spec-type templates), `references/standards/conventions/{context-tree,dependencies,naming,folder-structure}.spec.md`, `specs/workspace/folder-organization.spec.md` (this project's layout, including registries/).

**Guides:** `references/guides/msl-minimalism.md`, `frontmatter-relationships.md` (which link field to use), `terminology.md`, `context-positioning.md`, `progressive-disposability.md`.

**Registries (accepted current state, tiered):** required `decisions.md` (`DEC-`), `debt.md` (`DEBT-`), `security.md` (`SEC-`); recommended `conflicts` (`CON-`), `gaps` (`GAP-`); optional `dependencies` (`DEP-`), `issues` (`ISSUE-`). Standards in `references/standards/registries/`; behaviour in `specs/features/registry-specs.spec.md`. `registries/decisions.md` DEC-002 to DEC-009 record the spec-checker design decisions. Registries record what is known true now, not desired state (specs) or work (tickets).

**Behaviour specs:** `specs/features/automation.spec.md` (sweep, version migration), `specs/features/project-config.spec.md` (`project.yaml`; `livespec.version` is the accepted version, written by init, bumped by upgrade), `specs/artifacts/validators/{ci-validation,validate-coverage,validate-context,validator-output,validate-constraints,setup-hooks,vendor-conventions}.spec.md`, `specs/interfaces/formats/validator-output.spec.md` (`--json` contract and rule codes).

### Scripts (`scripts/`)
- **Seven validators:** `validate-frontmatter.sh`, `validate-crossrefs.sh`, `validate-constraints.sh`, `validate-registries.sh`, `validate-purpose.sh`, `validate-coverage.sh`, `validate-context.sh`; all accept `--json`; flags in Validation Workflow above
- **`scripts/validator-output.sh`** - Shared helper rendering the `--json` envelope (sourced, not run)
- **`scripts/check-requires-spec.sh`** `path/to/file` - Layer 2 spec-first gate; delegates to `validate-coverage.sh --which`
- **`scripts/setup-hooks.sh`** `[--check] [--force]` - Install the pre-commit hook; vendors hooked validators and instructed scripts with provenance
- **`scripts/vendor-conventions.sh`** `[--check] [--source DIR] [--target DIR]` - Vendor conventions into `specs/workspace/standards/` with provenance
- **`scripts/upgrade-to-v5.sh`** `[--detect-only] [--dry-run] [--map old=new]` - Table-driven migration of legacy installs; reports a retired `ctxt/phases/` or `ctxt/utils/` layout and never moves it
- **`scripts/remediate-references.sh`** `[--check]` - Drops metaspec/template entries from `governed-by`
- **`scripts/sweep-projects.sh`** `[--json] [--root <path>] [--stale-days <N>]` - Portfolio audit (backs `/livespec:sweep`)

### Plugin Skills
`/livespec:init` (new project), `/livespec:design` (create and refine specs, Phases 0-1), `/livespec:audit` (health, validate, context; Phases 3-4), `/livespec:learn` (session completion), `/livespec:sweep` (portfolio audit), `/livespec:birth` (incubate child projects), `/livespec:go` (intent router; "feedback" routes to the feedback-report prompt `references/prompts/utils/feedback-report.md`), `/livespec:upgrade` (migrate legacy installs).

---

*Agent configuration for LiveSpec v5.11.0*
*For specialized contexts, see ctxt/ directory*
*Generated from workspace specs*

<!-- livespec-context-sources: sha256:05325e2061ac33a004d5b3b90e0e80bea7a2ac2483e70b5f3cf692cbfc407461 n=96 -->
