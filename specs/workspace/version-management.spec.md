---
criticality: CRITICAL
failure_mode: Without consistent version management, documentation and version files drift, causing confusion about current release state and breaking version-dependent workflows
applies_to:
  - .livespec-version
  - AGENTS.md
  - dist/AGENTS.md.template
  - CHANGELOG.md
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Version Management

## Requirements

- [!] All version-related files remain synchronized across the project
  - `.livespec-version` file contains current version (single source of truth)
  - `dist/VERSION` contains current version (distributed with methodology)
  - `AGENTS.md` frontmatter `version:` field matches `.livespec-version`
  - `AGENTS.md` footer link text matches `.livespec-version` (e.g., "LiveSpec v3.1.0")
  - `dist/AGENTS.md.template` frontmatter `version:` field matches `.livespec-version`
  - `dist/AGENTS.md.template` footer link text matches `.livespec-version`
  - All files updated atomically in same commit during release
  - Validation detects mismatches before commits (via validate-project.md)

- [!] Version increments follow semantic versioning principles
  - **Major** (X.0.0): Breaking changes, backwards-incompatible
  - **Minor** (x.X.0): New features, backwards-compatible additions
  - **Patch** (x.x.X): Bug fixes, backwards-compatible corrections
  - Examples:
    - Folder structure reorganisation → Major (3.0.0)
    - Context Compression Framework added → Minor (3.1.0)
    - Documentation drift fixed → Patch (3.1.1) or included in next minor

- [!] CHANGELOG documents all changes before version increment
  - Move `## [Unreleased]` section to `## [X.Y.Z] - YYYY-MM-DD`
  - Create new empty `## [Unreleased]` section at top
  - Each entry includes impact level (HIGH/MEDIUM/LOW) and migration notes
  - Breaking changes clearly marked with "BREAKING:" prefix

- [!] Version updates happen atomically with functionality changes
  - Version incremented in same commit as last functionality change for release
  - All version files updated together (no partial updates)
  - AI agents check version files before committing functionality changes
  - Pre-commit validation catches version drift

## Rationale

**Why this prevents drift:**
- Single source of truth (`.livespec-version`) prevents ambiguity
- Validation enforces synchronisation automatically
- Semantic versioning communicates change impact clearly
- CHANGELOG provides upgrade guidance

**Why atomic updates matter:**
- Partial version updates create confusion about current state
- Git history shows exact version for any commit
- Users can trust version indicators match functionality

**Historical example:**
- v3.0.0 documented in CHANGELOG and `.livespec-version`
- But AGENTS.md still referenced v2.4.0 in multiple places
- Template referenced v2.1.0 in footer
- Caused confusion about actual current version

## Validation

### Automated Checks

**Pre-commit validation** (via `dist/prompts/utils/validate-project.md`):
```bash
# Extract versions from all files
VERSION_FILE=$(cat .livespec-version)
DIST_VERSION=$(cat dist/VERSION)
AGENTS_VERSION=$(grep "^version:" AGENTS.md | cut -d' ' -f2)
AGENTS_FOOTER=$(grep "LiveSpec v" AGENTS.md | grep -oP "v\K[0-9]+\.[0-9]+\.[0-9]+")
TEMPLATE_VERSION=$(grep "^version:" dist/AGENTS.md.template | cut -d' ' -f2)
TEMPLATE_FOOTER=$(grep "LiveSpec v" dist/AGENTS.md.template | grep -oP "v\K[0-9]+\.[0-9]+\.[0-9]+")

# Verify all match
if [ "$VERSION_FILE" != "$DIST_VERSION" ] || \
   [ "$VERSION_FILE" != "$AGENTS_VERSION" ] || \
   [ "$VERSION_FILE" != "$AGENTS_FOOTER" ] || \
   [ "$VERSION_FILE" != "$TEMPLATE_VERSION" ] || \
   [ "$VERSION_FILE" != "$TEMPLATE_FOOTER" ]; then
  echo "❌ ERROR: Version mismatch detected"
  echo "  .livespec-version: $VERSION_FILE"
  echo "  dist/VERSION: $DIST_VERSION"
  echo "  AGENTS.md version: $AGENTS_VERSION"
  echo "  AGENTS.md footer: $AGENTS_FOOTER"
  echo "  Template version: $TEMPLATE_VERSION"
  echo "  Template footer: $TEMPLATE_FOOTER"
  exit 1
fi
```

### Manual Verification

Before committing changes that affect functionality:
- [ ] Check `.livespec-version` reflects intended release version
- [ ] Run `dist/prompts/utils/validate-project.md` to verify synchronisation
- [ ] Verify CHANGELOG has entry for current version
- [ ] Confirm all version indicators match (`.livespec-version` is source of truth)

### Post-Release Verification

After version increment commit:
- [ ] Git tag created matching version: `git tag v3.1.0`
- [ ] All version files synchronized (validation passes)
- [ ] CHANGELOG documents changes for this release
- [ ] Git history shows atomic version update (all files in one commit)
