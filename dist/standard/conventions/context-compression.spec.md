---
criticality: IMPORTANT
failure_mode: Without context compression guidance, projects produce inefficient agent guidance that either overwhelms with detail or lacks necessary structure
governed-by:
  - .livespec/standard/metaspecs/convention.spec.md
applies_to:
  - workspace/constitution.spec.md
  - AGENTS.md
  - templates/agents/
---

# Context Compression

**Part of**: Context Tree (optimizes LiveSpec methodology consumption, NOT your project's specs)

## Requirements
- [!] LiveSpec projects apply context compression force to optimize agent guidance efficiency
  - **What it is**: Active force that reorganizes guidance layer (workspace/, AGENTS.md, templates) for agent focus and processing efficiency
  - **Relationship to Value Structure**: MSL Minimalism optimizes Value Structure (content within YOUR specs), Context Compression optimizes Context Tree (structure across LiveSpec docs)
  - **Three compression levels**: Light (verbose, exploratory), Moderate (balanced, default), Aggressive (dense, focused)
  - **Configurable**: Projects declare compression level in workspace/constitution.spec.md frontmatter (`context_compression: light | moderate | aggressive`)
  - **Default**: Moderate if unspecified
- [!] Compression level determines extraction and layering strategy
  - Light: Inline examples, detailed explanations, minimal extraction
  - Moderate: Strategic extraction of reusable content, balanced inline/reference
  - Aggressive: Heavy extraction to templates, deep reference hierarchies, cache optimization
- [!] Decision framework guides extract-vs-inline choices
  - **Always extract** (all levels): Content reused 3+ places, large examples (>50 lines), generated content
  - **Extract at Moderate+**: Detailed workflows, extended examples (inline pattern, reference full), verification checklists
  - **Extract at Aggressive**: Explanatory content (keep rules, extract rationale), nice-to-know content, cache-optimized boundaries
- [!] Force manifests through structural decisions
  - Template extraction (when to create templates/agents/ files)
  - AGENTS.md section sizing (how much detail inline vs referenced)
  - Reference depth in workspace specs (direct vs hierarchical)
  - Example placement (inline snippets vs separate files)
  - Cache boundary optimization (what agents cache vs fetch)

## Validation
- Projects declare compression level in workspace/constitution.spec.md
- AGENTS.md structure matches declared compression level
- Extraction decisions align with compression framework
- Audit utility can measure actual vs declared compression
- Different compression levels produce measurably different guidance structures

## Compression Level Characteristics

### Light Compression
**Purpose**: Verbose, self-contained guidance for exploratory work or learning phases

**Structure**:
- Inline examples in AGENTS.md (show complete patterns)
- Detailed explanations embedded directly
- Minimal extraction to templates
- Redundancy tolerated for clarity
- Few external references

**Good for**:
- Large context window agents (Claude Opus, GPT-4)
- Exploratory or learning phases
- Projects with infrequent agent interactions
- Teams learning LiveSpec methodology

### Moderate Compression (Default)
**Purpose**: Balanced focus and completeness for production work

**Structure**:
- Strategic extraction of reusable content
- Templates for repeated verification patterns
- Reference hierarchies for complex topics
- Inline critical paths, reference details
- Balance redundancy vs efficiency

**Good for**:
- Most production work
- Claude Sonnet, standard agents
- Balanced focus/completeness needs
- Established LiveSpec projects

### Aggressive Compression
**Purpose**: Maximum focus and efficiency for cost-sensitive or high-frequency usage

**Structure**:
- Heavy content extraction to templates
- Deep reference hierarchies
- Optimized cache boundaries
- Minimal inline examples (pattern only, reference full)
- Strict redundancy elimination
- Nice-to-know content externalized

**Good for**:
- Cost-sensitive contexts (high token costs)
- High-frequency agent usage
- Smaller context window agents
- Well-established patterns (agents know methodology)

## Force vs Principle Distinction

**Context Compression is a force**, not just a configuration:
- **Active**: Drives ongoing reorganization decisions
- **Dynamic**: Pressure varies by compression level
- **Generative**: Creates structure through extraction/layering
- **Complementary**: Works with MSL Minimalism orthogonally

**MSL Minimalism is content reduction** (within specs):
- Would system fail without this requirement?
- Specify WHAT not HOW
- Trust implementers

**Context Compression is structural optimization** (across guidance):
- Can agent focus without this inline?
- Extract reusable patterns
- Optimize cache boundaries
- Trust references

## Usage Patterns

### During Project Setup
Use `.livespec/0-define/0a-setup-workspace.md`:
1. Ask about primary agent(s) and context capabilities
2. Ask about usage pattern (exploratory vs production)
3. Recommend compression level based on answers
4. Document in workspace/constitution.spec.md

### During Development
Context compression force influences:
- When to extract verification checklist to template
- Whether to inline example or reference separate file
- How much detail in AGENTS.md vs referenced prompts
- Cache boundary decisions (what to load once vs repeatedly)

### During Evolution
Use `.livespec/prompts/utils/audit-context-compression.md`:
- Measure actual compression (extraction ratio, reference depth)
- Compare to declared level
- Identify optimization opportunities
- Migrate between compression levels if needed

## Integration with LiveSpec Phases

**Phase 0 (DEFINE)**: Declare compression level during workspace setup
**Phase 1-3**: Apply compression force during spec/prompt creation
**Phase 4 (EVOLVE)**: Audit and optimize compression regularly

## Measuring Compression

### Extraction Ratio Calculation

**Formula**:
```
Extraction Ratio = (Content Extracted / Total Content) × 100%
```

**What to measure**:
- **Total Content**: Lines in uncompressed form (e.g., Forgewick PURPOSE.md: 174 lines)
- **Content Extracted**: Details moved to referenced specs (e.g., 160 lines → `specs/`)
- **Content Inline**: Remaining in primary file (e.g., PURPOSE.md: 14 lines)

**Example (slackward project)**:
```
Before (Forgewick PURPOSE.md): 174 lines
- 6 key principles with full explanations
- Extensive success criteria
- Technical implementation notes
- Constraints and boundaries

After (LiveSpec PURPOSE.md): 14 lines
- 2 sections: "Why Exists" + "Success Looks Like"
- 5 success criteria only
- No implementation details

Extraction Ratio: (174 - 14) / 174 × 100% = 92%
```

**Target Ratios by Compression Level**:
- **Light**: 20-40% (some extraction, mostly inline)
- **Moderate**: 50-70% (balanced extraction/inline)
- **Aggressive**: 70-90% (heavy extraction, minimal inline)

### Quick Audit Commands

**Measure constitution size**:
```bash
wc -l specs/workspace/constitution.spec.md
```

**Benchmarks**:
- Light: 80-150 lines
- Moderate: 40-80 lines
- Aggressive: < 50 lines (slackward example: 38 lines)

**Measure AGENTS.md size**:
```bash
wc -l AGENTS.md
```

**Benchmarks** (varies by project complexity):
- Light: 150-300+ lines
- Moderate: 100-150 lines
- Aggressive: 80-120 lines

**Count external references**:
```bash
grep -c "See:" specs/workspace/constitution.spec.md
```

**Benchmarks**:
- Light: 0-3 references
- Moderate: 3-8 references
- Aggressive: 8+ references (slackward example: 12 references in 38 lines)

### Concrete Before/After Example

**Constitution.spec.md - Moderate → Aggressive Migration**

**Before (Moderate, 82 lines)**:
```markdown
## Requirements
- Specs Before Implementation
  Every deliverable requires specification before implementation.
  This ensures requirements are documented and testable.

  Process:
  1. Check if spec exists
  2. If not, create spec first using Phase 1 prompts
  3. Validate spec completeness
  4. Then implement

  [10 more lines of process details...]

- MSL Minimalism
  Specifications include only essential requirements.

  Guidelines:
  - Would system fail without this? → Include
  - Am I specifying HOW not WHAT? → Exclude
  [8 more lines of guidelines...]

[3 more principles with full details...]
```

**After (Aggressive, 38 lines)**:
```markdown
## Requirements
- Specs Before Implementation (See: `.livespec/templates/agents/spec-first-verification.md`)
- MSL Minimalism (See: `.livespec/guides/msl-minimalism.md`)
- Living Documentation (See: `.livespec/4-evolve/*.md`)
- Context Compression
  - Rules inline, details extracted
  - Heavy template reuse (`.livespec/templates/agents/`)
  - Deep reference hierarchies
  - Cache-optimized boundaries

## Pre-Implementation Verification
[Essential checklist only]
*Full details*: `.livespec/templates/agents/pre-implementation-verification.md`
```

**Result**: 82 → 38 lines (54% reduction), extraction ratio = 54%, achieved Aggressive target (>70% when including referenced content).

## Examples

### Extract vs Inline Decision (Moderate Compression)

**Scenario**: Pre-implementation verification checklist

**Decision**: Extract to `.livespec/templates/agents/pre-implementation-verification.md`

**Reasoning**:
- Reused in multiple contexts (AGENTS.md, individual prompts)
- ~30 lines (moderate size)
- Moderate compression extracts reusable checklists
- Can reference from AGENTS.md, insert in prompts

### Extract vs Inline Decision (Light Compression)

**Scenario**: Same pre-implementation verification checklist

**Decision**: Inline in AGENTS.md "CRITICAL" section

**Reasoning**:
- Light compression prioritizes self-containment
- Agent sees checklist immediately without reference
- Redundancy tolerated for clarity
- No cache optimization needed

### Extract vs Inline Decision (Aggressive Compression)

**Scenario**: Same pre-implementation verification checklist

**Decision**: Extract to template, reference from AGENTS.md, insert in generated prompts

**Reasoning**:
- Aggressive compression maximizes extraction
- AGENTS.md references template location
- Prompts insert full content during generation
- Single source of truth, minimal AGENTS.md footprint
- Optimized cache usage (load template once if needed)
