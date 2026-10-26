# Governance Domain Patterns

> **Generated file** - Do not edit directly. Regenerate using `/livespec:audit context`

Sub-agent context for governance domain projects and methodology development.

**Load when:** "methodology", "dogfooding", "governance", "framework development" — developing methodology, writing specs about specs, not using LiveSpec normally.

## Summary

Governance domain projects produce methodology frameworks, policies, procedures, and process documentation. LiveSpec itself is a governance project — it develops specifications about specification-driven development.

**Key characteristic:** Outputs are guidance for other projects, not user-facing products.

## Domain-Specific Patterns

### Dogfooding Pattern (Critical for Governance)

Governance projects use their own methodology to develop themselves: LiveSpec uses LiveSpec to evolve LiveSpec, policies are written following the policy-writing framework, procedures follow the procedure-documentation process.

```
LiveSpec (governance project):
├── specs/workspace/     # HOW LiveSpec develops itself (constitution, patterns, workflows,
│                        #   taxonomy, context-architecture, ...)
├── specs/strategy/      # Architecture: two-branch model, distribution approach
├── specs/features/      # Methodology behaviors (context-generation, mandatory-frontmatter, ...)
└── specs/artifacts/     # Deliverables: prompts/, agents/, commands/, skills/, validators/
```

### Framework Distribution Pattern

**Challenge:** Governance projects produce frameworks that other projects adopt.

**Solution (v5, plugin-based):**
```
livespec (source repo):
├── specs/          # Source of truth (specifications)
├── skills/         # Skill definitions (init, design, audit, learn, sweep, birth, go, upgrade)
├── commands/       # Slash command routing (thin wrappers to skills/)
├── agents/         # Sub-agent definitions (context-builder)
├── templates/      # Bootstrap and enforcement content
├── references/     # Prompts, guides, standards
└── AGENTS.md, ctxt/  # Generated, in the shape LiveSpec declares

target-project (user's repo):
├── PURPOSE.md, specs/, registries/, project.yaml
├── specs/workspace/standards/   # vendored conventions, with provenance
├── scripts/livespec/            # vendored hooked validators, with provenance
└── AGENTS.md (+ ctxt/ if declared)  # only once generated, on request
```

**Key insight:** `specs/` governs LiveSpec's own development. Target projects invoke the plugin's skills, commands and agents; none of those is copied. What a project depends on (conventions, hooked validators) is vendored as local files with `vendored-from`/`source-version`/`source-hash` provenance, and changes only when `/livespec:upgrade` is accepted. This replaced the pre-v5 `dist/` + submodule/copy model entirely.

**Toolchain vs project boundary** (dogfooding's sharpest edge): the authoring toolchain (`init`, workspace design, `audit`) may be harness-specific, but project artefacts (`PURPOSE.md`, `specs/`, `AGENTS.md`, `ctxt/`) stay harness-neutral. No action at a distance: a toolchain update never changes a project's behaviour, settings or context-tree shape on its own.

### Specs About Specs Pattern

**Governance projects have specs at three levels:**

1. **Meta-level** (specs about the framework): `specs/features/context-generation.spec.md` defines what context generation does as a behavior
2. **Artifact-level** (specs about deliverables): `specs/artifacts/agents/context-builder.spec.md` defines what the context-builder agent does
3. **Metaspec level** (templates for specs): `references/standards/metaspecs/base.spec.md` defines the structure required of ALL specs (IMP-005)

**Avoid confusion:** Metaspecs are templates, not instances. They live in `references/standards/` not `specs/`.

### Taxonomy for Governance Projects

Governance taxonomy (`specs/workspace/taxonomy.spec.md`) declares, and `project.yaml` records under `livespec.taxonomy`:

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
---
```

Links name specs only. A registry entry (e.g. `registries/debt.md` DEBT-NNN) is never a link target: mention it in the body.

**Artifact specs in governance projects:**
```yaml
---
type: agent
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without spec, agent implementation lacks requirements
governed-by: []
satisfies:
  - specs/features/context-generation.spec.md
specifies:
  - agents/context-builder.md
---
```

### Learning Distribution Pattern

**When governance project learns something:**

1. Capture reusable content in a template (`templates/agents/spec-first-enforcement.md`)
2. Update a spec to mandate the template (`specs/workspace/workflows.spec.md`)
3. Update `agents/context-builder.md` to reference it during generation
4. Regenerate AGENTS.md (`/livespec:audit context`) so it carries the content inline
5. Plugin users get updated skills on `/plugin update`; changes to a vendored convention or script reach a project only when it accepts them through `/livespec:upgrade`

**Result:** violations → templates → specs → skills/agents → AGENTS.md → plugin users, each project on its own acceptance.

## Folder Organization (Governance Projects)

**Workspace scope test — "Is this ABOUT the workspace or IN the workspace?"**
- ABOUT → workspace/: constitution (principles), patterns (MSL format, naming), workflows (spec-first workflow), taxonomy (classification), context-architecture (context tree shape)
- IN → appropriate layer: architecture → strategy/; context generation → features/; context-builder → artifacts/agents/

**Specs boundary — specs/ = specifications only, not the plugin implementation.** Test: "Is this defining WHAT the methodology does, or IS this the methodology's runnable artifact?" Defining WHAT → specs/; runnable artifact → skills/, commands/, agents/.

**Settings boundary:** methodology settings (`context_compression`, `tdd`) and `agent.context_budget` live in `project.yaml` only. A spec may refer to a setting but never declares one; two declarations drift apart.

## Common Behaviors (Governance Domain)

- Learnings captured in templates; violations trigger methodology updates
- Changes ship via the plugin (skills/commands/agents), not a copy step
- Registries are tiered (required/recommended/optional) and record accepted current state, not a backlog — entries read as state observations, not tickets. `registries/proposals.md` stages proposals from outside the project (an agreed AMP proposal, a residue harvest) and is not a registry: a session promotes each entry or drops it. See `specs/features/registry-specs.spec.md`

## Examples

### Example 1: Adding New Skill (Governance Project)

```bash
# 1. Behavior spec first: /livespec:design feature <name>
#    → specs/features/<name>.spec.md (type: behavior, satisfies, guided-by)
# 2. Artifact spec: specs/artifacts/commands/<name>.spec.md (specifies: commands/<name>.md)
# 3. Implement: skills/<name>/SKILL.md, commands/<name>.md
# 4. Update specs/artifacts/prompts/registry.spec.md if prompt-backed
#    (not registries/*.md — that's accepted-current-state data, not a tracking table)
# 5. Regenerate agent context
/livespec:audit context
```

### Example 2: Dogfooding Validation

```bash
/livespec:design feature mandatory-frontmatter   # spec for specs must itself have correct frontmatter
scripts/validate-frontmatter.sh                  # finds violations; fix all specs, then must exit 0
scripts/validate-constraints.sh                  # no dangling references
scripts/validate-crossrefs.sh --strict           # links trace to PURPOSE.md; --fix regenerates supports:
# Commit only after validation passes
```

## Decision Points

**Is this workspace/ or strategy/?** "Is this ABOUT how we operate?" → YES = workspace/. "Use MSL format" → workspace/ (operating convention); "Ship as a Claude Code plugin" → strategy/ (framework architecture).

**Is this features/ or artifacts/?** What the methodology DOES → features/ ("Context generation behavior"); something we BUILD → artifacts/ ("context-builder agent" → artifacts/agents/).

**Should I dogfood this?** Always, in a governance project: it validates the methodology works and demonstrates its patterns.

## Reference Library

- Parent: AGENTS.md (root context)
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms — IMP-006)
- Taxonomy: `specs/workspace/taxonomy.spec.md` (project classification)
- Settings: `specs/features/project-config.spec.md`
- Mandatory frontmatter: `specs/features/mandatory-frontmatter.spec.md`
- Base metaspec: `references/standards/metaspecs/base.spec.md`
- Context builder agent: `agents/context-builder.md`

---

*Governance domain specialist for LiveSpec v5.12.1*
*Parent: AGENTS.md*

<!-- livespec-context-sources: sha256:7e08a07c3ebc9e5e117d87f448731decf5fd3d0da77992e0770c303cc24f466c n=99 -->
