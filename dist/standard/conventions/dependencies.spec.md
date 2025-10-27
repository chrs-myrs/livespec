---
criticality: IMPORTANT
failure_mode: Without dependency tracking, specification relationships become implicit and unverifiable
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Dependency Convention

## Requirements
- LiveSpec specifications declare relationships via YAML frontmatter to enable traceability and impact analysis.
  - Specifications use standard frontmatter fields for dependencies
  - `derives_from:` lists parent specs this is based on
  - `constrained_by:` lists boundaries this must respect
  - `satisfies:` lists requirements this fulfills
  - `guided_by:` lists strategies that guide this spec (horizontal influence)
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
derives-from:
  - PURPOSE.md
  - specs/requirements.spec.md
```

### constrained_by
Boundaries and limits this specification must respect.

**Example:**
```yaml
governed-by:
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

### guided_by
Strategic approach or architectural decisions that guide this specification (horizontal influence, not satisfied by).

Distinct from `satisfies:` (vertical fulfillment), `guided-by:` represents advisory/directional relationships where strategy specs guide implementation choices without being "fulfilled" by them.

**Example:**
```yaml
guided-by:
  - specs/2-strategy/api-design.spec.md
  - specs/2-strategy/calculation-approach.spec.md
```

**Use cases:**
- Implementation specs guided by architectural strategies
- Behaviors following cross-cutting technical decisions
- Distinguishing WHAT (satisfies requirements) from HOW (guided by strategy)

### supports
What this specification enables or makes possible.

**Example:**
```yaml
supports:
  - prompts/4-evolve/4d-regenerate-agents.md
  - specs/3-behaviors/drift-detection.spec.md
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
specs/1-requirements/functional/user-authentication.spec.md
    ↓ satisfies (vertical)
specs/3-behaviors/oauth-authentication.spec.md
    ↑ guided_by (horizontal)
specs/2-strategy/security-architecture.spec.md
    ↓ constrained_by
specs/1-requirements/strategic/constraints.spec.md
```

**Note:** Implementation specs (Layer 3) have dual linkage:
- `satisfies:` requirements (vertical - WHAT they achieve)
- `guided_by:` strategy (horizontal - HOW they do it)

## Notes

Dependency frontmatter enables:
- **Impact analysis**: What breaks if this spec changes?
- **Traceability**: How does implementation trace to purpose?
- **Validation**: Are all dependencies satisfied?
- **Tooling**: Automated dependency graph generation

Optional but recommended for all specs with relationships. Required for key specs (requirements, architecture).
