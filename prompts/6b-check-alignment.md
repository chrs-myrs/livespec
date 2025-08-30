# Align Specifications to Code Prompt

You are tasked with checking alignment between specifications and actual code. **CRITICAL**: This prompt implements Mode 3 of the bidirectional requirements system - detecting and reporting misalignments between documented specifications and implemented code.

## Your Mindset for Alignment Checking

Before you begin, understand that you are:
- **An auditor**, comparing documentation against reality
- **A discrepancy detector**, finding gaps and inconsistencies
- **A drift analyzer**, understanding how specs and code diverged
- **A recommendation provider**, suggesting reconciliation paths

## Deep Analysis Framework

### Step 1: Specification Loading (5 minutes)
1. **Load All Specifications**:
   - Read all documents from `reqs/1-purpose/`
   - Read all documents from `reqs/2-strategy/`
   - Read all documents from `reqs/3-design/`
   - Read all documents from `reqs/4-components/`
   - Read all documents from `reqs/5-implementation/`

2. **Build Specification Model**:
   - Extract key claims and specifications
   - Map relationships between documents
   - Note specific testable assertions

### Step 2: Code Analysis (15+ minutes)
1. **Code Structure Discovery**:
   - Analyze actual project structure
   - Identify components and services
   - Map actual technologies used
   - Understand real data flows

2. **Implementation Verification**:
   - Check if specified components exist
   - Verify API contracts match specs
   - Validate data models align
   - Confirm architectural patterns

### Step 3: Alignment Analysis (10+ minutes)
1. **Compare Each Layer**:
   - Purpose vs Actual Functionality
   - Strategy vs Implemented Patterns
   - Design vs Real Architecture
   - Component Specs vs Actual Components
   - Implementation Specs vs Code Details

2. **Categorize Findings**:
   - **Aligned**: Spec matches code
   - **Drift**: Minor differences
   - **Misaligned**: Major differences
   - **Missing in Spec**: Code exists but not documented
   - **Missing in Code**: Spec exists but not implemented
   - **Contradictory**: Spec and code conflict

## Instructions

### Automatic Processing:
1. Load all specification documents from numbered folders
2. Analyze the codebase systematically
3. Compare each specification against reality
4. Generate alignment report
5. Provide recommendations for each misalignment

### Analysis Process:
1. **For Each Specification**:
   - Quote the specific claim or specification
   - Check against actual implementation
   - Document the finding
   - Assess severity and impact

2. **Pattern Recognition**:
   - Look for systematic divergence
   - Identify common causes of drift
   - Note areas of good alignment

3. **Root Cause Analysis**:
   - Why did misalignments occur?
   - Natural evolution vs mistakes?
   - Documentation lag vs spec changes?

## Alignment Report Template:

```markdown
# Specification-Code Alignment Report

**Analysis Date**: <YYYY-MM-DD>
**Codebase Version**: <commit hash or version>
**Overall Alignment Score**: <percentage>

## Executive Summary
<High-level summary of alignment status, major findings, and recommended actions>

## Alignment by Layer

### 1. System Purpose Alignment
**Document**: system-purpose.md
**Overall Status**: Aligned|Drift|Misaligned

#### Findings:
| Specification | Code Reality | Status | Severity |
|--------------|--------------|---------|----------|
| "Handles user authentication" | OAuth2 implementation found | ✅ Aligned | - |
| "Processes 10K requests/sec" | Load tests show 5K max | ⚠️ Drift | Medium |
| "Integrates with System X" | No integration code found | ❌ Missing | High |

#### Analysis:
<Why these misalignments exist>

### 2. Technical Strategy Alignment
[Repeat pattern for each strategy document]

### 3. System Design Alignment
[Repeat pattern for each design document]

### 4. Component Specification Alignment
[Repeat pattern for each component]

### 5. Implementation Specification Alignment
[Repeat pattern for each implementation spec]

## Undocumented Features
Components or capabilities found in code but not in specifications:

### Feature: <Name>
- **Location**: <Where in code>
- **Purpose**: <Inferred purpose>
- **Why Undocumented**: <Likely reason>
- **Recommendation**: Add to <which spec document>

## Missing Implementations
Specifications without corresponding code:

### Specification: <Name>
- **Document**: <Source document>
- **Expected**: <What was specified>
- **Status**: Not implemented|Partially implemented
- **Recommendation**: <Implement or remove from spec>

## Critical Misalignments
High-severity issues requiring immediate attention:

1. **Issue**: <Description>
   - **Impact**: <Business/technical impact>
   - **Resolution Path**: <How to fix>

## Drift Patterns
Systematic divergence observed:

### Pattern: <Name>
- **Description**: <What's happening>
- **Examples**: <Specific instances>
- **Root Cause**: <Why this happens>
- **Prevention**: <How to avoid>

## Recommendations

### Immediate Actions
1. <High-priority fixes>
2. <Critical updates needed>

### Short-term (1-2 weeks)
1. <Important alignment tasks>
2. <Documentation updates>

### Long-term Process Improvements
1. <How to maintain alignment>
2. <Process changes needed>

## Alignment Metrics

### By Document Type
- Purpose Documents: <X>% aligned
- Strategy Documents: <X>% aligned
- Design Documents: <X>% aligned
- Component Specs: <X>% aligned
- Implementation Specs: <X>% aligned

### By Severity
- ✅ Fully Aligned: <X> items
- ⚠️ Minor Drift: <X> items
- ❌ Major Misalignment: <X> items
- 🆕 Undocumented: <X> items
- 📋 Unimplemented: <X> items

## Appendix: Detailed Findings
[Full detailed list of all findings, organized by document]
```

## Quality Checks:

Before finalizing:
- [ ] All specification documents were analyzed
- [ ] Code was thoroughly examined
- [ ] Each misalignment has evidence
- [ ] Severity is appropriately assessed
- [ ] Recommendations are actionable
- [ ] Root causes are identified

## Common Misalignment Types:

### Documentation Drift
- Specs not updated after code changes
- Common in rapidly evolving features
- Fix: Regular sync cycles

### Optimistic Specifications
- Specs describe ideal state, not reality
- Common in performance targets
- Fix: Validate specs against measurements

### Shadow Features
- Code implements more than specified
- Often from quick fixes or experiments
- Fix: Document or remove

### Abandoned Specifications
- Specs for features never built
- Often from changed priorities
- Fix: Archive or implement

### Technology Pivots
- Strategy says X, code uses Y
- From practical discoveries
- Fix: Update strategy docs

## Severity Guidelines:

### High Severity
- Security specs not implemented
- Core functionality missing
- Data models completely different
- Critical integrations absent

### Medium Severity
- Performance targets not met
- Some APIs differ from spec
- Minor features missing
- Non-critical patterns different

### Low Severity
- Naming inconsistencies
- Documentation style issues
- Optional features missing
- Minor parameter differences

## Output Considerations:

1. **Be Specific**: Quote exact specifications and show exact code
2. **Be Fair**: Distinguish between reasonable evolution and problematic drift
3. **Be Actionable**: Every finding should have a clear resolution path
4. **Be Prioritized**: Focus on what matters most
5. **Be Constructive**: Frame as opportunities for improvement

## Update Progress Report

After alignment check:
1. Update `reqs/progress-report.md`:
   - Mark Stage 6 task 6.2 as complete for this cycle
   - Record alignment percentage
   - Update drift metrics
   - List documents needing updates
   - Add to activity log: `<Date>: Alignment check - Score: X%`
   - Flag any critical misalignments
   - Recommend specification updates needed

Regular alignment checks keep documentation trustworthy!

Remember: The goal is not to punish divergence but to understand it and provide a path to better alignment. Some drift is natural and healthy - the key is knowing what has drifted and why.