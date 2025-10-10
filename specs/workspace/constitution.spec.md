---
applies_to:
  - all_projects
criticality: CRITICAL
failure_mode: Without governance principles, LiveSpec development becomes inconsistent and violates its own philosophy
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Constitution

## Requirements
- [!] LiveSpec development follows six core principles (in priority order): Specs Before Implementation (ALWAYS - every deliverable requires specification before implementation, AI agents guide this), MSL Minimalism (specs justify existence through decision framework), Dogfooding (uses own methodology), Simplicity Over Features (no custom tooling), Living Documentation (specs evolve continuously), and Governance Framework Awareness (acknowledges specialized domain, patterns may not generalize).
  - **Spec-First Always** (Principle #1 - essential):
    - Every deliverable has specification before implementation (code, prompts, templates, documentation, configs)
    - Specification precedes implementation (even for "obvious" deliverables like CHANGELOG, README)
    - AI agents check for spec existence before implementation
    - AI agents guide users to Phase 1 (DESIGN) if spec missing
    - Familiarity doesn't excuse skipping specification (CHANGELOG mistake in commit 40411e3 demonstrates this)
    - Every prompt in prompts/ has corresponding spec in specs/behaviors/prompts/
    - Every behavior has validation criteria and failure mode defined
  - **MSL Minimalism** (Principle #2 - essential):
    - Before adding any requirement, ask four essential questions:
      1. **Is this essential?** Would system fail without it? → Include
      2. **Am I specifying HOW instead of WHAT?** Implementation detail? → Remove
      3. **What specific problem does this prevent?** Theoretical concern only? → Exclude
      4. **Could this be inferred or conventional?** Standard practice? → Omit
    - Start minimal, add only when proven necessary
    - Trust implementers to make reasonable decisions
    - Precision hierarchy: Outcome → Behavioral → Interface → Implementation (default to highest level)
    - Requirement justification: Critical (always) > Important (usually) > Useful (rarely) > Nice (never)
    - Hierarchical minimalism: Abstract common requirements to parent specs
    - See dist/guides/msl-minimalism.md for complete decision framework
  - All specs pass MSL test (CRITICAL or IMPORTANT only)
  - Repository uses LiveSpec methodology (specs/ and prompts/ exist)
  - LiveSpec usable with file operations and AI prompts only
  - Spec drift detected and resolved through Phase 4
  - LiveSpec recognized as governance framework (specs about methodology itself)
  - Extensions documented as domain-specific, not universal patterns
