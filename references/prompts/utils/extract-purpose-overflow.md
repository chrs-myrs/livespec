---
implements: specs/artifacts/prompts/utils-extract-purpose-overflow.spec.md
phase: utilities
estimated_time: "10-15 minutes"
---

# Extract PURPOSE.md Overflow

**Purpose**: Migrate existing oversized PURPOSE.md files to proper specification structure.

**When to use**:
- PURPOSE.md exceeds 20 content lines
- Validation script flags PURPOSE.md violations
- Upgrading from older LiveSpec patterns

---

## Instructions for AI Agent

### Step 1: Validate Current State

Run validation to understand what needs extraction:

```bash
scripts/validate-purpose.sh PURPOSE.md
```

**Expected issues:**
- Line count exceeding 20
- Extra sections beyond "Why" and "What Success"
- Content patterns suggesting misplaced material

### Step 2: Read and Analyze PURPOSE.md

Read the current PURPOSE.md and categorize each piece of content:

**Keep in PURPOSE.md:**
- "Why [Project] Exists" section (vision statement, 1-3 sentences)
- "What Success Looks Like" section (3-6 observable outcomes)

**Extract to proper specs:**

| Content Type | Target Location |
|--------------|----------------|
| Regulatory/compliance requirements | `specs/foundation/constraints.spec.md` |
| Specific measurable outcomes | `specs/foundation/outcomes.spec.md` |
| Technology decisions | `specs/strategy/architecture.spec.md` |
| Observable system behaviors | `specs/features/[feature].spec.md` |
| Development processes | `specs/workspace/workflows.spec.md` |
| Guiding principles | `specs/workspace/constitution.spec.md` |
| Usage documentation | `README.md` |

### Step 3: Create Target Specs (If Missing)

For each category of extracted content, check if target spec exists:

```bash
ls specs/foundation/constraints.spec.md
ls specs/foundation/outcomes.spec.md
ls specs/strategy/architecture.spec.md
```

If missing, create with minimal MSL structure:

```markdown
---
criticality: IMPORTANT
failure_mode: [Describe what breaks without this]
derives-from:
  - PURPOSE.md
---

# [Spec Title]

## Requirements
- [!] [Extracted requirements]
```

### Step 4: Extract Content

**Process:**
1. Copy content to appropriate target spec
2. Format as proper MSL requirements
3. Remove from PURPOSE.md
4. Verify PURPOSE.md now <20 lines

**Important:** Don't delete content, move it. Every piece of information belongs somewhere.

### Step 5: Trim PURPOSE.md

After extraction, PURPOSE.md should contain ONLY:

```markdown
# [Project] Purpose

## Why [Project] Exists

[1-3 sentences describing vision/problem]

## What Success Looks Like

- [Observable outcome 1]
- [Observable outcome 2]
- [Observable outcome 3]
- [Observable outcome 4]
```

**No other sections.** No frontmatter. No technical details.

### Step 6: Validate Result

```bash
scripts/validate-purpose.sh PURPOSE.md
```

**Expected result:**
- Content lines: 5-12
- Structure: PASS (Why and Success sections found)
- No errors

### Step 7: Update Dependencies

Extracted specs should reference PURPOSE.md in frontmatter:

```yaml
derives-from:
  - PURPOSE.md
```

This maintains traceability from PURPOSE to detailed requirements.

---

## Example Extraction

**Before (50+ lines):**
```markdown
# MyApp Purpose

## Why MyApp Exists
MyApp solves complex data processing needs...

## What Success Looks Like
- Process 10,000 records per minute
- Support PostgreSQL and MySQL
- GDPR compliant
...

## Technical Approach
We use microservices architecture...

## Constraints
Must support legacy API...
Must comply with SOC2...

## Features
- User authentication
- Data export
- Reporting dashboard
```

**After extraction:**

**PURPOSE.md (10 lines):**
```markdown
# MyApp Purpose

## Why MyApp Exists
MyApp solves complex data processing needs for enterprise teams who need reliable, compliant data workflows.

## What Success Looks Like
- Process high volumes of records efficiently
- Support multiple database backends
- Maintain compliance with data protection standards
- Provide intuitive data management interface
```

**specs/foundation/constraints.spec.md:**
```markdown
---
criticality: CRITICAL
failure_mode: Legal/compliance violations without these boundaries
derives-from:
  - PURPOSE.md
---

# MyApp Constraints

## Requirements
- [!] Must support legacy API compatibility
- [!] Must comply with SOC2 requirements
- [!] Must maintain GDPR compliance
```

**specs/foundation/outcomes.spec.md:**
```markdown
---
criticality: CRITICAL
failure_mode: Cannot measure success without specific targets
derives-from:
  - PURPOSE.md
---

# MyApp Outcomes

## Requirements
- [!] Process 10,000 records per minute
- [!] Support PostgreSQL and MySQL databases
```

---

## Success Criteria

- [ ] PURPOSE.md has <20 content lines
- [ ] Only "Why" and "What Success" sections remain
- [ ] All extracted content placed in appropriate specs
- [ ] Target specs have proper MSL format
- [ ] Target specs reference PURPOSE.md (derives-from)
- [ ] Validation passes: `scripts/validate-purpose.sh`
