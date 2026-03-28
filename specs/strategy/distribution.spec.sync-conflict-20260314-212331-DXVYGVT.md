---
derives-from:
  - specs/foundation/outcomes.spec.md (Minimal Maintenance, Universal Applicability)
  - specs/workspace/workflows.spec.md (Release process)
governed-by:
  - specs/foundation/constraints.spec.md (Manual Adoption, No Framework Lock-in)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without clear distribution strategy, users cannot adopt LiveSpec reliably and upgrades become chaotic
updated-by:
  - specs/features/ambient-architecture.spec.md (Plugin Distribution Model)
---

# Distribution Strategy

## Status

**Updated for ambient architecture.**

Key changes:
- Distribution via Claude Code plugin (not file copying)
- No dist/ directory in target projects
- Version control via plugin versions
- Upgrade via plugin update command

## Requirements

- [!] LiveSpec distributes methodology via Claude Code plugin, providing skills and templates at runtime while projects generate their own context locally
  - Plugin contains: skills, metaspec templates, guides, conventions
  - Plugin installed via: `claude plugin install livespec` (or local path)
  - Projects generate: CLAUDE.md (inline rules), AGENTS.md (project context), specs/ structure
  - No .livespec/ directory copied to projects
  - specs/ stays in LiveSpec repo (source, dogfooding)
  - Version control via plugin version tags
  - Upgrade via plugin update (automatic or manual)
  - Semantic versioning guides upgrade decisions

## Plugin Distribution Rationale

**Why plugin instead of file copying?**

**Problem with file copying:**
- Copied files go stale (users forget to upgrade)
- Manual sync process is laborious
- No automatic updates possible
- Duplication across projects

**Solution:**
- Plugin = methodology (skills, templates, guides)
- Projects = generated context (CLAUDE.md, AGENTS.md, specs/)
- Plugin updates automatically available

**Analogy:**
```
Traditional:
  dist/ = methodology (copied to projects)
  .livespec/ = local copy (may go stale)

Plugin model:
  plugin = methodology (always current)
  project = generated context (regenerable)
```

**What users see:**
```
your-project/
├── PURPOSE.md         # Project vision
├── CLAUDE.md          # Generated with inline rules
├── AGENTS.md          # Generated from workspace specs
└── specs/             # User's project specs
    ├── workspace/
    ├── foundation/
    ├── strategy/
    ├── features/
    └── interfaces/
```

**Benefits:**
- Methodology always current (plugin updates)
- No manual sync needed
- Clean separation (plugin = methodology, project = context)
- Still user-controlled (plugin version pinning available)

## Why Plugin Not Copy/Submodule

**Previous approaches (now deprecated):**

**1. Directory Copy** - Simple but stale
- Pro: Works everywhere, no dependencies
- Con: Files go stale, manual sync required
- Con: Duplication across projects

**2. Git Submodule** - Version-controlled but complex
- Pro: Version pinning, atomic updates
- Con: Complex workflows, git expertise required
- Con: Merge conflicts on customization

**Why plugin is better:**

**1. Always current:**
- Plugin: Updates available immediately
- Copy/submodule: Manual process to update

**2. Simpler mental model:**
- Plugin: Invoke skills, get guidance
- Copy: Navigate file structure, read prompts

**3. No local methodology files:**
- Plugin: Nothing to maintain in project
- Copy: .livespec/ needs syncing

**4. Customization via specs:**
- Plugin: Customize via specs/workspace/
- Copy: Temptation to modify .livespec/ (creates drift)

**Trade-offs accepted:**
- Requires Claude Code (not standalone)
- Offline support reduced (plugin must be installed)
- Less visibility into methodology files

**Benefits realized:**
- Zero maintenance burden (plugin handles methodology)
- Consistent methodology across projects
- Clear customization boundary (specs/workspace/ only)

## Version Strategy

**Location:** Plugin manifest (plugin.json) and package version

**Format:** Semantic versioning (MAJOR.MINOR.PATCH)
```
5.0.0
```

**Purpose:**
- Plugin version tracks methodology version
- Users can pin to specific version if needed
- Release notes reference specific versions
- Version visible via Claude Code plugin list

**Semantic versioning rules:**

### MAJOR version (x.0.0)
**Increment when:** Breaking changes requiring user action

**Examples:**
- Skill interface changes (different options, renamed skills)
- Generated file format changes (CLAUDE.md structure)
- Metaspec changes (new required frontmatter fields)
- Layer organization changes

**User impact:** May need to regenerate context, update workflow

### MINOR version (0.x.0)
**Increment when:** New features, backward-compatible additions

**Examples:**
- New skill added
- New template added
- Enhanced skill behavior (additional options)
- Documentation improvements

**User impact:** Can adopt new features optionally, existing setup unaffected

### PATCH version (0.0.x)
**Increment when:** Bug fixes, clarifications, no functional changes

**Examples:**
- Skill bug fixes
- Template corrections
- Clarification of existing requirements

**User impact:** Safe to upgrade, no action required

**Version history:**
- 0.1.0 - Initial release (proof of concept)
- 2.0.0 - Production release (file-copying model)
- 5.0.0 - Plugin architecture (ambient intelligence model)

## Dogfooding with Plugin

**Implementation in LiveSpec repo:**
- Local plugin install pointing to development path
- Skills invoked via /livespec:* commands
- Same experience as users

**Why local plugin install?**

**Dogfooding requirement:**
- LiveSpec must use EXACT methodology we distribute
- No "special development version" separate from user version
- Changes to skills immediately affect our usage

**How it works:**
```bash
# Install plugin from local development path
claude plugin install /path/to/livespec

# Now /livespec:* commands use local skills
/livespec:design feature authentication
```

**Benefits:**
- Forces us to keep skills usable (broken skills break our workflow)
- Tests validate distributed skills, not separate dev version
- Proves methodology works (we use it successfully)
- Same user experience (no special dev tools)

## What Plugin Provides vs What Projects Generate

### Plugin Provides (via skills at runtime)

**skills/** - Core methodology workflows
- /livespec:go - Intelligent router
- /livespec:init - Project bootstrap
- /livespec:design - Spec creation/refinement
- /livespec:audit - Health checks, context regeneration
- /livespec:learn - Session learning capture
- Rationale: Methodology delivered via interactive skills

**references/templates/** - Metaspec templates
- behavior.spec.md, contract.spec.md, etc.
- Rationale: Read when creating specs, ensures consistency

**references/guides/** - Usage guides
- MSL minimalism, TDD workflow, layer boundaries
- Rationale: Loaded by skills when providing guidance

**references/standard/** - Framework definition
- metaspecs/, conventions/
- Rationale: Defines spec formats and conventions

### Projects Generate (via /livespec:init)

**CLAUDE.md** - Inline essential rules
- Spec-first protocol
- Layer boundary rules
- Project-specific configuration
- Rationale: Static context loaded at session start

**AGENTS.md** - Project context
- Customized to PURPOSE, domain, constraints
- Routing to sub-agents
- Rationale: Specialized guidance for this project

**specs/** - Project specifications
- workspace/, foundation/, strategy/, features/, interfaces/
- Rationale: User's specs, not methodology specs

**ctxt/** (optional) - Sub-agent contexts
- Phase specialists, domain patterns
- Rationale: Large projects may need specialized agents

### Stays in LiveSpec Repo (source, not distributed)

**specs/** - LiveSpec's own specifications
- How WE build LiveSpec (dogfooding)
- Rationale: Our specs, demonstrates methodology

**tests/** - Validation suite
- Skill tests, structure validation
- Rationale: Development infrastructure

**Why this separation?**
- Plugin = methodology (always current)
- Projects = context (regenerable)
- No confusion about ownership
- Clean upgrade (update plugin, regenerate if needed)

## Upgrade Philosophy

**Core principle:** User-controlled, transparent, safe

**Plugin updates:**
- Updates available when published
- Users control when to update: `claude plugin update livespec`
- Version pinning available for stability
- Breaking changes announced in release notes

**Context regeneration:**
- After major plugin updates, may need to regenerate context
- /livespec:audit detects when regeneration needed
- Existing specs preserved (only context files regenerate)

**Migration from legacy:**
- /livespec:upgrade migrates from copy/submodule model
- Preserves existing specs/
- Generates new CLAUDE.md and AGENTS.md
- Removes .livespec/ directory

**Why this approach?**
- **Control**: Users decide when to update plugin
- **Safety**: specs/workspace/ customizations always preserved
- **Transparency**: Breaking changes clearly documented
- **Trust**: Context regenerable, nothing lost

**Upgrade workflow:** See /livespec:upgrade skill

**Connection to constraints:**
- Manual adoption (user triggers updates)
- No framework lock-in (can fork plugin)
- Simplicity (plugin update command)

## Release Process

**When to release:**
- Major feature complete (new skill, significant capability)
- Critical bug fix needed by users
- Breaking change requires version bump
- Regular cadence (e.g., quarterly minor releases)

**Release checklist:**
1. **Validate:** Run skill tests (all pass)
2. **Update version:** Increment per semantic versioning
3. **Regenerate context:** Latest methodology for dogfooding
4. **Write release notes:** What changed, migration guide if breaking
5. **Tag release:** `git tag v5.1.0`
6. **Push:** `git push && git push --tags`
7. **GitHub release:** Attach release notes
8. **Publish plugin:** Make available for install

**Release artifacts:**
- Git tag (vX.Y.Z)
- GitHub release (with notes)
- Plugin package (installable)
- Updated documentation

## Validation

### Plugin Structure
- [ ] skills/ contains all 5 skills (go, init, design, audit, learn)
- [ ] references/templates/ contains metaspec templates
- [ ] references/guides/ contains usage guides
- [ ] references/standard/ contains metaspecs and conventions
- [ ] Plugin manifest (plugin.json) exists with correct version

### Distribution Behavior
- [ ] `claude plugin install livespec` works
- [ ] All /livespec:* skills available after install
- [ ] Skills read templates from plugin path
- [ ] No .livespec/ directory created in target projects

### Dogfooding
- [ ] Local plugin install works in livespec repo
- [ ] Skills function correctly for dogfooding
- [ ] Same experience as end users

### Upgrade Path
- [ ] /livespec:upgrade migrates from legacy model
- [ ] Existing specs/ preserved during migration
- [ ] CLAUDE.md and AGENTS.md regenerated correctly
- [ ] .livespec/ directory removed after migration
