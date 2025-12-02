---
spec: specs/3-behaviors/validation/cross-reference-validation.spec.md, specs/3-behaviors/validation/generated-file-protection.spec.md
derives-from:
  - specs/workspace/workflows.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/version-management.spec.md
---

# Validate Project Integrity

**Purpose**: Detect violations of LiveSpec methodology discipline (broken cross-references, direct edits to generated files) before they cause drift and lost traceability.

**When to use:**
- Before committing changes
- Periodically (weekly/sprint end)
- After updating specs
- After regenerating files
- Before releases

**What it validates:**
1. **Cross-references**: All frontmatter references between specs, docs, and implementation
2. **Generated files**: Detection of direct edits that bypass source-of-truth
3. **Version synchronisation**: All version indicators match .livespec-version
4. **Taxonomy structure**: Required sections present in taxonomy.spec.md (NEW)
5. **Workspace scope**: Product-specific content not in workspace/ (NEW)
6. **Spec purity**: No implementation code in requirements/strategy specs (NEW)
7. **Architecture alignment**: Referenced directories actually exist (NEW)

---

## Validation Process

### Phase 0: Structural Validations (NEW)

Run the four new validation scripts:

```bash
# Taxonomy structure
bash scripts/validate-taxonomy-structure.sh

# Workspace scope
bash scripts/audit-workspace-scope.sh

# Spec purity
bash scripts/detect-code-in-specs.sh

# Architecture alignment
bash scripts/validate-architecture-alignment.sh
```

**Slash Command Validation:**

Check all 11 LiveSpec slash commands exist and are synchronized:

```bash
# Check command directory exists
test -d .claude/commands/livespec || echo "⚠️ WARNING: .claude/commands/livespec/ missing (copy from dist/ or run generate-custom-slash-commands.md)"

# Check all 11 commands exist
COMMANDS=(
  "complete-session"
  "rebuild-context"
  "refine-workspace"
  "suggest-improvements"
  "health-report"
  "validate"
  "audit"
  "next-steps"
  "run-spike"
  "analyze-failure"
  "upgrade"
)

MISSING=0
for cmd in "${COMMANDS[@]}"; do
  if [ ! -f ".claude/commands/livespec/$cmd.md" ]; then
    echo "❌ ERROR: Missing command: .claude/commands/livespec/$cmd.md"
    MISSING=$((MISSING + 1))
  fi
done

if [ $MISSING -gt 0 ]; then
  echo "❌ $MISSING slash commands missing."
  echo "   Fix: cp dist/.claude/commands/livespec/*.md .claude/commands/livespec/"
  echo "   Or customize: Use dist/prompts/utils/generate-custom-slash-commands.md"
fi

# Check generated commands have metadata
STALE=0
for cmd_file in .claude/commands/livespec/*.md; do
  if [ -f "$cmd_file" ]; then
    if grep -q "^generated_by: livespec$" "$cmd_file"; then
      # Check prompt path exists
      PROMPT=$(grep "^prompt:" "$cmd_file" | cut -d' ' -f2)
      if [ "$PROMPT" != "Multiple" ] && [ ! -f "$PROMPT" ]; then
        echo "⚠️ WARNING: $cmd_file references missing prompt: $PROMPT"
        STALE=$((STALE + 1))
      fi
    fi
  fi
done

if [ $STALE -gt 0 ]; then
  echo "⚠️ $STALE commands reference missing prompts. Consider regenerating."
fi
```

**Fix any violations before proceeding to Phase 1.**

These validations prevent:
- Agent confusion (incomplete taxonomy)
- Workspace pollution (product-specific content)
- MSL violations (code in specs)
- Spec-reality drift (non-existent directories)
- Utility discoverability issues (missing/stale slash commands)

### Phase 1: Cross-Reference Validation

**Scan for frontmatter references:**

```bash
# Find all files with YAML frontmatter
find specs/ prompts/ docs/ -name "*.md" -type f | while read file; do
  # Extract frontmatter and check for reference fields
  grep -E "^(implements|derives-from|governed-by|satisfies|specifies|supports):" "$file"
done
```

**For each reference, validate:**

1. **Target file exists:**
   - Extract reference path from frontmatter
   - Check file existence: `test -f [path]`
   - Report ERROR if missing

2. **Backlinks present (for implements/specifies):**
   - If spec has `specifies: prompts/foo.md`, check if `prompts/foo.md` has `implements: spec`
   - Report WARNING if backlink missing

**Report format:**

```markdown
## Cross-Reference Validation

### ❌ ERRORS (must fix)
- **specs/2-strategy/pathways/partnership/clt-formation.spec.md:5**
  - References: `docs/pathways/clt-formation.md`
  - Problem: File does not exist
  - Fix: Create docs/pathways/clt-formation.md OR remove reference from spec

### ⚠️ WARNINGS (should fix)
- **docs/pathways/clt-formation.md**
  - Problem: Missing backlink to specs/2-strategy/pathways/partnership/clt-formation.spec.md
  - Fix: Add frontmatter: `spec: specs/2-strategy/pathways/partnership/clt-formation.spec.md`
```

### Phase 2: Generated File Protection

**Detect generated files:**

```bash
# Find files with generation markers
grep -r "DO NOT EDIT: This file is generated" . --include="*.md" -l
grep -r "^generated:" . --include="*.md" -l  # Frontmatter style
```

**For each generated file, validate:**

1. **Extract metadata:**
   - Generation timestamp: `Generated: 2025-10-12T10:30:00Z`
   - Source files: Listed in header
   - Generator: `Generator: prompts/4-evolve/4d-regenerate-context.md`

2. **Compare timestamps:**
   ```bash
   # Get file modification time
   stat -c %Y AGENTS.md  # Last modified (Unix timestamp)

   # Get generation timestamp from header
   grep "^Generated:" AGENTS.md | cut -d' ' -f2  # ISO-8601

   # Compare: If file modified AFTER generation timestamp → ERROR
   ```

3. **Check source files:**
   ```bash
   # Get source file timestamps
   for source in PURPOSE.md specs/workspace/*.spec.md; do
     stat -c %Y "$source"
   done

   # If ANY source modified AFTER generation timestamp → WARNING (regeneration needed)
   ```

**Report format:**

```markdown
## Generated File Protection

### ❌ ERRORS (direct edits detected)
- **AGENTS.md**
  - Last modified: 2025-10-12 11:00:00
  - Generated: 2025-10-12T10:30:00Z
  - Problem: File edited AFTER generation (30 minutes ago)
  - Sources:
    - PURPOSE.md (last modified: 2025-10-12 09:00:00)
    - specs/workspace/constitution.spec.md (last modified: 2025-10-12 09:15:00)

  **Fix:**
  1. Revert AGENTS.md to last generated version: `git checkout AGENTS.md`
  2. Edit source specifications in specs/workspace/
  3. Regenerate: Use prompts/4-evolve/4d-regenerate-context.md

### ⚠️ WARNINGS (regeneration needed)
- **dist/AGENTS.md**
  - Generated: 2025-10-12T10:30:00Z
  - Sources changed:
    - specs/workspace/patterns.spec.md (modified: 2025-10-12 14:00:00)
  - Regenerate: Use prompts/4-evolve/4d-regenerate-context.md
```

### Phase 3: Partial Generation Validation

**Detect partially generated files:**

```bash
# Find files with section markers
grep -r "GENERATED SECTION START" . --include="*.md" -l
grep -r "MANUAL SECTION START" . --include="*.md" -l
```

**For each partially generated file:**

1. **Parse sections:**
   - Identify `<!-- GENERATED SECTION START: [name] -->` ... `<!-- GENERATED SECTION END: [name] -->`
   - Identify `<!-- MANUAL SECTION START: [name] -->` ... `<!-- MANUAL SECTION END: [name] -->`

2. **Validate generated sections:**
   - Check if content between GENERATED markers was edited after generation
   - Report ERROR if generated section modified

3. **Allow manual sections:**
   - Manual sections can be edited freely
   - No validation on manual section timestamps

**Report format:**

```markdown
### ❌ ERRORS (generated section edited)
- **docs/pathways/hybrid.md**
  - Section: `overview` (GENERATED)
  - Problem: Content changed after generation
  - Fix: Revert section, update sources, regenerate
```

### Phase 4: Version Synchronisation

**Check version consistency across all version indicators:**

```bash
# Extract version from each file
VERSION_FILE=$(cat .livespec-version 2>/dev/null)
DIST_VERSION=$(cat dist/VERSION 2>/dev/null)
AGENTS_FOOTER=$(grep "LiveSpec v" AGENTS.md 2>/dev/null | grep -oP "v\K[0-9]+\.[0-9]+\.[0-9]+" | head -1)
```

**Validate synchronisation:**

1. **All versions match:**
   - Compare all extracted versions
   - Report ERROR if any mismatch
   - `.livespec-version` is source of truth

2. **Version format valid:**
   - Check format: X.Y.Z (semantic versioning)
   - Report ERROR if malformed

**Report format:**

```markdown
## Version Synchronisation

### ❌ ERRORS (version mismatch)
- **Version indicators out of sync**
  - .livespec-version: 3.1.0 ✓ (source of truth)
  - dist/VERSION: 2.4.0 ✗
  - AGENTS.md footer: 2.4.0 ✗

**Fix:**
1. Update all version indicators to match .livespec-version:
   - dist/VERSION: `3.1.0`
   - AGENTS.md footer: `LiveSpec v3.1.0`
2. Or if .livespec-version is wrong, update it first, then others
3. See specs/workspace/version-management.spec.md for workflow

### ✓ SUCCESS
All version indicators synchronized at 3.1.0
```

---

## Validation Script

**Quick validation (scan only):**

```bash
#!/bin/bash
# Save as scripts/validate-project.sh

echo "=== LiveSpec Project Validation ==="
echo ""

errors=0
warnings=0

# Phase 1: Cross-references
echo "## Phase 1: Cross-Reference Validation"
echo ""

# Find all frontmatter references
for file in $(find specs/ prompts/ docs/ -name "*.md" -type f 2>/dev/null); do
  # Extract references (simplified - real implementation needs YAML parsing)
  refs=$(grep -E "^  - " "$file" | grep -v "^---" | sed 's/^  - //')

  for ref in $refs; do
    if [[ ! -f "$ref" ]]; then
      echo "❌ ERROR: $file references missing file: $ref"
      ((errors++))
    fi
  done
done

echo ""

# Phase 2: Generated files
echo "## Phase 2: Generated File Protection"
echo ""

# Check AGENTS.md (primary generated file)
if [[ -f AGENTS.md ]]; then
  if grep -q "DO NOT EDIT" AGENTS.md; then
    # Extract generation timestamp (would need proper parsing)
    gen_time=$(grep "Generated:" AGENTS.md | head -1 | awk '{print $2}')
    file_time=$(stat -c %Y AGENTS.md)

    # Note: Real implementation needs timestamp comparison logic
    echo "Found generated file: AGENTS.md (generated: $gen_time)"
  fi
fi

echo ""

# Phase 4: Version synchronisation
echo "## Phase 4: Version Synchronisation"
echo ""

if [[ -f .livespec-version ]]; then
  VERSION_FILE=$(cat .livespec-version)
  DIST_VERSION=$(cat dist/VERSION 2>/dev/null)
  AGENTS_FOOTER=$(grep "LiveSpec v" AGENTS.md 2>/dev/null | grep -oP "v\K[0-9]+\.[0-9]+\.[0-9]+" | head -1)

  if [[ "$VERSION_FILE" != "$DIST_VERSION" ]] || \
     [[ "$VERSION_FILE" != "$AGENTS_FOOTER" ]]; then
    echo "❌ ERROR: Version mismatch detected"
    echo "  .livespec-version: $VERSION_FILE"
    echo "  dist/VERSION: $DIST_VERSION"
    echo "  AGENTS.md footer: $AGENTS_FOOTER"
    ((errors++))
  else
    echo "✓ All versions synchronized at $VERSION_FILE"
  fi
else
  echo "⚠️ WARNING: .livespec-version not found"
  ((warnings++))
fi

echo ""
echo "=== Summary ==="
echo "Errors: $errors (must fix)"
echo "Warnings: $warnings (should fix)"

if [[ $errors -gt 0 ]]; then
  exit 1
fi
```

**Make executable:**
```bash
chmod +x scripts/validate-project.sh
```

---

## Integration with Workflows

### Pre-Commit Validation (Optional)

Create `.git/hooks/pre-commit`:

```bash
#!/bin/bash
# Validate project before commit

echo "Running LiveSpec validation..."

# Use AI agent to run full validation
# (Script above is simplified - AI does comprehensive check)

if ! ./scripts/validate-project.sh; then
  echo ""
  echo "❌ Validation failed. Fix errors before committing."
  echo "Run: Use prompts/utils/validate-project.md"
  exit 1
fi

echo "✅ Validation passed"
```

### Periodic Validation

**Weekly check:**
```bash
# Add to crontab or CI pipeline
0 9 * * 1 cd /path/to/project && ./scripts/validate-project.sh
```

### Regeneration Workflow Integration

**After regenerating AGENTS.md:**
```bash
# 1. Regenerate
# Use prompts/4-evolve/4d-regenerate-context.md

# 2. Validate immediately
# Use prompts/utils/validate-project.md

# 3. Commit if validation passes
git add AGENTS.md
git commit -m "Regenerate AGENTS.md from updated specs"
```

---

## Validation Report Template

When running this prompt, AI agent produces:

```markdown
# LiveSpec Validation Report
**Date**: 2025-10-12
**Project**: [project name]

## Summary
- ❌ Errors: [count] (must fix)
- ⚠️ Warnings: [count] (should fix)
- ✅ Checks passed: [count]

---

## Cross-Reference Validation

### ❌ ERRORS
[List of broken references with file paths and fix suggestions]

### ⚠️ WARNINGS
[List of missing backlinks with fix suggestions]

---

## Generated File Protection

### ❌ ERRORS
[List of directly-edited generated files with revert/regenerate instructions]

### ⚠️ WARNINGS
[List of stale generated files needing regeneration]

---

## Recommendations

**Immediate (before next commit):**
1. [Fix ERROR 1]
2. [Fix ERROR 2]

**Soon (before next release):**
1. [Fix WARNING 1]
2. [Fix WARNING 2]

**Process improvements:**
- [ ] Add pre-commit hook for validation
- [ ] Schedule weekly validation runs
- [ ] Document validation workflow in specs/workspace/workflows.spec.md
```

---

## Edge Cases

### Symlinked .livespec/ (Dogfooding)

If `.livespec/` is a symlink to distribution:
- Skip validation of `.livespec/` contents (canonical upstream)
- Validate only project-specific specs/ and prompts/

**Detection:**
```bash
if [[ -L .livespec ]]; then
  echo "Detected symlinked .livespec/ (dogfooding setup)"
  echo "Validating project specs only, skipping .livespec/ contents"
fi
```

### Missing Generation Markers

If generated file has no standard header:
- Report WARNING: "Suspected generated file without markers"
- Suggest adding standard header
- List candidates: AGENTS.md, CLAUDE.md, generated/ directories

### Circular References

If A derives-from B and B derives-from A:
- Report WARNING (not ERROR - may be intentional)
- Show cycle path
- Suggest reviewing architecture

### Custom Reference Fields

If project uses custom frontmatter fields:
- Document in specs/workspace/patterns.spec.md
- Add to validation script
- Example: `related-to:`, `supersedes:`

---

## Success Criteria

After running validation:
- All cross-references point to existing files
- No generated files edited directly
- No stale generated files (sources changed but not regenerated)
- Backlinks present for spec/doc relationships
- Validation report actionable (specific fixes suggested)

**Next steps:**
- Fix all ERRORs before committing
- Schedule fixing WARNINGs
- Consider adding pre-commit hook
- Update workflows.spec.md with validation cadence
