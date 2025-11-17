---
applies_to:
  - all_projects
  - all_specifications
criticality: IMPORTANT
failure_mode: Without compression strategy, AGENTS.md bloats, context budget wasted, agent efficiency decreases
governed-by:
  - .livespec/standard/metaspecs/workspace.spec.md
derives-from:
  - specs/workspace/constitution.spec.md
---

# Context Compression Strategy

## Requirements
- [!] LiveSpec projects declare and follow context compression level (light/moderate/aggressive), reorganizing guidance layer (workspace/, AGENTS.md, templates/) for agent focus efficiency through configurable structural force that complements MSL Minimalism.
  - Projects declare compression level in workspace/constitution.spec.md frontmatter
  - Light compression: Verbose, inline examples, minimal extraction (exploratory/learning)
  - Moderate compression: Balanced inline/reference, strategic extraction (production default)
  - Aggressive compression: Dense, heavy extraction, deep references (cost-sensitive)
  - Extract vs inline decision framework guides content placement
  - Compression drives template extraction, AGENTS.md sizing, reference depth
  - Audit tool measures declared vs actual compression alignment
  - Migration path for changing compression levels
  - Framework reference in `.livespec/standard/conventions/context-compression.spec.md`

## Compression Level Characteristics

### Light Compression (Verbose, Exploratory)

**When to use:**
- Large context agents (200K+ token windows)
- Learning phase (users/agents exploring methodology)
- Infrequent usage (not optimizing for speed)

**Characteristics:**
- Inline examples in AGENTS.md
- Detailed explanations embedded
- Minimal extraction to templates
- Redundancy tolerated for clarity

### Moderate Compression (Balanced - Default)

**When to use:**
- Most production work
- Standard agents (100-200K token windows)
- Regular usage patterns

**Characteristics:**
- Strategic extraction of reusable content
- Critical workflows inline, details referenced
- Templates for repeated patterns
- Balanced inline/reference approach

### Aggressive Compression (Dense, Focused)

**When to use:**
- Cost-sensitive environments
- High-frequency usage (agents called constantly)
- Small context agents (<100K token windows)

**Characteristics:**
- Heavy extraction to templates
- Deep reference hierarchies
- Minimal inline examples (pattern only)
- Strict redundancy elimination

## Extract vs Inline Decision Framework

### Always Extract (All Compression Levels)

- Content reused 3+ places
- Large example blocks (>50 lines)
- Generated content (maintain source of truth)

### Extract at Moderate+ Only

- Detailed workflows (can reference from AGENTS.md)
- Extended examples (inline pattern, reference full)
- Verification checklists (template-ize for reuse)

### Extract at Aggressive Only

- Explanatory content (keep rules, extract rationale)
- Nice-to-know vs need-to-know separation
- Context optimized for cache boundaries

## Compression Force Manifestation

Context compression **actively drives** these decisions:

**Template Extraction:**
- When to create `.livespec/templates/agents/*.md`
- What content belongs in templates vs inline
- Template granularity and reuse patterns

**AGENTS.md Section Sizing:**
- How much detail inline vs referenced
- Section length targets
- Balance of completeness vs conciseness

**Reference Depth:**
- Direct references (AGENTS.md → template)
- Hierarchical references (AGENTS.md → spec → template)
- Cache boundary optimization

**Example Placement:**
- Inline snippets (critical patterns)
- Separate files (detailed examples)
- Referenced external docs

**Cache Strategy:**
- What agents cache (frequently used content)
- What agents fetch (rarely used detail)
- Cache size optimization

## Audit and Migration

### Measuring Compression

**Use:** `.livespec/prompts/utils/audit-context-compression.md`

**Metrics:**
- Extraction ratio (template lines / total guidance lines)
- Reference depth (average hops to reach information)
- Example coverage (% of concepts with inline examples)
- AGENTS.md size vs target

**Comparison:**
- Declared compression level (in constitution.spec.md)
- Actual compression level (calculated from metrics)
- Alignment assessment (match/mismatch)

### Migrating Compression Levels

**Process:**
1. Update `context_compression` in workspace/constitution.spec.md
2. Reorganize content:
   - **To higher compression:** Extract items to templates, update references
   - **To lower compression:** Inline templates, remove unnecessary references
3. Regenerate AGENTS.md: `.livespec/4-evolve/4d-regenerate-context.md`
4. Validate structure matches new declared level
5. Monitor next 5 sessions for effectiveness

## Relationship to MSL Minimalism

**Context Compression ≠ MSL Minimalism**

These are complementary forces:

**MSL Minimalism** (content pressure):
- Applies **within** specs
- Reduces **WHAT** (requirements) to essentials
- Removes non-essential requirements
- Four essential questions framework

**Context Compression** (structural force):
- Applies **across** guidance layer
- Reorganizes **HOW** agents consume content
- Extracts vs inlines based on usage patterns
- Extract vs inline decision framework

**Example:**
- MSL Minimalism: Reduce requirement from 5 criteria to 2 essential ones
- Context Compression: Extract those 2 criteria to template if used 3+ times

## Validation
- Compression level declared in workspace/constitution.spec.md frontmatter
- Level appropriate for project usage patterns and agent capabilities
- Extraction/inline decisions follow framework for declared level
- AGENTS.md size within target for compression level (light: any, moderate: <100KB, aggressive: <50KB)
- Audit tool available at `.livespec/prompts/utils/audit-context-compression.md`
- Migration path documented and tested
- Framework reference exists at `.livespec/standard/conventions/context-compression.spec.md`
