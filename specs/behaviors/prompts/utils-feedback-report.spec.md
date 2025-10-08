---
specifies: dist/prompts/utils/generate-feedback-report.md
derives_from:
  - specs/workspace/workflows.spec.md
criticality: IMPORTANT
failure_mode: Without feedback mechanism, LiveSpec maintainers cannot understand real-world usage patterns, pain points, and successes, preventing methodology improvements
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
---

# Generate Feedback Report Utility Prompt

## Requirements
- [!] Prompt generates structured feedback report capturing project context, adoption metrics, quality assessment, usage patterns, and qualitative user experience to help LiveSpec maintainers improve methodology.
  - Can be run at any time (not tied to specific phase)
  - Automated analysis: Project context (domain, size, version), adoption metrics (phases used, spec counts, folder structure), quality assessment (drift status, MSL adherence, test coverage), usage patterns (prompt frequency, customizations)
  - User input: Five experience questions (what works, pain points, confusion, missing features, suggestions)
  - Anonymization options: Strip project-specific details, file names, sensitive data
  - Report output: var/feedback-reports/livespec-feedback-YYYYMMDD.md
  - Report structure: Project Context, Adoption Metrics, Quality Assessment, Usage Patterns, Experience Report, Submission Instructions
  - Random UUID for tracking (privacy-preserving identifier)
  - Submission guidance: GitHub issue template, optional contact info

## Prompt Outputs

**Primary outputs:**
- var/feedback-reports/livespec-feedback-YYYYMMDD.md (structured feedback report)

**Report structure:**
- Header (generated date, report ID/UUID, anonymization level)
- Project Context (domain, age, size, version, team size)
- Adoption Metrics (phases used, spec inventory, folder structure, customizations)
- Quality Assessment (drift status, MSL adherence, test coverage, validation status)
- Usage Patterns (prompt frequency, custom workflows, integration pattern)
- Experience Report (qualitative feedback from 5 questions)
- Submission Instructions (how to submit, GitHub template, optional contact)

**Validation:**
- AI performs automated analysis (codebase inspection, git history, file counts)
- AI asks user 5 experience questions
- Report includes both quantitative and qualitative data
- Anonymization options offered before generation
- Submission instructions clear and actionable

## Validation

- Prompt exists at dist/prompts/utils/generate-feedback-report.md
- Prompt has spec: frontmatter reference
- Six report sections documented (context, adoption, quality, usage, experience, submission)
- Five experience questions defined (works well, pain points, confusion, missing, suggestions)
- Anonymization options available (project details, file names, sensitive data)
- Report output location specified (var/feedback-reports/)
- UUID generation for privacy-preserving tracking
- Submission instructions comprehensive (GitHub, email, optional contact)
