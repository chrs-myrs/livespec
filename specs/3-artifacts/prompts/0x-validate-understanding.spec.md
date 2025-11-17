---
criticality: IMPORTANT
failure_mode: Without conceptual validation, users make organizational mistakes requiring costly restructuring
specifies: dist/prompts/0-define/0x-validate-understanding.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Prompt Behavior: Validate Understanding

## Requirements
- [!] Prompt verifies user understands four core LiveSpec concepts before implementation, catching conceptual gaps that would lead to organizational mistakes.
  - Asks 4 conceptual questions (not file operation questions)
  - Question 1: Phases vs Layers distinction
    - Pass: User explains phases = WHEN/workflow, layers = WHERE/organization
    - Fail: User thinks they're the same or unclear
    - On fail: Points to AGENTS.md "CRITICAL DISTINCTION" section
  - Question 2: Workspace Scope for Project Domain
    - Pass: User identifies project domain and correct workspace scope pattern
    - Fail: User unclear about domain or puts product features in workspace/
    - On fail: Points to Project Taxonomy section and decision tests
  - Question 3: Strategic vs Behavioral Specifications
    - Pass: User correctly places "API JSON" in 2-strategy/, "OAuth auth" in 3-behaviors/
    - Fail: User guesses wrong or puts both in same folder
    - On fail: Points to Folder Organization Decision Tests
  - Question 4: Generated Artifacts Organization
    - Pass: User knows generated files don't go in specs/
    - Fail: User thinks generated files go in specs/ or next to spec files
    - On fail: Points to Specs Boundary guidance
  - Provides guidance immediately when gaps detected (not at end)
  - Points to specific documentation sections (line numbers when possible)
  - Completes in 5-10 minutes
  - Clear validation results (all pass / some corrected / multiple fails)
  - Recommends next steps based on results
  - For multiple fails: Recommends reading documentation first
  - Creates no files (validation only)

## Validation
- Prompt asks exactly 4 conceptual questions
- Each question has clear PASS/FAIL criteria
- Guidance provided immediately after each failed question
- Specific documentation sections referenced (with line numbers)
- Validation results clearly communicated
- Next steps recommended based on results
- No files created (prompt is read-only validation)
- Takes 5-10 minutes to complete
- Users with weak understanding discover gaps before implementation
- Users with strong understanding proceed confidently
- Reduces likelihood of organizational mistakes requiring restructuring
