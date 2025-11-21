---
criticality: IMPORTANT
failure_mode: Workspace reorganization prompt unclear, usage patterns ignored, moves unjustified, extractions inappropriate, implementation incomplete
specifies: dist/prompts/utils/reorganize-workspace.md
implements: specs/3-behaviors/workspace-optimization.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
  - specs/workspace/patterns.spec.md
---

# Utility Prompt: Reorganize Workspace

## Requirements

- [!] Prompt MUST guide agent through optimization workflow
  - Step 1: Analyze context usage patterns (10-15 sessions)
  - Step 2: Measure current AGENTS.md structure
  - Step 3: Identify redundancy with CLAUDE.md
  - Step 4: Detect repeated inline content
  - Step 5: Propose section repositioning
  - Step 6: Identify extractions
  - Step 7: Check compression level
  - Step 8: Generate reorganization plan
  - Step 9: Ask for approval
  - Step 10: Implement (if approved)

- [!] Prompt MUST define usage pattern thresholds
  - Hot sections: >70% frequency → START
  - Warm sections: 40-70% frequency → MIDDLE
  - Cold sections: <40% frequency → END
  - Frequency calculation: Times referenced / Total sessions
  - Critical decision points → START regardless of frequency

- [!] Prompt MUST specify START/MIDDLE/END allocation
  - START: 30-40% of file (hot sections, critical decisions)
  - MIDDLE: 40% of file (warm sections, detailed workflows)
  - END: 20-30% of file (cold sections, advanced topics, pointers)

- [!] Prompt MUST define extraction criteria
  - Content repeated 3+ times (template candidate)
  - Long inline examples (could be templates)
  - Verification checklists (standardize)
  - Decision matrices (extract to .livespec/templates/)
  - Don't extract: Used once, critical decision logic, varies by context

- [!] Prompt MUST specify compression level assessment
  - Current: light / moderate / aggressive (from constitution.spec.md)
  - Light: Verbose, self-contained (exploratory, large models)
  - Moderate: Balanced (production, most agents)
  - Aggressive: Dense, focused (cost-sensitive, high-frequency)
  - Recommendation based on file size vs target (20-30KB)

- [!] Prompt MUST specify reorganization plan format
  - Usage pattern statistics (section frequencies)
  - Proposed moves table (section, frequency, current, recommended)
  - Proposed extractions (template path, savings, repetition count)
  - Redundancy reduction (what to consolidate)
  - Expected outcomes (new size, efficiency improvement)
  - Implementation steps (ordered)

- [!] Prompt MUST require user approval
  - Full reorganization option
  - Moves only option
  - Extractions only option
  - Review specific section option
  - Cancel option

- [!] Prompt MUST specify implementation steps
  - Create extraction templates (.livespec/templates/agents/)
  - Update AGENTS.md (move sections, add references)
  - Regenerate context tree (use regenerate-contexts.md)
  - Validate (file sizes, cross-references)
  - Monitor next 5 sessions (measure improvement)

- [!] Prompt MUST specify when NOT to use
  - Less than 10 sessions (insufficient data)
  - Major methodology changes (wait until stable)
  - Context already efficient (>60% signal-to-noise, within budget)
  - Just want to regenerate (use regenerate-contexts.md)

## Validation

- [ ] All 10 workflow steps documented
- [ ] Usage pattern thresholds defined (hot/warm/cold)
- [ ] START/MIDDLE/END allocation specified
- [ ] Extraction criteria defined
- [ ] Compression levels explained
- [ ] Reorganization plan format detailed
- [ ] User approval options listed
- [ ] Implementation steps ordered
- [ ] "When NOT to use" section present
- [ ] Quality checklist provided

## Failure Mode

Without proper prompt specification:
- Moves unjustified (no usage data)
- Inappropriate positioning (wrong thresholds)
- Bad extractions (repeated content kept inline)
- Wrong compression (doesn't match usage)
- Incomplete implementation (missing steps)
- Used inappropriately (insufficient data)
