# LiveSpec Conventions

LiveSpec uses [MSL (Markdown Specification Language)](https://github.com/chrs-myrs/msl-specification) with specific conventions for specification management and organization.

## MSL Extensions

### Custom Frontmatter Fields

LiveSpec extends MSL with two required frontmatter fields:

#### criticality

**Values**: `CRITICAL` | `IMPORTANT`

Indicates requirement priority:
- **CRITICAL**: System fails without this (literally breaks, unusable, or unsafe)
- **IMPORTANT**: System works but quality degrades significantly

**Not allowed**: "Should have", "Nice to have", "Could have", "Recommended"

If it's not CRITICAL or IMPORTANT, delete it.

#### failure_mode

**Format**: Single sentence describing concrete failure

Explains specifically what breaks if requirement not met.

**Good examples:**
- `Users cannot log in without authentication`
- `Data corruption occurs without validation`
- `System unusable on mobile without responsive design`

**Bad examples:**
- `Not having authentication would be problematic` (vague)
- `Users might have issues` (not specific)
- `System quality degrades` (what does this mean?)

### Dependency Frontmatter

LiveSpec uses MSL's standard dependency fields:

- **derives_from**: Parent specs this is based on
- **constrained_by**: Boundaries this must respect
- **satisfies**: Requirements this fulfills
- **supports**: What this spec enables
- **applies_to**: Scope (for workspace specs)

### Requirement Markers

LiveSpec uses MSL markers with specific conventions:

- `[!]` - Critical requirement (system fails without this)
- `[?]` - Needs validation (extracted specs with low confidence)
- `[x]` - Implemented and validated
- `[ ]` - Pending implementation

## Folder Structure

LiveSpec separates workspace specifications (HOW you build) from product specifications (WHAT you build):

```
specs/
├── mission/            # High-level project goals
│   ├── outcomes.spec.md     # What we must achieve
│   └── constraints.spec.md  # Hard boundaries
├── workspace/          # Development methodology (portable)
│   ├── constitution.spec.md
│   ├── patterns.spec.md
│   └── workflows.spec.md
├── behaviors/          # Observable system behaviors
└── contracts/          # API/data contracts
```

**Decision test**: "Could I copy this spec to a different project?"
- YES → `workspace/` (development process)
- NO → `mission/`, `behaviors/`, `strategy/`, or `contracts/` (product-specific)

## Naming Conventions

### Specification Files

- **Format**: `descriptive-name.spec.md`
- **Extension**: Always `.spec.md` (required)
- **Style**: Kebab-case for filenames

**Examples:**
- `user-authentication.spec.md`
- `api-versioning.spec.md`
- `drift-detection.spec.md`

### Prompt Files

- **Format**: `[0-4][a-z]-descriptive-name.md`
- **Phase prefix**: 0-4 (DEFINE, DESIGN, BUILD, VERIFY, EVOLVE)
- **Letter suffix**: Sequential within phase (a, b, c, d, e)

**Examples:**
- `0a-setup-workspace.md`
- `1b-define-behaviors.md`
- `4d-regenerate-context.md`

## Language Conventions

- **User documentation**: British English (synchronisation, behaviour, organise)
- **Code elements**: American English (synchronize, behavior, organize)
- **Specs**: Follow user documentation style (British English)

## Specification Patterns

### One Spec Per Behavior

Each observable behavior gets exactly one dedicated spec file. Avoid:
- Multiple behaviors in single spec
- Duplicate specs for same behavior
- Overly granular specs that fragment understanding

### Minimalism Test

Before adding any line to a spec, ask:

1. **Would the system fail without this?** (Validates criticality)
2. **Am I specifying HOW instead of WHAT?** (Remove implementation details)
3. **What specific problem does this prevent?** (Focus on real needs)
4. **Could this be inferred or is it conventional?** (Omit obvious)

Every word must justify its existence.

### Validation Criteria

Requirements include testable validation criteria as sub-bullets:

```markdown
## Requirements
- [!] Main requirement statement
  - Testable criterion 1
  - Testable criterion 2
  - Observable outcome 3
```

Criteria should be:
- **Observable**: Can be verified through testing or inspection
- **Specific**: No vague terms like "good" or "adequate"
- **Complete**: Cover all aspects of the requirement

## Extracted Specifications

When extracting specs from code (Phase 4b), mark low-confidence extractions:

### Frontmatter Metadata

```yaml
---
criticality: IMPORTANT
failure_mode: Description
extracted_from:
  - src/auth/oauth.py
  - src/auth/session.py
extracted_date: 2025-10-06
confidence: LOW
requires_validation: true
extraction_reason: "Inferred from implementation, no tests found"
---
```

### Lifecycle States

- **EXTRACTED**: Generated from code, needs validation
- **REVIEWED**: Human examined, corrections made
- **VALIDATED**: Promoted to standard spec (extraction metadata removed)

### Promotion

When validated:
1. Remove extraction metadata (`extracted_from`, `extracted_date`, `confidence`, etc.)
2. Add standard frontmatter (`derives_from`, `satisfies`, dependency fields)
3. Replace `[?]` markers with `[!]` or remove
4. Ensure all validation criteria are testable

## Additional Resources

- [MSL Specification](https://github.com/chrs-myrs/msl-specification) - Full format reference
- [MSL Guide](msl-guide.md) - LiveSpec's usage of MSL
- [Quickstart](quickstart.md) - Getting started with LiveSpec
