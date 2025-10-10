# MSL Alignment Migration Guide

**Version**: 2.2.0
**Status**: Breaking change - clean cutover to MSL field names

## Summary

LiveSpec frontmatter field names are changing to align with MSL (Markdown Specification Language) core conventions for better semantic precision and ecosystem interoperability.

**Changes:**
- `spec:` → `implements:` (clearer semantics)
- `constrained_by:` → `governed-by:` (MSL standard term)
- `derives_from:` → `derives-from:` (hyphen consistency)

## Why This Change?

### Better Semantics

**Before:**
```yaml
---
spec: specs/prompts/setup.spec.md
---
```

**After:**
```yaml
---
implements: specs/prompts/setup.spec.md
---
```

`implements:` is clearer: "This file implements that specification."

### MSL Ecosystem Alignment

MSL defines standard relationship fields:
- `extends:` - IS-A inheritance
- `governed-by:` - Metaspec governance
- `implements:` - Implementation fulfillment
- `specifies:` - Specification definition
- `references:` - Related specs

LiveSpec uses the same vocabulary, enabling:
- Unified tooling across MSL and LiveSpec
- Predictable field names for AI agents
- Better interoperability

### Hyphen Consistency

MSL uses hyphens (`governed-by`, `derives-from`), not underscores. LiveSpec matches this convention.

## Field Semantics Reference

| Field | Relationship | Meaning | Example |
|-------|-------------|---------|---------|
| `derives-from:` | Provenance | "I was created from this source" | spec derives-from: PURPOSE.md |
| `governed-by:` | Governance | "I must follow these rules/metaspecs" | spec governed-by: behavior-metaspec |
| `implements:` | Fulfillment | "I am code/content satisfying this spec" | prompt implements: prompt.spec.md |
| `specifies:` | Definition | "I define what these files should do" | spec specifies: prompt.md |
| `extends:` | Inheritance | "I am specialized type of parent" (MSL core) | mobile-api extends: api-base |
| `supports:` | Enablement | "These depend on me" (LiveSpec extension) | outcomes supports: architecture |

## How to Migrate Your Project

### Automatic Migration

Use this script to migrate all markdown files in your project:

```bash
#!/bin/bash
# migrate-to-msl-alignment.sh

echo "Migrating LiveSpec frontmatter to MSL-aligned fields..."

find . -name "*.md" -type f -exec sed -i \
  -e 's/^spec:/implements:/' \
  -e 's/^constrained_by:/governed-by:/' \
  -e 's/^derives_from:/derives-from:/' {} +

echo "Migration complete!"
echo ""
echo "Changed fields:"
echo "  spec: → implements:"
echo "  constrained_by: → governed-by:"
echo "  derives_from: → derives-from:"
```

**Migration steps:**
1. Commit current changes: `git add . && git commit -m "Before MSL alignment"`
2. Run script: `bash migrate-to-msl-alignment.sh`
3. Review changes: `git diff`
4. Test and commit: `git commit -am "Align frontmatter with MSL conventions"`

### Manual Migration

For smaller projects, update files manually:

**Prompt files** (`prompts/**/*.md`):
```yaml
# Before
---
spec: specs/behaviors/prompts/setup.spec.md
---

# After
---
implements: specs/behaviors/prompts/setup.spec.md
---
```

**Specification files** (`specs/**/*.spec.md`):
```yaml
# Before
---
derives_from: PURPOSE.md
constrained_by: .livespec/standard/metaspecs/behavior.spec.md
---

# After
---
derives-from: PURPOSE.md
governed-by: .livespec/standard/metaspecs/behavior.spec.md
---
```

## Field Mapping Reference

| Old Field | New Field |
|-----------|-----------|
| `spec:` | `implements:` |
| `specifies:` | `specifies:` (no change) |
| `constrained_by:` | `governed-by:` |
| `derives_from:` | `derives-from:` |

## LiveSpec Extensions

These fields are LiveSpec-specific (not in MSL core):

- `derives-from:` - Source material provenance
- `supports:` - Reverse dependency tracking

Both are compatible with MSL and used alongside MSL core fields.

## Benefits

- **Semantic clarity**: `implements:` is more precise than `spec:`
- **MSL alignment**: Same vocabulary as broader MSL ecosystem
- **Hyphen consistency**: Matches MSL convention (`derives-from` not `derives_from`)
- **Tooling compatibility**: MSL tools recognize LiveSpec projects
- **AI predictability**: Agents trained on MSL understand field meanings

## Support

Questions about migration?

- Review this guide
- Check examples in LiveSpec's own specs
- See alignment proposal: [MSL-LIVESPEC-ALIGNMENT.md](https://github.com/chrs-myrs/msl-specification/blob/master/LIVESPEC-ALIGNMENT.md)

---

**Document Status**: Official migration guide
**Last Updated**: 2025-10-10
**LiveSpec Version**: 2.2.0
