---
description: Apply session learnings to workspace specs
---

# Apply Learnings

Transform session insights into spec updates, completing the knowledge capture loop.

## When to Use

- After session completion identifies learnings
- When you've discovered something that should be documented
- After corrections or clarifications in conversation
- When patterns emerge that should become conventions

## Process

### Step 1: Gather Learning Candidates

Scan the current conversation for:

**Corrections made:**
- "I initially thought X, but actually it's Y"
- Mistaken assumptions corrected
- Wrong approaches abandoned

**User clarifications:**
- "No, I meant..."
- Requirements refined during discussion
- Scope adjusted based on feedback

**Patterns emerged:**
- Same problem hit multiple times
- New conventions established
- "We should always do X" statements

### Step 2: Present Options to User

Use AskUserQuestion to confirm which learnings to apply:

```
Question: "Which session insights should update specs?"
Header: "Learnings"
MultiSelect: true
Options:
  - [Learning 1]: Updates specs/workspace/[spec].spec.md
  - [Learning 2]: Updates specs/strategy/[spec].spec.md
  - "Add custom learning": Describe something not listed
```

### Step 3: Determine Target Specs

Route learnings to appropriate specs:

| Learning Type | Target Location |
|---------------|-----------------|
| Process/Convention | specs/workspace/ |
| Architectural Decision | specs/strategy/ |
| Feature Behavior | specs/features/ |

### Step 4: Apply Updates

For each confirmed learning:
1. Read the target spec
2. Identify insertion point
3. Edit preserving MSL format
4. Add new requirement with [!] marker

### Step 5: Rebuild Context

After all updates:
1. Run `/livespec:rebuild-context`
2. Confirm completion to user

```
Updated [X] specs with session learnings.
Context rebuilt. Learnings now available in AGENTS.md.

Updated specs:
- specs/workspace/workflows.spec.md (added X)
- specs/strategy/architecture.spec.md (clarified Y)
```

## References

For detailed learning application:
- `${CLAUDE_PLUGIN_ROOT}/references/prompts/utils/learn.md`
