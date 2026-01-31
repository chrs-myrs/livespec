---
description: Migrate to new LiveSpec version
---

# Upgrade LiveSpec

Migrate project to new LiveSpec version while preserving customizations.

## When to Use

- New LiveSpec version released
- `.livespec-version` indicates outdated methodology
- Wanting new features/improvements
- Instructed by LiveSpec maintainers

## Upgrade Process

### Step 1: Check Current Version

```bash
cat .livespec-version 2>/dev/null || echo "No version file"
```

### Step 2: Check Available Version

For plugin-based installation:
```bash
# Plugin version in .claude-plugin/plugin.json
```

For file-copy installation:
```bash
cat path/to/livespec/dist/VERSION
```

### Step 3: Review Breaking Changes

Check CHANGELOG.md for breaking changes between versions.

Common breaking changes:
- Renamed specs or prompts
- Changed folder structure
- New required workspace specs
- Modified MSL format

### Step 4: Backup Customizations

Identify project-specific customizations:
- specs/workspace/ modifications
- Custom compression settings
- Project-specific patterns

### Step 5: Apply Upgrade

**For plugin installation:**
```bash
/plugin update livespec
```

**For file-copy installation:**
```bash
# Compare and merge
diff -r .livespec/ path/to/livespec/dist/
# Then selectively copy updates
```

### Step 6: Update Workspace Specs

If workspace spec format changed:
1. Read new metaspecs
2. Update project workspace specs
3. Preserve project-specific content

### Step 7: Regenerate Context

```
/livespec:rebuild-context
```

### Step 8: Validate

```
/livespec:validate
```

Fix any issues before committing.

### Step 9: Update Version Indicator

```bash
echo "X.Y.Z" > .livespec-version
```

## Post-Upgrade Checklist

- [ ] Version file updated
- [ ] Workspace specs compatible
- [ ] AGENTS.md regenerated
- [ ] Validation passes
- [ ] Customizations preserved
- [ ] Team notified of changes

## Rollback

If upgrade causes issues:
1. Revert .livespec-version
2. Restore from git: `git checkout -- specs/workspace/`
3. Regenerate context
4. Report issue to LiveSpec maintainers

## References

For detailed upgrade procedures:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/upgrade-methodology.md`
