# LiveSpec Development Patterns

**Criticality**: IMPORTANT
**Failure Mode**: Inconsistent patterns make LiveSpec harder to understand and maintain

## Specification

LiveSpec follows strict patterns: MSL format for all specs (.spec.md extension with four sections), British English for user docs, phase-letter naming for prompts (0a-), one spec per behavior, workspace/product separation in folder structure, and YAML frontmatter declaring specification dependencies.

## Validation

- All .spec.md files pass MSL format validation
- Documentation uses British spellings (synchronisation, behaviour)
- Prompt files follow [0-4][a-z]-*.md pattern
- Each behavior has single dedicated spec file
- specs/workspace/ contains only development methodology
- Specifications declare dependencies via YAML frontmatter (`derives_from`, `constrained_by`, `satisfies`, `supports`, `applies_to`)
