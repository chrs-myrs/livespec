---
criticality: CRITICAL
failure_mode: Without base requirements, LiveSpec specs lack essential metadata and consistency
derives_from:
  - https://github.com/chrs-myrs/msl-specification
---

# Base LiveSpec Specification Requirements

## Requirements
- [!] All LiveSpec specifications extend MSL (Markdown Specification Language) with two required frontmatter fields.
  - Spec follows MSL format (title, `## Requirements` section, optional sections)
  - Spec has YAML frontmatter with `criticality` field (CRITICAL or IMPORTANT)
  - Spec has YAML frontmatter with `failure_mode` field (concrete failure description)
  - Criticality CRITICAL means system fails without this (breaks, unusable, unsafe)
  - Criticality IMPORTANT means system works but quality degrades significantly
  - Failure mode describes specifically what breaks (not vague)
  - Requirements use `[!]` marker for CRITICAL items
  - File uses `.spec.md` extension

## Notes

**LiveSpec extends MSL with:**

```yaml
---
criticality: CRITICAL | IMPORTANT
failure_mode: [Concrete description of what breaks]
---
```

These fields enable:
- **Prioritization**: CRITICAL vs IMPORTANT guides implementation order
- **Impact analysis**: Failure modes explain consequences of non-compliance
- **Minimalism enforcement**: "Would system fail without this?" validation

For MSL format details, see: https://github.com/chrs-myrs/msl-specification

All LiveSpec metaspecs, convention specs, and target project specs must follow this base format.
