---
type: metaspec
applies-to: specs/workspace/**/*.spec.md
purpose: Define quality criteria for workspace specs (process and meta-governance)
---

# Workspace Metaspec

Workspace specs define HOW you work, not what you build. They govern the development process itself.

## Requirements

- [!] Workspace specs describe process, not product
  - How work is organized and executed
  - Team conventions and workflows
  - Quality gates and validation rules
  - Not feature behaviors or system architecture

- [!] Workspace specs apply universally to all work
  - Orthogonal to product specs
  - Same process regardless of what's being built
  - Not feature-specific rules

- [!] Frontmatter declares scope
  ```yaml
  governed-by: references/templates/metaspecs/workspace.metaspec.md
  applies-to: [what this process governs]
  criticality: CRITICAL | IMPORTANT
  failure_mode: [What breaks without this]
  ```

## The Workspace Test

**Is this about HOW we work or WHAT we build?**
- HOW we work → Workspace spec
- WHAT we build → Foundation, strategy, or behavior spec

**Would this apply to a completely different project?**
- YES → Probably workspace (process is portable)
- NO → Probably product spec (feature-specific)

## Common Workspace Spec Types

| Spec | Covers |
|------|--------|
| `constitution.spec.md` | Core principles, non-negotiable rules |
| `workflows.spec.md` | How work flows through phases |
| `patterns.spec.md` | Conventions (naming, structure, format) |
| `taxonomy.spec.md` | Project classification and scope |
| `generated-files.spec.md` | What's generated vs authored |

## Anti-Patterns

Workspace specs must NOT contain:

- **Feature behaviors** - "User can login" belongs in features/
- **System architecture** - "Uses microservices" belongs in strategy/
- **Business outcomes** - "Increase revenue" belongs in foundation/
- **API contracts** - Interface definitions belong in interfaces/
- **Technology choices** - Unless it's tooling for the process itself

## Valid References

| Direction | Target | Relationship |
|-----------|--------|--------------|
| ACROSS | Other workspace specs | related-to |
| OUT | All other specs | applies-to (governance) |
| NEVER | Product specs (features, strategy) | Workspace doesn't depend on product |

## Orthogonality Principle

Workspace specs are **orthogonal** to product specs:

```
                    ┌─────────────┐
                    │  Workspace  │  ← HOW you work
                    │   specs     │    (applies to all)
                    └──────┬──────┘
                           │ governs
         ┌─────────────────┼─────────────────┐
         ▼                 ▼                 ▼
   ┌──────────┐     ┌──────────┐     ┌──────────┐
   │Foundation│ ──► │ Strategy │ ──► │ Behavior │  ← WHAT you build
   │  (WHY)   │     │  (HOW)   │     │  (WHAT)  │    (product-specific)
   └──────────┘     └──────────┘     └──────────┘
```

Workspace specs govern the PROCESS of creating product specs, but don't reference their content.

## Example Structure

```markdown
---
governed-by: references/templates/metaspecs/workspace.metaspec.md
applies-to: all specs in this workspace
criticality: IMPORTANT
failure_mode: Inconsistent process leads to quality gaps
---

# [Process/Convention Name]

## Requirements

- [!] [Process rule or convention]
  - Applies to: [what this governs]
  - Rationale: [why this helps]
  - Validation: [how to check compliance]

- [!] [Another process rule]
  - Applies to: [scope]
  - Exception: [when this doesn't apply]
```

## Validation Checklist

- [ ] Describes process, not product
- [ ] Applies universally (not feature-specific)
- [ ] No product architecture or behaviors
- [ ] Could apply to different project with same methodology
- [ ] governed-by frontmatter present
- [ ] applies-to scope declared
