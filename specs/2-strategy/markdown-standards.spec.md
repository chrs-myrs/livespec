---
guided-by:
  - specs/workspace/constitution.spec.md
criticality: IMPORTANT
failure_mode: Without consistent markdown standards, specifications become harder to understand and maintain, reducing AI discoverability
---

# LiveSpec Markdown and Documentation Standards

## Requirements
- [!] All LiveSpec documentation follows MSL (Markdown Specification Language) format with consistent patterns for architecture documentation and extraction confidence markers.
  - All .spec.md files follow MSL format (title, frontmatter with criticality/failure_mode, Requirements section)
  - MSL specification sourced from github.com/chrs-myrs/msl-specification
  - British English used for user documentation (synchronisation, behaviour, optimise)
  - American English used for code elements and technical terms
  - Strategy specs document both implementation benefits (developer experience) and strategic benefits (business value)
  - Extracted specs use confidence markers (LOW/MEDIUM/HIGH confidence) with validation workflow
  - All specs use .spec.md extension
  - Frontmatter uses YAML format

## Architecture Documentation Pattern

When documenting architectural decisions in specs/2-strategy/, capture multiple dimensions to provide complete value proposition:

### Implementation Benefits (Developer Experience)

Document how the decision improves:
- Code organisation clarity
- Developer productivity
- Maintainability approach
- Testing strategy
- Build/deployment patterns

### Strategic Benefits (Business Value)

Document business impact:
- Business value delivered
- Cost implications (reduction or investment)
- Risk reduction mechanisms
- Competitive advantages
- Technology flexibility
- Adoption drivers for stakeholders

### Why Both Matter

- **Strategic benefits drive adoption** - Provides business case for decision-makers
- **Implementation benefits drive success** - Ensures positive developer experience for practitioners
- **Documentation without strategic context** - Misses business value articulation
- **Documentation without implementation detail** - Lacks practical guidance

### Template for Strategy Specs

```markdown
# [Architecture Decision]

## Implementation Benefits
- [How this improves development experience]
- [How this aids maintainability]
- [How this supports testing]

## Strategic Benefits
- [Business value delivered]
- [Cost/risk implications]
- [Competitive advantages]
- [Technology flexibility enabled]

## Requirements
- [Specific architectural requirements]
```

### When to Document Both Dimensions

Use this pattern for:
- Major architectural decisions (three-layer architecture, microservices approach)
- Technology selections with strategic implications (language, framework, platform)
- Process changes affecting business outcomes (CI/CD, deployment strategies)
- Design patterns enabling future flexibility (plugin architecture, event-driven design)

## Confidence Markers for Extracted Specifications

When extracting specs from code (Phase 4b), mark low-confidence extractions to flag for validation.

### Frontmatter Metadata

```yaml
---
extracted_from:
  - src/module/component.ts  # Source files (traceability)
extracted_date: 2025-01-17T10:30:00Z  # ISO timestamp
confidence: LOW | MEDIUM  # Omit if HIGH confidence
requires_validation: true  # Boolean flag for review queue
extraction_reason: "Inferred from implementation patterns, not documented requirements"
---
```

### Inline Validation Markers

- `[?]` - Criterion needs validation (uncertain if requirement exists)
- `[✓]` - Criterion validated (confirmed as actual requirement)
- `⚠️` - Entire spec flagged for review (significant uncertainty)

### Lifecycle States

1. **EXTRACTED** - Generated from code, needs validation
2. **REVIEWED** - Human examined, corrections made
3. **VALIDATED** - Promoted to standard spec (markers removed)

### Promotion Workflow

When validated:
1. Remove extraction metadata (extracted_from, extracted_date, confidence, etc.)
2. Add standard frontmatter (derives-from, satisfies, guided-by)
3. Remove inline markers ([?], ⚠️)
4. Keep [✓] markers if they add value, otherwise remove

## MSL Format Structure

All specs follow MSL structure:

```markdown
---
[frontmatter fields]
---

# [Spec Title]

## Requirements
- [!] [Primary requirement]
  - [Testable criterion 1]
  - [Testable criterion 2]
```

### Required Frontmatter Fields

- `criticality`: CRITICAL | IMPORTANT
- `failure_mode`: What breaks without this spec

### Optional Frontmatter Fields

- `derives-from`: Parent specs this derives from
- `governed-by`: Meta-specs governing this spec
- `satisfies`: Requirements this fulfills
- `guided-by`: Strategies guiding implementation
- `supports`: What this spec enables
- `applies_to`: Scope (for workspace specs)

## Validation

- All .spec.md files pass MSL format validation
- Documentation uses British English spellings
- Code elements use American English
- Strategy specs include both implementation and strategic benefits when applicable
- Extracted specs use confidence markers appropriately
- Promoted specs remove extraction metadata
