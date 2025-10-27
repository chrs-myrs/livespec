---
implements: specs/3-behaviors/prompts/utils-audit-workspace-specs.spec.md
---

# Audit Workspace Specifications

**Purpose**: Detect bloat, redundancy, and consolidation opportunities in workspace specs
**When**: Monthly, before releases, when specs feel "heavy"

## Task

Review workspace specifications for MSL minimalism, identify bloat and consolidation opportunities.

## Audit Process

### 1. Size Check

```bash
# Check workspace spec sizes
ls -lh specs/workspace/*.spec.md

# Check AGENTS.md size
ls -lh AGENTS.md
```

**Flags**:
- Any workspace spec >10KB → Review for consolidation
- patterns.spec.md >30KB → Mandatory consolidation
- AGENTS.md >90KB → Critical - aggressive trimming needed

### 2. Redundancy Scan

For each workspace spec, check for:

**Duplicate requirements**:
- Same concept stated multiple ways
- Similar examples showing same principle
- Overlapping validation criteria

**Unnecessary elaboration**:
- Examples that don't add clarity
- Verbose explanations of simple concepts
- HOW details in WHAT specs

**Outdated content**:
- References to deprecated practices
- Examples from old project structure
- Patterns no longer used

### 3. MSL Minimalism Test

For each requirement in workspace specs, ask:

1. **Would spec fail without this?**
   - NO → Remove or consolidate
   - YES → Keep but can it be more concise?

2. **Is this WHAT or HOW?**
   - HOW → Remove (implementation detail)
   - WHAT → Keep

3. **Could this be inferred?**
   - YES → Remove (trust implementers)
   - NO → Keep

4. **Is this stated elsewhere?**
   - YES → Consolidate
   - NO → Keep

### 4. Generate Report

**Output format**:

```markdown
# Workspace Specs MSL Audit - [Date]

## Size Status
- constitution.spec.md: [size] - [OK/WARNING/CRITICAL]
- patterns.spec.md: [size] - [OK/WARNING/CRITICAL]
- workflows.spec.md: [size] - [OK/WARNING/CRITICAL]
- workspace-agent.spec.md: [size] - [OK/WARNING/CRITICAL]
- AGENTS.md: [size] - [OK/WARNING/CRITICAL]

## Redundancy Detected

### [spec-name].spec.md

**Lines [X-Y]: Duplicate concept**
- Requirement: "[requirement text]"
- Duplicates: [spec]:[line] "[other requirement]"
- Recommendation: Consolidate into single requirement

**Lines [X-Y]: Unnecessary elaboration**
- Content: "[verbose explanation]"
- Recommendation: Trim to: "[concise version]"

## Consolidation Opportunities

1. **[Topic across specs]**
   - Found in: constitution.spec.md:45, patterns.spec.md:123
   - Recommendation: Consolidate in [target spec]
   - Savings: ~[X] lines

## Recommended Actions

1. [ ] Remove redundant requirement at [spec]:[line]
2. [ ] Consolidate [topic] into [spec]
3. [ ] Trim verbose explanation at [spec]:[lines]

**Estimated savings**: [X] lines, [Y]KB
```

### 5. Apply Consolidations

After review approved:
1. Make recommended changes to workspace specs
2. Run 4d-regenerate-agents.md
3. Verify AGENTS.md size reduced/maintained
4. Commit with "MSL audit: consolidate workspace specs"

## Validation

- Workspace specs maintain functionality after consolidation
- No critical requirements lost
- AGENTS.md still covers 80% of use cases
- File sizes trend downward or stable
