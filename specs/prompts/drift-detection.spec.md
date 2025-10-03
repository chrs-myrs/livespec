# Drift Detection Behavior

**Criticality**: CRITICAL
**Failure Mode**: Without drift detection, specifications become outdated and useless

## Specification

LiveSpec detects when code and specifications diverge semantically, classifies changes into resolution categories, and guides updates through AI-assisted workflows.

## Detection Approach

Drift detection uses semantic analysis (not text diff) to identify:
- **Refactoring**: Same behavior, different implementation → No spec change
- **Bug fixes**: Code was wrong → Update code or clarify spec
- **New features**: New behavior added → Extract new specs
- **Removed features**: Behavior deleted → Archive or remove specs
- **Modified behavior**: Requirements changed → Update relevant specs

## Resolution Categories

### Auto-Accept (70-80% of changes)
- Pure refactoring (behavior unchanged)
- Formatting and style changes
- Internal implementation details
- Non-breaking additions

### Review Needed (10-20% of changes)
- Behavior modifications
- Contract changes
- New requirements
- Breaking changes

### Manual Resolution (5-10% of changes)
- Conflicting requirements
- Ambiguous intent
- Critical system changes
- Multi-spec impacts

## Validation

- Semantic analysis tools (SemanticDiff, oasdiff) recommended in prompts
- Three-way merge thinking applied (base, code, spec)
- Contract testing validates API drift
- Test changes signal requirement changes
- AI agents classify changes accurately >80% of the time
- Human review focuses only on ambiguous cases
