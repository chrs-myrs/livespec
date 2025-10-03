# Legacy Code Documentation - Example

This example demonstrates how to use the bidirectional specifications system to document an existing codebase that has little or no documentation.

## Scenario

You've inherited a 3-year-old e-commerce payment processing system with:
- 50,000+ lines of code
- No documentation beyond code comments
- Original developers have left
- System is critical but becoming hard to maintain
- Need to onboard new developers

## Approach

Using Mode 4 (Reverse Engineering), we'll:
1. Extract specifications from the existing code
2. Identify gaps and unknowns
3. Build understanding through analysis
4. Create living documentation that stays synchronized

## Process Timeline

1. **Day 1**: Initial code analysis and setup
2. **Day 2-3**: Extract purpose from functionality
3. **Day 4-5**: Document observed strategies
4. **Day 6-7**: Map system design and components
5. **Day 8-10**: Detail implementation specifications
6. **Day 11+**: Maintain synchronization

## Key Discoveries

Through reverse engineering, we discovered:
- System handles 3 payment providers (not documented)
- Complex retry logic for failed payments
- Undocumented PCI compliance features
- Hidden rate limiting implementation
- Orphaned code from removed features

## Example Output Structure

```
legacy-payment-system/
├── reqs/
│   ├── 0-complexity/
│   │   └── complexity-assessment.md    # Scored 7.8/10 - High complexity
│   ├── 1-purpose/
│   │   ├── system-purpose.md          # Inferred from code behavior
│   │   └── open-questions.md          # Many unknowns about business rules
│   ├── 2-strategy/
│   │   ├── 01-payment-strategy.md     # Multiple providers discovered
│   │   ├── 02-security-strategy.md    # PCI compliance patterns found
│   │   └── 03-reliability-strategy.md # Retry and circuit breaker patterns
│   ├── 3-design/
│   │   ├── 01-system-overview.md      # Extracted from code structure
│   │   ├── 02-component-map.md        # 12 components identified
│   │   └── 03-data-flow.md           # Payment flow reverse engineered
│   ├── 4-components/
│   │   ├── 01-payment-gateway.md      # Core payment handling
│   │   ├── 02-fraud-detector.md       # Hidden ML-based fraud detection
│   │   ├── 03-audit-logger.md         # Compliance logging found
│   │   └── ... (9 more components)
│   └── 5-implementation/
│       └── ... (detailed technical specs)
```

## Challenges and Solutions

### Challenge 1: Understanding Business Purpose
**Problem**: No documentation about why certain features exist
**Solution**: 
- Analyzed code paths and database schemas
- Interviewed current users
- Reviewed old tickets and commits
- Marked unclear purposes with "Inferred:"

### Challenge 2: Undocumented Integration Points
**Problem**: External service calls with no documentation
**Solution**:
- Traced network calls in logs
- Analyzed configuration files
- Created integration map from observations
- Added to open questions for validation

### Challenge 3: Dead Code vs Dormant Features
**Problem**: Unclear if unused code is deprecated or seasonal
**Solution**:
- Checked git history for last modifications
- Analyzed database for related data
- Marked suspicious code in component specs
- Added to maintenance backlog

## Benefits Achieved

1. **Onboarding Time**: Reduced from 6 weeks to 2 weeks
2. **Bug Resolution**: 40% faster with clear component boundaries
3. **Confidence**: Team now understands system architecture
4. **Maintenance**: Living docs stay current with changes
5. **Knowledge Preservation**: Critical knowledge now documented

## Lessons Learned

1. **Start with code structure** - Let the code tell its story
2. **Document uncertainties** - Mark inferences vs facts
3. **Use open questions** - Track unknowns systematically
4. **Validate with production** - Logs reveal actual behavior
5. **Interview stakeholders** - Fill in business context gaps

## Browse the Example

See these key documents:
1. [Extracted Purpose](reqs/1-purpose/system-purpose.md) - What we learned
2. [Open Questions](reqs/1-purpose/open-questions.md) - What we don't know
3. [Payment Strategy](reqs/2-strategy/01-payment-strategy.md) - Hidden patterns
4. [Component Map](reqs/3-design/02-component-map.md) - System structure

This example shows how reverse engineering creates valuable documentation even when starting with zero documentation.