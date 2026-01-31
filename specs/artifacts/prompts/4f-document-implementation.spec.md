---
specifies: dist/prompts/4-evolve/4f-document-implementation.md
governed-by:
  - specs/workspace/constitution.spec.md
  - .livespec/standard/metaspecs/prompt.spec.md
criticality: IMPORTANT
failure_mode: Without systematic implementation feedback capture, LiveSpec cannot learn from real-world usage patterns and methodology failures
---

# Document Implementation Feedback

## Requirements
- [!] Prompt guides AI agents to create comprehensive implementation feedback reports that capture methodology adherence, failures, successes, and learnings for continuous framework improvement.
  - Report includes honest analysis of what was skipped and why (overconfidence, efficiency instinct, pattern matching)
  - Documents critical failures (TDD skipped, UX flows missing, incomplete features, undefined models)
  - Captures what worked well (requirements phase, behavior specs, contract phase)
  - Identifies methodology gaps (ambiguous boundaries, redundancy, missing guidance)
  - Quantifies results (files created/updated, test coverage, rework cycles)
  - Provides actionable recommendations for framework improvements
  - Distinguishes framework issues from implementation issues
  - Reports stored in `var/implementation-reports/` (timestamped, gitignored)
  - Template ensures consistent structure for pattern analysis
  - Agent prompted to be brutally honest (no defensive rationalization)

## Template Sections
- [!] Implementation feedback reports follow structured template enabling systematic analysis across projects.
  - **Metadata**: Project, date, implementer, scope, methodology version
  - **Executive Summary**: 2-3 sentences on what was built and key learnings
  - **Process Adherence**: What methodology steps were followed vs skipped
  - **Honest Failure Analysis**: Why did agent skip steps (with cognitive bias identification)
  - **Critical Failures**: Major methodology violations and their impact
  - **What Worked Well**: Successful methodology applications
  - **What Didn't Work**: Methodology pain points and ambiguities
  - **Specific Benefits Observed**: Concrete examples of methodology value
  - **Quantitative Results**: Metrics table (files, coverage, issues, rework)
  - **Recommendations**: For methodology improvements (categorized by component)
  - **Conclusion**: Honest assessment and repeatable patterns

## Cataloging Strategy
- [!] Reports enable systematic learning and framework evolution over time.
  - Reports timestamped and versioned (link to LiveSpec version used)
  - Patterns extracted across multiple reports identify systemic issues
  - Common failures become additions to common-pitfalls.md
  - Repeated ambiguities drive clarification in specs/guides
  - Successful patterns documented as examples
  - Agent guidance strengthened based on actual failure modes
  - Recommendations tracked: proposed → implemented → validated

## Agent Behavior
- [!] Agent creates report immediately after significant implementation work.
  - Triggered when: Feature complete, sprint done, major refactoring, methodology trial
  - Agent reviews full conversation history for complete analysis
  - Agent references specs to identify what should have happened vs what did
  - Agent admits mistakes without defensiveness (learning over ego)
  - Agent provides specific file/line references for examples
  - Agent distinguishes "I skipped X" from "methodology unclear about X"
  - Report written while details fresh (not retrospective days later)

## Validation
- Report created in `var/implementation-reports/YYYY-MM-DD-project-scope.md`
- All template sections completed with substantive content
- Honest analysis (agent admits skipped steps and mistakes)
- Quantitative metrics included (not just narrative)
- Recommendations actionable and specific (not vague "improve X")
- Framework version documented for tracking evolution
- Report can be used to identify patterns across projects
