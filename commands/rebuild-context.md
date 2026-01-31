---
description: Rebuild AGENTS.md and context tree from workspace specs
---

# Rebuild Context

Regenerate AGENTS.md from current workspace specifications to ensure AI agents have current methodology context.

## When to Use

- After updating workspace specs (specs/workspace/)
- After Phase 0 setup (init)
- When agent context feels stale
- When workspace changes need to propagate
- After LiveSpec version upgrade

## Why This Matters

AGENTS.md is generated from:
- PURPOSE.md - Project vision and success criteria
- specs/workspace/constitution.spec.md - Development principles
- specs/workspace/patterns.spec.md - Naming conventions
- specs/workspace/workflows.spec.md - Phase workflow
- specs/workspace/taxonomy.spec.md - Project classification

Without regeneration, AI agents lack YOUR project's specific context.

## Process

### Step 1: Gather Sources

Read all workspace specs and PURPOSE.md:
```bash
cat PURPOSE.md specs/workspace/*.spec.md
```

### Step 2: Check Configuration

Read project.yaml if it exists for:
- context_compression level
- doc_format (AGENTS.md vs CLAUDE.md)
- context_budget target

### Step 3: Generate AGENTS.md

Structure the file following START/MIDDLE/END pattern:

**START (30-40%)**: Critical rules, principles, enforcement
**MIDDLE (40%)**: Examples, procedures, decision trees
**END (20-30%)**: References, prompt registry

Add frontmatter:
```yaml
---
generated: [ISO timestamp]
generator: livespec/rebuild-context
version: [from .livespec-version]
note: Generated from PURPOSE.md and specs/workspace/
---
```

### Step 4: Apply Compression

Based on context_compression setting:
- **Light**: Verbose, inline everything
- **Moderate**: Balanced inline/reference
- **Aggressive**: Dense, heavy referencing

Target size: < 40KB (leave headroom)

### Step 5: Validate

```bash
# Size check
ls -lh AGENTS.md

# Structure check
grep "^## " AGENTS.md

# Frontmatter check
head -n 10 AGENTS.md
```

Verify:
- File under budget
- All main sections present
- Generation metadata in frontmatter

### Step 6: Report

```
Context rebuilt!

AGENTS.md regenerated:
- Size: XX KB (target: 30-40KB)
- Sources: PURPOSE.md + 4 workspace specs
- Compression: [level]

Changes from last generation:
- [List of updated sections]
```

## Notes

- AGENTS.md should be committed to git
- Don't edit AGENTS.md directly - edit source specs
- Regenerate after any workspace spec changes

## References

For detailed context regeneration:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/evolve/4d-regenerate-context.md`
- `${CLAUDE_PLUGIN_ROOT}/references/guides/context-positioning.md`
