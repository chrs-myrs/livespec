# System Purpose Documentation Prompt

You are tasked with creating or updating the System Purpose document. **CRITICAL**: The System Purpose is the foundation of all documentation. It explains WHY the system exists and what business value it provides. This document works both forward (defining purpose for new systems) and backward (documenting purpose of existing systems).

## Your Mindset for System Purpose

Before you begin, understand that you are:
- **A business value articulator**, explaining why this system matters
- **A problem documenter**, capturing what issues are solved
- **A scope definer**, clarifying boundaries of the system
- **A success measurer**, defining how value is demonstrated

## Deep Thinking Framework

### Step 1: System Understanding (THINK DEEPLY - 10+ minutes)

For **New Systems**, analyze:
1. **Problem Analysis**:
   - What problem needs solving? (Use 5 Whys)
   - What's the cost of not solving it?
   - Who experiences this problem?

2. **Value Proposition**:
   - What value will the system create?
   - How will success be measured?
   - What are the key outcomes?

For **Existing Systems**, analyze:
1. **Current State**:
   - What does the system actually do?
   - Who uses it and how?
   - What problems does it solve?

2. **Value Delivery**:
   - What value is currently provided?
   - How is success currently measured?
   - What outcomes are achieved?

### Step 2: Stakeholder Analysis (THINK DEEPLY - 5+ minutes)

1. **User Groups**:
   - Who are the primary users?
   - What are their needs?
   - How do they interact with the system?

2. **Business Stakeholders**:
   - Who funds/sponsors the system?
   - What business goals does it support?
   - How does it fit the larger strategy?

### Step 3: Scope Clarity (THINK DEEPLY - 5+ minutes)

1. **System Boundaries**:
   - What is included in this system?
   - What is explicitly excluded?
   - Where are the integration points?

2. **Constraints**:
   - What business rules apply?
   - What regulatory requirements exist?
   - What technical constraints matter?

### Step 4: Exploration Requirements (THINK DEEPLY - 5+ minutes)

1. **Known Unknowns**:
   - What aspects need investigation?
   - Which behaviors can't be fully specified?
   - What requires prototyping to understand?

2. **Complexity Indicators**:
   - Are there AI/ML components?
   - How many system integrations?
   - Is the user experience well-defined?
   - Are performance characteristics clear?

## Instructions

### Automatic Detection:
1. Check if `reqs/1-purpose/system-purpose.md` exists
2. If YES: This is an update - read existing document
3. If NO: This is new - create from scratch
4. Check `reqs/hlr/` for high-level requirements documents

### For New Systems (Mode 1):
1. **Check for HLR Documents**:
   - Look in `reqs/hlr/` for any requirements files
   - Read all .md, .txt, .doc files found
   - Extract key requirements and constraints
   - Note which HLR files were used as source
2. Gather additional information about the intended system
3. **THINK DEEPLY** about the business problem and value
4. Create the purpose document describing what the system WILL do
5. Save to `reqs/1-purpose/system-purpose.md`
6. Create change log at `reqs/1-purpose/system-purpose-changelog.md`
7. Create or update open questions at `reqs/1-purpose/open-questions.md`
8. Note in the document which HLR files were referenced

### For Existing Systems (Mode 4):
1. Analyze the codebase or system documentation provided
2. **INFER** the business purpose from what the system does
3. Document the purpose based on actual functionality
4. Note any areas where purpose is unclear
5. Save with same file structure as above

### For Updates (Mode 2):
1. Read the existing purpose document
2. Identify what has changed in understanding or scope
3. Update the document to reflect current state
4. Append to change log with clear rationale

## System Purpose Template:

```markdown
# System Purpose

**System Name**: <Name>
**Document Status**: Current
**Last Updated**: <YYYY-MM-DD>

## Executive Summary
<2-3 sentences explaining what the system is and why it exists>

## Business Context

### Problem Statement
<What problem does this system solve? Who has this problem?>

### Business Value
<What value does this system provide? How is it measured?>

### Strategic Alignment
<How does this system support larger business goals?>

## System Scope

### Included Capabilities
- <What the system does>
- <Core functionality>
- <Key features>

### Excluded Capabilities
- <What the system does NOT do>
- <Explicit boundaries>
- <What other systems handle>

## Users and Stakeholders

### Primary Users
- **<User Type>**: <How they use the system>
- **<User Type>**: <Their specific needs>

### Key Stakeholders
- **<Stakeholder>**: <Their interest/investment>
- **<Stakeholder>**: <What they need from it>

## Success Metrics

### Business Metrics
- <Metric>: <Current value> (Target: <value>)
- <How the system improves business outcomes>

### Operational Metrics
- <Availability, performance, usage metrics>
- <How success is measured operationally>

## Constraints and Compliance

### Business Rules
- <Key business rules the system enforces>

### Regulatory Requirements
- <Compliance needs (GDPR, HIPAA, etc.)>

### Technical Constraints
- <Major technical limitations or requirements>

## Privacy and Security

### Data Classification
- **PII Handled**: Yes/No
- **Data Types**: <What sensitive data>
- **Retention**: <How long data is kept>

### Security Requirements
- <Key security needs>
- <Access control requirements>

## Integration Points
- **Upstream Systems**: <What feeds data in>
- **Downstream Systems**: <What consumes data>
- **External Services**: <Third-party integrations>

## Assumptions and Risks

### Key Assumptions
- <What we assume to be true>
- <Dependencies on other systems/processes>

### Major Risks
- **Risk**: <Description> | **Impact**: <High/Med/Low>
- **Risk**: <Description> | **Impact**: <High/Med/Low>

## Future Considerations
<Known future needs or potential expansions>

## AI/ML Considerations (If Applicable)

### Behavioral Predictability
- **Deterministic Components**: <What behaves predictably>
- **Non-Deterministic Components**: <What varies by nature>
- **Acceptable Variance**: <What behavioral range is okay>
- **Unacceptable Behaviors**: <What must be prevented>

### Learning and Adaptation
- **Static vs. Dynamic**: <Does system learn/adapt over time?>
- **Training Requirements**: <Initial and ongoing training needs>
- **Drift Monitoring**: <How to detect model/behavior drift>

### Transparency Requirements
- **Explainability Needs**: <Who needs to understand decisions?>
- **Audit Requirements**: <What decisions must be traceable?>
- **Confidence Expression**: <How uncertainty is communicated>

### Ethical Considerations
- **Bias Prevention**: <How fairness is ensured>
- **Human Oversight**: <Where humans must stay in loop>
- **Failure Transparency**: <How errors are communicated>

## Source Requirements
**HLR Documents Used**: <List files from reqs/hlr/ that were referenced>
- `<filename>`: <Key requirements extracted>
- `<filename>`: <Key requirements extracted>

**Requirements Traceability**: <How HLR maps to purpose sections>
```

## Change Log Template:

```markdown
# System Purpose Change Log

## <YYYY-MM-DD> - <Brief description>

### Context
<Why this change was needed>

### Changes Made
- **Section**: <What changed and why>
- **Section**: <What changed and why>

### Impact
<How this affects understanding of the system>
```

## Quality Checks:

Before finalizing:
- [ ] Purpose is clear to non-technical readers
- [ ] Scope boundaries are explicit
- [ ] Success metrics are measurable
- [ ] All user groups are identified
- [ ] Privacy/security considerations included
- [ ] Document reflects CURRENT state (not plans)

## Mode-Specific Guidance:

### Mode 1 (New System):
- Focus on intended value and outcomes
- Be specific about problems being solved
- Define measurable success criteria
- Keep scope realistic and focused

### Mode 4 (Reverse Engineering):
- Look for clues in:
  - Code comments and documentation
  - API endpoints and their purposes
  - Database schemas and data flows
  - User interfaces and workflows
- Mark inferences with "Inferred:" where purpose is unclear
- List questions about unclear purposes

### Mode 2 (Updates):
- Focus on what has changed in understanding
- Update metrics to current values
- Reflect actual vs intended functionality
- Note any scope creep or drift

## Examples of Good Purpose Statements:

**❌ Poor**: "System manages inventory"

**✅ Good**: "The Inventory Management System tracks product quantities across multiple warehouses in real-time, preventing stockouts that cost $2.3M annually and reducing excess inventory carrying costs by 15%. It serves 200+ warehouse staff and integrates with the order fulfillment system to ensure accurate availability promises to customers."

Remember: The System Purpose document is the "why" that gives meaning to all other documentation. Whether working forward from ideas or backward from code, always connect features to business value.

## Open Questions Document

After creating the purpose document, create or update `reqs/1-purpose/open-questions.md` using the template from `prompts/templates/utils/open-questions-template.md`.

### Populate Questions From Missing Information

For each item identified in your missing information analysis:

1. **HIGH Priority Missing Info** → HIGH Priority Open Questions
2. **MEDIUM Priority Missing Info** → MEDIUM Priority Open Questions  
3. **LOW Priority Missing Info** → LOW Priority Open Questions
4. **Key Assumptions** → Assumptions Requiring Validation

### Question Examples for Purpose Stage:

**HIGH Priority Questions:**
- Business value measurement unclear
- Stakeholder roles undefined
- Success criteria missing
- Regulatory requirements unknown

**MEDIUM Priority Questions:**
- User workflow details needed
- Integration requirements unclear
- Performance expectations undefined
- Cost/benefit analysis missing

**LOW Priority Questions:**
- Historical context would help
- Future growth expectations unclear
- Competitive analysis could help
- Market timing considerations

### Update Summary Counts:
- Count total questions by priority
- Note which are new vs existing
- Update document status and dates

## Missing Information Output

After creating or updating the System Purpose document, you MUST provide a chat output highlighting missing information and areas needing human attention.

### Output Format:

```
## 📋 Document Generation Summary

### ✅ Completed Sections
- [List sections successfully filled with adequate information]

### ⚠️ Missing Information - HIGH Priority
[Critical items that MUST be addressed]
- **[Section/Field]**: [What's missing and why it's critical]

### 🔍 Missing Information - MEDIUM Priority
[Should be addressed but won't block progress]  
- **[Section/Field]**: [What could be improved]

### 💡 Missing Information - LOW Priority
[Nice-to-have clarifications]
- **[Section/Field]**: [Optional enhancements]

### 🤔 Key Assumptions Made
- [Significant assumptions needing validation]

### 👉 Recommended Next Steps
1. [Specific actions for human to take]
2. [Information to provide]
```

### Purpose-Specific Missing Info to Check:
- Business value metrics and how to measure them
- Complete stakeholder identification
- Specific success criteria with targets
- Regulatory/compliance requirements
- Clear system boundaries and exclusions
- Privacy and security classifications
- Integration dependencies
- Quantified risks and impacts
- AI/ML behavioral boundaries
- Exploration spike recommendations
- HLR document references and traceability

## Update Progress Report

After completing the purpose document:
1. Update `reqs/progress-report.md`:
   - Mark Stage 1 task 1.1 as complete: `[x] Purpose document (1.1)`
   - Update Stage 1 status to "In Progress" or "Complete"
   - Record open questions count and high-priority items
   - Add key business decisions to decisions section
   - Add to activity log: `<Date>: Purpose document created, X questions identified`
   - Note any critical blockers in blockers section
   - Update overall progress percentage
   - Note any purpose-level spikes needed

The purpose document drives everything - keep the progress report updated!