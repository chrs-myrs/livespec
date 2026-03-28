# Governance Domain Patterns

> **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

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
│   └── distribution.spec.md   # How framework reaches users
│
├── specs/features/            # LiveSpec's methodology behaviors
│   ├── context-generation.spec.md
│   ├── mandatory-frontmatter.spec.md
│   └── ...
│
└── specs/artifacts/           # LiveSpec's deliverables (prompts, agents)
    └── prompts/*.spec.md
```

### Framework Distribution Pattern

**Challenge:** Governance projects produce frameworks that other projects copy.

**Solution:**
```
livespec (source repo):
├── specs/                     # Source of truth (specifications)
├── dist/                      # Distributable framework (what users copy)
│   ├── prompts/              # Phase 0-4 prompts
│   ├── guides/               # MSL, TDD, etc.
│   ├── standard/             # Metaspecs, conventions
│   └── templates/            # Reusable content
└── AGENTS.md                  # Generated (from specs/workspace/)

target-project (user's repo):
└── .livespec/                 # Copied from livespec/dist/
    ├── prompts/
    ├── guides/
    └── ...
```

**Key insight:** `specs/` governs LiveSpec's development, `dist/` is the distributed product.

### Specs About Specs Pattern

**Governance projects have specs at two levels:**

1. **Meta-level** (specs about the framework):
   ```
   specs/features/context-generation.spec.md
   → Defines what context generation does as a behavior
   ```

2. **Artifact-level** (specs about specific deliverables):
   ```
   specs/artifacts/prompts/4d-regenerate-context.spec.md
   → Defines what 4d-regenerate-context.md prompt does
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
  - docs/registries/improvements.md (IMP-NNN)  # if derived from registry
---
```

**Artifact specs in governance projects:**
```yaml
---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without spec, prompt implementation lacks requirements
governed-by: []
specifies:
  - dist/prompts/0-define/0a-quick-start.md
---
```

### Learning Distribution Pattern

**When governance project learns something:**

1. **Capture learning in template:**
   ```
   .livespec/templates/agents/spec-first-enforcement.md
   → Reusable verification content
   ```

2. **Update spec to mandate template:**
   ```
   specs/workspace/workflows.spec.md
   → "Agents use spec-first-enforcement template"
   ```

3. **Update prompt to reference template:**
   ```
   .livespec/prompts/4-evolve/4d-regenerate-context.md
   → Includes template in AGENTS.md generation
   ```

4. **Regenerate AGENTS.md:**
   ```
   AGENTS.md now contains template content
   ```

5. **Copy to dist/:**
   ```
   dist/AGENTS.md, dist/templates/agents/*
   → Target projects receive improvement automatically
   ```

**Result:** Learnings flow: violations → templates → specs → prompts → AGENTS.md → dist/ → target projects

## Folder Organization (Governance Projects)

### Workspace Scope Test

**"Is this ABOUT the workspace or IN the workspace?"**

**ABOUT → workspace/ (operating context):**
- constitution.spec.md — Development principles
- patterns.spec.md — MSL format, naming
- workflows.spec.md — Spec-first workflow
- taxonomy.spec.md — Project classification

**IN → appropriate layer (deliverables):**
- distribution.spec.md — How LiveSpec distributes → strategy/
- context-generation.spec.md — What context generation does → features/
- 0a-quick-start.spec.md — What prompt does → artifacts/prompts/

### Specs Boundary

**specs/ = specifications only (not distributable framework)**

**Test:** "Is this defining WHAT framework does, or IS this the framework itself?"
- Defining WHAT → specs/ (specifications)
- IS the framework → dist/ (distributable product)

## Common Behaviors (Governance Domain)

### Methodology Evolution

- Learnings captured in templates
- Violations trigger methodology updates
- Changes flow through distribution mechanism
- IMP-NNN registry entries track improvements

### Framework Development

- Framework has specifications (behaviors, prompts, guides)
- Framework dogfoods its own methodology
- Framework distribution follows distribution spec

## Examples

### Example 1: Adding New Prompt (Governance Project)

```bash
# Step 1: Create behavior spec FIRST
Use .livespec/1-design/1c-define-behaviors.md
# Creates: specs/features/prompts/0g-new-prompt.spec.md
# Full frontmatter with type: behavior, satisfies, guided-by

# Step 2: Create artifact spec
# Creates: specs/artifacts/prompts/0g-new-prompt.spec.md
# Full frontmatter with type: prompt, specifies: dist/prompts/...

# Step 3: Implement prompt
Use .livespec/2-build/2a-implement-from-specs.md
# Creates: dist/prompts/0-define/0g-new-prompt.md

# Step 4: Update registry
# Edit: specs/artifacts/prompts/registry.spec.md

# Step 5: Regenerate agents
Use .livespec/4-evolve/4d-regenerate-context.md
# Updates: AGENTS.md (references new prompt)
```

### Example 2: Capturing Violation Learning (IMP-005 pattern)

```bash
# Violation detected: Specs not machine-navigable, missing type field

# Step 1: Create feature spec
# Write: specs/features/mandatory-frontmatter.spec.md
# type: behavior, satisfies: outcomes, guided-by: strategy

# Step 2: Update base metaspec
# Edit: references/standards/metaspecs/base.spec.md
# Add: mandatory fields documentation

# Step 3: Create validation script
# Write: scripts/validate-frontmatter.sh
# Spec: specs/artifacts/validator-frontmatter.spec.md

# Step 4: Regenerate AGENTS.md (includes new guidance)
Use .livespec/4-evolve/4d-regenerate-context.md

# Step 5: Update dist/ templates
cp references/standards/metaspecs/base.spec.md dist/standard/metaspecs/

# Result: Target projects get mandatory frontmatter requirement
```

### Example 3: Dogfooding Validation

```bash
# Build new feature (e.g., mandatory frontmatter)

# Step 1: Use LiveSpec's own Phase 1 (DESIGN)
Use .livespec/1-design/1c-define-behaviors.md
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
- Example: "Distribute via dist/" → strategy/ (framework architecture)

**Is this features/ or artifacts/?**
- Test: "Does this describe what the methodology DOES?" → YES = features/
- Test: "Does this describe something we BUILD?" → YES = artifacts/
- Example: "Context generation behavior" → features/
- Example: "Regenerate-context prompt" → artifacts/prompts/

**Should I dogfood this?**
- YES if: Governance project (always dogfood)
- Validates methodology works, demonstrates patterns

## Reference Library

- Parent: AGENTS.md (root context)
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms — IMP-006)
- Taxonomy: `specs/workspace/taxonomy.spec.md` (project classification)
- Distribution: `specs/workspace/distribution.spec.md` (framework patterns)
- Mandatory frontmatter: `specs/features/mandatory-frontmatter.spec.md`
- Base metaspec: `references/standards/metaspecs/base.spec.md`

---

*Governance domain specialist for LiveSpec v5.4.1*
*Parent: AGENTS.md*
