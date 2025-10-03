# Missing Information Highlighting - Example Output

This document demonstrates how the updated prompts will highlight missing information when generating specification documents.

## Example Scenario

Let's say a user runs the `1-write-purpose` prompt for a new "Customer Analytics Dashboard" system with minimal information provided.

### Input Given
- Basic description: "A dashboard to show customer analytics"
- Users: "Marketing team"
- Purpose: "Better understand customers"

### Generated Document Output

The system would create the purpose document AND provide this chat output:

```
## 📋 Document Generation Summary

### ✅ Completed Sections
- Basic system description and name
- Primary user identification (Marketing team)
- General purpose statement

### ⚠️ Missing Information - HIGH Priority
- **Business Metrics**: No specific metrics defined. Need to know: What KPIs will the dashboard track? (e.g., Customer Lifetime Value, Churn Rate, Acquisition Cost)
- **Success Criteria**: No measurable success targets. Need: How will we know if the dashboard is successful? What improvements are expected?
- **Data Sources**: No data sources specified. Need: Where does customer data come from? (CRM, transactional database, analytics tools?)
- **Compliance Requirements**: No mention of data privacy. Need: Does this handle PII? GDPR compliance needed?

### 🔍 Missing Information - MEDIUM Priority  
- **Stakeholders**: Only mentioned Marketing team. Who else? (Sales, Customer Success, Executive team?)
- **Integration Points**: Unclear what systems this connects to. Assumed standalone but need confirmation.
- **Access Control**: No security requirements mentioned. Assumed role-based access needed.
- **Performance Requirements**: No response time targets. Assumed sub-2 second page loads acceptable.

### 💡 Missing Information - LOW Priority
- **Future Expansion**: Could this expand to predictive analytics?
- **Mobile Access**: Is mobile/tablet access required?
- **Export Capabilities**: Do users need to export reports?

### 🤔 Key Assumptions Made
- Assuming web-based dashboard (not desktop application)
- Assuming read-only analytics (no customer data modification)
- Assuming cloud deployment acceptable
- Assuming standard business hours usage pattern

### 👉 Recommended Next Steps
1. Define specific metrics and KPIs the dashboard must display
2. Set measurable success criteria (e.g., "Reduce time to insight by 50%")
3. Identify all data sources and integration requirements
4. Clarify compliance and security requirements
5. Confirm stakeholder list and their specific needs
```

## Benefits of This Approach

1. **Immediate Visibility**: Users instantly see what information is missing
2. **Prioritized Guidance**: HIGH/MEDIUM/LOW helps users focus on critical gaps first
3. **Specific Questions**: Instead of vague "need more info", asks specific questions
4. **Assumptions Documented**: Makes implicit assumptions explicit for validation
5. **Clear Next Steps**: Actionable items to improve the specification

## How It Works Across Specification Levels

### Level 1 - Purpose
Focus on missing business context, value metrics, stakeholders

### Level 2 - Strategy  
Focus on missing technical rationale, trade-offs, alternatives

### Level 3 - Design
Focus on missing component interactions, data flows, scalability

### Level 4 - Components
Focus on missing interfaces, error handling, test strategies

### Level 5 - Implementation
Focus on missing technical details, configurations, deployment steps

## Integration with Workflow

1. User runs prompt to create/update specification
2. System generates the document(s)
3. System analyzes what was generated vs. template requirements
4. System outputs missing information summary
5. User can immediately address gaps or note them for later
6. Re-running the prompt later can update based on new information

This approach ensures specifications improve iteratively while maintaining momentum in the development process.