---
phase: utilities
---

# Generate a LiveSpec Feedback Report

**Purpose**: Turn what a project learned about LiveSpec into a report a maintainer can act on without asking anything further.

**When to use**: After an upgrade, an audit or a remediation, or any session where LiveSpec itself got in the way or proved its worth. Also when a maintainer asks for feedback.

---

## Context

The reports that have changed LiveSpec shared three habits. They named the exact version installed and checked every claim against it, so nothing stale was filed. They kept findings about LiveSpec apart from findings about the project. And every finding came with a way to reproduce it. A survey of adoption metrics and impressions, however long, changed very little.

This prompt produces the first kind. Short is fine: three verified findings beat thirty observations.

## Prerequisites

- A LiveSpec project, or a session's worth of LiveSpec use to report on
- The installed LiveSpec plugin, to verify findings against. Without it the report can still be written, but must say its findings are unverified

## Task

### 1. Establish the versions

- **Installed**: read `"version"` from the plugin's `.claude-plugin/plugin.json`. The plugin root is the directory that contains this prompt's `references/` folder. Record the path you read it from
- **Accepted**: read `livespec.version` from the project's `project.yaml`
- If they differ, say so in the report: a problem seen under the accepted version may already be fixed in the installed one

### 2. Gather candidate findings

Ask the user what prompted the report, then collect candidates from the session: validator output, upgrade output, anything that had to be worked around, guidance that turned out wrong or missing. Note each as a one-line claim.

### 3. Keep only findings about LiveSpec

For each candidate ask: would this affect any project that adopted LiveSpec? If it is the project's own drift (its specs, its scripts, its history), drop it. Keep it only if the drift shows that LiveSpec failed to detect, prevent or explain something; then the finding is that failure.

### 4. Verify each finding against the installed version

Re-run the command, or read the file as the installed plugin ships it. The changelog is not evidence: it describes intent, and the installation is what users run.

- Still reproduces → keep it, with the command and its output
- Already fixed → drop it, or keep it as a short confirmation that the fix works in practice, which maintainers also need to hear
- Cannot be reproduced → drop it, or keep it marked unverified with the reason

### 5. Write each finding

```markdown
### N. <one-line statement of the problem>

**What happened**: <observed behaviour, and what was expected instead>

**Reproduce**: <command and output, or file and line, against the installed version>

**Why it matters**: <who it affects and how: blocked commits, silent wrong results, misleading guidance>

**Suggested fix**: <optional; mark it as a suggestion>
```

If a validator could have caught the problem and did not, say which. A finding nothing can detect tends to recur.

### 6. Record what worked

Ask the user, and draw on the session: which parts of LiveSpec did their job, especially any that a maintainer might otherwise change. Be specific: "the scoped hook let us commit while old drift remained" helps; "the methodology is good" does not.

### 7. Include measurements

Before and after counts the work produced: errors, warnings, broken references, file sizes, time taken. A table is enough.

### 8. Choose what to anonymise

Use AskUserQuestion before writing. The LiveSpec repository is public, and a report may end up there.

- Organisation and project names, people's names, internal systems and hostnames, file paths: strip or keep, as the user chooses. When unsure, strip them
- Credentials, personal data and customer data: never included, whatever the choice

### 9. Write the report and hand it over

Write it to `var/feedback-reports/livespec-feedback-YYYY-MM-DD.md`, show the user a summary, and give the submission options. Do not submit anything yourself.

## Outputs

`var/feedback-reports/livespec-feedback-YYYY-MM-DD.md`:

```markdown
# LiveSpec Feedback Report

**Date**: YYYY-MM-DD
**LiveSpec installed**: X.Y.Z (read from <path>)
**LiveSpec accepted by project**: X.Y.Z (project.yaml)
**Anonymisation**: <what was stripped>

## Context

<What the project is, and what was being done when these findings arose. One paragraph.>

## Findings

### 1. ...

## What Worked

- ...

## Measurements

| Measure | Before | After |
|---|---|---|

## Submission

File as an issue at https://github.com/chrs-myrs/livespec/issues (public), or
send this file to the LiveSpec maintainer directly.
```

## Validation

- The report names the installed version and the file it was read from
- Every finding has a reproduction and a statement of why it matters
- No finding describes something already fixed in the installed version, unless presented as a confirmation
- Nothing in the report is about the project alone
- Anonymisation was chosen before writing, and no credentials or personal data appear

## Success Criteria

- A maintainer can reproduce each finding without contacting the reporter
- Stale or project-only findings were caught by verification, not left for the maintainer to discover
- What worked is specific enough to protect from accidental change
- The report is short enough to read in one sitting

## Error Handling

- **No installed plugin visible**: record the accepted version only, state that findings were not verified against an installation, and mark each one unverified
- **No findings survive verification**: write a short report of confirmations and what worked. That is still useful
- **No `project.yaml` version**: record "none accepted" and continue
- **The user declines to choose what to anonymise**: strip organisation names, people and internal systems

## Constraints

- Do not report the project's own drift as a LiveSpec finding
- Do not generalise: without a reproduction, it is not a finding
- Do not pad the report with metrics nobody will act on, such as spec counts or folder inventories, unless a finding needs them
- Do not submit, post or send the report; the user does
- Do not include credentials, personal data or customer data
