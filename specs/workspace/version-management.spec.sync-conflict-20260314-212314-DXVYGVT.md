---
criticality: CRITICAL
failure_mode: Without consistent version management, plugin updates fail and consuming projects can't track methodology version
applies_to:
  - .claude-plugin/plugin.json (framework version)
  - project.yaml (consuming project's methodology version)
  - CHANGELOG.md
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# Version Management

## Requirements

### Version Sources

- [!] Framework version lives in `.claude-plugin/plugin.json`
  - Single source of truth for LiveSpec plugin version
  - Semantic version in `"version"` field (e.g., `"5.1.0"`)
  - Plugin system uses this for update detection
  - CHANGELOG references this version

- [!] Projects track methodology version in `project.yaml`
  - `livespec.version: "5.1.0"` indicates methodology version adopted
  - See `specs/features/config/project-config.spec.md` for full schema
  - Enables upgrade detection and migration guidance
  - LiveSpec framework itself uses this to dogfood the pattern

### Semantic Versioning

- [!] Version increments follow semantic versioning principles
  - **Major** (X.0.0): Breaking changes to skills, commands, or spec structure
  - **Minor** (x.X.0): New skills, new features, backwards-compatible additions
  - **Patch** (x.x.X): Bug fixes, documentation corrections
  - Examples:
    - Skill renamed (evolve → audit) → Minor (breaking but with clear migration)
    - New skill added (go, init) → Minor
    - Typo in documentation → Patch

### CHANGELOG Workflow

- [!] CHANGELOG tracks all changes with release metadata
  - `## [Unreleased]` section collects changes during development
  - On release: rename to `## [X.Y.Z] - YYYY-MM-DD`
  - Create new empty `## [Unreleased]` section at top
  - Each entry includes impact level (HIGH/MEDIUM/LOW)
  - Breaking changes marked with migration guidance

### Release Process (Framework)

- [!] Release follows explicit checklist to ensure plugin updates work
  1. **Finalize CHANGELOG**: Rename `[Unreleased]` → `[X.Y.Z] - YYYY-MM-DD`
  2. **Bump version**: Update `"version"` in `.claude-plugin/plugin.json`
  3. **Commit**: Single commit with version bump and CHANGELOG update
  4. **Tag**: `git tag vX.Y.Z`
  5. **Verify**: Users can run `/plugin update livespec` successfully

### Upgrade Process (Consuming Projects)

- [!] `/livespec:upgrade` updates project.yaml version after successful migration
  - Reads current `livespec.version` from project.yaml
  - Compares to installed plugin version
  - After migration steps complete, updates `livespec.version` to match
  - Validates project.yaml exists before attempting update

## Validation

### Pre-Release Checklist

- [ ] All changes documented in CHANGELOG under correct version
- [ ] Version in plugin.json matches CHANGELOG heading
- [ ] Impact level noted for each change (HIGH/MEDIUM/LOW)
- [ ] Breaking changes have migration guidance

### Post-Release Verification

- [ ] Git tag created: `git tag vX.Y.Z`
- [ ] `/plugin update livespec` pulls new version
- [ ] New skills visible after update
- [ ] CHANGELOG accessible to users
