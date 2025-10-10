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
  - No detailed requirements (→ specs/mission/outcomes.spec.md)
  - No constraints (→ specs/mission/constraints.spec.md)

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
- ❌ Detailed feature lists (→ behaviors/)
- ❌ Architecture decisions (→ strategy/)
- ❌ Technical constraints (→ mission/constraints.spec.md)
- ❌ Process definitions (→ workspace/)

**Relationship to other specs:**
```
PURPOSE.md (why - vision)
    ↓ derives
specs/mission/outcomes.spec.md (what - high-level requirements)
specs/mission/constraints.spec.md (limits - hard boundaries)
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
