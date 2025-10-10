# Context Positioning for AI Performance

Strategic content placement dramatically improves AI processing effectiveness. WHERE information appears matters as much as WHAT information is provided.

## Research Foundation

**Stanford "Lost in the Middle" Study** (Liu et al., 2023):
- Testing GPT-3.5-Turbo on multi-document question answering revealed:
  - **75.8% accuracy** when information at START
  - **53.8% accuracy** when information in MIDDLE (**22% degradation**)
  - **63.2% accuracy** when information at END (partial recovery)
- Middle-context performance fell **below no-context baseline**

**Key insight:** Having information in context doesn't guarantee AI can use it effectively.

## The Positioning Framework

### START Section (30-40% of content)
**Purpose:** Exploit primacy bias - information AI processes first

**Position here:**
- Critical behavioral rules and constraints
- Identity and role definition
- High-priority policies and principles
- Fundamental system context

**Why:** AI establishes foundational understanding, shapes decision-making throughout interaction.

### MIDDLE Section (40% of content)
**Purpose:** Supporting details AI retrieves as needed

**Position here:**
- Examples and demonstrations
- Detailed procedures and workflows
- Background information
- Lower-priority policies
- Technical specifications

**Why:** Available for reference, but not critical to initial understanding.

### END Section (20-30% of content)
**Purpose:** Exploit recency bias - information AI processed most recently

**Position here:**
- Current task requirements
- Active patterns and modes
- Explicit instructions
- Priority objectives
- Immediate next actions

**Why:** Drives immediate behavior, stays fresh in AI's processing context.

## The 4 Positioning Questions

Before placing any content, ask:

### 1. Must AI process this first?
- **Yes** → START position
- **No** → Consider MIDDLE or END

### 2. Does this drive immediate behavior?
- **Yes** → END position
- **No** → Consider START or MIDDLE

### 3. Is this supporting context?
- **Yes** → MIDDLE position
- Documentation, examples, details

### 4. What breaks if this is mispositioned?
- **Critical failure** → START or END
- **Degraded quality** → Optimize position
- **Minor impact** → MIDDLE acceptable

## Common Anti-Patterns

### ❌ The Buried Constraint
```markdown
# Introduction
[Background info - START]

# Examples
[Various examples - MIDDLE]

# Oh By The Way
You must never [CRITICAL CONSTRAINT].  ← Lost in middle!
```

### ✅ Correct: Critical Rules First
```markdown
# Core Constraints - START
You must never [CRITICAL CONSTRAINT].

# Examples - MIDDLE
[Examples that respect constraint]
```

### ❌ The Weak Ending
```markdown
# Current Priority - END
For more details, consult the documentation...  ← Vague!
```

### ✅ Correct: Actionable Ending
```markdown
# Current Priority - END
Start by analyzing requirements.
Apply MSL minimalism framework.
Present proposed structure first.
```

## Application to AGENTS.md

**START:**
- Summary, purpose, success criteria
- Core principles (spec-first, MSL minimalism)
- Critical constraints

**MIDDLE:**
- Quick start examples
- 5 phases overview
- Templates and patterns
- Anti-patterns

**END:**
- When to fetch full prompts (decision table)
- Current priorities based on project state
- Next steps guidance

## Measurable Impact

**Performance improvement:** 20-30% better AI accuracy when optimally positioned (research-validated)

**Indicators of success:**
- AI processes START content reliably (100% compliance with critical rules)
- AI retrieves MIDDLE content appropriately (when needed)
- AI prioritizes END instructions (executes first)
- Reduced clarification requests
- Fewer missed constraints

---

*Adapted from SpellForge Context Positioning policy for LiveSpec distribution. Research: "Lost in the Middle: How Language Models Use Long Contexts" (Stanford, 2023)*
