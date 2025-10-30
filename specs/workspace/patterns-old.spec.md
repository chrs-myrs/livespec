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
- LiveSpec follows strict patterns: MSL format for all specs (.spec.md extension with four sections), British English for user docs, phase-letter naming for prompts (0a-), one spec per behavior, workspace/strategy separation in folder structure, and YAML frontmatter declaring specification dependencies.
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

## Folder Organization

**PRIMARY REFERENCE**: Each project's `specs/workspace/taxonomy.spec.md` defines project-specific classification. **AI agents check taxonomy FIRST**, then apply patterns below.

**Taxonomy declares**:
- **Project Domain**: Software, Generation, Planning, Documentation, Governance, or Hybrid
- **Workspace Scope**: Explicitly lists what's portable methodology vs product-specific
- **Specs Boundary**: "specs/ = specifications only" - no data/research/artifacts

### specs/workspace/ - Development Process (Portable)
**Contains:** How we develop ANY project using LiveSpec methodology

**Examples:**
- constitution.spec.md - Governance (MSL minimalism, dogfooding)
- patterns.spec.md - Conventions (naming, format, structure)
- workflows.spec.md - Process (when phases run, how to evolve)
- taxonomy.spec.md - Project classification (domain, scope, boundaries)

**Test:** "Could I copy this spec to a different project?" → YES = workspace

### specs/2-strategy/ - Technical Approach (Product-Specific)
**Contains:** How we solve THIS SPECIFIC problem technically

**Examples:**
- architecture.spec.md - System structure, components, approach
- [For complex projects, can split into]:
  - integration.spec.md - APIs, messaging, service communication
  - data.spec.md - Storage, caching, data flow
  - security.spec.md - Authentication, authorization, encryption
  - deployment.spec.md - Infrastructure, CI/CD, environments

**Test:** "Could I copy this spec to a different project?" → NO = strategy

**Scaling guidance:**
- Simple projects: Single `strategy/architecture.spec.md` file
- When architecture.spec.md exceeds ~100 lines: Split by concern
- Each strategy file stays minimal (<50 lines per MSL)

### specs/3-behaviors/ - Observable Outcomes
**Contains:** What the system must do (user-facing behaviors)

### specs/3-contracts/ - Interface Definitions
**Contains:** API contracts, data formats (YAML, JSON, OpenAPI)

### knowledge/ - Reference Material (Optional)
**Contains:** Integration notes, external documentation links, imported specs

**Purpose:** Consolidate reference material that doesn't belong in specifications

**Examples:**
- knowledge/integrations/auth0-notes.md - Integration discoveries, links to Auth0 docs
- knowledge/integrations/stripe-api.yaml - Imported OpenAPI spec (if needed for code generation)
- knowledge/research/ - Dependency evaluation research

**When to use:**
- Need to keep integration notes or research findings
- Want to import external OpenAPI specs for tooling
- External documentation scattered, need consolidated references

**Test:** "Is this information discoverable elsewhere?" → NO = knowledge/

**Note:** knowledge/ is NOT specifications - contains references, notes, imports. Not part of requirements.

## Third-Party Dependencies and External Integrations

**Core principle: Don't duplicate external documentation.** Reference Auth0 docs, don't copy them.

### Default Approach

Most third-party components don't need LiveSpec specifications:

**Standard dependency files:**
- package.json - npm packages, versions
- requirements.txt - Python dependencies
- go.mod - Go modules
- Gemfile - Ruby gems

**External documentation:**
- Link to Auth0 docs, not copy them
- Reference Stripe API, not duplicate it
- Point to AWS documentation

**Only specify when:**
- Integration behavior is non-obvious or critical
- Failure modes require handling
- Multiple components need shared understanding

### When Specifications ARE Needed

**Decision tree:**

```
Do you integrate with external service/library?
├─ Is it in standard dependency file? (package.json, requirements.txt)
│  └─ YES → Sufficient for most cases, no spec needed
│
├─ Is integration behavior obvious from external docs?
│  └─ YES → Just reference external docs, no spec needed
│
├─ Is integration behavior non-obvious or critical?
│  └─ YES → Create behavior spec in specs/3-behaviors/integrations/
│
├─ Does architecture need to justify dependency choice?
│  └─ YES → Mention in specs/2-strategy/architecture.spec.md (one line + link)
│
└─ Is dependency a critical constraint? (contractual, regulatory)
   └─ YES → Document in specs/1-requirements/strategic/constraints.spec.md
```

### Location Patterns

**specs/3-behaviors/integrations/** - Integration behaviors (rare)
- YOUR system's behavior when using external service
- Only if non-obvious, critical, or has failure modes
- Links to external documentation, doesn't duplicate it
- Example: specs/3-behaviors/integrations/auth0-authentication.spec.md

**specs/2-strategy/architecture.spec.md** - Major dependencies (common)
- One-line mention of significant dependencies
- Link to external documentation
- Example: "System uses Auth0 (https://auth0.com/docs) for authentication"

**specs/1-requirements/strategic/constraints.spec.md** - Critical dependency constraints (rare)
- Only if dependency is fundamental business constraint
- Example: "Must support Auth0 as identity provider" (contractual requirement)

**knowledge/integrations/** - Reference material (optional)
- Integration notes, discoveries, research
- Imported OpenAPI specs (if needed for code generation)
- Links to scattered external documentation
- NOT specifications, just reference material

### Examples

**✅ Good patterns:**

**Simple library usage** (no spec needed):
- Express.js web framework → package.json only, no spec
- Lodash utilities → package.json only, no spec
- AWS SDK → package.json + link in README, no spec

**External service with good docs** (mention in architecture):
```markdown
# specs/2-strategy/architecture.spec.md

## External Dependencies

- **Auth0** (https://auth0.com/docs) - User authentication, OAuth2/OIDC
- **Stripe** (https://stripe.com/docs/api) - Payment processing
- **AWS S3** (https://docs.aws.amazon.com/s3/) - File storage
```

**Complex integration needing behavior spec:**
```markdown
# specs/3-behaviors/integrations/stripe-webhook-processing.spec.md
---
criticality: IMPORTANT
failure_mode: Payment confirmations not processed, orders stuck
---

# Stripe Webhook Processing

## Requirements
- [!] System processes Stripe webhook events reliably
  - Validates webhook signatures
  - Handles idempotent processing
  - Retries failed webhooks with exponential backoff
  - References: https://stripe.com/docs/webhooks

## Validation
- Webhook signature validation prevents spoofing
- Duplicate events processed idempotently
- Failed processing retried up to 5 times
```

**Critical dependency constraint:**
```markdown
# specs/1-requirements/strategic/constraints.spec.md

## Requirements
- [!] System must support Auth0 as identity provider
  - Contractual requirement with enterprise customers
  - Cannot migrate to alternative IdP without customer approval
```

**❌ Bad patterns:**

**Duplicating external docs:**
```markdown
❌ specs/3-contracts/auth0-api.yaml
   (copying Auth0's entire API spec - just link to their docs)
```

**Specifying obvious integrations:**
```markdown
❌ specs/3-behaviors/logging-with-winston.spec.md
   (obvious library usage, no critical behaviors)
```

**Over-specifying implementation details:**
```markdown
❌ specs/3-behaviors/http-client-configuration.spec.md
   (implementation detail, not behavior)
```

### Integration with Standard Dependency Management

**Use existing tools:**
- package.json, requirements.txt, go.mod for versions
- Dependabot, Renovate for updates
- npm audit, pip check for vulnerabilities

**LiveSpec adds:**
- Architectural justification (why this dependency?)
- Integration behaviors (non-obvious system behaviors)
- Failure mode documentation (what breaks if dependency unavailable?)
- Links to external docs (consolidated references)

**Don't duplicate:**
- Version specifications (use package.json)
- API documentation (link to external docs)
- Library usage examples (use external tutorials)

## Distribution Pattern

### Canonical Source: dist/
- **dist/prompts/** - Canonical framework prompts (source of truth)
- **dist/templates/** - Canonical templates
- **dist/standard/** - MSL metaspecs and conventions
- **dist/guides/** - Usage guides

### Project Use: Symlinks + Generated
- **prompts/** - Symlinks to dist/prompts/* (easy access, no duplication)
- **prompts/generated/** - Project-specific generated prompts (committed)
  - Generated by: prompts/utils/generate-*.md
  - Examples: self-improve.md, internalise-learnings.md
  - Customized to project PURPOSE, principles, and spec structure
- **.livespec/** - Copied from dist/ on project setup (gitignored)

**Why symlinks:**
- Single source of truth (dist/ is canonical)
- No drift between prompts/ and dist/prompts/
- Updates to dist/ immediately visible in prompts/
- Clear separation: framework (symlinked) vs project-specific (generated/)

**Why generated prompts are committed:**
- Tailored to specific project context
- Reference actual PURPOSE.md and specs/
- Should be versioned with project
- Regenerated when project fundamentals change

### Template Architecture Pattern

**Purpose:** Reusable markdown content for consistent agent guidance

**When to Create Template:**
- Content reused across multiple generated files
- Key process/checklist needing consistent application
- Content requiring independent updates without prompt changes

**Template Structure:**
- **Location**: `.livespec/templates/{domain}/` (e.g., `agents/`, `workspace/`)
- **Format**: Complete standalone markdown (not fragment)
- **Naming**: Descriptive (e.g., `pre-implementation-verification.md`)

**Template Flow:**
1. **Templates provide** reusable content (`.livespec/templates/agents/*.md`)
2. **Specs reference** templates (e.g., "Include `.livespec/templates/agents/X.md`")
3. **Prompts insert** templates during generation (e.g., "Insert template in START section")
4. **Generated files** are products (e.g., AGENTS.md includes template content)
5. **Distribution** via `dist/templates/` (target projects receive templates)

**Example:** Agent verification templates
- `templates/agents/pre-implementation-verification.md` - Checklist before implementing
- Referenced by: `specs/workspace/workspace-agent.spec.md`
- Inserted by: `prompts/4-evolve/4d-regenerate-agents.md`
- Result: AGENTS.md includes verification in START section

**Benefits:**
- Explicit and manageable (not embedded in prompts)
- Independently updatable (change template, regenerate)
- Distributable (templates copy to target projects)

### Meta-Process Specs Location

**When specs govern creation of documentation (not system behavior):**

Place in `specs/3-behaviors/processes/[process].spec.md`

**Examples:**
- `specs/3-behaviors/processes/investigation.spec.md` - How to document investigations
- `specs/3-behaviors/processes/refactoring.spec.md` - How to document refactoring decisions
- `specs/3-behaviors/processes/incident.spec.md` - How to document production incidents

**Template:** Use `dist/templates/processes/meta-process.spec.md.template`

**Pattern:**
- Spec defines requirements for ALL instances
- Instances (e.g., `investigations/001-problem.md`) conform to spec
- Instances are governed documentation, not specs themselves

**See AGENTS.md "Meta-Process Specs Pattern" section for detailed guidance.**

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

**Example: Three-Layer Architecture (requirements/strategy/implementations)**

Implementation benefits:
- Clear separation of concerns (WHAT/HOW/EXACTLY)
- Testable requirements independent of implementation
- Traceability from requirements through to code
- Specification reuse across implementations

Strategic benefits:
- Rapid rebuild on different technology stacks (microservices flexibility)
- Technology evolution without specification rework (requirements persist)
- Cost reduction (no requirements rediscovery during replatforms)
- Strategic technology flexibility (switch stacks, keep business logic)
- Microservices pattern enablement (different services, different technologies, same requirements)

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

### Dependency Traceability

**Prompts use `implements:` to reference defining specifications:**
```yaml
---
implements: specs/3-behaviors/prompts/1a-design-architecture.spec.md
---
```

**Specs use `governed-by:` to reference constraining metaspecs:**
```yaml
---
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
---
```

**Other dependency fields for specs:**
- `derives-from:` - Parent specs this is based on
- `satisfies:` - Requirements this fulfills
- `supports:` - What this spec enables
- `applies_to:` - Scope (for workspace specs)

### Cross-Reference Update Pattern

When renaming or moving prompts or specs, use systematic checklist to maintain traceability:

**Files to update:**
- [ ] Source file renamed/moved (dist/prompts/ or specs/)
- [ ] Spec frontmatter (`specifies:` or `implements:` field)
- [ ] Registry entry (specs/3-behaviors/prompts/registry.spec.md)
- [ ] Navigation files (dist/prompts/utils/next-steps.md)
- [ ] Predecessor prompts ("Next Step" sections)
- [ ] Documentation references (AGENTS.md, guides)
- [ ] Validation run (prompts/utils/validate-project.md)

**Example: Renaming 0d-identify-constraints.md → 0f-identify-constraints.md**

Updated files:
- ✓ dist/prompts/0-define/0f-identify-constraints.md (renamed)
- ✓ specs/3-behaviors/prompts/0f-identify-constraints.spec.md (frontmatter: specifies:)
- ✓ specs/3-behaviors/prompts/registry.spec.md (table entry)
- ✓ dist/prompts/utils/next-steps.md (decision tree references)
- ✓ dist/prompts/0-define/0c-define-outcomes.md (next step reference)

**Why systematic approach matters:**
- Missing spec frontmatter breaks bidirectional linking
- Missing registry breaks prompt discovery
- Missing navigation breaks workflow guidance
- Validation catches errors before commit

### Metaspec Hierarchy

**Purpose:** Eliminate repetition through hierarchical abstraction (MSL minimalism)

**Hierarchy structure:**
```
base.spec.md (MSL + LiveSpec frontmatter)
  ↓ governs
behavior.spec.md (observable outcomes, validation)
  ↓ governs
prompt.spec.md (THIS - prompt structural requirements)
  ↓ governs
[individual prompt specs] (specific outcomes only)
```

**What metaspecs define:**
- **base.spec.md** - Core MSL format (title, frontmatter, Requirements section)
- **behavior.spec.md** - Observable outcomes pattern, validation criteria requirements
- **prompt.spec.md** - Prompt-specific structure (Context, Prerequisites, Task, Outputs with format specifications, Validation, Success Criteria, Error Handling, Constraints sections; optional Examples)

**What individual specs define:**
- Specific outcomes THIS prompt/behavior achieves
- Specific files created (with paths and format specifications)
- Specific prerequisites for THIS use case
- Specific validation criteria for THIS behavior
- Specific error handling for THIS prompt's failure scenarios
- Specific constraints for THIS prompt's scope
- Examples if pattern is complex (optional)

**Benefit:** Individual prompt specs focus on WHAT prompt achieves, not HOW prompt is structured. Structure inherited from metaspec.

**Example - Before metaspec (repetitive):**
```markdown
# Prompt Behavior: Setup Workspace

## Requirements
- [!] Prompt must have Context section explaining when to use
- [!] Prompt must have Prerequisites section listing what's needed
- [!] Prompt must have Task section with step-by-step guidance
- [!] Prompt must have Success Criteria defining quality
- [!] Prompt must have Error Handling for failures
- [!] Prompt must have Constraints defining scope
- [!] Prompt creates specs/workspace/constitution.spec.md
- [!] Prompt creates specs/workspace/patterns.spec.md
```

**Example - After metaspec (minimal):**
```markdown
---
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Prompt Behavior: Setup Workspace

## Requirements
- [!] Prompt guides creation of three workspace specifications.
  - Produces `specs/workspace/constitution.spec.md` with 3-5 principles
  - Produces `specs/workspace/patterns.spec.md` with conventions
  - Produces `specs/workspace/workflows.spec.md` with processes

(Context, Prerequisites, Task, Outputs, Validation, Success Criteria, Error Handling,
and Constraints sections all required by metaspec - no need to specify again)
```

**Location:** Metaspecs live in `.livespec/standard/metaspecs/` and distribute to target projects via `dist/standard/metaspecs/`.

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

**Example frontmatter:**
```yaml
---
extracted_from:
  - src/auth/oauth.py
  - src/auth/session.py
extracted_date: 2025-10-06
confidence: LOW
requires_validation: true
extraction_reason: "Inferred from implementation, no tests found"
---
```

**Promotion:** When validated, remove extraction metadata, add standard frontmatter (derives_from, satisfies, etc.)

## Context Compression Patterns

**Purpose:** Guidance layer optimization through configurable structural force

**Context compression** is an active force that reorganizes guidance layer (workspace/, AGENTS.md, templates/) for agent focus efficiency. Complements MSL Minimalism:
- **MSL Minimalism**: Content pressure (reduce within specs - WHAT/requirements)
- **Context Compression**: Structural force (reorganize across guidance - HOW agents consume)

### Compression Level Declaration

Projects declare compression level in workspace/constitution.spec.md frontmatter:

```yaml
---
context_compression: light | moderate | aggressive
---
```

**Default:** moderate (if unspecified)

### Compression Level Characteristics

**Light Compression** (verbose, exploratory):
- Inline examples in AGENTS.md
- Detailed explanations embedded
- Minimal extraction to templates
- Redundancy tolerated for clarity
- Good for: Large context agents, learning phase, infrequent usage

**Moderate Compression** (balanced - LiveSpec default):
- Strategic extraction of reusable content
- Critical workflows inline, details referenced
- Templates for repeated patterns
- Balanced inline/reference approach
- Good for: Most production work, standard agents

**Aggressive Compression** (dense, focused):
- Heavy extraction to templates
- Deep reference hierarchies
- Minimal inline examples (pattern only)
- Strict redundancy elimination
- Good for: Cost-sensitive, high-frequency usage, small context agents

### Extract vs Inline Decision Framework

**Always extract** (all compression levels):
- Content reused 3+ places
- Large example blocks (>50 lines)
- Generated content (maintain source of truth)

**Extract at Moderate+**:
- Detailed workflows (can reference from AGENTS.md)
- Extended examples (inline pattern, reference full)
- Verification checklists (template-ize for reuse)

**Extract at Aggressive only**:
- Explanatory content (keep rules, extract rationale)
- Nice-to-know vs need-to-know separation
- Context optimized for cache boundaries

### Compression Force Manifestation

Context compression **drives** decisions:
- Template extraction (when to create `.livespec/templates/agents/*.md`)
- AGENTS.md section sizing (how much detail inline vs referenced)
- Reference depth (direct vs hierarchical)
- Example placement (inline snippets vs separate files)
- Cache boundary optimization (what agents cache vs fetch)

### Audit and Migration

**Measure compression**: Use `.livespec/prompts/utils/audit-context-compression.md`
- Calculates extraction ratio, reference depth, example coverage
- Compares declared vs actual compression
- Identifies optimization opportunities

**Migrate compression level**:
1. Update `context_compression` in workspace/constitution.spec.md
2. Reorganize content (extract or inline based on new level)
3. Regenerate AGENTS.md: `.livespec/4-evolve/4d-regenerate-agents.md`
4. Validate structure matches new level

**Framework reference**: `.livespec/standard/conventions/context-compression.spec.md`

## Generated File Patterns

### Standard Generation Markers

**Purpose:** Identify files generated from sources to prevent direct edits and enforce source-of-truth discipline

**HTML comment style (for markdown files):**
```markdown
<!--
DO NOT EDIT: This file is generated

Sources:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md

Regeneration:
  Use: prompts/4-evolve/4d-regenerate-agents.md

Generated: 2025-10-12T10:30:00Z
Generator: livespec/prompts/4-evolve/4d-regenerate-agents.md
Version: 2.4.0
-->

# [Generated Content]
```

**YAML frontmatter style (for specs that generate other specs):**
```yaml
---
generated: 2025-10-12T10:30:00Z
generator: prompts/utils/generate-self-improvement.md
generated_from:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/1-requirements/strategic/outcomes.spec.md
---
```

**Blockquote warning style (for AGENTS.md and visible warnings):**
```markdown
---
generated: 2025-10-12T10:30:00Z
generator: livespec/prompts/4-evolve/4d-regenerate-agents.md
version: 2.4.0
note: Generated from PURPOSE.md and specs/workspace/ - to update, regenerate this file
---

> **⚠️ Generated File**: Do not edit directly. See frontmatter for regeneration instructions.

# [Generated Content]
```

**Purpose**: Combines YAML metadata with visible warning to prevent direct edits

**Use when**:
- File likely to be edited by agents following "evolve existing files" pattern
- YAML frontmatter alone insufficient (too subtle)
- Need visible prohibition early in file body
- Common for AGENTS.md, CLAUDE.md, project configuration files

**Required elements:**
- Clear "DO NOT EDIT" warning (or `generated:` field)
- Source file list (enables traceability)
- Regeneration instructions (path to prompt)
- Generation timestamp (ISO-8601 format)
- Generator identification (prompt or script path)
- Version (LiveSpec version used)

**Validation:** See `specs/3-behaviors/validation/generated-file-protection.spec.md` for enforcement

### Partial Generation Pattern

**Purpose:** Support files combining generated content with manual sections

**Use when:**
- File needs both framework content (generated) and project content (manual)
- Some sections regenerate frequently, others stay stable
- Template provides structure, user provides specifics

**Section markers:**
```markdown
<!--
PARTIALLY GENERATED: This file combines generated content with manual sections

Generated sections are marked with:
<!-- GENERATED SECTION START: [section-name] -->
...
<!-- GENERATED SECTION END: [section-name] -->

Manual sections are marked with:
<!-- MANUAL SECTION START: [section-name] -->
...
<!-- MANUAL SECTION END: [section-name] -->

DO NOT EDIT generated sections directly. Edit sources and regenerate.
Manual sections may be edited freely.
-->

# Document Title

<!-- GENERATED SECTION START: overview -->
This overview is generated from specs/workspace/constitution.spec.md
<!-- GENERATED SECTION END: overview -->

<!-- MANUAL SECTION START: project-specifics -->
Add project-specific details here - this section is not regenerated
<!-- MANUAL SECTION END: project-specifics -->

<!-- GENERATED SECTION START: workflow -->
Standard workflow generated from specs/workspace/workflows.spec.md
<!-- GENERATED SECTION END: workflow -->
```

**Rules:**
- Generated sections: Never edit directly, update sources and regenerate
- Manual sections: Edit freely, won't be overwritten
- Validation detects edits to generated sections (ERROR)
- Validation ignores edits to manual sections (allowed)

**Example files:**
- Project README with framework structure (generated) + project intro (manual)
- Documentation with standard sections (generated) + custom examples (manual)

### Spec/Doc Relationship Pattern

**Purpose:** Maintain bidirectional links between specifications and documentation

**Pattern:**
- Spec references doc: `specifies: docs/pathways/clt-formation.md`
- Doc references spec: `spec: specs/2-strategy/pathways/partnership/clt-formation.spec.md`

**Validation:**
- Spec → Doc (ERROR if doc doesn't exist)
- Doc → Spec (WARNING if backlink missing)
- See `specs/3-behaviors/validation/cross-reference-validation.spec.md`

**Example spec frontmatter:**
```yaml
---
specifies: docs/getting-started.md
derives-from: PURPOSE.md
---
```

**Example doc frontmatter:**
```yaml
---
spec: specs/3-behaviors/getting-started.spec.md
---
```

**Benefits:**
- Traceability (navigate between spec and doc)
- Validation catches broken relationships
- AI agents understand spec/doc connection

### Generated File Lifecycle

**Creation:**
1. Define behavior in `specs/3-behaviors/[feature].spec.md`
2. Create generation prompt in `prompts/utils/generate-[feature].md`
3. Run generation prompt to create output file
4. Output includes standard generation markers
5. Commit generated file (if project-specific) or gitignore (if reproducible)

**Regeneration:**
1. Update source specifications
2. Run generation prompt again
3. Validate immediately (Use `prompts/utils/validate-project.md`)
4. Commit updated generated file with sources

**Validation:**
1. Check generation timestamp vs file modification time
2. Check source file timestamps vs generation timestamp
3. Report direct edits (ERROR) or stale generation (WARNING)

**Common generated files:**
- `AGENTS.md` - Agent configuration (from `specs/workspace/*.spec.md` + `PURPOSE.md`)
- `CLAUDE.md` - Project instructions (from workspace specs)
- `prompts/generated/*.md` - Project-specific prompts (from PURPOSE + specs)
- Documentation (from specs via generation prompts)

**Best practices:**
- Commit project-specific generated files (customised to project)
- Gitignore reproducible generated files (can regenerate from sources)
- Always include standard markers (enables validation)
- Run validation after regeneration (catch errors early)
- Update sources, never edit generated files directly

### Reference Library Pattern

**Purpose**: Enable agents to navigate from AGENTS.md summary (80%) to deep detail (20%)

**Path convention**: Always use `.livespec/` prefix
- Works in livespec repo (`.livespec` → symlink to `dist/`)
- Works in target projects (`.livespec/` copied from `dist/`)
- Consistent across all environments

**Structure**:
- **Categories**: Conventions (how to structure), Metaspecs (spec types), Guides (how to apply)
- **Entry format**:
  - **Fetch when**: Action-oriented trigger conditions
  - **Provides**: What detail this reference contains
  - **Cross-ref**: Where in AGENTS.md this topic is summarized

**Example**:
```markdown
**Context Compression** - `.livespec/standard/conventions/context-compression.spec.md`
- **Fetch when**: Deciding inline vs extract, optimizing AGENTS.md size
- **Provides**: Full compression framework, decision criteria, extraction patterns
- **Cross-ref**: See "Context Compression" section for summary
```

**Location**: MIDDLE or END section of AGENTS.md (detailed navigation, not critical rules)

**Integration**: Cross-reference from AGENTS.md summary sections
```markdown
## Context Compression
[Brief summary]

**Framework reference**: See Reference Library: `context-compression.spec.md`
```

**Validation**:
- All `.livespec/` paths work in both livespec repo and target projects
- "Fetch when" conditions are action-oriented (not passive descriptions)
- Cross-references bidirectional (AGENTS.md ↔ Reference Library)
- Categories logical (Conventions, Metaspecs, Guides)
