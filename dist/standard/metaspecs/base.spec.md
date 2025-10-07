---
criticality: CRITICAL
failure_mode: Without base requirements, LiveSpec specs lack essential metadata and consistency
derives_from:
  - https://github.com/chrs-myrs/msl-specification
---

# Base LiveSpec Specification Requirements

## Requirements
- [!] All LiveSpec specifications use MSL (Markdown Specification Language) L1+ with LiveSpec-specific frontmatter extensions for governance framework use.
  - Spec follows MSL L1+ format (title, YAML frontmatter, `## Requirements` section, optional sections)
  - Spec has YAML frontmatter with `criticality` field (CRITICAL or IMPORTANT)
  - Spec has YAML frontmatter with `failure_mode` field (concrete failure description)
  - Criticality CRITICAL means system fails without this (breaks, unusable, unsafe)
  - Criticality IMPORTANT means system works but quality degrades significantly
  - Failure mode describes specifically what breaks (not vague)
  - Requirements use `[!]` marker for CRITICAL items at requirement level
  - File uses `.spec.md` extension

## Notes

### LiveSpec Extensions for Governance Frameworks

LiveSpec is a **governance framework** where all specifications are policy documents about methodology itself. This specialized domain requires document-level metadata that complements MSL's requirement-level `[!]` markers.

**LiveSpec adds to MSL L1+ frontmatter:**

```yaml
---
criticality: CRITICAL | IMPORTANT       # Document-level priority
failure_mode: [Concrete description]    # Document-level impact
# Plus standard MSL L1 fields: id, extends, tags, etc.
---

## Requirements
- [!] Critical requirement                # Requirement-level priority (MSL L2)
- Regular requirement
```

**Relationship between document and requirement priority:**
- **Document-level** (`criticality:`): Framework-level prioritization (which policy specs to evolve first)
- **Requirement-level** (`[!]`): Individual requirement criticality (which requirements cannot be skipped)
- These complement each other in governance contexts; not redundant

**Why LiveSpec uses both:**
- **Filtering**: 50+ policy documents need organization by importance
- **AI context**: Agents prioritize which specs to update during framework evolution
- **Governance metadata**: Document-level impact analysis for framework changes

**When NOT to use this pattern:**
- Application code specifications (use MSL [!] markers only)
- Simple projects (<20 specs)
- Non-governance use cases

**MSL Foundation:**

For MSL L0-L2 specification details, see: https://github.com/chrs-myrs/msl-specification

LiveSpec uses MSL L1+ (optional frontmatter) with domain-specific extensions documented in MSL-FEEDBACK.md. These extensions work for governance frameworks but are not universal MSL recommendations.

All LiveSpec metaspecs, convention specs, and project specs follow this pattern.
