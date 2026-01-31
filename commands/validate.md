---
description: Run project validation checks for LiveSpec compliance
---

# Validate Project

Run comprehensive validation of LiveSpec project structure and compliance.

## What This Validates

1. **Taxonomy Structure**: Required sections present in taxonomy.spec.md
2. **Workspace Scope**: Product-specific content not in workspace/
3. **Spec Purity**: No implementation code in requirements/strategy specs
4. **Architecture Alignment**: Referenced directories actually exist
5. **Cross-References**: All frontmatter references between specs valid
6. **Generated Files**: Detection of direct edits that bypass source-of-truth
7. **Version Sync**: All version indicators match

## Process

### Phase 1: Structural Checks

Check specs/workspace/taxonomy.spec.md exists and has required sections:
- Project Domain
- Workspace Scope
- Specs Boundary

Verify workspace/ contains only operating context, not product-specific content.

### Phase 2: Cross-Reference Validation

For each spec with frontmatter references:
```bash
# Check implements, derives-from, governed-by, satisfies references
grep -E "^(implements|derives-from|governed-by|satisfies):" specs/**/*.spec.md
```

Validate each referenced file exists.

### Phase 3: Generated File Protection

Check if AGENTS.md was edited directly:
```bash
# Compare generation timestamp to modification time
grep "^generated:" AGENTS.md
stat AGENTS.md
```

If file modified after generation timestamp, report error.

### Phase 4: Version Sync

```bash
VERSION=$(cat .livespec-version 2>/dev/null || echo "unknown")
AGENTS_VERSION=$(grep "version:" AGENTS.md | head -1 | cut -d: -f2 | xargs)
```

Report any mismatches.

## Report Format

```markdown
# Validation Report

## Summary
- Errors: X (must fix)
- Warnings: X (should fix)
- Passed: X

## Errors
- [file:line] [description] [fix suggestion]

## Warnings
- [file] [description] [fix suggestion]

## Passed
- Taxonomy structure valid
- All cross-references valid
- No direct edits to generated files
```

## When to Run

- Before committing changes
- After regenerating files (AGENTS.md, docs)
- After updating specs
- Before releases
- Periodically (weekly/sprint end)

## References

For detailed validation procedures:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/validate-project.md`
