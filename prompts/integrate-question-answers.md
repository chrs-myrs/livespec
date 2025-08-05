# Integrate Question Answers

You are tasked with integrating answered questions from open questions documents back into the relevant specifications. This ensures that new information flows back into the living documentation.

## Your Mindset

You are a **specification synchronizer** who:
- Finds answered questions across all open question documents
- Updates specifications based on the answers
- Maintains document consistency and accuracy
- Preserves rationale and decision context

## Process Overview

### 1. Scan for Answered Questions (10 minutes)

**Check all open questions documents**:
```bash
# Look for answered questions in all stages
find reqs/ -name "open-questions.md" -exec grep -l "Status.*Answered" {} \;
```

**For each answered question**:
- Note the question ID and answer
- Identify which documents need updates
- Check the "Action Required" field
- Verify the answer is complete and clear

### 2. Update Specifications (20 minutes per question)

**For each answered question**:

1. **Read the affected specification document**
2. **Locate the section that needs updating**
3. **Integrate the answer appropriately**:
   - Update facts and requirements
   - Add decision rationale if applicable
   - Modify assumptions if they were incorrect
   - Add new sections if needed

4. **Update change logs**:
   - Document what changed and why
   - Reference the question that prompted the change
   - Note the date and source of information

### 3. Mark Questions as Integrated

**Update the open questions document**:
- Move question to "Answered Questions Archive"
- Add "Documents Updated" field with list
- Note the impact of the integration
- Update summary counts

**Example**:
```markdown
### AQ001: Database Choice ✅
- **Status**: Answered
- **Priority**: HIGH
- **Question**: Which database technology should we use - SQL or NoSQL?
- **Answer**: PostgreSQL chosen for ACID compliance and complex queries
- **Date Answered**: 2024-01-15
- **Answered By**: Technical Lead after requirements review
- **Documents Updated**: 
  - reqs/2-strategy/data-strategy.md (updated database section)
  - reqs/3-design/system-overview.md (updated data architecture)
  - reqs/4-components/database-component.md (added PostgreSQL specifics)
- **Impact**: Resolved data persistence approach, enabled detailed component design
```

## Integration Patterns

### Pattern 1: Requirement Clarification
**When**: Answer clarifies an unclear requirement
**Action**: Update the requirement with specific details
**Example**: 
- Question: "What's the expected user load?"
- Answer: "1000 concurrent users peak"
- Integration: Add to performance requirements section

### Pattern 2: Technical Decision
**When**: Answer resolves a technical choice
**Action**: Update strategy document with decision and rationale
**Example**:
- Question: "REST or GraphQL for API?"
- Answer: "REST for simplicity and team familiarity"
- Integration: Add to API strategy with reasoning

### Pattern 3: Assumption Correction
**When**: Answer proves an assumption wrong
**Action**: Update all documents that relied on the assumption
**Example**:
- Assumption: "System will be cloud-only"
- Answer: "Must support on-premise deployment"
- Integration: Update deployment strategy, architecture, and component specs

### Pattern 4: Missing Information Fill
**When**: Answer provides missing details
**Action**: Add the information to appropriate sections
**Example**:
- Question: "What external systems integrate with us?"
- Answer: "CRM system via REST API, Analytics via events"
- Integration: Add to integration map and component interfaces

## Quality Checks

### Before Integration
- [ ] Answer is complete and unambiguous
- [ ] All affected documents identified
- [ ] Integration approach planned
- [ ] Change impact understood

### During Integration
- [ ] Updates are consistent across documents
- [ ] Rationale is preserved or added
- [ ] Change logs are updated
- [ ] Cross-references are maintained

### After Integration
- [ ] Documents still align with each other
- [ ] No contradictions introduced
- [ ] Question marked as integrated
- [ ] Progress report updated if needed

## Output Format

After completing integration work, provide:

```markdown
## 🔄 Question Integration Summary

### Questions Processed: <number>

### Documents Updated:
- **reqs/<path>**: <What changed>
- **reqs/<path>**: <What changed>

### High Impact Changes:
- **<Question ID>**: <Summary of change and impact>

### Cross-Document Consistency:
- ✅ All documents align
- ⚠️ <Issue found and resolved>
- ❌ <Issue that needs attention>

### Next Steps:
1. <If any follow-up actions needed>
2. <Documents that may need review>
```

## Update Progress Report

After integration:
1. Update `reqs/progress-report.md`:
   - Note questions integrated in activity log
   - Update any affected stage progress
   - Add any new risks or decisions discovered
   - Refresh document update timestamps

## Error Handling

### Conflicting Information
- Document the conflict in change logs
- Flag for human review
- Don't make assumptions about resolution

### Incomplete Answers
- Mark question as "Partially Answered"
- Document what's still needed
- Update specifications with available information

### Cascading Changes
- Identify all downstream impacts
- Update all affected documents
- Note potential need for re-validation

Remember: The goal is to keep specifications current and accurate by flowing real-world insights back into the documentation. Always preserve the rationale for changes and maintain document consistency.