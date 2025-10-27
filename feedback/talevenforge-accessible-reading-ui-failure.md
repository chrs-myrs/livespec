# LiveSpec Implementation Failure: Talevenforge Accessible Reading UI Redesign

**Date**: 2025-10-16
**Project**: Talevenforge (children's story generation and reading system)
**Phase Attempted**: 1-design (DESIGN)
**Actual Phase Needed**: 0-define (DEFINE) with research evaluation
**LiveSpec Version**: 2.1.0

## Context

### Project State
Talevenforge has an existing React website (Phase 3 complete) with a critical accessibility flaw: font scaling controls resize the entire UI, not just story content. This reduces readable screen space for a 9-year-old user (Ashton) with Renpenning syndrome, severe ADHD, and cognitive impairment.

### What User Requested
"Let's re-think the main story list UI, please start by drafting UX documents for this project. Ashton will want to come and find a specific story, or a story in a series easily, to read it and zoom to see text properly, and to have it read to him."

### What I Did (WRONG)
1. Created arbitrary UX documentation in `docs/ux/`:
   - 01-user-profile.md
   - 02-user-stories.md
   - 03-information-architecture.md
   - 04-wireframes-text.md
   - 05-interaction-patterns.md
   - 06-visual-design-specs.md

2. User correctly stopped me: "Wait, we need to follow the real process from .livespec, not this arbitrary process. I can see you are not documenting as per those requirements"

3. I then read Phase 1 (DESIGN) prompts and created:
   - specs/2-strategy/accessible-reading-architecture.spec.md
   - specs/3-behaviors/website/content-text-scaling.spec.md
   - specs/3-behaviors/website/accessible-story-discovery.spec.md
   - specs/3-behaviors/website/read-aloud.spec.md

4. User correctly stopped me again: "This is not right, the UX research should be part of the define stage, but you are changing actual implementation."

## What I Got Wrong

### Critical Misunderstanding: Jumping Phases
I jumped directly to Phase 1 (DESIGN) when the project needed Phase 0 (DEFINE) research evaluation.

**Why this happened:**
- Existing website implementation (Phase 3 complete) made me think we were in Phase 4 (EVOLVE)
- User's request to "re-think the UI" felt like a redesign (Phase 1)
- I failed to recognize this was a **new problem statement** requiring Phase 0

**What I should have recognized:**
- This is effectively a **new sub-project**: "Accessible Reading Interface for Child with Cognitive Disabilities"
- Existing implementation violates critical accessibility requirements
- User research needed to understand Ashton's specific needs before any design decisions
- This requires Phase 0 (DEFINE) → Phase 1 (DESIGN) → Phase 2 (BUILD) cycle

### Specific Phase 0 Violations

**Should have run 0e-evaluate-research-needs.md:**
- Project Type: User-facing application (child with disabilities)
- User Understanding: Partial (Ashton's profile known, but UX needs are assumptions)
- Complexity Factors: High (ADHD-specific design patterns, motor control challenges, cognitive load minimization)
- Existing Research: One research brief (research/briefs/accessible-reading-interface.md) but no personas, journeys, flows, or validated insights

**CORRECTION: Research Actually Exists**

After user directed me to review `research/reports/accessible-reading-interface.md`, I discovered comprehensive evidence-based research already exists:

- **ACM CHI 2023 study** (177 participants, digital reading rulers)
- **2022 ADHD meta-analysis** (18 studies, 564 children, validated effect sizes)
- **Industry gold standards** (Voice Dream Reader, Apple Books, Kindle)
- **Accessibility research** (color schemes, typography, spacing with specific measurements)
- **Ashton-specific application** (maps research to 9yo with Renpenning syndrome, ADHD, cognitive impairment)

**Research Gaps Remaining (Lower Priority):**
1. **User Observation** (MEDIUM priority, 2-4 hours)
   - Observe Ashton using current broken interface
   - Document specific frustration points
   - Validate which research-backed features most critical for him
   - Test prototypes with real user

2. **UX Flow Documentation** (LOW priority, 2 hours)
   - Document current navigation patterns
   - Map to research-backed improvements
   - Primarily for implementation guidance, not requirements

**Key Insight**: Peer-reviewed research with similar populations (dyslexic readers, ADHD children) provides stronger foundation than single-user observation alone. The existing research report effectively answers Phase 0 questions. Additional observation would validate/refine, not replace.

### What I Created Instead

I created **implementation specifications** (Phase 1 DESIGN outputs) without the foundational research (Phase 0 DEFINE):

- `specs/2-strategy/accessible-reading-architecture.spec.md` - Assumed architectural decisions without research validation
- `specs/3-behaviors/website/content-text-scaling.spec.md` - Specified behavior without understanding actual user needs
- `specs/3-behaviors/website/accessible-story-discovery.spec.md` - Designed interaction patterns based on assumptions
- `specs/3-behaviors/website/read-aloud.spec.md` - Defined audio behavior without testing with user

**Problems with these specs:**
1. **Assumed requirements**: "60px touch targets," "2 taps to story," "no animations >200ms" - where did these come from? Not validated research.
2. **Prescriptive HOW not WHAT**: Specified CSS architecture, DOM structure, implementation details
3. **No traceability**: Not linked to validated user research or outcomes
4. **Premature optimization**: Solving problems that may not exist or missing actual problems

## What Should Have Happened

### Correct Phase 0 (DEFINE) Process

**Step 1: Define the Problem (0b-define-problem.md)**
Create `PURPOSE.md` for this sub-project:
```markdown
# Accessible Reading Interface Purpose

## Why This Exists
Current Talevenforge website has accessibility barriers preventing independent use by child with ADHD, cognitive impairment, and motor control challenges. Font scaling reduces readable space, navigation is overwhelming, and interface competes with story content for attention.

## What Success Looks Like
- Ashton reads stories independently without adult assistance
- Text scaling doesn't reduce readable screen space
- Navigation requires zero cognitive load
- Interface never competes with story for attention
- Ashton sustains engagement throughout reading sessions
```

**Step 2: Define Outcomes (0c-define-outcomes.md)**
Create `specs/1-requirements/strategic/accessible-reading-outcomes.spec.md`:
```markdown
## Requirements
- [!] Child uses interface independently without frustration
  - Completes story discovery → reading in single session
  - Navigates without adult intervention
  - Returns to app voluntarily for subsequent sessions

- [!] Text scaling optimizes readability without UI penalty
  - Readable screen space maximized at all text sizes
  - UI controls remain ergonomically sized
  - No layout shifts or reflows during scaling
```

**Step 3: Evaluate Research Needs (0e-evaluate-research-needs.md)**
Run systematic research evaluation:

**HIGH Priority Research:**
1. **User Persona** - Ashton's actual interaction patterns
2. **UX Flow** - Current interface navigation paths and pain points
3. **User Insights** - Observation sessions and pain point validation

**Effort**: 2-4 days total
**Templates**: Use `.livespec/templates/research/persona.md.template`, etc.
**Informs**: All subsequent requirements and design decisions

**Step 4: Conduct Research**
Create research artifacts:
- `research/personas/ashton-reader.md` - Evidence-based persona from observation
- `research/flows/story-discovery-current.md` - Documented current UX with pain points
- `research/insights/accessibility-pain-points.md` - Findings from observation sessions

**Step 5: Update Requirements Based on Research**
Refine `specs/1-requirements/strategic/accessible-reading-outcomes.spec.md` with:
```yaml
informed-by:
  - research/personas/ashton-reader.md
  - research/insights/accessibility-pain-points.md
```

**Step 6: Only THEN Proceed to Phase 1 (DESIGN)**
Now create architecture and behavior specs grounded in validated research.

## Root Causes of Failure

### 1. LiveSpec Doesn't Clearly Signal Sub-Project Phases
When working on an existing project (Talevenforge website is Phase 3 complete), there's no clear prompt pattern for:
- "This feature redesign needs its own Phase 0"
- "Go back to DEFINE even though project is at VERIFY"
- Distinguishing feature additions (continue current phase) from architectural redesigns (restart at DEFINE)

**Suggestion**: Add `.livespec/prompts/utils/detect-phase-restart.md` that helps identify when to restart at Phase 0 for sub-features.

### 2. Research Evaluation Optional Framing
Prompt 0e says "Optional: Skip entirely for projects without user research needs" and includes extensive "when to skip" guidance.

For user-facing applications with **accessibility requirements**, this should be **mandatory not optional**.

**Suggestion**: Add callout in 0e:
```markdown
## NEVER Skip Research For:
- Accessibility-focused projects
- Child users with disabilities
- High-complexity UX patterns
- Novel interaction models
```

### 3. Research Templates Not Visible in Workflow
I read Phase 1 prompts but never saw Phase 0 prompts. The workflow assumes linear phase progression, but projects often loop back.

**Suggestion**: Each phase prompt should include:
```markdown
## Before This Phase
If you're unsure whether prior phases are complete:
- Run `.livespec/prompts/utils/phase-checker.md`
- Verify all Phase X prerequisites exist
```

### 4. Ambiguity Around "Research" vs "UX Documentation"
I created "UX documents" (user stories, wireframes, interaction patterns) thinking this was design work. But these ARE research artifacts that belong in Phase 0.

**Suggestion**: Clarify in 0e-evaluate-research-needs.md:
```markdown
## What Counts as Research?
These are Phase 0 research activities, NOT Phase 1 design:
- User personas
- User journey maps
- UX flows and wireframes
- User stories
- Interaction pattern analysis
- Mental model documentation

These are Phase 1 design activities:
- Architecture specifications
- Behavior specifications
- API contracts
- Component interfaces
```

### 5. MSL Format Encourages Premature Specification
The MSL spec format is so structured and complete-feeling that it's tempting to write specs based on assumptions rather than research.

**Observation**: Having a well-formatted spec FEELS authoritative even when it's built on sand. The `informed-by:` frontmatter field exists but isn't enforced.

**Suggestion**: Add validation in metaspecs:
```yaml
# In behavior.spec.md metaspec
requirements:
  - [!] If spec targets user-facing behavior, must include informed-by linking to research artifacts
```

## Correct State Now

### What Should Be Deleted
- `docs/ux/*.md` (6 files) - Wrong location, wrong phase, arbitrary structure
- `specs/2-strategy/accessible-reading-architecture.spec.md` - Premature, not research-informed
- `specs/3-behaviors/website/content-text-scaling.spec.md` - Premature, not research-informed
- `specs/3-behaviors/website/accessible-story-discovery.spec.md` - Premature, not research-informed
- `specs/3-behaviors/website/read-aloud.spec.md` - Premature, not research-informed

### What Should Exist
- `PURPOSE.md` (or `docs/accessible-reading-PURPOSE.md` for sub-project)
- `specs/1-requirements/strategic/accessible-reading-outcomes.spec.md`
- `specs/1-requirements/strategic/accessible-reading-complexity-assessment.md`
- `specs/1-requirements/strategic/accessible-reading-research-evaluation.md` (output of 0e)
- `research/personas/ashton-reader.md` (after observation)
- `research/flows/current-story-discovery.md` (after analysis)
- `research/insights/accessibility-pain-points.md` (after testing)

### Next Steps (Correct Order)
1. Run 0b-define-problem.md → Create PURPOSE.md for accessible reading sub-project
2. Run 0c-define-outcomes.md → Create outcomes.spec.md
3. Run 0d-assess-complexity.md → Document complexity factors
4. Run 0e-evaluate-research-needs.md → Systematic research evaluation
5. Conduct HIGH priority research using templates
6. Update requirements with `informed-by:` frontmatter
7. ONLY THEN proceed to Phase 1 (1a-design-architecture.md)

## Lessons for LiveSpec Evolution

### For Documentation
1. Add explicit "phase restart detection" guidance
2. Clarify research vs design activities
3. Make research mandatory for accessibility projects
4. Add phase prerequisite checkers

### For Prompts
1. Each prompt should validate prerequisites before executing
2. Add explicit "wrong phase" detection
3. Include "before this phase" section with phase-checker reference

### For Metaspecs
1. Enforce `informed-by:` for user-facing behavior specs
2. Add quality criteria distinguishing assumption-based vs research-based specs

### For Templates
1. Research templates should be more prominent in Phase 0
2. Add template for sub-project PURPOSE.md

## Impact Assessment

**Wasted Effort**: ~2 hours creating wrong artifacts
**Rework Required**: Delete 11 files, start Phase 0 correctly
**Risk Introduced**: If proceeded to implementation, would have built wrong solution
**Cost of Detection**: User caught error before implementation, minimal damage

**Key Insight**: LiveSpec's "keep specs synchronized with reality" purpose is violated when specs are created without research foundation. Specs LOOKED right but were actually fiction dressed as specification.

## Acknowledgment

This failure demonstrates exactly why LiveSpec exists - to prevent specification drift from reality. I created specifications that drifted from reality before a single line of code was written. The user correctly identified that UX research belongs in DEFINE phase, not bundled into DESIGN as an afterthought.

Thank you for the course correction.
