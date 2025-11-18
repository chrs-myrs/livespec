# LiveSpec v3.8.0

**Specifications that live with your code**

This is the LiveSpec methodology framework distribution. It provides prompts, templates, validation tools, and guides for specification-driven development with bidirectional code↔spec synchronization.

## Quick Start: Installation

### Option 1: Helper Script (Recommended)

The helper script auto-detects the best installation method for your environment:

```bash
bash scripts/install-livespec.sh
```

**What it does:**
- Detects sparse submodule support (git 2.25+ or git-partial-submodule tool)
- Falls back to full submodule or directory copy if needed
- Creates `.livespec` directory/symlink automatically
- Reports which method was used

### Option 2: Sparse Submodule (Manual)

**Best for**: Zero-duplication across multiple projects, automatic updates

**Requirements**: git 2.25+ or [git-partial-submodule](https://github.com/niner/git-partial-submodule) tool

```bash
# Add as sparse submodule (fetches only dist/)
git submodule add --name livespec https://github.com/chrs-myrs/livespec .livespec-repo
cd .livespec-repo
git sparse-checkout init --cone
git sparse-checkout set dist
cd ..

# Create symlink to dist/
ln -s .livespec-repo/dist .livespec

# Update .gitignore
echo ".livespec" >> .gitignore

# Track the submodule
git add .gitmodules .livespec-repo .gitignore
```

**Updates**: `git submodule update --remote .livespec-repo`

### Option 3: Full Submodule (Manual)

**Best for**: Git version management without sparse support

```bash
# Add as regular submodule
git submodule add https://github.com/chrs-myrs/livespec .livespec-repo

# Create symlink to dist/
ln -s .livespec-repo/dist .livespec

# Update .gitignore
echo ".livespec" >> .gitignore

# Track the submodule
git add .gitmodules .livespec-repo .gitignore
```

**Updates**: `git submodule update --remote .livespec-repo`

### Option 4: Directory Copy (Legacy)

**Best for**: Simple setup, no git integration needed

```bash
# Copy this dist/ directory to your project
cp -r /path/to/livespec/dist .livespec

# Add to .gitignore
echo ".livespec/" >> .gitignore
```

**Updates**: Manual - copy dist/ again when upgrading

---

## After Installation

### 1. Verify Installation

```bash
# Check version
cat .livespec/VERSION

# Verify structure
ls .livespec/prompts/
ls .livespec/scripts/
ls .livespec/templates/
```

### 2. Quick Start (5 minutes)

Create workspace with defaults:

```bash
# Use quick-start prompt
# In Claude Code, reference: .livespec/prompts/0-define/0a-quick-start.md
```

This creates:
- `PURPOSE.md` - Why project exists
- `specs/workspace/` - Development process specs
- `.livespec-version` - Version tracking
- `prompts/` - Symlinks to .livespec/prompts/

### 3. OR Customize Workspace (20-30 minutes)

For specific requirements:

```bash
# Use customize prompt
# In Claude Code, reference: .livespec/prompts/0-define/0b-customize-workspace.md
```

---

## What's Included

### Prompts (Methodology Phases)

- `prompts/0-define/` - Problem definition, workspace setup
- `prompts/1-design/` - Architecture, behaviors, contracts
- `prompts/2-build/` - TDD implementation
- `prompts/3-verify/` - Validation, acceptance
- `prompts/4-evolve/` - Drift detection, synchronization
- `prompts/utils/` - Validation, health checks, session analysis

### Scripts (Validation & Tools)

- `scripts/setup-hooks.sh` - Install git pre-commit validation
- `scripts/check-requires-spec.sh` - Spec-first enforcement
- `scripts/validate-*.sh` - 12 validation scripts
- `scripts/generate-compliance-dashboard.sh` - Health metrics
- `scripts/traceability/` - Research linkage validation

### Tests (Validation Framework)

- `tests/structure/test_full_validation.sh` - Comprehensive validation
- `tests/structure/test_traceability.sh` - Dependency graph checks
- `tests/prompts/` - Prompt-specific tests

### Templates

- `templates/agents/` - Agent context patterns
- `templates/commands/` - Slash command templates
- `templates/workspace/` - Workspace spec templates
- `templates/specs/` - Behavior/contract templates

### Guides

- `guides/` - Deep-dive documentation on patterns, workflows, and best practices

### Standards

- `standard/metaspecs/` - Templates for different spec types
- `standard/conventions/` - Folder structure, naming, dependencies

---

## Version Tracking

After installation, copy VERSION to your project root:

```bash
cp .livespec/VERSION .livespec-version
```

This enables version-based validation and upgrade detection.

---

## Git Hook Validation (Optional but Recommended)

Enable pre-commit validation:

```bash
bash .livespec/scripts/setup-hooks.sh
```

**What it does:**
- Installs pre-commit hook
- Runs validation before every commit
- Blocks commits with spec violations
- Bypass: `git commit --no-verify` (use carefully)

---

## Framework Philosophy

### Immutability

`.livespec/` is **read-only framework reference**. Never modify directly.

**Customize via:**
- `specs/workspace/` - Your development process
- `prompts/generated/` - Project-specific prompts
- `AGENTS.md` - Generated from your specs

**Fork only for**: Fundamental methodology changes (rare)

### Zero Duplication

Sparse submodules enable one local LiveSpec copy shared across many projects:

```
~/.livespec-repo/   # One copy
~/project-a/.livespec → ~/.livespec-repo/dist  # Symlink
~/project-b/.livespec → ~/.livespec-repo/dist  # Symlink
~/project-c/.livespec → ~/.livespec-repo/dist  # Symlink
```

Updates propagate automatically: `git submodule update --remote`

---

## Documentation

- **AGENTS.md** - Comprehensive agent guidance (load this first)
- **Installation behavior**: `specs/3-behaviors/installation.spec.md` (if source available)
- **Distribution architecture**: `specs/workspace/distribution.spec.md` (if source available)

---

## Getting Help

- **Issues**: https://github.com/chrs-myrs/livespec/issues
- **Quick validation**: `bash .livespec/scripts/check-livespec-installation.sh`
- **Health check**: Use `.livespec/prompts/utils/run-health-report.md`

---

## Next Steps

1. ✅ Installation complete
2. → Create `PURPOSE.md` (why project exists)
3. → Set up workspace specs (use prompts/0-define/)
4. → Begin Phase 1 (DESIGN) or Phase 4 (EVOLVE) for existing code

**Methodology**: DEFINE → DESIGN → BUILD (TDD) → VERIFY → EVOLVE (continuous)

---

*LiveSpec v3.8.0 - Specification-driven development with bidirectional sync*
