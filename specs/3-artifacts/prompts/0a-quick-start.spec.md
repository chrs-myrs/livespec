---
criticality: IMPORTANT
failure_mode: Without quick-start, new users face high cognitive load and long setup time, reducing adoption
specifies: dist/prompts/0-define/0a-quick-start.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
derives-from:
  - specs/3-artifacts/prompts/0a-setup-workspace.spec.md
---

# Prompt Behavior: Quick Start

## Requirements
- [!] Prompt verifies LiveSpec installation before proceeding, preventing workspace creation without functional framework.
  - Checks for .livespec/VERSION file existence
  - If missing, guides user to install using helper script or manual methods
  - Verifies required directories exist (.livespec/prompts/, .livespec/scripts/, .livespec/templates/)
  - Cannot proceed to workspace creation without functional .livespec/ directory
  - Provides clear installation instructions if needed
  - Uses validation script (check-livespec-installation.sh) if available

- [!] Prompt initializes LiveSpec workspace with sensible defaults in under 5 minutes, asking zero questions, creating four standard workspace specs suitable for 80% of projects.
  - Asks zero questions (applies defaults)
  - Context compression: Moderate (balanced inline/reference)
  - Project domain: Software (produces code)
  - Workspace scope: Standard portable methodology (constitution, patterns, workflows, taxonomy)
  - Specs boundary: Specifications only (no data/research)
  - Creates specs/workspace/taxonomy.spec.md with Software domain defaults
  - Creates specs/workspace/constitution.spec.md with spec-driven development
  - Creates specs/workspace/patterns.spec.md with MSL format conventions
  - Creates specs/workspace/workflows.spec.md with five-phase workflow
  - Completes in ~5 minutes
  - Provides clear next steps (define problem or customize workspace)
  - Explains defaults chosen and how to change them
  - Suitable for immediate use (80% of projects)
  - Clear path to customization (0b-customize-workspace.md)

## Validation
- Prompt verifies .livespec/VERSION exists before creating workspace specs
- If installation missing, provides clear installation instructions
- Cannot proceed without functional .livespec/ directory
- Prompt creates exactly four workspace spec files
- All specs follow MSL format (frontmatter, Requirements, Validation)
- taxonomy.spec.md declares Software domain with standard workspace scope
- constitution.spec.md includes context_compression: moderate in frontmatter
- No questions asked to user (zero-question requirement met)
- Setup completes in under 5 minutes
- User can immediately proceed to define problem or design
- Defaults explained clearly (what was chosen and why)
- Customization path provided (reference to 0b-customize-workspace.md)
