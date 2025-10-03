# MSL Format Behavior

**Criticality**: CRITICAL
**Failure Mode**: Without MSL format, specifications bloat and become maintenance burdens

## Specification

All LiveSpec specifications follow MSL (Minimal Specification Language) format with exactly four sections: Criticality, Failure Mode, Specification, and Validation.

## Format

```markdown
# [Specification Name]

**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [What breaks if this requirement is not met]

## Specification
[Single sentence or paragraph describing the requirement]

## Validation
[How to verify this requirement is satisfied]
```

## Rules

1. **Criticality must be justified**: Only CRITICAL (system fails) or IMPORTANT (quality degrades) allowed
2. **Failure mode must be concrete**: Explain specifically what breaks
3. **Specification must be minimal**: Remove any word that doesn't change meaning
4. **Validation must be testable**: Describe observable criteria

## Validation

- All specifications contain exactly these four sections
- No "nice to have" or "should" requirements exist
- Every specification can answer: "Would the system fail without this?"
- Specifications are 70% smaller than traditional requirement documents
- AI agents understand requirements without ambiguity
