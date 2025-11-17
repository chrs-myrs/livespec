---
derives-from:
  - specs/1-requirements/strategic/outcomes.spec.md (Minimal Maintenance, Universal Applicability)
  - specs/workspace/workflows.spec.md (Release process)
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md (Manual Adoption, No Framework Lock-in)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear distribution strategy, users cannot adopt LiveSpec reliably and upgrades become chaotic
---

# Distribution Strategy

## Requirements
- [!] LiveSpec packages methodology in dist/ folder containing standard/, prompts/, templates/, and VERSION file, enabling users to copy entire methodology via simple file operations while maintaining clear separation between source specifications (specs/) and deliverable methodology (dist/), with semantic versioning guiding upgrade decisions and manual upgrade process preserving user customizations.
  - dist/ folder contains complete deliverable methodology
  - dist/standard/ contains metaspecs and conventions (framework definition)
  - dist/prompts/ contains 5-phase methodology (0-define through 4-evolve plus utils)
  - dist/templates/ contains workspace spec starter files
  - dist/VERSION contains current version (semantic versioning: MAJOR.MINOR.PATCH)
  - Users copy dist/* to their-project/.livespec/ (simple file operation)
  - .livespec/ symlink in LiveSpec repo points to dist/ (dogfooding)
  - specs/ stays in LiveSpec repo (source, not distributed)
  - tests/ stays in LiveSpec repo (validation, not distributed)
  - docs/ stays in LiveSpec repo (reference, not distributed)
  - Upgrade process manual via prompts/utils/upgrade-methodology.md
  - VERSION increments follow semantic versioning rules

## dist/ Folder Rationale

**Why separate dist/ from specs/?**

**Problem:**
- specs/ documents HOW we build LiveSpec (our workspace, our behaviors, our strategy)
- Users don't need our specs, they need the methodology (prompts, standard, templates)
- Distributing specs/ would confuse users (whose specs? LiveSpec's or theirs?)

**Solution:**
- dist/ = deliverables (what users copy)
- specs/ = source specifications (how we build dist/)
- Clear separation prevents confusion

**Analogy:**
```
Software project:
  src/ = source code (how we build it)
  dist/ = compiled output (what users get)

LiveSpec project:
  specs/ = source specifications (how we build it)
  dist/ = methodology (what users get)
```

**What users see:**
```
your-project/
├── .livespec/         # Copied from livespec/dist/
│   ├── standard/
│   ├── prompts/
│   ├── templates/
│   └── VERSION
└── specs/             # User's project specs (not LiveSpec's specs)
    ├── workspace/
    ├── behaviors/
    └── ...
```

**Benefits:**
- Clear mental model (dist/ = public API, specs/ = internals)
- Users never confused about whose specs they're reading
- Separation enables dogfooding (we use dist/ on ourselves via symlink)
- Clean upgrade (replace .livespec/ with new dist/)

## Why Copy Not Git Submodule

**Alternative: Git submodule**
```bash
# Submodule approach (NOT our choice)
git submodule add https://github.com/chrs-myrs/livespec .livespec
```

**Why we chose copy instead:**

**1. Simplicity constraint:**
- Copy: Single command, works anywhere
- Submodule: Requires git knowledge, complex workflows
- Users understand copy, may not understand submodules

**2. Customization:**
- Copy: Users can modify prompts for their needs
- Submodule: Modifications cause merge conflicts on update
- Custom utilities live alongside standard ones

**3. Offline support:**
- Copy: Works without internet
- Submodule: Requires git connectivity
- Air-gapped environments supported

**4. Version stability:**
- Copy: Users control when to upgrade
- Submodule: Pulling changes can break workflow
- Explicit upgrade process (upgrade-methodology.md)

**5. Manual adoption constraint:**
- Copy: File operations only
- Submodule: Git operations required
- No git expertise prerequisite

**Trade-offs accepted:**
- No automatic updates (users must upgrade manually)
- Copy may go stale (users forget to upgrade)
- Duplication (many projects copy same dist/)

**Benefits realized:**
- Users control methodology version (stability)
- Customization supported (extend prompts/)
- Simple mental model (just files)
- Works universally (git not required)

## VERSION File Strategy

**Location:** dist/VERSION

**Format:** Semantic versioning (MAJOR.MINOR.PATCH)
```
2.0.0
```

**Purpose:**
- Users know what version they have (.livespec/VERSION)
- Upgrade prompt detects current vs available version
- Release notes reference specific versions
- Context7 can reference version (future: @context7/.../livespec@2.0.0)

**Semantic versioning rules:**

### MAJOR version (x.0.0)
**Increment when:** Breaking changes requiring user action

**Examples:**
- Folder structure changes (add/remove/rename standard folders)
- Metaspec changes (new required frontmatter fields)
- Prompt format changes (incompatible with previous version)
- MSL base changes (new required sections)

**User impact:** Must review all project specs, may need modifications

### MINOR version (0.x.0)
**Increment when:** New features, backward-compatible additions

**Examples:**
- New phase prompt added (e.g., 4d-regenerate-context.md)
- New utility added (e.g., upgrade-methodology.md)
- New template added (e.g., additional workspace spec type)
- Documentation improvements

**User impact:** Can adopt new features optionally, existing setup unaffected

### PATCH version (0.0.x)
**Increment when:** Bug fixes, clarifications, no functional changes

**Examples:**
- Typo fixes in prompts
- Clarification of existing requirements
- Example improvements
- Test fixes

**User impact:** Safe to upgrade, no action required

**Version history:**
- 0.1.0 - Initial release (proof of concept)
- 0.2.0 - Beta release (LiveSpec v1)
- 2.0.0 - Production release (LiveSpec v2, complete restructure)
- Future: 2.1.0 (new utils), 2.0.1 (bug fix), 3.0.0 (breaking change)

## Symlink for Dogfooding

**Implementation in LiveSpec repo:**
```bash
.livespec -> dist/
```

**Why symlink not copy?**

**Dogfooding requirement:**
- LiveSpec must use EXACT methodology we distribute
- No "special development version" separate from user version
- Changes to dist/ immediately affect our usage

**Alternatives considered:**

**1. Copy dist/ to .livespec/ (NOT chosen)**
- Pro: Simpler
- Con: Can diverge (edit .livespec/ without updating dist/)
- Con: Extra sync step (copy after every dist/ change)

**2. Separate development methodology (NOT chosen)**
- Pro: Can iterate faster
- Con: Violates dogfooding principle
- Con: May ship methodology we don't use ourselves

**3. Symlink dist/ to .livespec/ (CHOSEN)**
- Pro: Always using dist/ version
- Pro: Changes immediately tested
- Pro: Impossible to diverge
- Con: Slightly complex (users may not understand symlink)

**Benefits:**
- Forces us to keep dist/ usable (broken dist/ breaks our workflow)
- Tests validate dist/ not separate dev version
- Proves methodology works (we use it successfully)
- Eliminates sync overhead (single source of truth)

## What Gets Distributed vs What Stays

### Distributed (in dist/, users copy)

**dist/standard/** - Framework definition
- metaspecs/*.spec.md (7 files: base, behavior, workspace, etc.)
- conventions/*.spec.md (3 files: folder-structure, naming, dependencies)
- Rationale: Users need these to validate their specs

**dist/prompts/** - Methodology guidance
- 0-define/, 1-design/, 2-build/, 3-verify/, 4-evolve/ (phase prompts)
- utils/ (optional advanced prompts)
- Rationale: Core methodology users adopt

**dist/templates/** - Starter files
- workspace/*.spec.md.template (constitution, patterns, workflows)
- Rationale: Bootstrap new projects quickly

**dist/VERSION** - Version tracking
- Single line: version number
- Rationale: Enables version-aware operations

### Not Distributed (stays in repo)

**specs/** - LiveSpec's source specifications
- workspace/, behaviors/, strategy/ (how WE build LiveSpec)
- Rationale: Our specs, not users' specs (would confuse)

**tests/** - Validation suite
- prompts/, structure/ (test scripts)
- Rationale: Users can run if interested, but not part of core methodology

**docs/** - Human documentation
- quickstart.md, methodology.md, msl-guide.md
- Rationale: Available on GitHub, not needed locally

**Root files** - Repository metadata
- PURPOSE.md, README.md, LICENSE
- AGENTS.md, llms.txt (Context7 integration, cached)
- Rationale: GitHub provides these, don't need in .livespec/

**Why this separation?**
- Users get clean methodology (dist/)
- We maintain source separately (specs/)
- No confusion about ownership
- Upgrade clean (replace .livespec/, keep specs/)

## Upgrade Philosophy

**Core principle:** User-controlled, manual, safe

**NOT automatic:**
- No auto-update mechanism
- No background version checks
- No silent upgrades
- Users decide when to upgrade

**Manual process:**
1. User hears about new version (release notes, Context7, community)
2. User runs upgrade-methodology.md prompt
3. Prompt shows diff (what changed)
4. User reviews and approves each change
5. User's customizations preserved
6. Rollback available if needed

**Why manual?**
- **Control**: Users decide when (not during critical work)
- **Review**: Users see what changes before applying
- **Safety**: Customizations preserved, backup created
- **Transparency**: No hidden updates
- **Trust**: Users maintain agency

**Upgrade workflow:** See specs/3-artifacts/prompts/utils-upgrade.spec.md

**Connection to constraints:**
- Manual adoption constraint (no automation)
- No framework lock-in (can modify dist/ after copy)
- Simplicity (file operations only)

## Release Process

**When to release:**
- Major feature complete (new phase, significant capability)
- Critical bug fix needed by users
- Breaking change requires version bump
- Regular cadence (e.g., quarterly minor releases)

**Release checklist:**
1. **Validate:** Run tests/run-all-tests.sh (all pass)
2. **Update VERSION:** Increment per semantic versioning
3. **Update llms.txt:** Reflect new version, features
4. **Regenerate AGENTS.md:** Latest methodology
5. **Write release notes:** What changed, migration guide
6. **Tag release:** `git tag v2.1.0`
7. **Push:** `git push && git push --tags`
8. **GitHub release:** Attach release notes
9. **Announce:** Community, docs, Context7 refresh

**Release artifacts:**
- Git tag (vX.Y.Z)
- GitHub release (with notes)
- dist/ contents (downloadable tarball)
- Updated Context7 index

## Validation

- dist/ folder exists with standard/, prompts/, templates/, VERSION
- dist/ contains complete methodology (nothing missing)
- specs/ exists separately (source specifications)
- tests/ exists separately (validation suite)
- docs/ exists separately (human documentation)
- .livespec/ symlink points to dist/ (dogfooding)
- Users copy dist/* to their .livespec/ via file operations
- VERSION file uses semantic versioning (MAJOR.MINOR.PATCH)
- Upgrade process documented in prompts/utils/upgrade-methodology.md
- No automatic updates (user-controlled)
- Distribution model explained in README Quick Start
