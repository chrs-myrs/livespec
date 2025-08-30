# Project Setup - Minimal CLAUDE.md Generator

You are setting up a project with the Bidirectional Specifications System. Generate a minimal, focused CLAUDE.md that enhances rather than hinders engineering effectiveness.

## Your Mindset

You are creating a **concise context file** that:
- Contains only project-specific information
- Focuses on what makes THIS project unique
- Avoids generic boilerplate
- Can grow organically as needed

## Quick Analysis (5 minutes)

### 1. Detect Project Basics
```bash
# Check for package.json, go.mod, Cargo.toml, etc.
# Identify primary language and framework
# Note any obvious complexity indicators
```

### 2. Ask Only Essential Questions

**Required Information**:
1. What is the main purpose of this project? (1 sentence)
2. What is the highest risk or complexity area?
3. Any critical compliance/security requirements?
4. Current team size? (solo/small/large)

**Optional (only if relevant)**:
- Specific deployment constraints?
- Unusual technical decisions already made?
- Performance requirements?

## Generate Minimal CLAUDE.md

### Template (Keep under 50 lines)

```markdown
# [Project Name] - Claude Context

## Quick Reference
- **Purpose**: [One sentence description]
- **Type**: [web app/API/CLI tool/library]
- **Stack**: [Primary language/framework]
- **Started**: [Today's date]
- **Stage**: [Current stage from progress report]

## Project-Specific Focus

### Complexity Areas
- [Highest complexity/risk area]
- [Second area if applicable]

### Critical Constraints
- [Any compliance/security requirements]
- [Performance requirements if critical]
- [Deployment constraints if unusual]

## Working Agreements

### Code Standards
- [Only project-specific standards]
- [Not generic best practices]

### Documentation Flow
- Specs live in `reqs/` folder
- HLR inputs go in `reqs/hlr/`
- Progress tracked in `reqs/progress-report.md`
- [Any project-specific documentation rules]

## Current Sprint Focus
[What's being worked on now - updated each sprint]

## Key Technical Decisions
[Only list as they're made, with brief rationale]
```

## Post-Generation Actions

1. **Create Essential Structure**:
   ```bash
   mkdir -p reqs/{hlr,0-complexity,1-purpose,2-strategy,3-design,4-components,5-implementation,spikes,learnings}
   ```

2. **Initialize Progress Report**:
   - Create from template
   - Note any HLR documents found
   - Set project name and today's date

3. **Suggest Next Steps** (based on situation):
   - If HLR exists → "Run complexity assessment (0.2)"
   - If greenfield → "Define purpose (1.1)"  
   - If legacy code → "Extract specifications"

4. **Explain Growth Strategy**:
   ```
   Your CLAUDE.md will grow as needed:
   - Add sections only when relevant
   - Remove outdated information
   - Keep it under 100 lines
   - Focus on project-specific guidance
   ```

## Examples of Good Minimal CLAUDE.md

### Example 1: Simple API
```markdown
# Weather API - Claude Context

## Quick Reference
- **Purpose**: RESTful API for weather data aggregation
- **Type**: FastAPI microservice
- **Stack**: Python 3.11, PostgreSQL
- **Started**: 2024-01-20
- **Stage**: Design (Stage 3)

## Project-Specific Focus

### Complexity Areas
- Multiple weather provider integrations
- Rate limiting across providers

### Critical Constraints
- Must handle provider outages gracefully
- 99.9% uptime requirement

## Working Agreements

### Code Standards
- All provider integrations use adapter pattern
- Pydantic for all API models
- UTC timestamps only

### Documentation Flow
- Standard reqs/ structure
- Provider specs in reqs/4-components/providers/

## Current Sprint Focus
Implementing OpenWeatherMap adapter
```

### Example 2: Complex Web App
```markdown
# HealthTracker - Claude Context

## Quick Reference
- **Purpose**: HIPAA-compliant patient health tracking system
- **Type**: React SPA + Node.js API
- **Stack**: TypeScript, PostgreSQL, Redis
- **Started**: 2024-01-15
- **Stage**: Implementation (Stage 5)

## Project-Specific Focus

### Complexity Areas
- HIPAA compliance for all data handling
- Real-time vitals monitoring
- Integration with 3 different EHR systems

### Critical Constraints
- Zero PHI in logs
- All data encrypted at rest
- Audit trail for all data access
- 5-year data retention requirement

## Working Agreements

### Code Standards
- PHI never in variable names
- All DB queries through approved ORM methods
- Security review required for auth changes

### Documentation Flow
- Compliance docs in reqs/2-strategy/compliance/
- Integration specs in reqs/4-components/integrations/
- Security decisions tracked in all changelogs

## Current Sprint Focus
Implementing audit trail system per reqs/5-implementation/02-audit-trail.md

## Key Technical Decisions
- **PostgreSQL**: Chosen for ACID compliance
- **Redis**: Session store only (no PHI)
- **JWT**: 15-minute expiry for security
```

## Why This Works Better

1. **Cognitive Load**: 50 lines vs 500 lines
2. **Signal/Noise**: Every line has purpose
3. **Flexibility**: Grows with project
4. **Maintenance**: Easy to keep current
5. **Effectiveness**: Model focuses on what matters

## Migration Note

For existing projects using verbose CLAUDE.md:
1. Extract only project-specific rules
2. Remove all generic content
3. Consolidate to under 100 lines
4. Archive old version if needed