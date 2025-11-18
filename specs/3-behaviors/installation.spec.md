---
criticality: IMPORTANT
failure_mode: Users unable to install LiveSpec properly, leading to manual errors, version drift, and adoption barriers
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 5: Voluntary Adoption)
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 4: Minimal Maintenance)
guided-by:
  - specs/workspace/distribution.spec.md
---

# LiveSpec Installation Methods

## Requirements
- [!] LiveSpec provides multiple installation methods with graceful degradation, prioritizing sparse submodules over full submodules over directory copying, with automated detection and fallback handling.
  - **Sparse Submodule Method** (preferred):
    - Uses git-partial-submodule if available for sparse checkout
    - Falls back to native git sparse-checkout (git 2.25+)
    - Only fetches dist/ directory from livespec repo
    - Creates .livespec-repo/ submodule with sparse patterns
    - Creates symlink .livespec → .livespec-repo/dist
    - Version pinning via git tags/commits
    - Updates via `git submodule update --remote`
  - **Full Submodule Method** (fallback):
    - Used when sparse checkout unavailable
    - Fetches entire livespec repository
    - Creates symlink .livespec → .livespec-repo/dist
    - Same version control as sparse method
  - **Copy Method** (legacy fallback):
    - Simple directory copy: `cp -r livespec/dist/* .livespec/`
    - Works in all environments
    - Manual update process
    - No git integration
  - **Installation Helper Script**:
    - Script: scripts/install-livespec.sh
    - Detects git-partial-submodule availability
    - Checks git version for sparse-checkout support
    - Automatically selects best available method
    - Provides user feedback about chosen method
    - Creates .livespec symlink automatically
    - Exit codes: 0 = success, 1 = error, 2 = unsupported git version
  - **Documentation Requirements**:
    - README.md Quick Start section documents all three methods
    - Each method includes pros/cons
    - Helper script usage documented
    - Update workflows documented for each method
    - Backwards compatibility noted (existing copy-based setups continue working)

## Method Selection Logic

**Priority order (helper script):**
1. Check for git-partial-submodule → Use sparse submodule with tool
2. Check git version ≥2.25 → Use native sparse submodule
3. Fallback → Use full submodule (with warning)
4. Manual override → User chooses copy method

## Framework Immutability

**Installation creates read-only framework reference:**
- .livespec-repo/ (submodule methods) contains upstream git repository
- .livespec/ symlinks to .livespec-repo/dist (immutable)
- Framework prompts used as-is (no modification supported)

**Project customization happens elsewhere:**
- specs/workspace/ - Process customization (constitution, patterns, workflows)
- prompts/generated/ - Project-specific generated prompts
- AGENTS.md - Generated from workspace specs

**Fork only for framework changes:**
- Rare edge case (methodology itself doesn't fit)
- Point submodule to your fork URL
- Normal case: specs/workspace/ customization sufficient

## Validation
- Helper script successfully detects git-partial-submodule
- Helper script correctly identifies git version capabilities
- Sparse submodule installation only fetches dist/
- Symlink .livespec correctly points to submodule dist/
- All three methods result in functional .livespec/ directory
- Documentation covers all installation methods with examples
- Update procedures documented for each method
- Framework immutability principle stated clearly
- Customization guidance points to specs/workspace/
