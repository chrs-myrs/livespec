---
applies_to:
  - all_projects
  - all_specifications
criticality: IMPORTANT
failure_mode: Inconsistent patterns make LiveSpec harder to understand and maintain
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
---

# LiveSpec Development Patterns

## Requirements
- LiveSpec follows strict patterns: MSL format for all specs (.spec.md extension with title, frontmatter, Requirements section), British English for user docs, phase-letter naming for prompts (0a-), one spec per behavior, workspace/strategy separation in folder structure, and YAML frontmatter declaring specification dependencies.
  - All .spec.md files pass MSL format validation
  - Documentation uses British spellings (synchronisation, behaviour)
  - Prompt files follow [0-4][a-z]-*.md pattern
  - Each behavior has single dedicated spec file
  - specs/workspace/ contains only portable development methodology
  - specs/2-strategy/ contains only product-specific technical decisions
  - Specifications declare dependencies via YAML frontmatter
  - Strategy files stay minimal (single file <100 lines, split files <50 lines each)
  - AGENTS.md references specs/workspace/workspace-agent.spec.md in frontmatter
  - Agent integration behaviors defined in specs/workspace/livespec.spec.md
  - Regeneration prompt exists at prompts/4-evolve/4d-regenerate-agents.md
  - Extracted specs use confidence markers when appropriate (LOW/MEDIUM confidence)
  - Extracted specs promoted to VALIDATED status after human review

## Pattern Areas (Detailed Specifications)

**Core patterns covered in depth by specialized specs:**

### Abstraction Layers Architecture
**See:** `specs/2-strategy/layer-definitions.spec.md` (257 lines)
- **CRITICAL**: Three abstraction layers (1-requirements/, 2-strategy/, 3-behaviors/) vs five phases (0-4)
- Layer characteristics (changeability, frontmatter, cross-references)
- Dual linkage pattern (satisfies requirements + guided-by strategy)
- Technology-agnostic requirements enabling rapid rebuild
- **Read this if confused about folder organization**

### Folder Organization
**See:** `specs/workspace/folder-organization.spec.md`
- Folder structure (workspace/, 1-requirements/, 2-strategy/, 3-behaviors/, 3-contracts/, knowledge/)
- Folder decision tests (workspace test, strategy test, behaviors test)
- Multi-domain organization (Software, Governance, Planning, Generation domains)
- Meta-process specs location
- Taxonomy as PRIMARY reference

### Third-Party Dependencies
**See:** `specs/workspace/third-party-dependencies.spec.md`
- Decision tree (when to specify vs reference)
- Location patterns (behaviors/integrations/, strategy/architecture.spec.md, constraints.spec.md)
- Integration with standard dependency management
- Examples (good and bad patterns)

### Distribution
**See:** `specs/workspace/distribution.spec.md`
- dist/ canonical source pattern
- Symlinks vs generated files
- Template architecture
- Reference Library pattern

### Generated Files
**See:** `specs/workspace/generated-files.spec.md`
- Standard generation markers (HTML, YAML, blockquote styles)
- Partial generation pattern
- Spec/doc relationship pattern
- Generated file lifecycle

### Cross-References
**See:** `specs/workspace/cross-references.spec.md`
- Dependency traceability (implements:, specifies:, governed-by:)
- Cross-reference update workflow
- Metaspec hierarchy
- Systematic update checklist

## Specification Patterns

### Spec Evolution - No Deprecated Specs

**One source of truth principle:**
- `specs/` contains ONLY current, active specs
- No `_old`, `_v2`, `_deprecated`, or `_backup` files
- No deprecated specs (delete them, git preserves history)
- No version numbers in filenames

**When spec changes:**
- Update spec file in place (git commit captures change)
- If renaming: `git mv` old spec, update all references, delete in same commit
- Git history is the version control system

**When spec becomes obsolete:**
- DELETE the spec file: `git rm specs/3-behaviors/old-spec.spec.md`
- Remove references from other specs
- Commit with clear explanation

**Rationale:** Multiple versions create risk of implementing from wrong spec, confusion about authority, and drift between versions.

### MSL Format
- All specs follow MSL (Markdown Specification Language) from github.com/chrs-myrs/msl-specification
- Required: Title and `## Requirements` section
- LiveSpec custom frontmatter: `criticality` (CRITICAL/IMPORTANT), `failure_mode`

### Naming Conventions
- Prompts: [0-4][a-z]-descriptive-name.md (e.g., 1a-design-architecture.md)
- Specs: descriptive-name.spec.md (matches prompt or behavior)
- British English for user documentation (synchronisation, behaviour)
- American English for code elements

## Documentation Patterns

### Architecture Documentation Pattern

When documenting architectural decisions, capture multiple dimensions to provide complete value proposition:

**Implementation Benefits** (developer experience):
- Code organisation clarity
- Developer productivity
- Maintainability approach
- Testing strategy
- Build/deployment patterns

**Strategic Benefits** (business value):
- Business value delivered
- Cost implications (reduction or investment)
- Risk reduction mechanisms
- Competitive advantages
- Technology flexibility
- Adoption drivers for stakeholders

**Why both matter:**
- Strategic benefits drive adoption (business case for decision-makers)
- Implementation benefits drive success (developer experience for practitioners)
- Documentation without strategic context misses business value
- Documentation without implementation detail lacks practical guidance

**Template for strategy/ specs:**
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

**When to document both:**
- Major architectural decisions (three-layer architecture, microservices approach)
- Technology selections with strategic implications (language, framework, platform)
- Process changes affecting business outcomes (CI/CD, deployment strategies)
- Design patterns enabling future flexibility (plugin architecture, event-driven design)

### Confidence Markers for Extracted Specifications

When extracting specs from code (Phase 4b), mark low-confidence extractions:

**Frontmatter metadata:**
- `extracted_from` - Source files (traceability)
- `extracted_date` - ISO timestamp (when extracted)
- `confidence` - LOW | MEDIUM (omit if HIGH)
- `requires_validation` - Boolean flag for review queue
- `extraction_reason` - Why low confidence (helps validation)

**Validation markers:**
- `[?]` - Criterion needs validation
- `[✓]` - Criterion validated
- `⚠️` - Entire spec flagged for review

**Lifecycle states:**
- EXTRACTED - Generated from code, needs validation
- REVIEWED - Human examined, corrections made
- VALIDATED - Promoted to standard spec (markers removed)

**Promotion:** When validated, remove extraction metadata, add standard frontmatter (derives_from, satisfies, etc.)

## Context Compression Patterns

**See:** `specs/workspace/context-compression.spec.md` (105 lines)
- **IMPORTANT**: Configurable structural force for guidance layer optimization
- Compression levels (light/moderate/aggressive) with characteristics
- Extract vs inline decision framework (when to template)
- Compression drives template extraction, AGENTS.md sizing, reference depth
- Relationship to MSL Minimalism (content vs structural optimization)
- Audit tool and migration path

**Key concept:** Context compression reorganizes HOW agents consume content (structural), while MSL Minimalism reduces WHAT is specified (content). Complementary forces.

## Validation
- All specs use MSL format (.spec.md extension)
- Documentation uses British English spellings
- Prompts follow phase-letter naming ([0-4][a-z]-*.md)
- One spec per behavior (no monolithic specs >200 lines without split)
- workspace/ contains portable methodology only
- Specifications declare dependencies via frontmatter
- Pattern detail specs exist and are referenced
- Context compression level declared and followed
- Extracted specs use confidence markers
