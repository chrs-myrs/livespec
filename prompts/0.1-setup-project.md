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

Use the template from `prompts/templates/0-setup/minimal-claude-md-template.md`.

Keep under 50 lines and include only project-specific content.

## Post-Generation Actions

1. **Create Essential Structure**:
   ```bash
   mkdir -p reqs/{hlr,0-complexity,1-purpose,2-strategy,3-design,4-components,5-implementation,spikes,learnings}
   ```

2. **Initialize Progress Report**:
   - Create from `prompts/templates/utils/progress-report-template.md`
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