---
specifies: dist/prompts/utils/upgrade-methodology.md
derives-from:
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Users cannot safely upgrade methodology, risking manual errors or abandoning updates when LiveSpec evolves
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/distribution.spec.md
---

# Upgrade Methodology Utility Prompt

## Requirements
- [!] Prompt guides user through safely upgrading LiveSpec framework via git submodule update with validation checks ensuring upgrade succeeded and project specs remain independent.
  - **Pre-Flight Checks**:
    - Detects installation method (.livespec-repo/ exists = submodule, .livespec/ directory only = copy)
    - Shows current version: `git -C .livespec-repo describe --tags` (submodule) or manual check
    - Warns if uncommitted changes in project (user should commit before upgrading)
    - Agent cannot proceed without completing pre-flight checks
  - **Upgrade Methods by Installation Type**:
    - **Submodule installations** (recommended):
      - Check current: `git -C .livespec-repo describe --tags`
      - Fetch latest: `git submodule update --remote .livespec-repo`
      - Verify symlink: `.livespec → .livespec-repo/dist` still valid
      - Show new version: `git -C .livespec-repo describe --tags`
    - **Copy installations** (legacy):
      - Warn: "Manual upgrade required (copy method has no auto-update)"
      - Suggest: "Consider migrating to sparse submodule (bash scripts/install-livespec.sh)"
      - Manual steps: Clone latest, diff, copy files
  - **Validation**:
    - Framework prompts accessible via `.livespec/prompts/`
    - Project specs untouched in `specs/workspace/`
    - Generated prompts preserved in `prompts/generated/`
    - Quick test: Agent reads `.livespec/prompts/0-define/0a-quick-start.md` (proves framework accessible)
  - **Post-Upgrade**:
    - Show upgrade summary (old version → new version)
    - Note: "Framework upgraded, project specs unchanged (customization via specs/workspace/)"
    - Suggest: Check CHANGELOG for breaking changes (rare)
  - Process completes in under 2 minutes for submodule installations
  - Zero risk to project customizations (specs/workspace/ independent of framework)

## Triggers

**When to use:**
- LiveSpec releases new version
- User wants latest methodology improvements
- Bug fixes in framework prompts

**When NOT to use:**
- No `.livespec/` directory exists (use installation guide instead)
- Major version upgrade (check migration guide first)

## Upgrade Process

### For Submodule Installations (Preferred)

**Step 1: Check Current Version**
```bash
git -C .livespec-repo describe --tags
# Example output: v3.7.0
```

**Step 2: Update Framework**
```bash
git submodule update --remote .livespec-repo
# Fetches latest from upstream
```

**Step 3: Validate**
```bash
# Verify symlink still points correctly
ls -l .livespec
# Should show: .livespec -> .livespec-repo/dist

# Show new version
git -C .livespec-repo describe --tags
# Example output: v3.8.0

# Test framework accessible
cat .livespec/prompts/0-define/0a-quick-start.md | head -5
```

**Step 4: Commit Submodule Update**
```bash
git add .livespec-repo
git commit -m "Update LiveSpec framework to v3.8.0"
```

### For Copy Installations (Legacy)

**Migration Recommended:**
```bash
# Better to migrate to submodule
rm -rf .livespec/
bash scripts/install-livespec.sh
```

**Manual Upgrade (Not Recommended):**
```bash
# Clone latest
git clone https://github.com/chrs-myrs/livespec /tmp/livespec-latest

# Diff to see changes
diff -r .livespec/ /tmp/livespec-latest/dist/

# Manual copy (risks overwriting any customizations)
rm -rf .livespec/
cp -r /tmp/livespec-latest/dist/* .livespec/
```

## Framework Immutability

**Key concept:** `.livespec/` is immutable framework reference
- Framework prompts used as-is (no modification)
- Project customization via `specs/workspace/` (not framework)
- Submodule update safe (project specs separate)

**What's preserved during upgrade:**
- ✅ `specs/workspace/` - Your project-specific process
- ✅ `prompts/generated/` - Your generated prompts
- ✅ `AGENTS.md` - Your generated agent context
- ✅ All project code and specs

**What changes during upgrade:**
- ⚠️ `.livespec/prompts/` - Framework prompts (expected)
- ⚠️ `.livespec/templates/` - Reference templates (expected)
- ⚠️ `.livespec/standard/` - MSL metaspecs (expected)

**If framework doesn't fit:**
- Rare case: Fork repository and point submodule to your fork
- Normal case: Customize via `specs/workspace/` (sufficient for 99% of projects)

## Outputs

**Primary outputs:**
- Updated `.livespec-repo/` (submodule method)
- Version bump visible in `git -C .livespec-repo describe --tags`
- Upgrade summary (old version → new version)

**Validation checks:**
- Framework accessible (test file read)
- Symlink valid (ls -l .livespec)
- Project specs unchanged (git status specs/)
- Generated prompts preserved (ls prompts/generated/)

**Success criteria:**
- User can immediately use upgraded methodology
- Project customizations untouched
- Clear version change shown (old → new)
- Framework prompts accessible

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

## Validation

- Upgrade prompt exists at dist/prompts/utils/upgrade-methodology.md
- Prompt detects installation method (submodule vs copy)
- Submodule upgrade uses `git submodule update --remote`
- Validation confirms framework accessible after upgrade
- No references to customizations.yaml (removed - framework immutable)
- No merge logic (framework is read-only reference)
- Process simplified to 4 steps for submodule installations
- Migration path documented for copy installations
- Framework immutability principle reinforced throughout
