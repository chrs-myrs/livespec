---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Without feedback mechanism, LiveSpec maintainers cannot understand real-world usage patterns, pain points, and successes, preventing methodology improvements
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/phase-workflow.spec.md
derives-from:
  - specs/workspace/workflows.spec.md
specifies:
  - references/prompts/utils/feedback-report.md
---

# Generate Feedback Report Utility Prompt

Feedback is worth what a maintainer can act on without a follow-up conversation.
The reports that changed LiveSpec named the installed version, verified each
claim against it, and gave every finding a reproduction; a survey of adoption
metrics and impressions changed little.

## Requirements

- [!] Prompt produces a report a maintainer can act on without asking anything further
  - Every finding is about LiveSpec (tooling, conventions, templates, guidance), tested by whether it would affect any project adopting LiveSpec; the reporting project's own drift is left out
  - Each finding states what happened, how to reproduce it (command and output, or file and line), and why it matters; a suggested fix is optional
  - Each finding is verified against the installed plugin before it is reported, never against the changelog alone; one already fixed in the installed version is dropped or reported as a confirmation
  - The report records the installed LiveSpec version and where it was read, and the project's accepted version (`project.yaml` `livespec.version`)
  - The report says what worked, since feedback otherwise skews negative and maintainers need to know what not to change
  - Measurements the work produced, such as before and after counts, are included
  - Can be run at any time, not tied to a phase

- [!] Report is safe to publish
  - The LiveSpec repository is public, and a report may be filed there as an issue or kept as a record
  - Before writing, the user chooses what to anonymise: organisation and project names, people, internal systems, paths. When unsure, these are stripped
  - Credentials, personal data and customer data are never included

- [!] Report reaches the maintainer
  - Written to `var/feedback-reports/livespec-feedback-YYYY-MM-DD.md` in the reporting project
  - Submission instructions name the channels: an issue on the public LiveSpec repository, or directly to the maintainer; the prompt never submits anything itself

## Prompt Outputs

**Primary output:** `var/feedback-reports/livespec-feedback-YYYY-MM-DD.md`

**Report structure:**
- Header: date, installed LiveSpec version and its source, accepted version, anonymisation applied
- Context: what the project is and what was being done when the findings arose, in one paragraph
- Findings: numbered, each with what happened, how to reproduce it, why it matters, and an optional suggested fix
- What worked
- Measurements, when there are any
- Submission

## Validation

- Prompt exists at `references/prompts/utils/feedback-report.md` with the prompt metaspec's essential sections
- A report produced by following it names the installed version and how it was read
- Every finding in such a report has a reproduction and an impact
- No finding in it describes something already fixed in the installed version
- Anonymisation is chosen before anything is written
