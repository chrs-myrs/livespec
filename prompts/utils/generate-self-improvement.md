---
implements: specs/behaviors/prompts/utils-generate-self-improvement.spec.md
phase: utils
purpose: Generate customized self-improvement prompt tailored to project specs
---

# Generate Self-Improvement Prompt

Generate a customized `prompts/utils/self-improve.md` prompt tailored to this project's PURPOSE, principles, and constraints.

## Pre-flight Checks

**Before generating, verify:**

1. **Check if prompt already exists:**
   ```bash
   ls prompts/utils/self-improve.md 2>/dev/null
   ```
   - If exists: Ask user "self-improve.md already exists. Regenerate? (yes/no)"
   - If user says no: Exit without changes
   - If user says yes: Continue

2. **Verify required specs exist:**
   - PURPOSE.md
   - specs/workspace/constitution.spec.md

   If missing: Warn but continue with degraded customization

## Phase 1: Read Project Context

**Read top-down through spec hierarchy:**

1. **Purpose & Vision:**
   ```bash
   cat PURPOSE.md
   ```
   Extract: Why project exists, success criteria

2. **Mission (if exists):**
   ```bash
   cat specs/mission/outcomes.spec.md 2>/dev/null || echo "Not found"
   cat specs/mission/constraints.spec.md 2>/dev/null || echo "Not found"
   ```
   Extract: High-level requirements, hard boundaries

3. **Strategy (if exists):**
   ```bash
   cat specs/strategy/architecture.spec.md 2>/dev/null || echo "Not found"
   ```
   Extract: Technical approach, cross-cutting decisions

4. **Workspace:**
   ```bash
   cat specs/workspace/constitution.spec.md
   cat specs/workspace/patterns.spec.md 2>/dev/null || echo "Not found"
   cat specs/workspace/workflows.spec.md 2>/dev/null || echo "Not found"
   ```
   Extract: Core principles, conventions, processes

## Phase 2: Detect Project Characteristics

**Analyze project domain:**
- Check for behaviors/user-features/ → Software focus
- Check for behaviors/policies/ → Governance focus
- Check for behaviors/services/ → Operations focus
- Default: Software development

**Identify key priorities from PURPOSE:**
- What success metrics are stated?
- What problems does project solve?
- What constraints are emphasized?

## Phase 3: Customize Template

**Read base template:**
```bash
cat dist/templates/utils/self-improve.md.template
```

**Apply customizations:**

1. **Ultrathink block** - Insert project-specific context:
   ```
   <ultrathink>
   I need to analyze [PROJECT NAME from PURPOSE] for systematic improvements.

   Project purpose: [FROM PURPOSE.md - why exists]
   Success criteria: [FROM PURPOSE.md - what success looks like]
   Core principles: [FROM constitution.spec.md - top 3 principles]
   Key constraints: [FROM constraints.spec.md - critical boundaries]

   This is a [detected domain] project, so I'll focus on [domain-specific concerns].
   </ultrathink>
   ```

2. **Analysis framework** - Adapt to detected domain:
   - Software: Code quality, architecture, testing, documentation
   - Governance: Policy completeness, procedure accuracy, compliance
   - Operations: Reliability, runbooks, monitoring, automation
   - Planning: Workflow clarity, template effectiveness, tracking

3. **Priority alignment** - Map to PURPOSE success criteria:
   - Extract 3-5 key success metrics from PURPOSE
   - Create analysis sections for each metric
   - Focus recommendations on stated priorities

4. **Spec structure awareness** - Reference actual folders:
   ```bash
   find specs/ -type d -maxdepth 2
   ```
   Guide analysis to check actual spec locations

## Phase 4: Generate Prompt

**Write customized prompt:**

```bash
mkdir -p prompts/utils
cat > prompts/utils/self-improve.md << 'EOF'
---
generated: [ISO-8601 timestamp]
generated_by: prompts/utils/generate-self-improvement.md
sources:
  - PURPOSE.md
  - specs/mission/outcomes.spec.md
  - specs/mission/constraints.spec.md
  - specs/workspace/constitution.spec.md
implements: specs/behaviors/prompts/utils-self-improve.spec.md
---

# Self-Improvement Analysis

[CUSTOMIZED ULTRATHINK BLOCK]

## Execution

### Phase 1: Context Validation

Reading project specifications to understand current state...

**Purpose:** [From PURPOSE.md]
**Success Criteria:** [From PURPOSE.md]
**Core Principles:** [From constitution.spec.md]
**Critical Constraints:** [From constraints.spec.md]

### Phase 2: [Domain]-Specific Health Assessment

[DOMAIN-ADAPTED ANALYSIS SECTIONS]

### Phase 3: Gap Analysis

[ALIGNED TO PURPOSE SUCCESS CRITERIA]

### Phase 4: Improvement Recommendations

**High Priority** (Critical to success):
[RECOMMENDATIONS ALIGNED TO PURPOSE]

**Medium Priority** (Enhanced quality):
[QUALITY IMPROVEMENTS]

**Low Priority** (Proactive enhancements):
[NICE-TO-HAVE IMPROVEMENTS]

### Phase 5: Implementation Roadmap

[SPECIFIC ACTION ITEMS WITH ESTIMATES]

## Analysis Summary

[PROJECT-SPECIFIC SUMMARY GUIDANCE]
EOF
```

**Report generation:**
```
✅ Generated prompts/utils/self-improve.md

Customized for: [project name]
Domain: [detected domain]
Sources: [list files read]
Timestamp: [ISO-8601]

To use: Read prompts/utils/self-improve.md and execute analysis
To regenerate: Run this prompt again
```

## Notes

- Generated prompt adapts to THIS project specifically
- Ultrathink references actual PURPOSE and principles
- Analysis framework matches detected domain
- Priorities align with stated success criteria
- Gracefully degrades if optional specs missing
- User controls whether to overwrite existing prompt
