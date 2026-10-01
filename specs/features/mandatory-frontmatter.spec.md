---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without mandatory frontmatter, specs are not self-describing or machine-navigable, requiring AGENTS.md or taxonomy as intermediaries and scoring 1/5 on machine-readability audits
governed-by:
  - specs/interfaces/formats/validator-output.spec.md
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 1: Specification-first development)
  - specs/foundation/outcomes.spec.md (Requirement 4: Sustainable methodology)
guided-by:
  - specs/strategy/ai-discoverability.spec.md
  - specs/workspace/patterns.spec.md
informed-by:
  - knowledge-store audit findings (local research report, not in the repository)
supports:
  - specs/artifacts/validators/validate-coverage.spec.md
---

# Mandatory Spec Frontmatter

## Requirements

### Base Frontmatter Schema

- [!] All `.spec.md` files carry six mandatory YAML frontmatter fields that make each spec self-describing without external intermediaries.
  - `type` field present with valid subtype value (see Type Classification below)
  - `category` field present matching the spec's directory (`workspace` | `foundation` | `strategy` | `features` | `interfaces` | `artifacts`)
  - `fidelity` field present (`full-detail` | `behavioral` | `decisions-only` | `process`)
  - `criticality` field present (`CRITICAL` | `IMPORTANT`)
  - `failure_mode` field present (concrete one-sentence description)
  - `governed-by` field present (array of content-governance spec paths, or empty array for root specs)

### Type Classification

- [!] The `type` field classifies spec subtype and implies which metaspec template governs its format, eliminating the need for metaspec references in `governed-by`.
  - Foundation types: `outcomes`, `constraints`
  - Strategy type: `strategy`
  - Feature types: `behavior`, `taxonomy`
  - Interface type: `contract`
  - Workspace type: `workspace`
  - Artifact types: `prompt`, `agent`, `validator`, `diagram`, `command`, `registry`
  - Type-to-metaspec mapping is deterministic (each type maps to exactly one metaspec template)

### Governed-By Semantics

- [!] The `governed-by` field references only content governance (higher-level specs that constrain WHAT this spec can say), never format governance (metaspec templates).
  - Metaspec template references removed from `governed-by` arrays (format implied by `type`)
  - Foundation specs may have empty `governed-by` (they are dependency graph roots)
  - Content governance examples: constraints specs, workspace patterns, foundation outcomes
  - Format governance is implicit via `type` field mapping to metaspec

### Fidelity Assignment

- The `fidelity` field declares the expected detail level and may diverge from the category default when justified.
  - Default fidelity by category: interfaces→`full-detail`, features→`behavioral`, strategy→`decisions-only`, workspace→`process`, foundation→`behavioral`, artifacts→`behavioral`
  - Override permitted when a spec requires more or less detail than its category default
  - Fidelity informs both human writers and automated audit tools

### Per-Category Mandatory Fields

- [!] Each category requires additional fields beyond the base six, reflecting the natural traceability patterns of that spec type.
  - workspace specs: `applies_to` (governance scope declaration)
  - foundation specs: `derives-from`, `supports`
  - strategy specs: `derives-from`
  - features specs: `satisfies`, `guided-by`
  - interfaces specs: `supports`
  - artifacts specs: `specifies` (path to deliverable)
  - `specifies` is also valid on features and interfaces, and each value may be a file, a directory or a glob: it is the one link that says which files a spec governs

### Relationship Field Values

- [!] A declared relationship field carrying no values asserts that the relationship does not exist; that assertion is legitimate where the field is optional and a reportable gap where the category mandates it.
  - Empty optional fields report nothing — an empty `governed-by` is the correct default for a spec that nothing governs
  - Empty per-category mandatory fields report as warnings, never errors: the traceability is usually carried by a different populated field rather than genuinely absent
  - Empty `specifies` on an artifact spec has no substitute field — it means no machine-checkable link to the deliverable exists
  - Emptiness is structural, covering both `field: []` and a bare `field:` with no list items beneath it

### Field Naming Consistency

- All relationship field names use hyphenated form (`derives-from`, `governed-by`, `guided-by`), never underscored (`derives_from`).
  - Existing underscore variants normalised to hyphens
  - Validation rejects underscore variants

### Frontmatter Validation

- [!] A validation script checks all `.spec.md` files for frontmatter compliance, runnable both manually and in pre-commit hooks.
  - Checks base six fields present on all specs
  - Checks per-category mandatory fields present
  - Validates `type` against allowed values
  - Validates `category` matches directory location for specs under `specs/`
  - Validates `fidelity` against allowed values
  - Warns on `governed-by` containing metaspec paths, including pre-schema metaspec copies under `references/templates/` and `*.metaspec.md` names that older versions planted
  - Warns on underscore field names
  - Warns on per-category mandatory fields declared empty
  - Reports relationship graph population per mandatory field — populated against declared — so unpopulated declarations are visible as a proportion
  - Accepts optional path arguments, each a directory to scan or a single spec file, so spec-shaped files outside `specs/` and the specs staged for a commit can be validated; defaults to `specs/`
  - Promotes empty-field warnings to errors under `--strict`, letting a project that has populated its graph prevent regression
  - Exits 0 when all checks pass, 1 on any failure

## Validation

### Schema Compliance
- [ ] Every `.spec.md` file has all six base fields
- [ ] `type` values are from the allowed set
- [ ] `category` values match directory for every spec
- [ ] `fidelity` values are from the allowed set
- [ ] Per-category mandatory fields present on applicable specs
- [ ] Per-category mandatory fields declared empty are reported as warnings, with a populated/declared count per field

### Semantic Correctness
- [ ] No `governed-by` arrays contain metaspec template paths
- [ ] Foundation specs have empty or content-only `governed-by`, and empty `governed-by` is never reported
- [ ] No `derives_from` (underscore) remaining anywhere
- [ ] `type` values correctly imply the right metaspec for each spec

### Tooling
- [ ] `scripts/validate-frontmatter.sh` exists and exits 0 against current specs
- [ ] `scripts/validate-frontmatter.sh` validates a caller-supplied tree as well as `specs/`
- [ ] Metaspec templates updated to document new mandatory fields
- [ ] `templates/` include full frontmatter schema for target projects

### Audit Impact
- [ ] A1 (frontmatter completeness) improves from 1/5 baseline
- [ ] B1 (machine-readability) improves from 1/5 baseline
