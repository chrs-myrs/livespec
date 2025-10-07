# MSL Extension Feedback for Upstream Consideration

**From:** LiveSpec project (https://github.com/chrs-myrs/livespec)
**To:** MSL Specification maintainers (https://github.com/chrs-myrs/msl-specification)
**Date:** 2025-10-07
**LiveSpec Version:** 2.0.0
**MSL Base Version:** As of 2025-10

## Executive Summary

LiveSpec has successfully applied MSL to a complex, self-referential project (51 specifications defining a methodology framework). Through development and dogfooding, we've identified valuable extensions to MSL that enable:

1. **Traceability** - Bidirectional dependency tracking across specification networks
2. **Prioritization** - Impact-driven development decisions
3. **Validation** - Automated completeness and consistency checking

This document reports what worked, what we needed to extend, and recommendations for upstreaming to benefit the broader MSL community.

## What Worked Well (Standard MSL)

### 1. Four-Section Format

**Specification:**
- Title (# Heading)
- Frontmatter (YAML)
- Requirements (## Requirements)
- Optional sections

**LiveSpec experience:**
- ✅ **Clarity**: Immediately recognizable structure across 51 specs
- ✅ **Parsability**: Easy for both humans and AI agents to parse
- ✅ **Flexibility**: Optional sections accommodate different spec types
- ✅ **Minimalism**: Forces focus on requirements (prevents bloat)

**Recommendation:** Keep as-is, core strength of MSL

### 2. [!] Critical Marker

**Specification:**
- Requirements use `[!]` marker for CRITICAL items

**LiveSpec experience:**
- ✅ **Visual scanning**: Easy to spot critical requirements
- ✅ **AI agent parsing**: Agents prioritize [!] items
- ✅ **Implementation guidance**: Developers know what NOT to skip
- ✅ **Minimalism test**: "Is this [!] worthy?" reduces non-essential requirements

**Recommendation:** Keep as-is, excellent minimal design

### 3. Markdown Foundation

**Specification:**
- Pure markdown, no proprietary formats
- Standard YAML frontmatter

**LiveSpec experience:**
- ✅ **Universal tools**: Works with any markdown editor, GitHub rendering
- ✅ **Version control**: Git diffs work naturally
- ✅ **No lock-in**: Readable without special tools
- ✅ **AI-friendly**: All AI agents understand markdown

**Recommendation:** Keep as-is, fundamental to MSL success

## What We Extended (LiveSpec-Specific)

LiveSpec extends MSL in two areas: **prioritization** and **traceability**. Below we document what we added, why, and whether it should be upstreamed.

### Extension 1: Prioritization Fields (Recommend Upstreaming)

#### criticality (CRITICAL | IMPORTANT)

**What we added:**
```yaml
---
criticality: CRITICAL
failure_mode: System unsecured without authentication
---
```

**Why added:**
- Need to prioritize implementation (limited time/resources)
- "What breaks without this?" is powerful minimalism filter
- CRITICAL vs IMPORTANT guides AI agents on what to implement first

**Usage pattern:**
- CRITICAL: System fails without (breaks, unusable, unsafe)
- IMPORTANT: System works but quality degrades significantly
- Forces binary decision (no MEDIUM escape hatch)

**Statistics:**
- 51/51 LiveSpec specs include criticality field (100% adoption)
- Demonstrates filtering effectiveness (not everything marked critical)

**Recommendation: ✅ UPSTREAM TO MSL**

**Rationale:**
- Universal need: All projects prioritize
- Clear semantics: Binary choice prevents analysis paralysis
- Minimalism enforcement: "Is this CRITICAL?" filters noise
- Proven in practice: 100% adoption in LiveSpec

**Proposed MSL addition:**
```markdown
## Required Frontmatter

All MSL specifications must include:

```yaml
---
criticality: CRITICAL | IMPORTANT
failure_mode: [Concrete description of what breaks]
---
```

**Semantics:**
- **CRITICAL**: System fails without this (broken, unusable, unsafe, data loss)
- **IMPORTANT**: System works but quality/experience degrades significantly
- **failure_mode**: Specific consequences of non-compliance (not vague)
```

### Extension 2: Traceability Fields (Consider for Upstreaming)

#### constrained_by (Universal - Recommend Upstreaming)

**What we added:**
```yaml
---
constrained_by:
  - .livespec/standard/metaspecs/behavior.spec.md
  - specs/constraints.spec.md
---
```

**Why added:**
- Metaspec system: Specs about specs (frameworks need this)
- Constraint tracking: What hard boundaries apply?
- Validation: Check all specs point to valid metaspecs

**Usage pattern:**
- Points to specs that constrain THIS spec
- Creates type system (behavior specs constrained by behavior metaspec)
- Enables automated validation (all specs constrained?)

**Statistics:**
- 50/51 specs include constrained_by (98% adoption)
- Average 1.5 constraints per spec
- Enables circularity validation (complete chain: MSL → base → metaspecs → specs)

**Recommendation: ✅ UPSTREAM TO MSL (Optional field)**

**Rationale:**
- Universal need for frameworks: Standards need metaspecs
- Optional: Projects without metaspecs don't need it
- Powerful validation: Automated completeness checking
- Clear semantics: Points to constraining specifications

**Proposed MSL addition:**
```markdown
## Optional Frontmatter

### constrained_by

Points to specifications that constrain this specification.

**Use cases:**
- Frameworks: Specs constrained by metaspecs (type system)
- Policies: Specs constrained by governance docs
- Standards: Implementations constrained by standards

**Format:**
```yaml
---
constrained_by:
  - path/to/constraining-spec.md
  - path/to/another-constraint.md
---
```

**Validation:**
- All referenced files should exist
- Prevents orphaned specifications
```

#### derives_from (Universal - Recommend Upstreaming)

**What we added:**
```yaml
---
derives_from:
  - PURPOSE.md
  - specs/requirements.spec.md
---
```

**Why added:**
- Requirements tracing: Which requirements does this satisfy?
- Impact analysis: If requirement changes, which specs affected?
- Justification: Why does this spec exist?

**Usage pattern:**
- Points to upstream requirements, PURPOSE, or other foundational specs
- Creates dependency graph (requirements → design → implementation)
- Answers "why this spec?" question

**Statistics:**
- 18/51 specs include derives_from (35% adoption)
- Primarily strategy/ and constraints/ specs (architectural decisions)
- Links to foundational requirements and PURPOSE.md

**Recommendation: ✅ UPSTREAM TO MSL (Optional field)**

**Rationale:**
- Universal need: Traceability to requirements
- Optional: Not all specs derive from requirements (metaspecs don't)
- Standard practice: Requirements engineering uses this
- Clear semantics: Upward dependency

**Proposed MSL addition:**
```markdown
### derives_from

Points to specifications or documents this specification derives from.

**Use cases:**
- Requirements tracing: Design specs derive from requirement specs
- Impact analysis: Requirement changes affect derived specs
- Justification: Why this specification exists

**Format:**
```yaml
---
derives_from:
  - requirements.spec.md
  - PURPOSE.md
  - external-standard.md
---
```
```

#### specifies (Domain-Specific - Consider Case-by-Case)

**What we added:**
```yaml
---
specifies: dist/prompts/4-evolve/4a-detect-drift.md
---
```

**Why added:**
- Bidirectional linking: Spec → Deliverable relationship
- Circularity validation: Every deliverable has spec
- LiveSpec-specific: Methodology specs define methodology deliverables

**Usage pattern:**
- Behavior spec points to the deliverable it defines
- Used in specs/behaviors/prompts/ (defining prompt files)
- Enables completeness check (all deliverables spec'd?)

**Statistics:**
- 23/51 specs include specifies (45% adoption)
- All prompt behavior specs use it (100% in that category)
- Primarily LiveSpec dogfooding use case

**Recommendation: ⚠️ CONSIDER FOR MSL (Domain-specific)**

**Rationale:**
- **Pros:**
  - Useful for framework/tool development (specs about deliverables)
  - Clear semantics: Points to what this spec defines
  - Enables validation: Deliverables must have specs
- **Cons:**
  - Domain-specific: Not all projects have "deliverables" concept
  - Alternative: Could use generic "defines" or "implements" field
  - May not be universal enough for MSL

**Alternative proposal:**
```markdown
### implements (or defines)

Points to files/artifacts this specification defines or governs.

**Use cases:**
- Framework development: Specs define deliverable files
- Tool development: Specs define tool behavior
- Code generation: Specs define generated outputs

**Format:**
```yaml
---
implements:
  - path/to/implementation.js
  - path/to/deliverable.md
---
```
```

#### satisfies, supports, applies_to (Domain-Specific - Probably NOT Upstream)

**What we added:**

**satisfies:**
```yaml
---
satisfies:
  - specs/requirements.spec.md (bidirectional sync)
---
```
Points to requirements this spec satisfies (reverse of derives_from)

**supports:**
```yaml
---
supports:
  - prompts/4-evolve/4d-regenerate-agents.md
---
```
Points to things this spec enables or supports

**applies_to:**
```yaml
---
applies_to:
  - all_ai_agents
  - AGENTS.md
---
```
Scope declaration for workspace specs

**Usage statistics:**
- satisfies: 4/51 specs (8%) - Rare
- supports: 5/51 specs (10%) - Rare
- applies_to: 3/51 specs (6%) - Very rare

**Recommendation: ❌ DO NOT UPSTREAM**

**Rationale:**
- Low adoption even in LiveSpec (complex project)
- Overlaps with derives_from/specifies semantics
- Project-specific uses (not universal patterns)
- Can be achieved with other fields + documentation

**Alternative:** Document these as LiveSpec-specific extensions in base.spec.md

## Recommendations Summary

### Tier 1: Strongly Recommend Upstreaming

1. **criticality + failure_mode** (Required fields)
   - Universal need for prioritization
   - Proven minimalism enforcement
   - 100% adoption in LiveSpec
   - Clear semantics

### Tier 2: Recommend Upstreaming (Optional)

2. **constrained_by** (Optional field)
   - Enables metaspec systems
   - Automated validation
   - 98% adoption in LiveSpec
   - Useful for frameworks/standards

3. **derives_from** (Optional field)
   - Requirements traceability
   - Impact analysis
   - Standard practice in RE
   - 31% adoption shows selective use

### Tier 3: Consider Case-by-Case

4. **specifies / implements / defines** (Optional field)
   - Useful for framework development
   - Domain-specific application
   - 41% adoption in LiveSpec
   - May benefit tool/framework developers

### Tier 4: Keep as LiveSpec Extensions

5. **satisfies, supports, applies_to**
   - Project-specific uses
   - Low adoption (4-10%)
   - Overlapping semantics
   - Document as extensions in LiveSpec base.spec.md

## Implementation Guidance for MSL

If upstreaming these fields, suggest:

### 1. Make tier 1 (criticality/failure_mode) required
```markdown
# MSL Format

All specifications must include:

## Title
`# Specification Name`

## Frontmatter (Required)
```yaml
---
criticality: CRITICAL | IMPORTANT
failure_mode: [Specific failure description]
---
```

## Requirements Section (Required)
`## Requirements`
- [!] Critical requirement
- Regular requirement
```

### 2. Make tier 2/3 optional with clear documentation
```markdown
## Optional Frontmatter Fields

### Traceability

Projects may include dependency tracking fields:

- `constrained_by:` - Points to constraining specifications
- `derives_from:` - Points to upstream requirements/sources
- `implements:` - Points to artifacts this spec defines

These fields enable:
- Automated validation (completeness checking)
- Impact analysis (change propagation)
- Requirement tracing (upward/downward)

Example:
```yaml
---
criticality: CRITICAL
failure_mode: System fails without authentication
derives_from:
  - requirements/security.spec.md
constrained_by:
  - standards/auth-standard.spec.md
implements:
  - src/auth/login.js
---
```
```

### 3. Provide validation examples

Help implementers validate correct usage:

```bash
# Check all specs have required frontmatter
for spec in **/*.spec.md; do
  grep -q "^criticality: " "$spec" || echo "Missing: $spec"
  grep -q "^failure_mode: " "$spec" || echo "Missing: $spec"
done

# Check traceability chain completeness (if using)
for spec in **/*.spec.md; do
  # Extract constrained_by references
  REFS=$(sed -n '/^constrained_by:/,/^[a-z]/p' "$spec" | grep "^\s\s-")
  # Validate each reference exists
  for ref in $REFS; do
    [ -f "$ref" ] || echo "Broken reference: $spec -> $ref"
  done
done
```

## Lessons Learned

### What We'd Do Differently

**1. Fewer traceability fields earlier**
- Started with many fields (satisfies, supports, etc.)
- Found derives_from + constrained_by cover 90% of needs
- Recommendation: Start with 2-3 core fields, add only if proven necessary

**2. Document semantics clearly upfront**
- Initially ambiguous: derives_from vs satisfies (both point up dependency chain)
- Required clarification in patterns.spec.md
- Recommendation: MSL should provide clear semantics for each field

**3. Automated validation from day 1**
- Manual checking of frontmatter completeness was error-prone
- Automated tests caught missing fields immediately
- Recommendation: MSL should provide reference validation scripts

### What Worked Incredibly Well

**1. Minimalism discipline**
- criticality/failure_mode forces "is this CRITICAL?" question
- Reduced specs by ~70% compared to traditional documentation
- Every spec justifies its existence

**2. AI agent effectiveness**
- Clear structure enables AI parsing
- criticality field helps agents prioritize
- Traceability helps agents understand context

**3. Dogfooding validation**
- Using MSL to document MSL (via LiveSpec) proved viability
- Self-referential specs (metaspecs about specs) worked seamlessly
- Circularity possible and valuable

## Statistics Summary

**Project scale:**
- 51 specifications across methodology, metaspecs, and conventions
- 36+ deliverables (prompts, templates, docs)
- 100% MSL format compliance

**Field adoption:**
| Field | Count | Adoption | Recommendation |
|-------|-------|----------|----------------|
| criticality | 51/51 | 100% | ✅ Upstream (required) |
| failure_mode | 51/51 | 100% | ✅ Upstream (required) |
| constrained_by | 50/51 | 98% | ✅ Upstream (optional) |
| specifies | 23/51 | 45% | ⚠️ Consider (optional) |
| derives_from | 18/51 | 35% | ✅ Upstream (optional) |
| supports | 5/51 | 10% | ❌ Keep as extension |
| satisfies | 4/51 | 8% | ❌ Keep as extension |
| applies_to | 3/51 | 6% | ❌ Keep as extension |

**Validation:**
- 6 automated test scripts validate MSL compliance
- Tests run in CI/CD on every commit
- 100% pass rate (dogfooding enforces compliance)

## Contact

For questions or discussion about these recommendations:
- **LiveSpec Repository:** https://github.com/chrs-myrs/livespec
- **MSL Specification:** https://github.com/chrs-myrs/msl-specification
- **Issue Discussion:** Open issue on MSL repo referencing this feedback

We're happy to collaborate on upstreaming beneficial extensions and refining semantics for broader MSL community benefit.

---

**Document Version:** 1.0
**Last Updated:** 2025-10-07
**Feedback Status:** Submitted for MSL maintainer consideration
