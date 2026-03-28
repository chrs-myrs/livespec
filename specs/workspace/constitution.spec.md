---
type: workspace
category: workspace
fidelity: process
criticality: CRITICAL
failure_mode: Without governance principles, LiveSpec development becomes inconsistent and violates its own philosophy
governed-by: []
applies_to:
  - all_projects
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 4: Maintenance Proportional to Durability)
  - specs/foundation/outcomes.spec.md (Requirement 5: Voluntary Adoption)
context_compression: moderate
---

# LiveSpec Development Constitution

## Requirements
- [!] LiveSpec development follows ten core principles (in priority order): Specs Before Deliverables (ALWAYS - every deliverable requires specification first, AI agents guide this), MSL Minimalism (specs justify existence through decision framework), Dogfooding (uses own methodology), Simplicity Over Features (no custom tooling), Living Documentation (specs evolve continuously), Governance Framework Awareness (acknowledges specialized domain, patterns may not generalize), Active Agent Guidance (agents have concise definitive context with active verification prompts, not passive documentation), Clean Evolution (no deprecation or backwards compatibility, evolve forward without legacy baggage), Progressive Disposability (upper layers more durable, lower layers derived), and Spec Health (maintain spec quality through validation and evolution).
  - **Spec-First Always** (Principle #1 - essential):
    - Every deliverable has specification before creation (prompts, templates, documentation, configs)
    - Specification precedes deliverable (even for "obvious" deliverables like CHANGELOG, README)
    - AI agents check for spec existence before proceeding
    - AI agents guide users to DESIGN mode if spec missing
    - Familiarity doesn't excuse skipping specification (CHANGELOG mistake in commit 40411e3 demonstrates this)
    - Every prompt in prompts/ has corresponding spec in specs/artifacts/prompts/
    - Every behavior has validation criteria and failure mode defined
  - **MSL Minimalism** (Principle #2 - essential):
    - Before adding any requirement, ask four essential questions:
      1. **Is this essential?** Would system fail without it? → Include
      2. **Am I specifying HOW instead of WHAT?** Implementation detail? → Remove
      3. **What specific problem does this prevent?** Theoretical concern only? → Exclude
      4. **Could this be inferred or conventional?** Standard practice? → Omit
    - Start minimal, add only when proven necessary
    - Trust implementers to make reasonable decisions
    - Precision hierarchy: Outcome → Behavioral → Interface (default to highest level)
    - Requirement justification: Critical (always) > Important (usually) > Useful (rarely) > Nice (never)
    - Hierarchical minimalism: Abstract common requirements to parent specs
    - See .livespec/guides/msl-minimalism.md for complete decision framework
  - All specs pass MSL test (CRITICAL or IMPORTANT only)
  - Repository uses LiveSpec methodology (specs/ and prompts/ exist)
  - LiveSpec usable with file operations and AI prompts only
  - Spec health monitored and resolved through EVOLVE mode
  - LiveSpec recognized as governance framework (specs about methodology itself)
  - Extensions documented as domain-specific, not universal patterns
  - All LiveSpec artifacts are specifications at different abstraction levels (strategic specs in foundation/, approach specs in 2-strategy/, behavioral specs in features/)
  - **Active Agent Guidance** (Principle #6 - essential):
    - AGENTS.md is definitive cacheable agent context (<100KB)
    - 80/20 coverage (agents handle 80% of cases without fetching additional context)
    - Includes ACTIVE verification prompts (not passive documentation):
      - Pre-action verification checklist
      - "No plumbing exception" warning (all behavior changes need specs)
      - Active self-check questions agents ask before creating specs
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
  - **Clean Evolution** (Principle #7 - LiveSpec project only):
    - LiveSpec itself evolves without backwards compatibility or deprecation cycles
    - Old patterns deleted, not deprecated (no .deprecated files, no legacy code paths)
    - Users on old versions use their copied dist/ (already have it, not broken)
    - New users get current best practice only (no confusion from multiple patterns)
    - Lean codebase with no accumulated baggage
    - Dogfoods "remain lean" principle (LiveSpec practices what it preaches)
    - **Not imposed on projects using LiveSpec** (projects can handle backwards compatibility as needed)
    - **LiveSpec-specific constraint** (governance framework development philosophy)
  - **Progressive Disposability** (Principle #8 - essential):
    - Upper layers are more durable than lower layers
    - PURPOSE most durable → REQUIREMENTS → STRATEGY → BEHAVIORS → derived artifacts most volatile
    - Essential knowledge lives in specs, not derived artifacts
    - Maintenance energy invested proportional to layer durability
    - Discoveries level up to appropriate spec layer or remain local
  - **Spec Health** (Principle #9 - essential):
    - Maintain spec quality through validation and evolution
    - "Time to refine specs" is a positive signal, not a failure state
    - Spec health detection identifies issues early
    - EVOLVE mode runs continuously to maintain spec quality
