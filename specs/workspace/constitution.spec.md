---
applies_to:
  - all_projects
criticality: CRITICAL
failure_mode: Without governance principles, LiveSpec development becomes inconsistent and violates its own philosophy
constrained_by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Constitution

## Requirements
- [!] LiveSpec development follows six core principles (in priority order): Specs Before Implementation (ALWAYS - every deliverable requires specification before implementation, AI agents guide this), MSL Minimalism (specs justify existence), Dogfooding (uses own methodology), Simplicity Over Features (no custom tooling), Living Documentation (specs evolve continuously), and Governance Framework Awareness (acknowledges specialized domain, patterns may not generalize).
  - **Spec-First Always** (Principle #1 - essential):
    - Every deliverable has specification before implementation (code, prompts, templates, documentation, configs)
    - Specification precedes implementation (even for "obvious" deliverables like CHANGELOG, README)
    - AI agents check for spec existence before implementation
    - AI agents guide users to Phase 1 (DESIGN) if spec missing
    - Familiarity doesn't excuse skipping specification (CHANGELOG mistake in commit 40411e3 demonstrates this)
    - Every prompt in prompts/ has corresponding spec in specs/behaviors/prompts/
    - Every behavior has validation criteria and failure mode defined
  - All specs pass MSL test (CRITICAL or IMPORTANT only)
  - Repository uses LiveSpec methodology (specs/ and prompts/ exist)
  - LiveSpec usable with file operations and AI prompts only
  - Spec drift detected and resolved through Phase 4
  - LiveSpec recognized as governance framework (specs about methodology itself)
  - Extensions documented as domain-specific, not universal patterns
