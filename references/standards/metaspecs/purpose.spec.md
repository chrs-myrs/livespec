---
criticality: CRITICAL
failure_mode: Without clear purpose, projects lack vision and success criteria
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
---

# Purpose Document Requirements

## Requirements
- [!] Purpose document captures project vision (why it exists) and success criteria (what success looks like) in minimal form.
  - Document located at project root: `PURPOSE.md`
  - Document is minimal (<20 lines, typically 10-15)
  - Contains "Why [Project] Exists" section (1-3 sentences stating the problem/vision)
  - Contains "What Success Looks Like" section (3-6 bullet points with observable criteria)
  - Success criteria are observable/measurable
  - No YAML frontmatter (free-form markdown, not MSL spec)
  - No implementation details (→ strategy specs)
  - No architectural decisions (→ strategy specs)
  - No detailed requirements (→ specs/foundation/outcomes.spec.md)
  - No constraints (→ specs/foundation/constraints.spec.md)

## Notes

**Purpose of PURPOSE.md:**
- Inspirational vision (why we do this)
- Measurable success criteria (how we know it worked)
- Parent document for all specifications
- Not a spec itself - a vision document

**Good purpose statements:**
- ✅ "Prevent documentation drift so AI agents can help effectively"
- ✅ "Enable teams to maintain specs without burden"
- ✅ "Works for new and existing projects"

**Not for PURPOSE.md:**
- Detailed feature lists (→ behaviors/)
- Architecture decisions (→ strategy/)
- Technical constraints (→ foundation/constraints.spec.md)
- Process definitions (→ workspace/)

## Content Routing Table

**Route content to the correct location at capture time (don't accumulate then extract):**

| Content Type | Correct Location | Test |
|--------------|------------------|------|
| "Must comply with X" | `specs/foundation/constraints.spec.md` | Regulatory/legal requirement? |
| "Users can do X" | `specs/foundation/outcomes.spec.md` | Measurable outcome? |
| "Will use X technology" | `specs/strategy/architecture.spec.md` | Technical decision? |
| "System does X when Y" | `specs/features/[feature].spec.md` | Observable behavior? |
| "Team follows X process" | `specs/workspace/workflows.spec.md` | Development process? |
| "We value X principle" | `specs/workspace/constitution.spec.md` | Governing principle? |

**Decision test:** "Can I explain this in an elevator pitch to a non-technical stakeholder?"
- YES (high-level vision) → Keep in PURPOSE.md
- NO (needs technical context) → Route to appropriate spec

**Common mistakes:**
- "Must support 1000 concurrent users" → NOT PURPOSE (constraint) → constraints.spec.md
- "Use PostgreSQL for persistence" → NOT PURPOSE (technical) → architecture.spec.md
- "API returns JSON" → NOT PURPOSE (contract) → interfaces/
- "Checkout must complete in <3 seconds" → NOT PURPOSE (requirement) → outcomes.spec.md

**Relationship to other specs:**
```
PURPOSE.md (why - vision)
    ↓ derives
specs/foundation/outcomes.spec.md (what - high-level requirements)
specs/foundation/constraints.spec.md (limits - hard boundaries)
    ↓ both inform
specs/strategy/architecture.spec.md (how - technical approach)
```

**Example structure (LiveSpec's own PURPOSE.md):**
```markdown
# [Project] Purpose

## Why [Project] Exists
[1-3 sentences describing the problem or vision]

## What Success Looks Like
- [Observable outcome 1]
- [Observable outcome 2]
- [Observable outcome 3]
- [Observable outcome 4]
```

Purpose document goes at project root (most visible location).
