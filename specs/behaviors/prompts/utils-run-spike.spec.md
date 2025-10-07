---
specifies: dist/prompts/utils/run-spike.md
derives_from:
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Without spike guidance, teams waste time on full implementations for unvalidated approaches or skip exploration leading to costly architectural mistakes
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Run Spike Discovery Prompt

## Requirements
- [!] Prompt guides time-boxed technical exploration to answer specific questions before committing to design/implementation, producing spike report in specs/spikes/ with clear answer, findings (worked/failed/surprises), measurements, recommendations, and disposable code samples, reducing risk by converting unknowns to knowns.
  - Triggers: Testing if approach works, measuring performance, understanding APIs, exploring UX, validating integrations
  - Not for: Production code, well-understood problems, simple doc-answerable questions
  - Spike charter required: Question (specific), time box (hours/days), success criteria, out of scope
  - Build minimal prototype: Disposable, hardcoded OK, no tests, no polish
  - Test aggressively: Push boundaries, test failures, measure actual behavior, try unexpected inputs
  - Document findings in specs/spikes/[name]-spike.md
  - Discard spike code after (delete, move to .scratch/, mark "do not use")
  - Report structure: Answer, key findings (worked/failed/surprises), measurements table, recommendations (specs/implementation), code samples, follow-up questions
  - Integration: Update complexity assessment, incorporate into architecture, document constraints, refine behaviors
  - Example scenarios: Performance (load testing), integration (API timeouts), AI/ML (prompt patterns)

## Prompt Outputs

**Primary outputs:**
- specs/spikes/[name]-spike.md (discovery report)
- Disposable prototype code (deleted or moved to .scratch/)

**Report structure:**
- Question (what explored), time box (planned vs actual), date
- Answer (clear, direct answer to question)
- Key Findings:
  - What Worked ✅ (approaches/patterns that succeeded)
  - What Failed ❌ (approaches/limitations discovered)
  - Surprises 🎯 (unexpected discoveries, wrong assumptions)
- Measurements table (metric, expected, actual, notes)
- Recommendations:
  - For specs (how to inform design, constraints to document)
  - For implementation (approach to use, pitfalls to avoid)
- Code Samples (minimal working examples of patterns)
- Follow-up Questions (new unknowns, additional spikes needed)

**Integration with LiveSpec:**
- Update 0d-assess-complexity.spec.md if findings change complexity
- Incorporate into architecture specs (strategy/)
- Document discovered constraints (constraints.spec.md)
- Refine behavior specs based on learnings

**Validation:**
- Spike charter defined before starting
- Time box respected (actual vs planned documented)
- Question answered clearly
- Measurements objective (not assumptions)
- Recommendations actionable
- Code discarded after report created
- Report valuable for future decisions

## Validation

- Prompt exists at dist/prompts/utils/run-spike.md
- Prompt has spec: frontmatter reference
- Spike charter template includes question, time box, success criteria, out of scope
- Report template comprehensive (answer, findings, measurements, recommendations)
- Emphasizes disposable code (spike ≠ production)
- Integration steps documented (update complexity, architecture, constraints, behaviors)
- Example scenarios cover common spike types (performance, integration, AI/ML)
- Tips emphasize focus, measurement, immediate documentation, sharing findings
- Output directory: specs/spikes/ (not root or var/)
