# Upgrade to LiveSpec v5

Guide for migrating from legacy LiveSpec installations (submodule + symlink) to the v5 plugin architecture.

## Prerequisites

- Git repository with existing LiveSpec installation
- Claude Code CLI installed
- Access to LiveSpec plugin source

## Step 1: Identify Current Installation

Check your current setup:

```bash
# Check for legacy submodule
git submodule status | grep livespec

# Check for symlink
ls -la .livespec
```

**Legacy pattern** (pre-v5):
```
.livespec-repo/     # Git submodule (actual files)
.livespec           # Symlink → .livespec-repo/
```

**v5 pattern**:
```
.claude-plugin/     # Plugin installation (or global)
```

## Step 2: Backup Existing Specs

Your specs are safe - they live in `specs/` not in the methodology folder. But backup anyway:

```bash
# Backup specs (optional but recommended)
cp -r specs/ specs.backup/
```

## Step 3: Remove Legacy Symlink

```bash
# Remove the symlink (not the target)
rm .livespec

# Verify it's gone
ls -la .livespec 2>/dev/null || echo "Symlink removed"
```

## Step 4: Remove Legacy Git Submodule

Git submodules require careful removal:

```bash
# 1. Deinitialize the submodule
git submodule deinit -f .livespec-repo

# 2. Remove from git tracking
git rm -f .livespec-repo

# 3. Remove the submodule directory from .git
rm -rf .git/modules/.livespec-repo

# 4. Clean up .gitmodules if it exists
git config -f .gitmodules --remove-section submodule..livespec-repo 2>/dev/null || true

# 5. Stage the changes
git add .gitmodules 2>/dev/null || true
```

## Step 5: Verify Plugin Installation

**If you're running `/livespec:upgrade`, the plugin is already installed. Skip this step.**

Check if the plugin is already available:

```bash
# Check global plugins
ls ~/.claude/plugins/livespec 2>/dev/null && echo "INSTALLED: Global plugin"

# Check local plugins
ls .claude-plugin 2>/dev/null && echo "INSTALLED: Local plugin"
```

**If neither exists** (manual migration only - not via `/livespec:upgrade`):

### Option A: Global Plugin (Recommended)

```bash
git clone https://github.com/chrs-myrs/livespec ~/.claude/plugins/livespec
```

### Option B: Project-Local Plugin

```bash
mkdir -p .claude-plugin
cp -r /path/to/livespec/.claude-plugin/* .claude-plugin/
```

## Step 6: Migrate specs/ Folder Structure

v5 uses semantic folder names instead of numbered layers.

### Identify Current Structure

```bash
ls -d specs/*/
```

**Old structure** (numbered layers):
```
specs/
├── 1-requirements/     # Strategic outcomes, constraints
│   ├── functional/
│   └── strategic/
├── 2-strategy/         # Architectural decisions
└── 3-behaviors/        # Observable outcomes, contracts
```

**New structure** (semantic):
```
specs/
├── workspace/          # How we work (process specs)
├── foundation/         # WHY - outcomes, constraints
├── strategy/           # HOW - architectural approach
├── features/           # WHAT - observable behaviors
└── interfaces/         # Contracts - API/data schemas
```

### Migration Script

`scripts/upgrade-to-v5.sh` does the move from one table, which `/livespec:upgrade`
runs for you. Do not move folders with `mv dir/*`: it silently overwrites a file
of the same name. The script never overwrites; a clash is reported and both files
are kept for you to compare.

```bash
bash scripts/upgrade-to-v5.sh --detect-only   # classify every folder under specs/
bash scripts/upgrade-to-v5.sh --dry-run       # show what would move
bash scripts/upgrade-to-v5.sh                 # move the documented folders
```

**Folders it moves without asking:**

| Old folder | New home |
|------------|----------|
| `specs/1-requirements/` (`strategic/`, `functional/` flattened) | `specs/foundation/` |
| `specs/2-strategy/` | `specs/strategy/` |
| `specs/3-behaviors/` | `specs/features/` |
| `specs/3-behaviors/contracts/` | `specs/interfaces/` |
| `specs/3-contracts/` | `specs/interfaces/` |
| `specs/4-contracts/` (a template named `3-contracts/` this way in error) | `specs/interfaces/` |

**Folders it proposes a home for, moved only once you confirm:**

| Old folder | Proposed home | Why |
|------------|---------------|-----|
| `specs/procedures/` | `specs/interfaces/procedures/` | Process contracts live under interfaces |
| `specs/meta/` | `specs/workspace/` | It describes how the workspace works |
| `specs/reports/` | `var/audit-reports/` | Reports are generated; delete them instead if they can be regenerated |
| `specs/metaspecs/` | `specs/workspace/standards/` | Delete copies of LiveSpec's metaspecs (`type` implies the template); keep project-authored templates |
| `specs/4-validation/` | `specs/features/validation/` | Validation behaviour; move any reports out of `specs/` |
| `specs/4-baseline/` | `specs/features/` | A brownfield baseline; keep its extraction markers |
| `specs/learnings/` | none | Accepted learnings become registry entries; raw notes can go, git keeps them |
| any other `specs/[0-9]-*/` | none | Retired, but with no known mapping |

Confirm each one with `--map`, which also rewrites references to it:

```bash
bash scripts/upgrade-to-v5.sh --map specs/meta=specs/workspace --map specs/reports=var/audit-reports
```

Any other folder under `specs/` that is not part of the current layout is
reported as unknown and left where it is.

### Update Cross-References in Specs

The script rewrites references to every folder it moves, and its verification
lists any that remain:

```bash
grep -r "specs/1-requirements\|specs/2-strategy\|specs/3-behaviors\|specs/3-contracts\|specs/4-contracts" specs/
```

## Step 7: Update Workspace Specs

Workspace specs may reference old prompts and phases.

### Update taxonomy.spec.md

```bash
# Check for old references
grep -E "phase|0-define|1-design|2-build|3-verify|4-evolve" specs/workspace/taxonomy.spec.md
```

**Old taxonomy references:**
```yaml
phases:
  - 0-define
  - 1-design
  - 2-build
  - 3-verify
  - 4-evolve
```

**New taxonomy (v5 modes):**
```yaml
modes:
  - define   # Problem definition (was Phase 0)
  - design   # Solution design (was Phase 1)
  - evolve   # Continuous evolution (was Phase 4)
# Note: build/verify are implementation concerns, not LiveSpec modes
```

### Update constitution.spec.md

Check for old prompt references:

```bash
grep -E "\.livespec/|prompts/[0-4]" specs/workspace/constitution.spec.md
```

**Old patterns:**
```markdown
- Use `.livespec/prompts/0-define/0a-quick-start.md` for setup
- Reference `.livespec/prompts/1-design/1b-design-architecture.md`
```

**New patterns:**
```markdown
- Use `/livespec:design workspace` for setup
- Design skill handles architecture guidance internally
```

### Update patterns.spec.md

Remove phase-specific workflow references:

```bash
grep -E "Phase [0-4]|phase-[0-4]" specs/workspace/patterns.spec.md
```

**Old:**
```markdown
## Workflow
- Phase 0: Define problem
- Phase 1: Design solution
- Phase 2: Build with TDD
- Phase 3: Verify
- Phase 4: Evolve
```

**New:**
```markdown
## Workflow
- Define: Problem definition and workspace setup
- Design: Architecture and behavior specification
- Evolve: Health monitoring, learning, context generation
- (Build/Verify: Implementation concern, guided but not owned)
```

### Update workflows.spec.md

Replace prompt paths with skill invocations:

| Old Reference | New Reference |
|---------------|---------------|
| `.livespec/prompts/0-define/*.md` | `/livespec:design workspace` |
| `.livespec/prompts/1-design/*.md` | `/livespec:design` |
| `.livespec/prompts/2-build/*.md` | (implementation guidance only) |
| `.livespec/prompts/3-verify/*.md` | `/livespec:audit validate` |
| `.livespec/prompts/4-evolve/*.md` | `/livespec:audit` |
| `.livespec/prompts/utils/*.md` | Various skill modes |

## Step 8: Update Other References

Old references may point to `.livespec/`. Update them:

```bash
# Find stale references
grep -r "\.livespec/" . --include="*.md" 2>/dev/null

# Common files to check:
# - CLAUDE.md
# - AGENTS.md
# - Any custom scripts
```

**Old patterns to replace:**

| Old | New |
|-----|-----|
| `.livespec/prompts/` | Plugin handles internally |
| `.livespec/templates/` | `references/templates/` |
| `.livespec/standard/` | `references/standards/` |
| `/livespec:feature` | `/livespec:design feature` |
| `/livespec:debug` | `/livespec:design debug` |
| `/livespec:refine` | `/livespec:design refine` |
| `/livespec:validate` | `/livespec:audit validate` |
| `/livespec:rebuild-context` | `/livespec:audit context` |
| `/livespec:session-review` | `/livespec:learn` |

## Step 9: Verify Installation

```bash
# Check plugin is recognized (in Claude Code)
/livespec

# Should show:
# - Entry point menu
# - Or routing based on project state
```

Test the new commands:

```bash
/livespec:design workspace    # Should show workspace setup
/livespec:audit health       # Should run health check
/livespec:learn compliance    # Should show compliance scores
```

## Step 10: Commit Migration

```bash
git add -A
git commit -m "Migrate to LiveSpec v5

- Remove .livespec-repo/ git submodule
- Remove .livespec symlink
- Migrate specs/ to semantic folder structure
- Update workspace specs for v5 modes
- Install LiveSpec v5 via plugin

Co-Authored-By: Claude <noreply@anthropic.com>"
```

## v5 Command Reference

| Command | Purpose |
|---------|---------|
| `/livespec` | Entry point - routing based on intent |
| `/livespec:design` | Create/refine specs (feature, debug, refine, workspace) |
| `/livespec:audit` | Health, validation, context generation |
| `/livespec:learn` | Session completion and learning capture |

## Troubleshooting

### "Submodule not found"

If git complains about missing submodule:

```bash
# Force remove from index
git rm --cached .livespec-repo
rm -rf .livespec-repo
```

### "Plugin not loading"

Check plugin location:

```bash
# Global plugins
ls ~/.claude/plugins/

# Local plugins
ls .claude-plugin/
```

### "Old commands not working"

Commands were consolidated in v5. See mapping table above.

### "AGENTS.md has stale references"

Regenerate context:

```bash
/livespec:audit context
```

### "Specs have broken cross-references after migration"

Find and fix stale paths:

```bash
# Find old numbered paths
grep -rn "specs/[1-3]-" specs/

# Common fixes:
# specs/1-requirements/ → specs/foundation/
# specs/2-strategy/ → specs/strategy/
# specs/3-behaviors/ → specs/features/
```

### "Workspace specs reference old phases"

Update to v5 modes:

```bash
# Find phase references
grep -rn "Phase [0-4]\|phase-[0-4]\|0-define\|1-design" specs/workspace/

# Replace with mode references (define, design, evolve)
```

## What Changed in v5

| Aspect | v4 | v5 |
|--------|----|----|
| Installation | Git submodule + symlink | Claude plugin |
| Commands | 17 individual commands | 4 unified commands |
| Skills | init, do, evolve | design, evolve, learn |
| Phases | 5 phases (0-4) | 3 modes (define, design, evolve) |
| Build/Verify | Owned by LiveSpec | Guidance only (wrap, don't own) |
| specs/ structure | Numbered (1-requirements/, 2-strategy/, 3-behaviors/) | Semantic (foundation/, strategy/, features/, interfaces/) |
| Prompts | User-invocable via paths | Internal to skills |

## See Also

- `/livespec:design workspace` - Set up or customize workspace
- `/livespec:audit context` - Regenerate AGENTS.md
- `var/debate/2026-01-31-livespec-v5-architecture-debate.md` - Architecture decisions
