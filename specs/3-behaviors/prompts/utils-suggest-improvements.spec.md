---
criticality: IMPORTANT
failure_mode: Strategic improvement prompt unclear or incomplete, improvements made without proper data analysis, prioritization incorrect
specifies: dist/prompts/utils/suggest-improvements.md
implements: specs/3-behaviors/improvement-analysis.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
  - specs/workspace/patterns.spec.md
---

# Utility Prompt: Suggest Improvements

## Requirements

- [!] Prompt MUST guide agent through data analysis workflow
  - Step 1: Read all three registries
  - Step 2: Read recent session feedback (10-15 files)
  - Step 3: Analyze compliance trends (5-10 files)
  - Step 4: Prioritize by impact × frequency
  - Step 5: Identify related items
  - Step 6: Check improvement history
  - Step 7: Generate recommendations
  - Step 8: Update registries
  - Step 9: Present to user
  - Step 10: Ask for direction

- [!] Prompt MUST provide prioritization framework
  - Impact levels defined (CRITICAL, HIGH, MEDIUM, LOW with scores)
  - Frequency levels defined (Every, Most, Occasional, Rare with scores)
  - Priority calculation: Impact × Frequency (1-16 range)
  - Priority groups: P1 (12-16), P2 (8-11), P3 (4-7), P4 (1-3)

- [!] Prompt MUST enforce improvement history checking
  - Check improvements registry before recommending
  - Identify ineffective approaches (documented failures)
  - Note why previous attempts failed
  - Recommend different approach if needed

- [!] Prompt MUST specify output format
  - P1/P2/P3/P4 sections with title, problem, impact, frequency, root cause, action
  - Quick wins highlighted
  - Systemic patterns explained
  - Data quality notes
  - User choice offered (which priority to start)

- [!] Prompt MUST include data requirements
  - Minimum: 5 compliance files, 3 feedback files, registries exist
  - Better: 10+ sessions, multiple weeks, variety of tasks
  - Insufficient data handling (inform user, gather more data)

- [!] Prompt MUST specify when NOT to use
  - Less than 5 sessions (insufficient)
  - No registries (setup first)
  - Immediate crisis (direct fix)
  - Tactical help needed (use complete-session)

## Validation

- [ ] All 10 workflow steps documented
- [ ] Prioritization framework complete (impact, frequency, calculation)
- [ ] Improvement history check enforced
- [ ] Output format specified
- [ ] Data requirements stated
- [ ] "When NOT to use" section present
- [ ] Quality checklist provided

## Failure Mode

Without proper prompt specification:
- Incomplete data analysis (miss registries or trends)
- Wrong prioritization (no framework)
- Repeat failed approaches (no history check)
- Vague recommendations (no format)
- Used inappropriately (no boundaries)
