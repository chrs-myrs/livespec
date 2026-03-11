---
implements: specs/artifacts/prompts/utils-upgrade.spec.md
generated: '2025-12-15'
---

# Upgrade Methodology Utility Prompt

**Purpose**: Safely upgrade LiveSpec methodology to latest version

## Context

This utility prompt guides you through upgrading the LiveSpec framework in your project. The upgrade process preserves all your project-specific customizations (specs/workspace/, AGENTS.md, etc.) while updating the framework prompts and tools.

**When to use:**
- New LiveSpec version released
- You want latest methodology improvements
- Bug fixes in framework prompts

**When NOT to use:**
- No `.livespec/` directory exists (use installation script instead)
- Major version upgrade with breaking changes (check migration guide first)

## Task

### Step 1: Pre-Flight Checks

**Detect installation method:**
```bash
# Check for submodule
if [ -d ".livespec-repo" ]; then
  echo "Submodule installation detected"
else
  echo "Copy installation detected (or framework missing)"
fi
```

**Show current version:**
```bash
# For submodule installations
git -C .livespec-repo describe --tags 2>/dev/null || echo "No tags found"

# Alternative: read VERSION file
cat .livespec/VERSION 2>/dev/null || echo "VERSION file not found"
```

**Check for uncommitted changes:**
```bash
git status --porcelain
```

If uncommitted changes exist, warn user:
"You have uncommitted changes. Consider committing or stashing before upgrading to clearly track what changed."

**Cannot proceed without completing pre-flight checks.**

### Step 2: Upgrade Framework

**For Submodule Installations (Recommended):**

```bash
# Fetch latest from upstream
git submodule update --remote .livespec-repo

# Verify symlink still valid
ls -l .livespec
# Should show: .livespec -> .livespec-repo/dist

# Show new version
git -C .livespec-repo describe --tags
```

**For Copy Installations (Legacy):**

Warn user:
"Copy installations require manual upgrade. Consider migrating to sparse submodule for automatic updates."

**Option A - Migrate to Submodule (Recommended):**
```bash
# Remove old copy
rm -rf .livespec/

# Install via submodule
bash /path/to/livespec/dist/scripts/install-livespec.sh
```

**Option B - Manual Copy (Not Recommended):**
```bash
# Clone latest
git clone https://github.com/chrs-myrs/livespec /tmp/livespec-latest

# View changes (optional)
diff -r .livespec/ /tmp/livespec-latest/dist/ | head -50

# Replace framework
rm -rf .livespec/
cp -r /tmp/livespec-latest/dist .livespec

# Cleanup
rm -rf /tmp/livespec-latest
```

### Step 3: Validate Upgrade

**Test framework accessibility:**
```bash
# Quick test - read a prompt
cat .livespec/prompts/0-define/0a-quick-start.md | head -10
```

**Verify project specs untouched:**
```bash
# Should show no changes to your specs
git status specs/
```

**Verify generated content preserved:**
```bash
# Check AGENTS.md exists
test -f AGENTS.md && echo "AGENTS.md preserved" || echo "AGENTS.md missing"

# Check generated prompts (if any)
ls prompts/generated/ 2>/dev/null || echo "No generated prompts"
```

### Step 4: Post-Upgrade Actions

**Commit the upgrade (submodule installations):**
```bash
git add .livespec-repo
git commit -m "Update LiveSpec framework to $(git -C .livespec-repo describe --tags)"
```

**Show summary:**

Tell user:
"**Upgrade complete!**

**Framework upgraded** (old version → new version)
- `.livespec/prompts/` - Updated methodology prompts
- `.livespec/templates/` - Updated templates
- `.livespec/standard/` - Updated MSL metaspecs

**Preserved (unchanged)**:
- `specs/workspace/` - Your project-specific process
- `AGENTS.md` - Your generated agent context
- `prompts/generated/` - Your custom prompts
- All project code and specs

**Recommended**: Check CHANGELOG for breaking changes (rare)"

## Framework Immutability

**Key concept:** `.livespec/` is immutable framework reference
- Framework prompts used as-is (no modification)
- Project customization via `specs/workspace/` (not framework)
- Submodule update safe (project specs separate from framework)

**If framework doesn't fit your needs:**
- 99% of cases: Customize via `specs/workspace/` (sufficient)
- Rare case: Fork repository and point submodule to your fork

## Edge Cases

**No .livespec-repo/ exists:**
- Copy installation detected
- Recommend migration to submodule
- Provide manual upgrade steps if user declines

**Uncommitted changes:**
- Warn before upgrade
- User should commit or stash first
- Prevents confusion about what changed

**Breaking changes (rare):**
- Note in upgrade summary: "Check CHANGELOG for breaking changes"
- LiveSpec maintains backwards compatibility in practice
- Major version jumps may require migration guide

## Output

**Primary outputs:**
- Updated `.livespec-repo/` (submodule method) or `.livespec/` (copy method)
- Version bump visible
- Upgrade summary showing old → new version

**Validation checks:**
- Framework accessible (test file read)
- Symlink valid (ls -l .livespec)
- Project specs unchanged (git status specs/)
- Generated content preserved

## Validation

- Upgrade detected installation method correctly
- Submodule upgrade used `git submodule update --remote`
- Copy upgrade offered migration path first
- Post-upgrade validation confirmed framework accessible
- Project specs and generated content preserved

## Success Criteria

- User can immediately use upgraded methodology
- Project customizations untouched
- Clear version change shown (old → new)
- Framework prompts accessible
- Process completed in under 2 minutes (submodule installations)
