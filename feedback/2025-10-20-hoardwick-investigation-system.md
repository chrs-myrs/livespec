# LiveSpec Feedback: Hoardwick Investigation System

**Date**: 2025-10-20
**Project**: Hoardwick (storage analysis tool)
**Context**: Creating spec-driven investigation framework for root cause analysis
**LiveSpec Experience**: First real-world application beyond initial setup

## Summary

Successfully used LiveSpec to create a sustainable investigation system with specs governing problem documentation, data collection, and findings. The framework worked well overall but revealed edge cases around meta-processes and spec evolution.

## What Worked Exceptionally Well

### 1. Spec-First Thinking Prevented Premature Implementation

**Experience:**
- Started with investigation.spec.md defining WHAT investigations must deliver
- Prevented jumping straight to "build investigation tool"
- Result: Simple folder structure + markdown files, no unnecessary tooling

**Value:** MSL minimalism forced us to question every requirement. "Do we need investigation state tracking?" → Yes, prevents lost work. "Do we need investigation priority levels?" → Yes, determines work order. "Do we need investigation templates?" → No, spec defines required sections.

**Recommendation:** LiveSpec documentation could emphasize this "spec-first prevents over-engineering" benefit more strongly.

### 2. Frontmatter Dependencies Created Clear Relationships

**Spec structure used:**
```yaml
governed-by: .livespec/standard/metaspecs/behavior.metaspec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
  - specs/workspace/patterns.spec.md
```

**Value:**
- Immediately clear which higher-level specs this satisfies
- Easy to trace requirements → strategy → behavior
- Natural review process: check guided-by specs for constraints

**Worked perfectly.** No suggestions for improvement here.

### 3. Rationale Sections Captured Critical Context

**Example from investigation.spec.md:**
```markdown
## Rationale

Session investigation revealed:
- WSL VHDX doesn't auto-shrink → 38GB trapped space
- Docker accumulates despite prunes → need root cause
...

Without structured investigation:
- Root causes remain unknown
- Problems recur
- Solutions are temporary cleanups
```

**Value:**
- Future readers understand WHY this spec exists
- Captures the problem that motivated the solution
- Prevents "why did we build this?" questions later

**Recommendation:** LiveSpec should emphasize rationale sections more. They're often more valuable than the requirements themselves for long-term maintenance.

## Edge Cases & Challenges Encountered

### 1. Meta-Process Specs (Specs About Specs)

**Challenge:**
investigation.spec.md is a behavior spec that governs how to create problem.md and findings.md files. Those files document investigations. Those investigations feed learnings back into specs.

**Questions raised:**
- Is this a behavior spec? (It doesn't describe system behavior)
- Is it a workspace spec? (It's more than a pattern)
- Should it be a new metaspec category?
- How do we handle circular dependencies (investigations → learnings → specs → investigations)?

**Current solution:**
Placed in `specs/3-behaviors/investigation.spec.md` as best fit, but acknowledged it's meta-process, not system behavior.

**Recommendation:**
LiveSpec could define guidance for "process specs" or "meta-process specs" - specs that govern how other documentation is created and maintained.

### 2. Spec vs Documentation Boundary

**Challenge:**
When should something be a spec vs just documentation?

**Examples from session:**
- `QUEUE.md` - Just documentation (tracks state, not requirements)
- `LEARNINGS.md` - Just documentation (captures insights, not requirements)
- `problem.md` - Documentation governed by spec
- `findings.md` - Documentation governed by spec

**Decision criteria developed:**
- **Spec**: Defines requirements, constraints, must-haves
- **Documentation**: Records state, history, decisions, outcomes

**But grey area:** "investigation.spec.md governs problem.md" - is problem.md a spec? It contains success criteria (requirements) but for a specific instance, not the system.

**Recommendation:**
LiveSpec should provide clearer guidance on:
1. When to create a spec vs governed documentation
2. How to reference documentation from specs
3. Whether instance-specific requirements (like problem.md) should follow spec format

### 3. Spec Evolution & Versioning

**Challenge:**
investigation.spec.md will evolve based on learnings from investigations. How do we track spec evolution?

**Questions:**
- Should old versions be archived?
- How do we know when a spec changed?
- Do git commits suffice or do we need spec versioning?
- What if active investigations follow old spec version?

**Current approach:**
Relying on git history, but no explicit versioning in spec frontmatter.

**Recommendation:**
Consider adding optional frontmatter fields:
```yaml
version: 1.0.0  # Semantic versioning
last-updated: 2025-10-20
changelog:
  - 1.0.0 (2025-10-20): Initial version
```

This would help track breaking changes to spec requirements.

### 4. Validation & Conformance

**Challenge:**
No automated way to verify investigations/001-docker-wsl-growth/ conforms to investigation.spec.md.

**Manual checks required:**
- Does it have problem.md with required sections?
- Does it have status.txt?
- Does problem.md define success criteria?
- Are findings permanent solutions (not cleanup scripts)?

**Current approach:**
Manual review, no tooling.

**Recommendation:**
LiveSpec could provide guidance or examples for spec validation:
1. Lightweight validation scripts
2. Structured spec requirements format for automated checking
3. Pre-commit hooks or CI checks
4. Or acknowledge this is out of scope and specs are human-governed

## Workflow Observations

### What We Did

1. **Created behavior spec** (investigation.spec.md)
2. **Created folder structure** per spec requirements
3. **Created investigation instances** (001, 002, 003, 004)
4. **Populated per spec** (problem.md, status.txt, data/)
5. **Collected data** for investigation 001
6. **Documented learnings** for future spec updates

### Workflow Strengths

- **Spec-first prevented bikeshedding**: Clear requirements meant no debate about folder structure
- **Repeatable**: Created 4 investigation instances consistently
- **Self-documenting**: New team member can read investigation.spec.md and understand the system
- **Evolvable**: Learnings feed back into spec for next iteration

### Workflow Gaps

- **No discovery phase guidance**: How do we know when we need a new spec?
- **No refactoring guidance**: What if we realize spec structure was wrong?
- **No deprecation guidance**: How do we sunset old specs?
- **No cross-project reuse**: investigation.spec.md is valuable beyond Hoardwick - how to share?

## Specific Improvements for LiveSpec

### 1. Add "Process Spec" Category

**Proposed structure:**
```
specs/
├── 1-requirements/
├── 2-strategy/
├── 3-behaviors/
├── 4-processes/      # NEW: Specs governing how work is done
│   ├── investigation.spec.md
│   ├── refactoring.spec.md
│   └── code-review.spec.md
└── workspace/
```

**Rationale:** Some specs govern the development process itself, not the system. These don't fit cleanly into behavior/strategy/requirements.

### 2. Provide Spec vs Documentation Decision Tree

```
Does it define requirements?
  ├─ No → Documentation
  └─ Yes → Is it reusable across instances?
            ├─ No → Governed documentation (e.g., problem.md)
            └─ Yes → Spec (e.g., investigation.spec.md)
```

### 3. Add Frontmatter for Spec Lifecycle

```yaml
---
version: 1.0.0
status: stable | draft | deprecated
last-updated: 2025-10-20
replaces: specs/old-investigation.spec.md  # For deprecations
---
```

### 4. Clarify Circular Dependencies

Our case: Investigations → Learnings → Specs → Investigations

**Guidance needed:**
- Is this acceptable?
- How to prevent infinite loops?
- Should there be a "stable state" where specs don't change?

**Proposed guidance:**
"Circular dependencies are acceptable for continuous improvement processes. Specs should converge toward stability as learnings accumulate. Document feedback loops in rationale section."

### 5. Template for Meta-Process Specs

Since investigation.spec.md worked well, suggest template for other meta-process specs:

```markdown
# [Process Name] Behavior

## Requirements

### [Artifact] Structure
- [!] Each [artifact] lives in [location]
- [!] Each [artifact] contains: [required elements]

### [Artifact] Format ([filename])
- [!] Must define: [required sections]
- [!] Must be measurable: [examples]

### [Phase] Lifecycle
- [!] States: [list of states]
- [!] State tracked via: [mechanism]

## Rationale
[Why this process exists, what problem it solves]

## Validation
[How to verify conformance]
```

## Conclusion

LiveSpec worked extremely well for creating a sustainable investigation framework. The spec-first approach prevented over-engineering and created clear, maintainable structure.

Main gaps are around:
1. **Meta-processes** (processes about processes)
2. **Spec evolution** (versioning, deprecation)
3. **Validation** (conformance checking)
4. **Discovery** (when to create new specs)

All gaps are addressable with additional guidance, not framework changes.

**Would use LiveSpec again:** Absolutely. The discipline it imposes is valuable.

## Artifacts for Review

If helpful for LiveSpec improvement:
- `/home/chris/projects/hoardwick/specs/3-behaviors/investigation.spec.md` - The meta-process spec
- `/home/chris/projects/hoardwick/investigations/` - Instances governed by spec
- `/home/chris/projects/hoardwick/investigations/LEARNINGS.md` - Feedback loop documentation

## Questions for LiveSpec Maintainers

1. Should meta-process specs be a distinct category?
2. Is there guidance for spec versioning/evolution?
3. Is validation in scope for LiveSpec or explicitly out of scope?
4. How should circular dependencies (continuous improvement loops) be handled?
5. Any guidance for sharing specs across projects (investigation pattern useful elsewhere)?
