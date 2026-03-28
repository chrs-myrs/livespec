---
criticality: CRITICAL
failure_mode: Without base requirements, LiveSpec specs lack essential metadata and consistency
derives-from:
  - https://github.com/chrs-myrs/msl-specification
---

# Base LiveSpec Specification Requirements

## Requirements
- [!] All LiveSpec specifications use MSL (Markdown Specification Language) L1+ with LiveSpec-specific frontmatter extensions for governance framework use.
  - Spec follows MSL L1+ format (title, YAML frontmatter, `## Requirements` section, optional sections)
  - Spec has YAML frontmatter with `type` field (subtype classification, see Type Values below)
  - Spec has YAML frontmatter with `category` field matching directory (`workspace` | `foundation` | `strategy` | `features` | `interfaces` | `artifacts`)
  - Spec has YAML frontmatter with `fidelity` field (`full-detail` | `behavioral` | `decisions-only` | `process`)
  - Spec has YAML frontmatter with `criticality` field (CRITICAL or IMPORTANT)
  - Spec has YAML frontmatter with `failure_mode` field (concrete failure description)
  - Spec has YAML frontmatter with `governed-by` field (array of content-governance spec paths, or empty array for root specs)
  - Criticality CRITICAL means system fails without this (breaks, unusable, unsafe)
  - Criticality IMPORTANT means system works but quality degrades significantly
  - Failure mode describes specifically what breaks (not vague)
  - Requirements use `[!]` marker for CRITICAL items at requirement level
  - File uses `.spec.md` extension

### Type Values

- [!] The `type` field classifies spec subtype and implies which metaspec template governs format.
  - `outcomes` — Foundation outcomes (implies outcomes.spec.md)
  - `constraints` — Foundation constraints (implies constraints.spec.md)
  - `strategy` — Strategic decisions (implies strategy.spec.md)
  - `behavior` — Observable outcomes (implies behavior.spec.md)
  - `contract` — Interface definitions (implies contract.spec.md)
  - `workspace` — Process governance (implies workspace.spec.md)
  - `taxonomy` — Classification systems (implies taxonomy.spec.md)
  - `prompt` — Prompt artifacts (implies prompt.spec.md)
  - `agent` — Agent artifacts (implies agent.spec.md)
  - `validator` — Validation script artifacts
  - `diagram` — Diagram artifacts
  - `command` — Command artifacts
  - `registry` — Registry format specs
  - `domain-model` — Entity/concept specs (implies domain-model.spec.md)
  - `purpose` — Project purpose (implies purpose.spec.md)

### Governed-By Semantics

- [!] The `governed-by` field references only content governance, never format governance.
  - Content governance: higher-level specs that constrain WHAT this spec can say
  - Format governance (metaspec template) is implied by `type` — no metaspec refs in `governed-by`
  - Foundation specs may have empty `governed-by` (dependency graph roots)

### Per-Category Mandatory Fields

- [!] Each category requires additional fields beyond the base six.
  - workspace: `applies_to` (governance scope)
  - foundation: `derives-from`, `supports`
  - strategy: `derives-from`
  - features: `satisfies`, `guided-by`
  - interfaces: `supports`
  - artifacts: `specifies` (path to deliverable)

### Fidelity Defaults

- The `fidelity` field may diverge from category default when justified.
  - interfaces → `full-detail` (default)
  - features → `behavioral` (default)
  - strategy → `decisions-only` (default)
  - workspace → `process` (default)
  - foundation → `behavioral` (default)
  - artifacts → `behavioral` (default)

### Field Naming

- All relationship field names use hyphenated form (`derives-from`, `governed-by`, `guided-by`), never underscored.

## Notes

### LiveSpec Extensions for Governance Frameworks

LiveSpec is a **governance framework** where all specifications are policy documents about methodology itself. This specialized domain requires document-level metadata that complements MSL's requirement-level `[!]` markers.

**LiveSpec adds to MSL L1+ frontmatter:**

```yaml
---
criticality: CRITICAL | IMPORTANT       # Document-level priority
failure_mode: [Concrete description]    # Document-level impact
# Plus standard MSL L1 fields: id, extends, tags, etc.
---

## Requirements
- [!] Critical requirement                # Requirement-level priority (MSL L2)
- Regular requirement
```

**Relationship between document and requirement priority:**
- **Document-level** (`criticality:`): Framework-level prioritization (which policy specs to evolve first)
- **Requirement-level** (`[!]`): Individual requirement criticality (which requirements cannot be skipped)
- These complement each other in governance contexts; not redundant

**Why LiveSpec uses both:**
- **Filtering**: 50+ policy documents need organization by importance
- **AI context**: Agents prioritize which specs to update during framework evolution
- **Governance metadata**: Document-level impact analysis for framework changes

**When NOT to use this pattern:**
- Application code specifications (use MSL [!] markers only)
- Simple projects (<20 specs)
- Non-governance use cases

**MSL Foundation:**

For MSL L0-L2 specification details, see: https://github.com/chrs-myrs/msl-specification

LiveSpec uses MSL L1+ (optional frontmatter) with domain-specific extensions documented in MSL-FEEDBACK.md. These extensions work for governance frameworks but are not universal MSL recommendations.

All LiveSpec metaspecs, convention specs, and project specs follow this pattern.
