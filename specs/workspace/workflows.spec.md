---
applies_to:
  - all_projects
  - livespec_development
criticality: IMPORTANT
failure_mode: Without clear workflows, contributors don't know how to evolve LiveSpec properly
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Workflows

## Requirements
- [!] LiveSpec development follows specific workflows with spec-first guidance as essential first step: AI agents check for spec existence before creating deliverables, new prompts require behavior specs first, spec changes follow EVOLVE mode workflow, changes validated through real usage before merge, periodic MSL audits maintain minimalism, and documentation updates accompany prompt/spec changes.
  - **Spec-First Guidance Workflow** (essential before creating deliverables):
    - AI checks: Does `specs/features/[deliverable].spec.md` exist for what user wants to create?
    - If NO: Pause to ensure spec exists first
    - AI says: "I need a specification before proceeding. Let's create specs/features/[deliverable].spec.md first using DESIGN mode"
    - AI guides user to appropriate DESIGN mode prompt (1a-design-architecture.md, 1b-define-behaviors.md, or 1c-create-contracts.md)
    - If YES: Verify spec has Requirements section with [!] items, Validation criteria, and Failure Mode defined
    - Then proceed with the deliverable
    - Applies to all deliverables (CHANGELOG, README, configs, templates all need specs)
  - Every prompt in prompts/ has spec in specs/artifacts/prompts/
  - Git history shows specs created before deliverables
  - Specifications don't grow larger over time (MSL audits via prompts/utils/audit-workspace-specs.md)
  - docs/ reflects current prompts/ and specs/ state
  - **Learning Distribution Workflow** (essential for target project adoption):
    - Learnings from violations/corrections captured systematically
    - Changes flow through distribution mechanism (not just LiveSpec's own specs):
      1. Create template in `.livespec/templates/` (if reusable content)
      2. Update spec requirements (mandate template usage)
      3. Update prompt instructions (reference templates during generation)
      4. Regenerate AGENTS.md (includes templates in distribution)
      5. Copy to `dist/` (target projects receive templates)
    - Validates that improvements reach target projects automatically
    - Prevents "update our specs but not distribution" mistake
  - **Validation Workflow** (essential for methodology discipline):
    - Validation runs at key checkpoints to detect violations early:
      - Before committing changes (pre-commit hook recommended)
      - After regenerating files (AGENTS.md, CLAUDE.md, documentation)
      - After updating specs (verify cross-references still valid)
      - Periodically (weekly/sprint end)
      - Before releases (all validations must pass)
    - Validation checks three critical disciplines:
      - Cross-reference integrity (all frontmatter references valid)
      - Generated file protection (no direct edits bypassing sources)
      - Version synchronisation (all version indicators match .livespec-version)
    - Run validation: Use `prompts/utils/validate-project.md`
    - Validation severity levels guide action:
      - ❌ ERROR: Must fix before committing (broken references, direct edits to generated files, version mismatches)
      - ⚠️ WARNING: Should fix soon (missing backlinks, stale generated files)
    - Validation reports actionable (file paths, line numbers, specific fix suggestions)
    - Integration with regeneration workflow:
      1. Update source specs
      2. Regenerate files (Use prompts/4-evolve/4d-regenerate-context.md)
      3. Validate immediately (Use prompts/utils/validate-project.md)
      4. Fix any errors detected
      5. Commit if validation passes
    - Git hook integration (optional but recommended):
      - Pre-commit: Block commit if validation errors detected
      - Post-merge: Warn if validation issues after merge
      - Setup: Run `bash scripts/setup-hooks.sh` to install pre-commit hook automatically
    - Prevents three failure modes:
      - Direct edits to generated files (AGENTS.md mistake)
      - Broken spec/doc cross-references (clt-formation mistake)
      - Version drift (v3.0.0 in .livespec-version but v2.4.0 in AGENTS.md)
  - **Dogfooding Validation Workflow** (essential before committing new specs):
    - Create spec following methodology → USE spec in current session → THEN commit
    - Catches integration issues before release (missing files, incomplete workflows, version drift)
    - Process:
      1. Create spec according to methodology
      2. USE the spec in the same session where it was created
      3. Validate spec works as specified (run through actual workflow)
      4. Fix any integration gaps discovered during usage
      5. Commit only after successful real-world validation
    - Examples:
      - Session completion framework: Created spec → ran completion analysis on same session → discovered version drift → fixed before committing
      - Version tracking: Updated version files → ran regeneration workflow → discovered missing dist/VERSION → added to spec
    - Why this prevents failures:
      - Reveals integration gaps (missing files, incomplete workflows)
      - Validates complete end-to-end functionality
      - Catches issues while context is fresh (easier to fix)
      - Demonstrates spec actually works
    - Validation criteria:
      - Spec used successfully in creating session
      - All integration points validated (file references, workflows, version synchronization)
      - No manual workarounds needed (spec works as specified)
  - **Prompt Reorganisation Workflow** (when adding prompts between existing ones):
    - When adding new prompts between existing prompts or renumbering:
      - **Step 1: Plan Renumbering**
        1. Identify insertion point in workflow sequence
        2. Determine which existing prompts shift (e.g., 0d→0f, 0e→0d)
        3. Verify new sequence maintains workflow logic (setup → problem → outcomes → complexity → research → constraints)
      - **Step 2: Systematic Updates**
        1. Rename prompt files in dist/prompts/[mode]/
        2. Update spec frontmatter (specifies: field in specs/artifacts/prompts/)
        3. Update registry (specs/artifacts/prompts/registry.spec.md table)
        4. Update navigation (dist/prompts/utils/next-steps.md decision tree)
        5. Update predecessor prompts ("Next Step" sections)
        6. Update AGENTS.md references if prompt mentioned
      - **Step 3: Validation**
        1. Run cross-reference validation (prompts/utils/validate-project.md)
        2. Check all references resolve correctly
        3. Verify workflow sequence makes logical sense
        4. Check prompt discovery (can agents find renamed prompts?)
    - Common mistakes:
      - Forgetting spec frontmatter updates (breaks bidirectional linking)
      - Missing next-steps.md references (breaks navigation)
      - Breaking workflow logic with poor insertion point
    - Example: Adding research evaluation (0e) between complexity (0d) and constraints (0d→0f)
      - Renamed: 0d-identify-constraints.md → 0f-identify-constraints.md
      - Renamed: 0e-assess-complexity.md → 0d-assess-complexity.md
      - Created: 0e-evaluate-research-needs.md (new)
      - Updated: registry, next-steps, predecessor prompt (0c), all spec frontmatter
