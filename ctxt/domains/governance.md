# Governance Domain Patterns

> **Generated file** - Do not edit directly. Regenerate using `/livespec:audit context`

Sub-agent context for governance domain projects and methodology development.

## Summary

Governance domain projects produce methodology frameworks, policies, procedures, and process documentation. LiveSpec itself is a governance project — it develops specifications about specification-driven development.

**Key characteristic:** Outputs are guidance for other projects, not user-facing products.

## Domain-Specific Patterns

### Dogfooding Pattern (Critical for Governance)

**What it means:**
- Governance projects use their own methodology to develop themselves
- LiveSpec uses LiveSpec methodology to evolve LiveSpec
- Policies are written following the policy-writing framework
- Procedures are documented following the procedure-documentation process

**Implementation:**
```
LiveSpec (governance project):
├── specs/workspace/           # HOW LiveSpec develops itself (dogfooding)
│   ├── constitution.spec.md   # LiveSpec's development principles
│   ├── patterns.spec.md       # LiveSpec's conventions
│   └── workflows.spec.md      # LiveSpec's process
│
├── specs/strategy/            # LiveSpec's architecture
│   └── architecture.spec.md   # Two-branch model, distribution approach
│
├── specs/features/            # LiveSpec's methodology behaviors
│   ├── context-generation.spec.md
│   ├── mandatory-frontmatter.spec.md
│   └── ...
│
└── specs/artifacts/           # LiveSpec's deliverables (prompts, agents, commands)
    ├── prompts/*.spec.md
    ├── agents/*.spec.md
    └── commands/*.spec.md
```

### Framework Distribution Pattern

**Challenge:** Governance projects produce frameworks that other projects adopt.

**Solution (v5, plugin-based):**
```
livespec (source repo):
├── specs/                     # Source of truth (specifications)
├── skills/                    # Skill definitions (init, design, audit, learn, sweep, birth, go, upgrade)
├── commands/                  # Slash command routing (thin wrappers to skills/)
├── agents/                    # Sub-agent definitions (context-builder)
├── references/                # Prompts, guides, standards (LiveSpec's own working detail)
└── AGENTS.md                  # Generated (from specs/workspace/)

target-project (user's repo):
└── (no copied framework files — the Claude Code plugin provides
    /livespec:* skills directly; project only has specs/ and AGENTS.md)
```

**Key insight:** `specs/` governs LiveSpec's own development. The plugin (`skills/`, `commands/`, `agents/`) is what target projects invoke — nothing is copied into their repos. This replaced the pre-v5 `dist/` + submodule/copy model entirely.

### Specs About Specs Pattern

**Governance projects have specs at three levels:**

1. **Meta-level** (specs about the framework):
   ```
   specs/features/context-generation.spec.md
   → Defines what context generation does as a behavior
   ```

2. **Artifact-level** (specs about specific deliverables):
   ```
   specs/artifacts/agents/context-builder.spec.md
   → Defines what the context-builder agent does
   ```

3. **Metaspec level** (templates for specs, in references/):
   ```
   references/standards/metaspecs/base.spec.md
   → Defines structure required of ALL specs (IMP-005)
   ```

**Avoid confusion:** Metaspecs are templates, not instances. They live in `references/standards/` not `specs/`.

### Taxonomy for Governance Projects

Governance taxonomy (`specs/workspace/taxonomy.spec.md`) declares:

```yaml
domain: governance
workspace_scope: [constitution, patterns, workflows, taxonomy]
specs_boundary: specifications_only
```

**Five-way classification for specs/:**
1. "Is this a strategic outcome or hard constraint?" → **foundation/**
2. "Does this apply across the whole product?" → **strategy/**
3. "Does this describe observable methodology behavior?" → **features/**
4. "Does this describe something we build and distribute?" → **artifacts/**
5. "Does this define a format, contract, or discovery interface?" → **interfaces/**

**Orthogonal:** "Is this ABOUT how we work?" → **workspace/**

### Governance Frontmatter Patterns

**Policy/behavior specs in governance projects:**
```yaml
---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without this, the methodology exhibits observable failure
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement N: Name)
guided-by:
  - specs/strategy/architecture.spec.md
derives-from:
  - registries/debt.md (DEBT-NNN)  # if derived from a known accepted debt item
---
```

**Artifact specs in governance projects:**
```yaml
---
type: agent
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without spec, agent implementation lacks requirements
governed-by: []
specifies:
  - agents/context-builder.md
---
```

### Learning Distribution Pattern

**When governance project learns something:**

1. **Capture learning in template:**
   ```
   templates/agents/spec-first-enforcement.md
   → Reusable verification content
   ```

2. **Update spec to mandate template:**
   ```
   specs/workspace/workflows.spec.md
   → "Agents use spec-first-enforcement template"
   ```

3. **Update agent to reference template:**
   ```
   agents/context-builder.md
   → Includes template in AGENTS.md generation
   ```

4. **Regenerate AGENTS.md:**
   ```
   /livespec:audit context
   → AGENTS.md now contains template content
   ```

5. **Plugin ships the update:**
   ```
   Users on the installed plugin receive the improved skill/template
   directly — no manual copy step, no dist/ sync
   ```

**Result:** Learnings flow: violations → templates → specs → skills/agents → AGENTS.md → plugin users.

## Folder Organization (Governance Projects)

### Workspace Scope Test

**"Is this ABOUT the workspace or IN the workspace?"**

**ABOUT → workspace/ (operating context):**
- constitution.spec.md — Development principles
- patterns.spec.md — MSL format, naming
- workflows.spec.md — Spec-first workflow
- taxonomy.spec.md — Project classification

**IN → appropriate layer (deliverables):**
- architecture.spec.md — How LiveSpec is structured → strategy/
- context-generation.spec.md — What context generation does → features/
- context-builder.spec.md — What the agent does → artifacts/agents/

### Specs Boundary

**specs/ = specifications only (not the plugin implementation itself)**

**Test:** "Is this defining WHAT the methodology does, or IS this the methodology's runnable artifact?"
- Defining WHAT → specs/ (specifications)
- IS the runnable artifact → skills/, commands/, agents/ (plugin implementation)

## Common Behaviors (Governance Domain)

### Methodology Evolution

- Learnings captured in templates
- Violations trigger methodology updates
- Changes ship via the plugin (skills/commands/agents), not a copy step
- Registries are tiered: required (`decisions.md`, `debt.md`, `security.md`), recommended (`conflicts.md`, `gaps.md`), optional (`dependencies.md`, `issues.md` — only without a ticketing platform). They record accepted current state — known tensions, not a backlog. Entries read as state observations ("X is missing because...", "Y debt is accepted because..."); when an entry becomes actionable it graduates to a ticket and is removed from the registry. See `specs/features/registry-specs.spec.md`.

### Framework Development

- Framework has specifications (behaviors, prompts, guides)
- Framework dogfoods its own methodology
- Framework distributed as a Claude Code plugin (no submodule/copy)

## Examples

### Example 1: Adding New Skill (Governance Project)

```bash
# Step 1: Create behavior spec FIRST
Use /livespec:design feature <name>
# Creates: specs/features/<name>.spec.md
# Full frontmatter with type: behavior, satisfies, guided-by

# Step 2: Create artifact spec
# Creates: specs/artifacts/commands/<name>.spec.md (or skills/ equivalent)
# Full frontmatter with type: command/prompt, specifies: commands/<name>.md

# Step 3: Implement the skill/command
# Creates: skills/<name>/SKILL.md, commands/<name>.md

# Step 4: Update registry
# Edit: specs/artifacts/prompts/registry.spec.md (if prompt-backed)
# (Not registries/*.md — those are accepted-current-state data, not this kind of tracking table)

# Step 5: Regenerate agents
/livespec:audit context
# Updates: AGENTS.md (references new skill)
```

### Example 2: Dogfooding Validation

```bash
# Build new feature (e.g., mandatory frontmatter)

# Step 1: Use LiveSpec's own DESIGN skill
/livespec:design feature mandatory-frontmatter
# Creates: specs/features/mandatory-frontmatter.spec.md
# (Meta-irony: spec for specs must itself have correct frontmatter)

# Step 2: Migrate all existing specs
scripts/validate-frontmatter.sh  # finds violations
# Fix all specs to comply

# Step 3: USE the validation in current session
scripts/validate-frontmatter.sh  # must exit 0

# Step 4: Commit only after validation passes
```

## Decision Points

**Is this workspace/ or strategy/?**
- Test: "Is this ABOUT how we operate?" → YES = workspace/
- Example: "Use MSL format" → workspace/ (operating convention)
- Example: "Ship as a Claude Code plugin" → strategy/ (framework architecture)

**Is this features/ or artifacts/?**
- Test: "Does this describe what the methodology DOES?" → YES = features/
- Test: "Does this describe something we BUILD?" → YES = artifacts/
- Example: "Context generation behavior" → features/
- Example: "context-builder agent" → artifacts/agents/

**Should I dogfood this?**
- YES if: Governance project (always dogfood)
- Validates methodology works, demonstrates patterns

## Reference Library

- Parent: AGENTS.md (root context)
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms — IMP-006)
- Taxonomy: `specs/workspace/taxonomy.spec.md` (project classification)
- Mandatory frontmatter: `specs/features/mandatory-frontmatter.spec.md`
- Base metaspec: `references/standards/metaspecs/base.spec.md`
- Context builder agent: `agents/context-builder.md`

---

*Governance domain specialist for LiveSpec v5.7.0*
*Parent: AGENTS.md*
