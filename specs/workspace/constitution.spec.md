---
criticality: CRITICAL
failure_mode: Without governance principles, LiveSpec development becomes inconsistent and violates its own philosophy
constrained_by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Constitution

## Requirements
- [!] LiveSpec development follows six core principles: MSL Minimalism (specs justify existence), Dogfooding (uses own methodology), Simplicity Over Features (no custom tooling), Specs Before Implementation (behavior specs precede prompts), Living Documentation (specs evolve continuously), and Governance Framework Awareness (acknowledges specialized domain, patterns may not generalize).
  - All specs pass MSL test (CRITICAL or IMPORTANT only)
  - Repository uses LiveSpec methodology (specs/ and prompts/ exist)
  - LiveSpec usable with file operations and AI prompts only
  - Every prompt has corresponding behavior spec
  - Spec drift detected and resolved through Phase 4
  - LiveSpec recognized as governance framework (specs about methodology itself)
  - Extensions documented as domain-specific, not universal patterns
