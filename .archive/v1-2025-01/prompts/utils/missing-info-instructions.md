# Missing Information Detection Instructions

## Chat Output Requirements

After creating or updating any specification document, you MUST provide a chat output that highlights:

### 1. Missing Information Summary

Create a structured output showing:

```
## 📋 Document Generation Summary

### ✅ Completed Sections
- [List sections that were successfully filled with adequate information]

### ⚠️ Missing Information - HIGH Priority
[Items that MUST be addressed before implementation]
- **[Section/Field]**: [What's missing and why it's critical]
- **[Section/Field]**: [Specific information needed from human]

### 🔍 Missing Information - MEDIUM Priority  
[Items that should be addressed but won't block progress]
- **[Section/Field]**: [What could be improved with human input]
- **[Section/Field]**: [Areas where assumptions were made]

### 💡 Missing Information - LOW Priority
[Nice-to-have clarifications]
- **[Section/Field]**: [Optional enhancements or details]

### 🤔 Key Assumptions Made
- [List any significant assumptions that need validation]
- [Areas where rationale was inferred rather than explicit]

### 👉 Recommended Next Steps
1. [Specific action for human to take]
2. [Questions to answer or information to provide]
3. [Documents or code to review]
```

### 2. Severity Levels for Missing Information

**HIGH Priority** (Blocks implementation):
- Missing core functionality definitions
- Undefined security requirements
- Unknown integration points
- Missing success metrics
- Unclear system boundaries

**MEDIUM Priority** (May cause issues):
- Incomplete rationale for decisions
- Missing non-functional requirements
- Unclear edge cases
- Assumed but unconfirmed constraints
- Missing test scenarios

**LOW Priority** (Nice to have):
- Historical context
- Future considerations
- Optional optimizations
- Additional examples

### 3. Context-Specific Detection

For each document type, focus on:

**Purpose Documents**:
- Missing business value metrics
- Unclear stakeholder identification  
- Undefined success criteria
- Missing compliance requirements

**Strategy Documents**:
- Missing rationale for technical choices
- Undefined trade-offs
- Missing alternative considerations
- Unclear reversibility assessment

**Design Documents**:
- Missing component interactions
- Undefined data flows
- Missing error handling strategies
- Unclear scalability considerations

**Component Specs**:
- Missing interface definitions
- Undefined error conditions
- Missing test strategies
- Unclear data ownership

**Implementation Specs**:
- Missing technical details
- Undefined deployment requirements
- Missing configuration needs
- Unclear dependencies

### 4. Output Format Examples

#### Good Example:
```
## 📋 Document Generation Summary

### ✅ Completed Sections
- System overview and business context
- Core component identification
- Basic interface definitions

### ⚠️ Missing Information - HIGH Priority
- **Authentication Strategy**: No authentication method specified. Need to know: OAuth2, JWT, or session-based?
- **Database Choice**: Data strategy mentions persistence but no database specified. Need: SQL/NoSQL decision and specific technology.

### 🔍 Missing Information - MEDIUM Priority
- **Error Recovery**: Component specs lack error handling details. Assumed standard retry with exponential backoff.
- **Performance Targets**: No specific latency requirements given. Assumed sub-second response time.

### 💡 Missing Information - LOW Priority
- **Monitoring Details**: Could enhance with specific metrics to track
- **Future Scaling**: No discussion of sharding strategy if data grows

### 🤔 Key Assumptions Made
- Assuming REST API based on web context (not explicitly stated)
- Assuming cloud deployment (no on-premise requirements mentioned)

### 👉 Recommended Next Steps
1. Specify authentication requirements and method
2. Choose and document database technology
3. Review component error handling assumptions
4. Define specific performance SLAs if critical
```

### 5. Integration Instructions

Add this to every document generation prompt:

1. Track missing information while creating documents
2. Categorize by severity (HIGH/MEDIUM/LOW)
3. Output summary immediately after saving files
4. Be specific about what information is needed
5. Provide actionable next steps

### 6. Special Cases

**Mode 1 (New Systems)**: Focus on missing requirements and undefined scope
**Mode 4 (Reverse Engineering)**: Focus on unclear rationale and missing context
**Updates**: Focus on what changed and why

Remember: The goal is to make it easy for humans to identify and provide missing information that will improve the specifications.