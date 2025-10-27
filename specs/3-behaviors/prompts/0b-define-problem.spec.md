---
specifies: prompts/0-define/0b-define-problem.md
criticality: CRITICAL
failure_mode: Projects lack clear purpose and vision, leading to misaligned solutions
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
  - specs/1-requirements/functional/five-phases.spec.md
guided-by:
  - specs/2-strategy/phase-workflow.spec.md
---

# Prompt Behavior: Define Purpose

## Requirements
- [!] Prompt guides AI agent to create purpose document that clearly articulates project vision and success criteria.
  - Produces PURPOSE.md file at project root (format: simple markdown, no frontmatter)
  - Purpose document is minimal (<20 lines)
  - Contains "Why [Project] Exists" section (1-3 sentences)
  - Contains "What Success Looks Like" section (3-6 observable criteria)
  - Success criteria are observable and testable
  - User can explain the vision in their own words

## Context

Use when:
- Starting new project (first step in Phase 0)
- Project lacks written purpose document
- Team needs clarity on project vision and goals
- Before design/implementation begins

## Prerequisites

- Project idea or initial concept
- Understanding of user/stakeholder needs
- Agent has access to project root directory
- User available to clarify vision and goals

## Outputs

- `PURPOSE.md` - Project vision and success criteria (format: markdown with "Why [Project] Exists" and "What Success Looks Like" sections, no frontmatter, <20 lines)

## Validation

- PURPOSE.md exists at project root
- File is minimal (<20 lines)
- Contains "Why [Project] Exists" section (1-3 sentences)
- Contains "What Success Looks Like" section (3-6 criteria)
- No frontmatter (simple markdown, not MSL spec)
- Success criteria are observable and testable
- Vision is clear and unambiguous

## Success Criteria

- Purpose statement captures genuine "why" (not just "what")
- Success criteria are measurable and observable
- Document readable by non-technical stakeholders
- Team can align decisions against stated purpose
- Minimal yet complete (no unnecessary elaboration)

## Error Handling

**If user unclear about project vision:**
- Use discovery questions to clarify purpose
- Guide user through "5 Whys" to find root motivation
- Suggest examples from similar problem domains

**If success criteria vague or immeasurable:**
- Ask: "How would you know this succeeded?"
- Convert abstract goals to observable outcomes
- Example: "Better UX" → "Users complete task in <2 minutes"

**If PURPOSE.md becomes too long (>20 lines):**
- Refocus on essential "why" and "success"
- Move detailed requirements to separate specs (outcomes.spec.md)
- Remind: PURPOSE.md is vision, not requirements document

## Constraints

What this prompt should NOT do:
- ❌ Include detailed requirements (those belong in specs/1-requirements/strategic/outcomes.spec.md)
- ❌ Specify implementation approach (that's architecture/design)
- ❌ Use technical jargon that stakeholders won't understand
- ❌ Create elaborate multi-page documents (keep <20 lines)
- ❌ Use MSL format with frontmatter (PURPOSE.md is free-form)
