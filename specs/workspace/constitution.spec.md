---
applies_to:
  - all_projects
context_compression: moderate
criticality: CRITICAL
failure_mode: Without governance principles, LiveSpec development becomes inconsistent and violates its own philosophy
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Constitution

## Requirements
- [!] LiveSpec development follows seven core principles (in priority order): Specs Before Implementation (ALWAYS - every deliverable requires specification before implementation, AI agents guide this), MSL Minimalism (specs justify existence through decision framework), Dogfooding (uses own methodology), Simplicity Over Features (no custom tooling), Living Documentation (specs evolve continuously), Governance Framework Awareness (acknowledges specialized domain, patterns may not generalize), and Active Agent Guidance (agents have concise definitive context with active verification prompts, not passive documentation).
  - **Spec-First Always** (Principle #1 - essential):
    - Every deliverable has specification before implementation (code, prompts, templates, documentation, configs)
    - Specification precedes implementation (even for "obvious" deliverables like CHANGELOG, README)
    - AI agents check for spec existence before implementation
    - AI agents guide users to Phase 1 (DESIGN) if spec missing
    - Familiarity doesn't excuse skipping specification (CHANGELOG mistake in commit 40411e3 demonstrates this)
    - Every prompt in prompts/ has corresponding spec in specs/3-behaviors/prompts/
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
    - See .livespec/guides/msl-minimalism.md for complete decision framework
  - All specs pass MSL test (CRITICAL or IMPORTANT only)
  - Repository uses LiveSpec methodology (specs/ and prompts/ exist)
  - LiveSpec usable with file operations and AI prompts only
  - Spec drift detected and resolved through Phase 4
  - LiveSpec recognized as governance framework (specs about methodology itself)
  - Extensions documented as domain-specific, not universal patterns
  - All LiveSpec artifacts are specifications at different abstraction levels (strategic specs in 1-requirements/, approach specs in 2-strategy/, behavioral specs in 3-behaviors/)
  - **Active Agent Guidance** (Principle #7 - essential):
    - AGENTS.md is definitive cacheable agent context (<100KB)
    - 80/20 coverage (agents handle 80% of cases without fetching additional context)
    - Includes ACTIVE verification prompts (not passive documentation):
      - Pre-implementation verification checklist
      - "No plumbing exception" warning (all behavior changes need specs)
      - Active self-check questions agents ask before implementing
      - Plan review for methodology compliance
    - Context positioning optimized (START 30-40%, MIDDLE 40%, END 20-30%)
    - Clear pointers to extended context (when to fetch full prompts)
    - Reference Library with `.livespec/` paths enables 80/20 navigation (AGENTS.md → deep detail)
    - Templates in `.livespec/templates/agents/` provide reusable verification content
    - Structural enforcement makes compliance path of least resistance
    - **Context Compression** applied (Moderate level):
      - Active force that reorganizes guidance for agent focus efficiency
      - Complements MSL Minimalism (content vs structure optimization)
      - Strategic extraction of reusable content to templates
      - Balanced inline/reference approach (critical inline, details referenced)
      - Configurable: Light (verbose) | Moderate (balanced) | Aggressive (dense)
      - Framework: `.livespec/standard/conventions/context-compression.spec.md`
