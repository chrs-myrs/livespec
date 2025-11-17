---
implements: specs/3-artifacts/prompts/utils-feedback-report.spec.md
generated: '2025-10-10'
---

# Generate Feedback Report Utility Prompt

**Purpose**: Execute Generate Feedback Report Utility Prompt

## Context

This utility prompt helps with common development scenarios across all phases.

## Task

1. Prompt generates structured feedback report capturing project context, adoption metrics, quality assessment, usage patterns, and qualitative user experience to help LiveSpec maintainers improve methodology.

## Output

Complete the specified task with clear deliverables.

## Validation

- Prompt exists at dist/prompts/utils/generate-feedback-report.md
- Prompt has spec: frontmatter reference
- Six report sections documented (context, adoption, quality, usage, experience, submission)
- Five experience questions defined (works well, pain points, confusion, missing, suggestions)
- Anonymization options available (project details, file names, sensitive data)
- Report output location specified (var/feedback-reports/)
- UUID generation for privacy-preserving tracking
- Submission instructions comprehensive (GitHub, email, optional contact)

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: IMPORTANT
**Failure Mode**: Without feedback mechanism, LiveSpec maintainers cannot understand real-world usage patterns, pain points, and successes, preventing methodology improvements
