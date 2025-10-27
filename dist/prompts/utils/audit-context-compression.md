---
implements: specs/3-behaviors/prompts/utils-audit-context-compression.spec.md
phase: utility
---

# Audit Context Compression

## Context

This utility helps projects measure and optimize their context compression strategy. Context compression is the force that reorganizes guidance layer (workspace/, AGENTS.md, templates) for agent focus efficiency.

Use this prompt when:
- Context compression level unclear or undeclared
- Suspecting compression misalignment (structure doesn't match declared level)
- Considering migration between compression levels
- Periodic optimization (quarterly or before major changes)

## Prerequisites

- Project has workspace/ specifications
- AGENTS.md exists (if project uses it)
- Understanding of context compression levels (See: `dist/standard/conventions/context-compression.spec.md`)

## Task

You are auditing the project's context compression to measure actual vs declared levels and identify optimization opportunities.

### Step 1: Read Declared Compression Level

Check workspace/constitution.spec.md frontmatter:
```yaml
context_compression: light | moderate | aggressive
```

If not declared: Note as `undeclared` (default: moderate assumed)

### Step 2: Measure Actual Compression

Analyze guidance layer structure and calculate metrics:

**Extraction Ratio** (% of content in templates vs inline):
```
templates_content_lines / (inline_content_lines + templates_content_lines) × 100
```

Count:
- Inline: Content in AGENTS.md, workspace/*.spec.md
- Templates: Content in `.livespec/templates/agents/*.md`, `.livespec/templates/workspace/*.md`

**Reference Depth** (average hops to reach information):
- Depth 0: Inline in AGENTS.md or workspace spec
- Depth 1: Single reference (AGENTS.md → template)
- Depth 2: Chained reference (AGENTS.md → spec → template)
- Depth 3+: Deep hierarchy

**Example Coverage** (% of concepts with inline examples):
```
concepts_with_inline_examples / total_concepts × 100
```

**Redundancy Tolerance** (same content in multiple places):
- Count instances of duplicated verification checklists, examples, explanations

### Step 3: Classify Measured Compression

Based on metrics, determine actual compression level:

**Light Compression Indicators**:
- Extraction ratio: <30%
- Reference depth: Mostly 0 (avg <0.5)
- Example coverage: >70% inline
- Redundancy: High (duplicates tolerated)

**Moderate Compression Indicators**:
- Extraction ratio: 30-60%
- Reference depth: Mix 0-1 (avg 0.5-1.0)
- Example coverage: 40-70% inline
- Redundancy: Moderate (strategic duplication)

**Aggressive Compression Indicators**:
- Extraction ratio: >60%
- Reference depth: Mostly 1-2 (avg >1.0)
- Example coverage: <40% inline
- Redundancy: Low (single source of truth)

### Step 4: Compare Declared vs Actual

Report alignment:

```markdown
## Context Compression Audit

**Declared Level**: [light | moderate | aggressive | undeclared]
**Measured Level**: [light | moderate | aggressive]
**Alignment**: [✓ Aligned | ⚠ Slight mismatch | ❌ Significant mismatch]

### Metrics

| Metric | Value | Expected for [Declared] | Assessment |
|--------|-------|-------------------------|------------|
| Extraction Ratio | X% | Y-Z% | [Within/Above/Below range] |
| Reference Depth | X.X avg | Y-Z avg | [Within/Above/Below range] |
| Example Coverage | X% | Y-Z% | [Within/Above/Below range] |
| Redundancy | [Low/Mod/High] | [Expected] | [Matches/Differs] |
```

### Step 5: Identify Optimization Opportunities

Based on misalignment or improvement potential, suggest specific actions:

**If under-compressed** (actual < declared):
- List specific content that could be extracted
- Suggest template creation opportunities
- Identify redundant inline content
- Propose reference hierarchy improvements

**If over-compressed** (actual > declared):
- List critical workflows that should be inline
- Suggest reducing reference depth for frequent paths
- Identify where inline examples would help
- Propose strategic redundancy for clarity

**If aligned but suboptimal**:
- Suggest compression level change if agent/usage context changed
- Identify borderline content (could go either way)
- Propose cache boundary optimizations

### Step 6: Migration Guidance (If Level Change Recommended)

If recommending compression level change, provide migration plan:

1. **Update declaration** in workspace/constitution.spec.md
2. **Reorganize content**:
   - Moving to higher compression: Extract specific items to templates, update references
   - Moving to lower compression: Inline specific templates, remove unnecessary references
3. **Regenerate AGENTS.md** with new compression level (use `.livespec/4-evolve/4d-regenerate-agents.md`)
4. **Validate** that structure matches new declared level
5. **Commit** with clear explanation of compression change

## Outputs

### Audit Report

Create markdown report: `reports/context-compression-audit-[date].md`

Structure:
```markdown
# Context Compression Audit - [Date]

## Summary
- Declared: [level]
- Measured: [level]
- Alignment: [status]

## Metrics
[Table from Step 4]

## Findings
[Detailed analysis]

## Recommendations
[Specific optimization actions]

## Migration Plan (if applicable)
[Step-by-step guidance]
```

## Success Criteria

- Declared compression level identified (or noted as undeclared)
- Actual compression measured with specific metrics
- Alignment assessed (match/mismatch/undeclared)
- Specific optimization opportunities identified with file paths
- Migration plan provided if level change recommended
- Report actionable (user can immediately apply recommendations)

## Error Handling

**No workspace/constitution.spec.md**:
- Report: "Context compression undeclared (default: moderate assumed)"
- Recommend adding frontmatter declaration

**No AGENTS.md**:
- Skip AGENTS.md-specific metrics
- Focus on workspace/ spec structure
- Note: "Consider generating AGENTS.md for complete compression strategy"

**Insufficient templates/**:
- May indicate under-extraction
- Check if declared level expects more extraction than exists
- Suggest template creation opportunities

## Constraints

- Audit is measurement and recommendation only (no automatic changes)
- User must review and approve recommendations before acting
- Preserve project-specific content during any reorganization
- Compression level change is project-wide decision (discuss with team)

## Related Prompts

- `.livespec/standard/conventions/context-compression.spec.md` - Framework definition
- `.livespec/4-evolve/4d-regenerate-agents.md` - Regenerate AGENTS.md with compression awareness
- `.livespec/0-define/0a-setup-workspace.md` - Initial compression level selection
