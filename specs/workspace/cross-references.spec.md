---
type: workspace
category: workspace
fidelity: process
criticality: IMPORTANT
failure_mode: Broken cross-references prevent navigation between prompts and specs, breaking traceability
governed-by: []
applies_to:
  - all_projects
derives-from:
  - specs/workspace/patterns.spec.md
---

# Cross-Reference Patterns

## Requirements
- [!] LiveSpec keeps links between specs, and from specs to the files they govern, navigable in both directions, with a systematic update workflow when renaming or moving files.
  - Specs declare upward links (`derives-from`, `satisfies`, `guided-by`, `governed-by`) to what they serve, written from the repository root
  - Specs declare `specifies:` naming the files they govern; those files carry no link back
  - Each spec's `supports:` is generated from the upward links that reach it, never written by hand
  - `governed-by:` is content governance; the metaspec a spec follows is implied by its `type`
  - Systematic checklist used when renaming/moving files
  - All cross-references updated atomically in single commit
  - Validation catches broken references and links that do not trace to PURPOSE.md

## Dependency Traceability

### Specs → Parents (upward links)

**Specs name what they serve, upward only:**
```yaml
---
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
---
```

**Purpose:**
- Traces every spec to PURPOSE.md
- The parent's `supports:` is generated from these, so navigation down needs no tool
- One source of truth: editing a link means editing the child

### Specs → Files (specifies:)

**Specs use `specifies:` to name what they govern:**
```yaml
---
specifies: skills/design/SKILL.md
---
```

**Purpose:**
- Links a spec to its deliverable
- A file's governing spec is the one whose `specifies:` names it
- Enables validation (spec requirements met by implementation)

### Other Dependency Fields

**For specs:**
- `supports:` - Generated: the specs that link up to this one
- `informed-by:` - External research or standards
- `applies_to:` - Scope (for workspace specs)

**See:** `references/guides/frontmatter-relationships.md` for the decision framework

## Cross-Reference Update Pattern

When renaming or moving prompts or specs, use systematic checklist to maintain traceability.

### Update Checklist

**Files to update:**
- [ ] Source file renamed/moved (skills/, commands/, or specs/)
- [ ] Spec frontmatter (`specifies:` and any upward links naming the moved spec)
- [ ] Registry entry (specs/artifacts/prompts/registry.spec.md)
- [ ] Navigation references (command routing, skill cross-links)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (`bash scripts/validate-crossrefs.sh --fix`, then `/livespec:audit validate`)

### Example: Renaming Prompt

**Scenario:** Renaming 0d-identify-constraints.md → 0f-identify-constraints.md

**Updated files:**
1. ✓ references/prompts/define/0f-identify-constraints.md (renamed)
2. ✓ specs/artifacts/prompts/0f-identify-constraints.spec.md (frontmatter: `specifies:`)
3. ✓ specs/artifacts/prompts/registry.spec.md (table entry)
4. ✓ references/prompts/define/0c-define-outcomes.md (next step reference)
5. ✓ AGENTS.md (if prompt mentioned)
6. ✓ Run validation to catch any missed references

**Git workflow:**
```bash
# Rename files
git mv references/prompts/define/0d-identify-constraints.md \
       references/prompts/define/0f-identify-constraints.md

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
- Missing spec frontmatter breaks traceability to PURPOSE.md
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

**Location:** Metaspecs live in `references/standards/metaspecs/` and are distributed to target projects via the LiveSpec plugin (`/plugin install livespec@livespec`), not file copying.

## Validation
- All prompt behavior specs declare `specifies:` field
- Every spec's upward links reach PURPOSE.md
- Every `supports:` matches the upward links that reach its spec
- No spec declares the retired `implements:` field
- Systematic checklist used for renames/moves
- All cross-references updated atomically
- Validation catches broken references
- Registry entries accurate
- Navigation references current
