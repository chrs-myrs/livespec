---
applies_to:
  - all_projects
criticality: IMPORTANT
failure_mode: Broken cross-references prevent navigation between prompts and specs, breaking traceability
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
derives-from:
  - specs/workspace/patterns.spec.md
---

# Cross-Reference Patterns

## Requirements
- [!] LiveSpec maintains bidirectional links between prompts and specifications using YAML frontmatter with systematic update workflow when renaming or moving files.
  - Prompts declare `implements:` field linking to behavior spec
  - Specs declare `specifies:` field linking to implementation
  - Specs declare `governed-by:` field linking to metaspecs
  - Other dependency fields available (derives-from, satisfies, supports, applies_to)
  - Systematic checklist used when renaming/moving files
  - All cross-references updated atomically in single commit
  - Validation catches broken references

## Dependency Traceability

### Prompts → Specs (implements:)

**Prompts use `implements:` to reference defining specifications:**
```yaml
---
implements: specs/3-artifacts/prompts/1a-design-architecture.spec.md
---
```

**Purpose:**
- Links prompt to its behavioral specification
- Enables validation (prompt matches spec requirements)
- Provides traceability (what behavior does this prompt implement)

### Specs → Prompts (specifies:)

**Specs use `specifies:` to reference implementation:**
```yaml
---
specifies: dist/prompts/1-design/1a-design-architecture.md
---
```

**Purpose:**
- Links behavior spec to its implementation
- Bidirectional navigation (spec ↔ prompt)
- Enables validation (spec requirements met by implementation)

### Specs → Metaspecs (governed-by:)

**Specs use `governed-by:` to reference constraining metaspecs:**
```yaml
---
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---
```

**Purpose:**
- Declares hierarchical structure
- Inherits requirements from parent metaspec
- Enables MSL minimalism (don't repeat inherited structure)

### Other Dependency Fields

**For specs:**
- `derives-from:` - Parent specs this is based on
- `satisfies:` - Requirements this fulfills
- `supports:` - What this spec enables
- `applies_to:` - Scope (for workspace specs)
- `guided-by:` - Strategies guiding this spec (horizontal influence)

**See:** `.livespec/standard/conventions/dependencies.spec.md` for complete reference

## Cross-Reference Update Pattern

When renaming or moving prompts or specs, use systematic checklist to maintain traceability.

### Update Checklist

**Files to update:**
- [ ] Source file renamed/moved (dist/prompts/ or specs/)
- [ ] Spec frontmatter (`specifies:` or `implements:` field)
- [ ] Registry entry (specs/3-artifacts/prompts/registry.spec.md)
- [ ] Navigation files (dist/prompts/utils/next-steps.md)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (prompts/utils/validate-project.md)

### Example: Renaming Prompt

**Scenario:** Renaming 0d-identify-constraints.md → 0f-identify-constraints.md

**Updated files:**
1. ✓ dist/prompts/0-define/0f-identify-constraints.md (renamed)
2. ✓ specs/3-artifacts/prompts/0f-identify-constraints.spec.md (frontmatter: `specifies:`)
3. ✓ specs/3-artifacts/prompts/registry.spec.md (table entry)
4. ✓ dist/prompts/utils/next-steps.md (decision tree references)
5. ✓ dist/prompts/0-define/0c-define-outcomes.md (next step reference)
6. ✓ AGENTS.md (if prompt mentioned)
7. ✓ Run validation to catch any missed references

**Git workflow:**
```bash
# Rename files
git mv dist/prompts/0-define/0d-identify-constraints.md \
       dist/prompts/0-define/0f-identify-constraints.md

# Update all cross-references (Edit tool)
# ... update spec frontmatter, registry, navigation, etc.

# Commit atomically
git add .
git commit -m "Rename 0d → 0f: Update all cross-references

- Renamed prompt file
- Updated spec frontmatter (specifies:)
- Updated registry entry
- Updated navigation references
- Updated predecessor prompt references
- Validated: No broken links"
```

### Why Systematic Approach Matters

**Missing updates cause:**
- Missing spec frontmatter breaks bidirectional linking
- Missing registry breaks prompt discovery
- Missing navigation breaks workflow guidance
- Inconsistent references confuse AI agents

**Systematic checklist prevents:**
- Forgotten references
- Broken navigation
- Discovery failures
- Validation errors

## Metaspec Hierarchy

**Purpose:** Eliminate repetition through hierarchical abstraction (MSL minimalism)

**Hierarchy structure:**
```
base.spec.md (MSL + LiveSpec frontmatter)
  ↓ governs
behavior.spec.md (observable outcomes, validation)
  ↓ governs
prompt.spec.md (prompt structural requirements)
  ↓ governs
[individual prompt specs] (specific outcomes only)
```

**What metaspecs define:**
- **base.spec.md** - Core MSL format (title, frontmatter, Requirements section)
- **behavior.spec.md** - Observable outcomes pattern, validation criteria requirements
- **prompt.spec.md** - Prompt-specific structure (Context, Prerequisites, Task, Outputs, Validation, Success Criteria, Error Handling, Constraints sections)

**What individual specs define:**
- Specific outcomes THIS prompt/behavior achieves
- Specific files created (with paths and format specifications)
- Specific prerequisites for THIS use case
- Specific validation criteria for THIS behavior

**Benefit:** Individual prompt specs focus on WHAT prompt achieves, not HOW prompt is structured. Structure inherited from metaspec.

**Location:** Metaspecs live in `.livespec/standard/metaspecs/` and distribute to target projects via `dist/standard/metaspecs/`.

## Validation
- All prompts declare `implements:` field
- All prompt behavior specs declare `specifies:` field
- All specs declare `governed-by:` field (except metaspecs)
- Bidirectional links maintained (implements: ↔ specifies:)
- Systematic checklist used for renames/moves
- All cross-references updated atomically
- Validation catches broken references
- Registry entries accurate
- Navigation references current
