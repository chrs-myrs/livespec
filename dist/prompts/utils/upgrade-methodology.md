---
spec: specs/behaviors/prompts/utils-upgrade.spec.md
---

# Upgrade Methodology

**Purpose**: Safely upgrade .livespec/ to latest LiveSpec version
**Context**: See `specs/behaviors/prompts/utils-upgrade.spec.md` for full requirements

## When to Use

Use this prompt when:
- LiveSpec releases a new version
- You want latest methodology improvements
- Critical bug fixes in prompts
- New features or metaspecs added

Do NOT use if:
- `.livespec/` is a symlink (dogfooding setup - use `git pull` instead)
- No `.livespec/` exists (use Quick Start install)

## Pre-Flight Checks

Before starting, verify:

```bash
# Check .livespec exists
ls -la .livespec/

# Check if symlink (dogfooding case)
test -L .livespec && echo "SYMLINK DETECTED - Use git pull instead" || echo "Regular directory - proceed"

# Check current version (if exists)
cat .livespec/VERSION 2>/dev/null || echo "No VERSION file (pre-upgrade install)"
```

**If symlink detected:** Stop here. Use `git pull` in the linked repository instead.

**If ready to proceed:** Continue to backup phase.

## Phase 1: Backup

Create timestamped backup before any changes:

```bash
# Create backup with timestamp
BACKUP_DIR=".livespec.backup-$(date +%Y%m%d-%H%M%S)"
cp -r .livespec "$BACKUP_DIR"

# Verify backup
echo "Backup created at: $BACKUP_DIR"
ls -la "$BACKUP_DIR"
```

**Verify:** Backup directory exists and contains all .livespec/ contents.

**Store backup path for rollback:** Remember this path in case rollback needed.

## Phase 2: Fetch New Distribution

Choose one fetch method:

### Option A: Git Clone (Recommended)

```bash
# Clone LiveSpec to temp directory
TEMP_DIR=$(mktemp -d)
git clone https://github.com/chrs-myrs/livespec.git "$TEMP_DIR"

# Check version
cat "$TEMP_DIR/dist/VERSION"

# Path to new distribution
NEW_DIST="$TEMP_DIR/dist"
echo "Fetched version: $(cat $NEW_DIST/VERSION)"
```

### Option B: GitHub Release Tarball

```bash
# Download latest release (replace VERSION with desired version)
VERSION="v2.0.0"
curl -L "https://github.com/chrs-myrs/livespec/archive/refs/tags/$VERSION.tar.gz" -o livespec.tar.gz

# Extract
tar -xzf livespec.tar.gz

# Path to new distribution
NEW_DIST="livespec-${VERSION#v}/dist"
echo "Fetched version: $(cat $NEW_DIST/VERSION)"
```

### Option C: Manual Path

```bash
# If you have LiveSpec cloned locally
NEW_DIST="/path/to/your/livespec/dist"
echo "Using distribution at: $NEW_DIST"
cat "$NEW_DIST/VERSION"
```

**Verify:** New distribution path set and VERSION file readable.

## Phase 3: Diff Analysis

Generate comprehensive diff report:

```bash
# Create diff report
mkdir -p var
echo "=== UPGRADE DIFF REPORT ===" > var/var/upgrade-diff.txt
echo "Current version: $(cat .livespec/VERSION 2>/dev/null || echo 'unknown')" >> var/var/upgrade-diff.txt
echo "New version: $(cat $NEW_DIST/VERSION)" >> var/var/upgrade-diff.txt
echo "" >> var/var/upgrade-diff.txt

# Find new files (in new dist, not in .livespec)
echo "🟢 NEW FILES (will be added):" >> var/var/upgrade-diff.txt
comm -13 <(cd .livespec && find . -type f | sort) <(cd "$NEW_DIST" && find . -type f | sort) | sed 's/^/  /' >> var/var/upgrade-diff.txt
echo "" >> var/var/upgrade-diff.txt

# Find modified files (in both, different content)
echo "🟡 MODIFIED FILES (review required):" >> var/var/upgrade-diff.txt
for file in $(comm -12 <(cd .livespec && find . -type f | sort) <(cd "$NEW_DIST" && find . -type f | sort)); do
  if ! diff -q ".livespec/$file" "$NEW_DIST/$file" >/dev/null 2>&1; then
    echo "  $file" >> var/upgrade-diff.txt
  fi
done
echo "" >> var/upgrade-diff.txt

# Find removed files (in old .livespec, not in new dist)
echo "🔴 REMOVED FILES (no longer in standard):" >> var/upgrade-diff.txt
comm -23 <(cd .livespec && find . -type f | sort) <(cd "$NEW_DIST" && find . -type f | sort) | sed 's/^/  /' >> var/upgrade-diff.txt
echo "" >> var/upgrade-diff.txt

# Show report
cat var/upgrade-diff.txt
```

**Review the diff report carefully.**

### Categorization Guide

- **🟢 New files**: Safe to add (new features, prompts, metaspecs)
- **🟡 Modified files**: Review diff carefully - may conflict with your customizations
- **🔴 Removed files**: Standard files removed from new version
- **⚪ Custom files**: Your files not in standard (automatically preserved)

## Phase 4: Selective Application

Apply changes systematically. For each category:

### Apply New Files

```bash
# Copy new files from diff report
# Review list of new files first
grep "🟢" var/upgrade-diff.txt -A 100 | grep "^\s\s" | while read -r file; do
  file=$(echo "$file" | xargs)  # trim whitespace
  if [ -f "$NEW_DIST/$file" ]; then
    echo "Add: $file? (y/n)"
    read -r response
    if [ "$response" = "y" ]; then
      mkdir -p ".livespec/$(dirname "$file")"
      cp "$NEW_DIST/$file" ".livespec/$file"
      echo "  ✓ Added $file"
    else
      echo "  ⊘ Skipped $file"
    fi
  fi
done
```

### Review & Apply Modified Files

```bash
# For each modified file, show diff and ask
grep "🟡" var/upgrade-diff.txt -A 100 | grep "^\s\s" | while read -r file; do
  file=$(echo "$file" | xargs)
  if [ -f ".livespec/$file" ] && [ -f "$NEW_DIST/$file" ]; then
    echo "===== MODIFIED: $file ====="
    echo "Choose action: (d)iff, (a)pply, (s)kip, (f)ull-diff"
    read -r action

    case "$action" in
      d)
        # Show brief diff
        diff -u ".livespec/$file" "$NEW_DIST/$file" | head -50
        echo "Apply? (y/n)"
        read -r response
        [ "$response" = "y" ] && cp "$NEW_DIST/$file" ".livespec/$file" && echo "  ✓ Applied"
        ;;
      a)
        cp "$NEW_DIST/$file" ".livespec/$file"
        echo "  ✓ Applied $file"
        ;;
      s)
        echo "  ⊘ Skipped $file (keeping your version)"
        ;;
      f)
        # Full diff
        diff -u ".livespec/$file" "$NEW_DIST/$file"
        echo "Apply? (y/n)"
        read -r response
        [ "$response" = "y" ] && cp "$NEW_DIST/$file" ".livespec/$file" && echo "  ✓ Applied"
        ;;
    esac
  fi
done
```

### Handle Removed Files

```bash
# Review removed files - decide whether to delete
grep "🔴" var/upgrade-diff.txt -A 100 | grep "^\s\s" | while read -r file; do
  file=$(echo "$file" | xargs)
  if [ -f ".livespec/$file" ]; then
    echo "Remove: $file (no longer in standard)? (y/n)"
    read -r response
    if [ "$response" = "y" ]; then
      rm ".livespec/$file"
      echo "  ✓ Removed $file"
    else
      echo "  ⊘ Kept $file (custom file)"
    fi
  fi
done
```

### Update VERSION File

```bash
# Update version after applying changes
cp "$NEW_DIST/VERSION" .livespec/VERSION
echo "✓ Updated VERSION to $(cat .livespec/VERSION)"
```

## Phase 5: Validation

Verify upgrade integrity:

```bash
echo "=== VALIDATION REPORT ===" > var/validation-report.txt

# Check folder structure
echo "Checking folder structure..." >> var/validation-report.txt
for dir in standard/metaspecs standard/conventions prompts/0-define prompts/1-design prompts/2-build prompts/3-verify prompts/4-evolve prompts/utils templates/workspace; do
  if [ -d ".livespec/$dir" ]; then
    echo "  ✓ $dir exists" >> var/validation-report.txt
  else
    echo "  ✗ $dir missing" >> var/validation-report.txt
  fi
done

# Check critical files
echo "" >> var/validation-report.txt
echo "Checking critical files..." >> var/validation-report.txt

# Metaspecs (7 required)
for spec in base behavior workspace strategy requirements constraints contract; do
  if [ -f ".livespec/standard/metaspecs/${spec}.spec.md" ]; then
    echo "  ✓ metaspecs/${spec}.spec.md" >> var/validation-report.txt
  else
    echo "  ✗ metaspecs/${spec}.spec.md missing" >> var/validation-report.txt
  fi
done

# Conventions (3 required)
for conv in folder-structure naming dependencies; do
  if [ -f ".livespec/standard/conventions/${conv}.spec.md" ]; then
    echo "  ✓ conventions/${conv}.spec.md" >> var/validation-report.txt
  else
    echo "  ✗ conventions/${conv}.spec.md missing" >> var/validation-report.txt
  fi
done

# VERSION file
if [ -f ".livespec/VERSION" ]; then
  echo "  ✓ VERSION: $(cat .livespec/VERSION)" >> var/validation-report.txt
else
  echo "  ✗ VERSION file missing" >> var/validation-report.txt
fi

# List non-standard files (potential custom additions)
echo "" >> var/validation-report.txt
echo "Custom or non-standard files:" >> var/validation-report.txt
comm -23 <(cd .livespec && find . -type f | sort) <(cd "$NEW_DIST" && find . -type f | sort) | sed 's/^/  /' >> var/validation-report.txt

# Show report
cat var/validation-report.txt
```

**Review validation report:** Ensure no critical files missing.

## Phase 6: Summary & Cleanup

Generate upgrade summary:

```bash
echo "=== UPGRADE SUMMARY ===" > var/upgrade-summary.txt
echo "Upgraded from $(cat "$BACKUP_DIR/VERSION" 2>/dev/null || echo 'unknown') to $(cat .livespec/VERSION)" >> var/upgrade-summary.txt
echo "" >> var/upgrade-summary.txt
echo "Backup location: $BACKUP_DIR" >> var/upgrade-summary.txt
echo "" >> var/upgrade-summary.txt
echo "Changes applied:" >> var/upgrade-summary.txt
# Count changes from diff report
echo "  New files added: $(grep -c "✓ Added" var/upgrade-diff.txt 2>/dev/null || echo '0')" >> var/upgrade-summary.txt
echo "  Files modified: $(grep -c "✓ Applied" var/upgrade-diff.txt 2>/dev/null || echo '0')" >> var/upgrade-summary.txt
echo "  Files removed: $(grep -c "✓ Removed" var/upgrade-diff.txt 2>/dev/null || echo '0')" >> var/upgrade-summary.txt
echo "" >> var/upgrade-summary.txt
echo "See var/upgrade-diff.txt and var/validation-report.txt for details." >> var/upgrade-summary.txt

cat var/upgrade-summary.txt
```

### Rollback Instructions

If upgrade fails or causes issues:

```bash
# Rollback to backup (REPLACE TIMESTAMP)
rm -rf .livespec
mv .livespec.backup-YYYYMMDD-HHMMSS .livespec

echo "Rolled back to version: $(cat .livespec/VERSION 2>/dev/null || echo 'unknown')"
```

### Remove Backup (if successful)

If validation passed and everything works:

```bash
# Remove backup to clean up
rm -rf "$BACKUP_DIR"
echo "Backup removed. Upgrade complete."

# Clean up temp files
rm -f var/upgrade-diff.txt var/validation-report.txt var/upgrade-summary.txt
[ -d "$TEMP_DIR" ] && rm -rf "$TEMP_DIR"
```

## Post-Upgrade Steps

After successful upgrade:

1. **Test methodology:** Try using a prompt to ensure everything works
2. **Regenerate AGENTS.md** (if workspace specs changed):
   ```bash
   claude-code "Use .livespec/4-evolve/4d-regenerate-agents.md"
   ```
3. **Review skipped changes:** Check var/upgrade-diff.txt for anything you skipped
4. **Update project specs:** If metaspecs changed significantly, review your project specs

## Exit Criteria

- [ ] Backup created and verified
- [ ] New distribution fetched
- [ ] Diff report reviewed
- [ ] Changes selectively applied
- [ ] VERSION file updated
- [ ] Validation passed (no critical files missing)
- [ ] Upgrade summary reviewed
- [ ] Rollback instructions noted (if needed)
- [ ] Backup removed (if successful)
- [ ] AGENTS.md regenerated (if applicable)

## Troubleshooting

**Fetch fails:**
- Try alternative fetch method (git vs tarball vs manual)
- Check internet connection
- Verify GitHub repository accessible

**Diff fails:**
- Ensure .livespec/ and NEW_DIST paths correct
- Check file permissions
- Try running commands manually

**Validation fails:**
- Review var/validation-report.txt for specific missing files
- Consider re-applying skipped critical files
- Check if custom changes broke structure

**Conflicts with customizations:**
- Keep your version (skip modified files)
- Manually merge changes later
- Document conflicts in project notes

## Notes

- **Customizations preserved:** Your custom files and skipped changes remain untouched
- **Selective application:** You control what changes apply
- **Safety first:** Backup always created before changes
- **Rollback available:** Can always restore from backup
- **No automation:** Manual process ensures you understand each change
