---
criticality: IMPORTANT
failure_mode: Without dependency tracking, specification relationships become implicit and unverifiable
constrained_by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Dependency Convention

## Requirements
- LiveSpec specifications declare relationships via YAML frontmatter to enable traceability and impact analysis.
  - Specifications use standard frontmatter fields for dependencies
  - `derives_from:` lists parent specs this is based on
  - `constrained_by:` lists boundaries this must respect
  - `satisfies:` lists requirements this fulfills
  - `supports:` lists what this spec enables
  - `applies_to:` defines scope (for workspace specs)
  - Dependency values are file paths (relative to project root) or URLs
  - Dependency paths use forward slashes (cross-platform)
  - All referenced files exist (no broken references)
  - Circular dependencies are avoided

## Dependency Fields

### derives_from
Parent specifications this is based on or extends.

**Example:**
```yaml
derives_from:
  - PURPOSE.md
  - specs/requirements.spec.md
```

### constrained_by
Boundaries and limits this specification must respect.

**Example:**
```yaml
constrained_by:
  - specs/constraints.spec.md
  - .livespec/standard/metaspecs/behavior.spec.md
```

### satisfies
Requirements or parent specs this specification fulfills.

**Example:**
```yaml
satisfies:
  - specs/requirements.spec.md
```

### supports
What this specification enables or makes possible.

**Example:**
```yaml
supports:
  - prompts/4-evolve/4d-regenerate-agents.md
  - specs/behaviors/drift-detection.spec.md
```

### applies_to
Scope for workspace specifications (what this applies to).

**Example:**
```yaml
applies_to:
  - all_projects
  - all_ai_agents
  - all_developers
```

## Traceability Example

```
PURPOSE.md
    ↓ derives_from
specs/requirements.spec.md
    ↓ satisfies
specs/behaviors/user-authentication.spec.md
    ↓ constrained_by
specs/constraints.spec.md
```

## Notes

Dependency frontmatter enables:
- **Impact analysis**: What breaks if this spec changes?
- **Traceability**: How does implementation trace to purpose?
- **Validation**: Are all dependencies satisfied?
- **Tooling**: Automated dependency graph generation

Optional but recommended for all specs with relationships. Required for key specs (requirements, architecture).
