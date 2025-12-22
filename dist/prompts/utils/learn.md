---
implements: specs/3-behaviors/learning-application.spec.md
phase: utilities
---

# Apply Session Learnings

**Purpose**: Transform session insights into spec updates, completing the knowledge capture loop.

**When to use**: After session completion identifies learnings, or when you've discovered something that should be documented in specs.

---

## Instructions for AI Agent

You are applying learnings from the current session to workspace and strategy specs. Use AskUserQuestion to confirm what to capture, then make updates and rebuild context.

### Step 1: Gather Learning Candidates

Scan the current conversation for:

**Corrections made:**
- "I initially thought X, but actually it's Y"
- Mistaken assumptions you corrected
- Wrong approaches abandoned

**User clarifications:**
- "No, I meant..."
- "Actually, it should..."
- Requirements refined during discussion
- Scope adjusted based on feedback

**Patterns emerged:**
- Same problem hit multiple times
- New conventions established
- Workflow improvements discovered
- "We should always do X" statements

**Explicit requests:**
- "This should be documented"
- "Add this to the specs"
- "Remember this for next time"

**Create candidate list:**
```markdown
## Detected Learnings

1. [Brief description of learning 1]
   - Source: [Quote or summary from conversation]
   - Likely target: specs/workspace/[spec].spec.md

2. [Brief description of learning 2]
   - Source: [Quote or summary]
   - Likely target: specs/2-strategy/[spec].spec.md

[etc.]
```

### Step 2: Present Options to User

Use AskUserQuestion to confirm which learnings to apply:

```
Question: "Which session insights should update specs?"
Header: "Learnings"
MultiSelect: true
Options:
  - label: "[Learning 1 brief]"
    description: "Updates specs/workspace/[spec].spec.md"
  - label: "[Learning 2 brief]"
    description: "Updates specs/2-strategy/[spec].spec.md"
  - label: "[Learning 3 brief]"
    description: "Updates specs/3-behaviors/[spec].spec.md"
  - label: "Add custom learning"
    description: "Describe something not listed above"
```

**If user selects "Add custom learning":**
Ask follow-up: "What insight should be captured?"

**If no learnings detected:**
Ask: "What did you learn this session that should update specs?"

### Step 3: Determine Target Specs

For each selected learning, identify the appropriate spec:

**Process/Convention → specs/workspace/**
- How work is done (workflows, patterns)
- Team conventions (naming, structure)
- Tool usage (validation, commands)
- Examples: "Always run X before Y", "Use Z format for..."

**Architectural Decision → specs/2-strategy/**
- Cross-cutting technical decisions
- Technology choices
- Design patterns adopted
- Examples: "We use X approach for...", "Architecture follows..."

**Feature Behavior → specs/3-behaviors/**
- Observable outcomes
- Feature requirements
- System behaviors
- Examples: "System must...", "Feature should..."

**Show mapping to user:**
```markdown
## Proposed Updates

| Learning | Target Spec | Change |
|----------|-------------|--------|
| [Learning 1] | specs/workspace/workflows.spec.md | Add requirement about X |
| [Learning 2] | specs/2-strategy/architecture.spec.md | Clarify Y approach |
```

### Step 4: Apply Updates

For each confirmed learning:

1. **Read the target spec**
2. **Identify insertion point:**
   - New requirement? Add to `## Requirements` section
   - Clarification? Edit existing requirement
   - New section needed? Add with MSL format
3. **Edit the spec** preserving:
   - MSL format (frontmatter, Requirements section, [!] markers)
   - Existing structure and flow
   - Criticality level (don't escalate without reason)

**Example update:**
```markdown
## Requirements

- [!] Existing requirement
  - Existing criterion
  - NEW: [Added criterion from learning]

- [!] NEW: [New requirement from learning]
  - [Criterion 1]
  - [Criterion 2]
```

### Step 5: Rebuild Context

After all updates applied:

1. **Inform user:**
   ```
   Updated [X] specs with session learnings. Rebuilding context...
   ```

2. **Run context regeneration:**
   Use `dist/prompts/utils/regenerate-contexts.md`

3. **Confirm completion:**
   ```
   Context rebuilt. Learnings now available in AGENTS.md for future sessions.

   Updated specs:
   - specs/workspace/workflows.spec.md (added X)
   - specs/2-strategy/architecture.spec.md (clarified Y)
   ```

---

## When NOT to Use This Prompt

**Don't use if:**
- No session work done yet (nothing to learn from)
- Just want to edit specs directly (use normal editing)
- Learnings are code-level, not spec-level (implementation details stay in code)

**Use instead:**
- **complete-session.md** - To analyze session and identify learnings first
- **regenerate-contexts.md** - To rebuild context without spec updates
- Direct editing - For deliberate spec changes (not session-driven)

---

## Validation Checklist

Before completing:
- [ ] Learning candidates gathered from conversation
- [ ] User confirmed which learnings to apply via AskUserQuestion
- [ ] Target specs identified for each learning
- [ ] Updates preserve MSL format
- [ ] Context regenerated after updates
- [ ] User informed of what was updated
