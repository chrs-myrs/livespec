# Update Specifications with Code Prompt

You are tasked with updating specifications based on code changes. **CRITICAL**: This prompt implements Mode 2 of the bidirectional requirements system - keeping specifications synchronized with code as the implementation evolves.

## Your Mindset for Specification Updates

Before you begin, understand that you are:
- **A change tracker**, identifying what has evolved in the code
- **A documentation updater**, keeping specs current with reality
- **A decision capturer**, documenting why changes were made
- **A consistency maintainer**, ensuring all levels stay aligned

## Change Detection Framework

### Step 1: Current State Analysis (10 minutes)
1. **Load Existing Specifications**:
   - Read all documents from numbered folders
   - Build model of documented state
   - Note last update dates

2. **Analyze Current Code**:
   - Map current implementation
   - Identify all components
   - Extract current patterns
   - Document actual behavior

### Step 2: Change Identification (15 minutes)
1. **Compare Against Specifications**:
   - What's new in the code?
   - What has changed?
   - What was removed?
   - What was refactored?

2. **Categorize Changes**:
   - **New Features**: Added capabilities
   - **Enhancements**: Improved existing features
   - **Refactoring**: Internal changes
   - **Bug Fixes**: Corrected behaviors
   - **Deprecations**: Removed features
   - **Tech Updates**: Library/framework changes

### Step 3: Impact Analysis (10 minutes)
1. **Trace Change Impact**:
   - Which specs are affected?
   - How do changes cascade?
   - What documents need updates?

2. **Understand Rationale**:
   - Look for commit messages
   - Check PR descriptions
   - Infer from code patterns
   - Note technical improvements

## Instructions

### Automatic Processing:
1. Load all existing specifications
2. Analyze current codebase state
3. Identify all changes since specs were last updated
4. Update affected documents at all levels
5. Append to change logs with clear rationale

### Update Process by Level:

#### Level 1: System Purpose Updates
Check if changes affect:
- Core system value proposition
- User groups or stakeholders
- Success metrics or KPIs
- System scope or boundaries

Update `system-purpose.md` if:
- New major features added
- User types changed
- Business model evolved
- Scope significantly expanded

#### Level 2: Technical Strategy Updates
Check if changes affect:
- Architectural patterns
- Technology choices
- Integration approaches
- Data strategies
- Security methods

Update relevant strategy documents if:
- New patterns adopted
- Technologies replaced
- Strategies evolved
- Constraints changed

#### Level 3: System Design Updates
Check if changes affect:
- Component structure
- Service boundaries
- Data flows
- Integration points

Update design documents if:
- New components added
- Interactions changed
- Flows modified
- Topology altered

#### Level 4: Component Specification Updates
Check if changes affect:
- Component capabilities
- Interfaces (APIs, events)
- Data ownership
- Business rules

Update component specs if:
- New operations added
- APIs modified
- Events changed
- Rules updated

#### Level 5: Implementation Specification Updates
Check if changes affect:
- API contracts
- Database schemas
- Algorithms
- Deployment configs

Update implementation specs if:
- Endpoints changed
- Schemas modified
- Logic updated
- Configs altered

## Update Templates:

### For Feature Additions
```markdown
## <Feature Name>

**Added**: <YYYY-MM-DD>
**Status**: Active

### Purpose
<Why this feature was added>

### Capabilities
<What the feature does>

### Technical Details
<How it's implemented>
```

### For Modifications
```markdown
### <Existing Feature/Component>

**Modified**: <YYYY-MM-DD>

**Previous State**:
<What it was>

**Current State**:
<What it is now>

**Rationale**:
<Why the change was made>
```

### For Deprecations
```markdown
### <Deprecated Feature>

**Deprecated**: <YYYY-MM-DD>
**Removal Target**: <YYYY-MM-DD>
**Migration Path**: <How to migrate>

**Reason**:
<Why being removed>
```

## Change Log Entry Template:

```markdown
## <YYYY-MM-DD> - <Brief description>

### Context
<Why these changes were made - business or technical drivers>

### Code Changes Summary
- **Added**: <New files, features, or components>
- **Modified**: <Changed files or behaviors>
- **Removed**: <Deleted code or features>

### Specification Updates
- **Section/Field**: <What was updated>
  - Previous: <Old content>
  - Current: <New content>
  - Reason: <Why changed>

### Impact
- **Users**: <How users are affected>
- **Systems**: <How other systems are affected>
- **Operations**: <Deployment or operational impacts>

### Migration Notes
<Any special steps needed for existing systems>
```

## Common Update Patterns:

### API Evolution
When APIs change:
1. Update implementation spec with new contract
2. Update component spec if capabilities changed
3. Note breaking vs non-breaking changes
4. Document migration path

### Database Schema Changes
When schemas change:
1. Update implementation spec schemas
2. Update component data management section
3. Include migration scripts references
4. Note data compatibility

### New Integration
When integrations added:
1. Update system design with new connection
2. Update integration strategy if pattern changed
3. Update component dependencies
4. Add to implementation specs

### Performance Optimization
When optimizations made:
1. Update implementation algorithms
2. Update performance characteristics
3. Note if strategy assumptions changed
4. Document new benchmarks

### Security Enhancement
When security improved:
1. Update security strategy if approach changed
2. Update implementation security section
3. Update component auth/authz
4. Note compliance impacts

## Quality Checks:

Before finalizing updates:
- [ ] All changed code areas examined
- [ ] All affected specs identified
- [ ] Updates maintain consistency across levels
- [ ] Change rationale documented
- [ ] Change logs updated with context
- [ ] Breaking changes clearly marked

## Update Heuristics:

### When to Update Purpose (Level 1)
- Rarely - only for fundamental changes
- New user types or use cases
- Major business model shifts
- Significant scope changes

### When to Update Strategy (Level 2)
- Occasionally - for approach changes
- New architectural patterns
- Technology stack changes
- Major constraint changes

### When to Update Design (Level 3)
- Sometimes - for structural changes
- New components or services
- Changed interactions
- Modified data flows

### When to Update Component Specs (Level 4)
- Frequently - for capability changes
- New or modified APIs
- Changed business rules
- Updated interfaces

### When to Update Implementation (Level 5)
- Most frequently - for any code changes
- API contract modifications
- Schema updates
- Algorithm changes
- Config modifications

## Rationale Documentation:

Always try to understand and document WHY changes were made:

### Technical Reasons
- Performance improvement
- Bug fix
- Technical debt reduction
- Security enhancement
- Scalability improvement

### Business Reasons
- New requirement
- Customer feedback
- Market change
- Compliance need
- Cost optimization

### Operational Reasons
- Monitoring improvement
- Deployment simplification
- Maintenance reduction
- Incident response

## Special Considerations:

### Rapid Development
- Batch related changes
- Focus on significant updates
- Don't document every commit
- Summarize sprint changes

### Refactoring
- Update implementation details
- Keep component specs stable
- Note if behavior unchanged
- Document improvement rationale

### Emergency Fixes
- Document what and why
- Note if temporary
- Plan proper update
- Track technical debt

## Update Progress Report

After updating specifications:
1. Update `reqs/progress-report.md`:
   - Mark Stage 6 task 6.1 as active/complete
   - Record number of documents updated
   - Note types of changes (features/fixes/refactors)
   - Update documentation health metrics
   - Add to activity log: `<Date>: Specifications updated (count: X)`
   - Calculate new drift metrics if available
   - Update overall progress (maintenance is ongoing)

Living documentation requires living progress tracking!

Remember: The goal is to keep specifications as a living, accurate representation of the system. Focus on meaningful changes that affect understanding or usage of the system. Not every code change requires specification updates - use judgment about what matters for documentation users.