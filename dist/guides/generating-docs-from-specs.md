# Generating User-Facing Documentation from Specs

**Purpose**: Show how workspace specs (pointers) reference strategy specs (content) to generate user-facing development documentation.

**Pattern**: Workspace → Strategy → Generated Docs

---

## The Pattern

```
specs/workspace/patterns.spec.md (pointer)
  ↓ references
specs/2-strategy/markdown-standards.spec.md (content)
  ↓ generates
DEVELOPMENT.md (user-facing docs)
```

**Key insight**: Workspace specs define WHAT to include in docs, strategy specs provide the CONTENT, generated docs make it readable for humans.

---

## Example: Generating DEVELOPMENT.md

### Step 1: Identify Strategy Specs Referenced by Workspace

From `specs/workspace/patterns.spec.md`:
```markdown
## Cross-Cutting Development Standards (Strategy References)

- **Markdown and Documentation Standards**: See specs/2-strategy/markdown-standards.spec.md
- **Testing Approach**: See specs/2-strategy/testing-approach.spec.md
```

These references tell us what to include in DEVELOPMENT.md.

### Step 2: Extract User-Friendly Content from Strategy Specs

**From `specs/2-strategy/markdown-standards.spec.md`**:
```markdown
# In DEVELOPMENT.md

## Documentation Standards

### MSL Format
All specifications follow MSL (Markdown Specification Language):
- Title and ## Requirements section required
- YAML frontmatter with criticality and failure_mode
- British English for user docs, American English for code

### Architecture Documentation Pattern
When documenting architectural decisions, include:
- **Implementation Benefits**: Developer experience improvements
- **Strategic Benefits**: Business value and cost implications

[See specs/2-strategy/markdown-standards.spec.md for complete details]
```

**From `specs/2-strategy/testing-approach.spec.md`**:
```markdown
# In DEVELOPMENT.md

## Testing Approach

### TDD Workflow
We follow Test-Driven Development:
1. **RED**: Write failing test first
2. **GREEN**: Make test pass with minimal code
3. **REFACTOR**: Improve design while keeping tests passing

### When TDD Applies
- Required: Bash scripts, complex logic, data transformations
- Escape hatch: Trivial scripts (document justification)

[See specs/2-strategy/testing-approach.spec.md for complete details]
```

### Step 3: Combine into User-Facing DEVELOPMENT.md

```markdown
# Development Guide

This document provides guidelines for contributing to this project. For complete specifications, see specs/2-strategy/.

## Documentation Standards

### MSL Format
All specifications follow MSL (Markdown Specification Language):
- Title and ## Requirements section required
- YAML frontmatter with criticality and failure_mode
- British English for user docs, American English for code

### Architecture Documentation
When documenting architectural decisions, include both:
- **Implementation Benefits**: How this improves developer experience
- **Strategic Benefits**: Business value and cost implications

**Complete spec**: [specs/2-strategy/markdown-standards.spec.md](../specs/2-strategy/markdown-standards.spec.md)

## Testing Approach

### TDD Workflow
We follow Test-Driven Development with Red-Green-Refactor cycle:

1. **RED**: Write failing test that defines expected behavior
2. **GREEN**: Implement minimal code to make test pass
3. **REFACTOR**: Improve design while keeping tests passing

### When to Use TDD
- ✅ Required for: Bash scripts, complex logic, data transformations
- ⚠️ Escape hatch: Trivial operations (document justification)

**Complete spec**: [specs/2-strategy/testing-approach.spec.md](../specs/2-strategy/testing-approach.spec.md)

## Coding Standards

[Generated from specs/2-strategy/coding-standards.spec.md if it exists]

---

*This document summarizes development standards. For authoritative requirements, see strategy specs.*
```

---

## Automation Pattern

### Using AI to Generate Docs

**Prompt**:
```
Generate DEVELOPMENT.md from strategy specs:

1. Read specs/workspace/patterns.spec.md to identify strategy references
2. For each referenced spec in specs/2-strategy/:
   - Extract user-friendly summaries
   - Convert technical requirements to guidelines
   - Add links back to authoritative specs
3. Write DEVELOPMENT.md with clear structure
4. Add disclaimer linking to specs/ as authoritative source
```

### Using Script to Generate Docs

```bash
#!/bin/bash
# scripts/generate-development-docs.sh

# Extract strategy references from workspace
STRATEGY_REFS=$(grep -oP 'specs/2-strategy/[\w-]+\.spec\.md' specs/workspace/patterns.spec.md)

# Start DEVELOPMENT.md
cat > DEVELOPMENT.md <<'EOF'
# Development Guide

This document provides guidelines for contributing to this project.
For authoritative requirements, see specs/2-strategy/.

---
EOF

# For each referenced strategy spec, extract user-friendly section
for SPEC in $STRATEGY_REFS; do
  # Extract spec title and create section
  TITLE=$(grep -m1 "^# " "$SPEC" | sed 's/^# //')

  echo "## $TITLE" >> DEVELOPMENT.md
  echo "" >> DEVELOPMENT.md

  # Extract requirements as guidelines (simplified)
  # ... (custom logic to convert spec requirements to user-friendly text)

  # Link to authoritative spec
  echo "**Complete spec**: [$SPEC]($SPEC)" >> DEVELOPMENT.md
  echo "" >> DEVELOPMENT.md
done

# Add footer
cat >> DEVELOPMENT.md <<'EOF'

---

*This document summarizes development standards. For authoritative requirements, see strategy specs in specs/2-strategy/.*
EOF
```

---

## Benefits of This Pattern

### 1. Single Source of Truth
- **Strategy specs** are authoritative (what agents follow)
- **DEVELOPMENT.md** is generated (what humans read)
- No duplication, no drift

### 2. Workspace as Curator
- `patterns.spec.md` decides WHAT standards to include
- References point to WHERE standards are defined
- Generated docs make them accessible

### 3. Flexible Generation
- Update strategy spec → Regenerate docs
- Add new strategy spec → Add reference in patterns → Regenerate
- Different audiences → Different generated docs from same specs

### 4. Clear Ownership
- Workspace specs: Define what to include (meta-structural)
- Strategy specs: Define the content (cross-cutting standards)
- Generated docs: Present content for humans

---

## Related Patterns

### AGENTS.md Generation
Similar pattern for AI agent context:
- `specs/workspace/workspace-agent.spec.md` defines structure
- References strategy specs for cross-cutting standards
- `prompts/4-evolve/4d-regenerate-context.md` generates AGENTS.md

### README.md Generation
Could generate README from:
- PURPOSE.md (vision)
- specs/1-requirements/strategic/outcomes.spec.md (what it does)
- Quick start sections from workspace specs

---

## When to Generate vs Handwrite

### Generate when:
- ✅ Content exists in specs (avoid duplication)
- ✅ Multiple audiences need different views of same content
- ✅ Docs need frequent regeneration (specs change often)
- ✅ Consistent format/structure required

### Handwrite when:
- ✅ Content is narrative (tutorials, explanations, examples)
- ✅ Audience-specific context needed (onboarding, FAQs)
- ✅ Content doesn't map to specs (community guidelines, history)

---

## Example Use Cases

### 1. Contributing Guidelines
- **Source**: specs/2-strategy/testing-approach.spec.md, specs/2-strategy/coding-standards.spec.md
- **Generate**: CONTRIBUTING.md with TDD workflow, coding standards, PR process
- **Why**: Keeps contributors' guide synchronized with actual requirements

### 2. Architecture Documentation
- **Source**: specs/2-strategy/architecture.spec.md, specs/2-strategy/layer-definitions.spec.md
- **Generate**: docs/architecture/README.md with system structure, layers, patterns
- **Why**: Architecture docs stay current with strategic decisions

### 3. API Style Guide
- **Source**: specs/2-strategy/api-design.spec.md, specs/3-contracts/api/
- **Generate**: docs/api-style-guide.md with conventions, patterns, examples
- **Why**: API guidelines match actual API contracts

---

## Summary

**The Pattern**:
1. Workspace specs POINT to what standards exist (references)
2. Strategy specs CONTAIN the standards (content)
3. Generation scripts CREATE user-facing docs (presentation)

**The Flow**:
```
workspace/patterns.spec.md (curator)
  → references → 2-strategy/*.spec.md (authority)
  → generates → DEVELOPMENT.md (readability)
```

**The Benefit**: Single source of truth with multiple presentations for different audiences (AI agents read specs, humans read generated docs).
