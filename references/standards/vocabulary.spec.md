---
type: taxonomy
category: artifacts
fidelity: full-detail
criticality: CRITICAL
failure_mode: Without vocabulary definitions, agents and users interpret controlled terms inconsistently, achieving 70-80% correct usage vs 100% with full definitions
governed-by: []
specifies:
  - references/standards/metaspecs/base.spec.md
derives-from:
  - docs/registries/improvements.md (IMP-006)
---

# LiveSpec Vocabulary

## Requirements

- [!] All controlled terms in LiveSpec are defined here with value, description, and usage context. This is the canonical source of truth for controlled vocabularies.

---

## Frontmatter Field Values

### type

Classifies the spec subtype. Implies which metaspec template governs format (no metaspec reference needed in `governed-by`).

| Value | Description | Implied Metaspec | Typical Category |
|-------|-------------|-----------------|------------------|
| `outcomes` | Project-level success criteria and strategic requirements | outcomes.spec.md | foundation |
| `constraints` | Hard boundaries, regulatory limits, non-negotiable rules | constraints.spec.md | foundation |
| `strategy` | Cross-cutting technical or architectural decisions | strategy.spec.md | strategy |
| `behavior` | Observable outcome testable by users, systems, or auditors | behavior.spec.md | features |
| `contract` | Interface definition (API, data format, protocol) | contract.spec.md | interfaces |
| `workspace` | Process governance — how the workspace operates | workspace.spec.md | workspace |
| `taxonomy` | Classification system or controlled vocabulary | taxonomy.spec.md | workspace |
| `prompt` | AI prompt deliverable specification | prompt.spec.md | artifacts |
| `agent` | AI agent deliverable specification | agent.spec.md | artifacts |
| `validator` | Validation script or check specification | (base) | artifacts |
| `command` | Slash command specification | (base) | artifacts |
| `diagram` | Diagram or visual artefact specification | (base) | artifacts |
| `registry` | Registry format specification | (base) | artifacts |
| `domain-model` | Entity or concept model specification | domain-model.spec.md | varies |
| `purpose` | Project purpose specification | purpose.spec.md | foundation |

### category

Directory-level classification. Must match the spec's location in `specs/`.

| Value | Directory | Contains |
|-------|-----------|----------|
| `workspace` | specs/workspace/ | Process governance, patterns, workflows, taxonomy |
| `foundation` | specs/foundation/ | Strategic outcomes and hard constraints |
| `strategy` | specs/strategy/ | Cross-cutting architectural decisions |
| `features` | specs/features/ | Observable behaviours and outcomes |
| `interfaces` | specs/interfaces/ | API contracts, data formats, protocols |
| `artifacts` | specs/artifacts/ | Prompts, agents, validators, commands, diagrams |

### fidelity

Expected detail level. Defaults by category but may diverge when justified.

| Value | Description | Default For |
|-------|-------------|-------------|
| `full-detail` | Complete specification including parameters, schemas, edge cases | interfaces |
| `behavioral` | Observable outcomes with validation criteria, no internals | features, foundation, artifacts |
| `decisions-only` | Strategic decisions with rationale, no implementation | strategy |
| `process` | Workflow steps and governance rules | workspace |

### criticality

Document-level priority. Distinct from requirement-level `[!]` markers.

| Value | Meaning | Decision Criteria |
|-------|---------|-------------------|
| `CRITICAL` | System fails without this — breaks, unusable, or unsafe | Would removal cause immediate, observable failure? |
| `IMPORTANT` | System works but quality degrades significantly | Would removal degrade quality without breaking function? |

**Note:** Document-level criticality (`criticality:` field) and requirement-level criticality (`[!]` marker) are complementary, not redundant. Document-level prioritises which specs to evolve first; requirement-level prioritises which requirements cannot be skipped.

---

## Relationship Fields

All relationship field names use **hyphenated form** (never underscored).

### Upward Relationships (pointing to more abstract/durable specs)

| Field | Description | Common Usage |
|-------|-------------|-------------|
| `governed-by` | Content governance — higher-level specs that constrain WHAT this spec can say | Any spec → constraints, workspace patterns |
| `satisfies` | Fulfils a stated requirement or outcome | features/artifacts → foundation outcomes |
| `guided-by` | Informed by a pattern, strategy, or convention | features/artifacts → workspace patterns, strategy |

### Backward Relationships (pointing to prior/source specs)

| Field | Description | Common Usage |
|-------|-------------|-------------|
| `derives-from` | Based on or evolved from another spec | strategy → outcomes, workspace → principles |
| `extends` | Extends a metaspec template | agent/prompt metaspecs → behavior metaspec |
| `informed-by` | Sourced from external research or standard | Specs based on external evidence |
| `supersedes` | Replaces an older spec | Feature replacing a deprecated feature |

### Downward Relationships (pointing to implementations)

| Field | Description | Common Usage |
|-------|-------------|-------------|
| `specifies` | Path to the deliverable this spec governs | artifact specs → prompt/agent/script files |
| `implements` | Realises a behaviour in code or configuration | validator → behaviour spec |
| `supports` | Enables or makes possible | interfaces → features, foundation → strategy |

### Sideways Relationships (peer coordination)

| Field | Description | Common Usage |
|-------|-------------|-------------|
| `updated-by` | Modified by a specific agent or process | Feature → agent that modifies it |

### Scope Fields

| Field | Description | Common Usage |
|-------|-------------|-------------|
| `applies_to` | Declares governance scope | workspace specs → `all_projects`, `all_ai_agents` |
| `context_compression` | Compression level for context generation | constitution.spec.md only |

---

## Phase Vocabulary

LiveSpec development follows five temporal phases. Phases describe WHEN you work.

| Number | Name | Purpose | Entry Condition | Key Outputs |
|--------|------|---------|-----------------|-------------|
| 0 | DEFINE | Establish problem space and constraints | Project idea or codebase | PURPOSE.md, foundation specs, workspace specs |
| 1 | DESIGN | Design solution architecture | Problem and constraints defined | Strategy specs, feature specs, interface specs |
| 2 | BUILD | Implement with TDD discipline | Design specifications complete | Automated tests + working code |
| 3 | VERIFY | Validate solution meets requirements | Implementation complete | Test results, validation reports |
| 4 | EVOLVE | Maintain specs, regenerate code | Ongoing | Updated specs, regeneration decisions |

**Location:** Phase prompts live in `.livespec/0-define/` through `.livespec/4-evolve/`.

---

## Layer Vocabulary

Specs are organised into three abstraction layers. Layers describe WHERE specs live.

| Number | Name | Directory | Answers | Durability |
|--------|------|-----------|---------|------------|
| 1 | Foundation | specs/foundation/ | WHY — strategic outcomes and constraints | Most durable |
| 2 | Strategy | specs/strategy/ | HOW — cross-cutting architectural approach | Durable |
| 3 | Features + Interfaces | specs/features/, specs/interfaces/ | WHAT — observable behaviours and contracts | Less durable |

**Note:** `specs/workspace/` and `specs/artifacts/` are orthogonal to the layer hierarchy. Workspace governs process; artifacts specify deliverables.

**Critical distinction:** Phases (WHEN) and layers (WHERE) are independent numbering systems. A spec written during Phase 1 (DESIGN) may belong in Layer 2 (strategy/).

---

## Registry Vocabularies

### Gap Registry

| Field | Values | Description |
|-------|--------|-------------|
| Impact | `HIGH`, `MEDIUM`, `LOW` | Severity of the methodology gap |
| Status | `Open`, `Resolved`, `Accepted Limitation` | Current state of the gap |

### Issue Registry

| Field | Values | Description |
|-------|--------|-------------|
| Category | `Process`, `Structure`, `Guidance`, `Tooling` | Classification of the issue |
| Status | `Open`, `Resolved`, `Accepted Limitation` | Current state of the issue |

### Improvement Registry

| Field | Values | Description |
|-------|--------|-------------|
| Category | `Structure`, `Guidance`, `Process`, `Traceability`, `Governance` | What the improvement changes |
| Decision | `Pending`, `Keep`, `Accepted as Limitation`, `Implemented` | Outcome of evaluation |

---

## Requirement Markers

| Marker | Level | Meaning |
|--------|-------|---------|
| `[!]` | Requirement | This individual requirement is critical — cannot be skipped |
| `criticality: CRITICAL` | Document | This entire spec is critical — system fails without it |
| `criticality: IMPORTANT` | Document | This spec is important — quality degrades without it |

**Hierarchy:** A CRITICAL document may contain non-critical requirements. An IMPORTANT document may contain `[!]` critical requirements. The two levels are independent.

---

## Extension Mechanism

Projects may extend the core vocabulary with domain-specific values.

### How to Extend

1. Create `specs/workspace/vocabulary.spec.md` in your project
2. Add `derives-from: references/standards/vocabulary.spec.md` (or `.livespec/standard/vocabulary.spec.md`)
3. Define additional values per vocabulary domain

### Example: Governance Domain Extension

```yaml
---
type: taxonomy
category: workspace
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without domain vocabulary, governance-specific terms are interpreted inconsistently
governed-by: []
derives-from:
  - .livespec/standard/vocabulary.spec.md
applies_to:
  - this_project
---

# Project Vocabulary Extensions

## Additional Type Values

| Value | Description | Implied Metaspec | Used In |
|-------|-------------|-----------------|---------|
| `policy` | Governance policy specification | behavior.spec.md | features |
| `runbook` | Operational procedure specification | contract.spec.md | interfaces |
| `migration` | Data or system migration specification | behavior.spec.md | features |
```

### Rules for Extensions

- Core values cannot be redefined (only extended)
- Extended values must include description, implied metaspec, and typical category
- Validation scripts should accept both core and project-level values
