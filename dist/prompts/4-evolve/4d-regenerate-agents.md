---
implements: specs/3-behaviors/prompts/4d-regenerate-agents.spec.md
estimated_time: "10-15 minutes"
---

# 4d: Regenerate Agent Configuration

**Phase**: EVOLVE
**Purpose**: Rebuild AGENTS.md from current workspace specifications
**Context**: See `specs/workspace/workspace-agent.spec.md` for structure requirements

## Task

Regenerate root AGENTS.md file from PURPOSE.md and workspace specifications to ensure AI agents have current methodology context.

## When to Regenerate

Run this prompt when:
- **Workspace specs change**: constitution.spec.md, patterns.spec.md, workflows.spec.md modified
- **PURPOSE.md changes**: Project vision or success criteria updated
- **New workspace spec added**: Additional methodology specification created
- **Strategy architecture changes**: Major architectural decisions that affect agent guidance
- **After LiveSpec version upgrade**: Methodology updates from upstream

## Prerequisites

**Critical dependency:** This prompt requires `.livespec/templates/agents/` to exist with verification templates:
- `pre-implementation-verification.md`
- `no-plumbing-exception.md`
- `self-check-questions.md`
- `plan-review-checklist.md`

**If missing**: Copy `dist/templates/` → `.livespec/templates/` or copy entire `dist/` → `.livespec/` as documented in `specs/2-strategy/architecture.spec.md` Distribution section.

**Why this matters**: Agent verification templates are inserted into AGENTS.md START section to provide structural enforcement. Without them, generated AGENTS.md lacks active verification prompts that prevent methodology violations.

## Regeneration Process

### 1. Gather Source Content

**Required sources:**
```bash
# Core vision and process
PURPOSE.md
specs/requirements.spec.md
specs/constraints.spec.md
specs/workspace/constitution.spec.md
specs/workspace/patterns.spec.md
specs/workspace/workflows.spec.md

# Technical approach (summary only)
specs/2-strategy/architecture.spec.md
```

**Extract from each:**
- PURPOSE.md → Summary section (why this exists, success criteria)
- requirements.spec.md → Core requirements list
- constraints.spec.md → Critical boundaries list
- constitution.spec.md → Development principles
- patterns.spec.md → Naming, format, folder conventions
- workflows.spec.md → 5 phases with entry/exit conditions
- architecture.spec.md → High-level approach (2-3 sentences)

### 2. Read Context Compression Level

Check workspace/constitution.spec.md frontmatter for `context_compression`:

```yaml
---
context_compression: light | moderate | aggressive
---
```

**If unspecified**: Assume `moderate` (default)

**Compression affects**:
- How much content to inline vs extract/reference
- Template insertion strategy
- Example verbosity
- Section sizing

**See**: `.livespec/standard/conventions/context-compression.spec.md` for detailed framework

### 3. Structure AGENTS.md

**Follow this template structure** (adjust based on compression level):

```markdown
---
generated: [ISO timestamp]
generator: livespec/generate-project-config
version: [LiveSpec version from package.json or VERSION file]
note: Generated from PURPOSE.md and specs/workspace/ - to update, regenerate this file
---

> **⚠️ Generated File**: Do not edit directly. See frontmatter for regeneration instructions.

# [Project Name] Agent Configuration

## Summary
[From PURPOSE.md - why exists, success criteria]

---

# START SECTION - Critical Rules & Principles

## ⚠️ CRITICAL: Spec-First Guidance (Principle #1)
[Detailed spec-first workflow from constitution.spec.md]

**INCLUDE TEMPLATES (active verification prompts):**
1. Insert: `.livespec/templates/agents/pre-implementation-verification.md`
2. Insert: `.livespec/templates/agents/no-plumbing-exception.md`
3. Insert: `.livespec/templates/agents/self-check-questions.md`
4. Insert: `.livespec/templates/agents/plan-review-checklist.md`

## Core Principles (In Priority Order)
[From constitution.spec.md - all 7 principles with explanations]

## Critical Constraints (Boundaries That Must Never Be Violated)
[From constraints.spec.md - each constraint with brief explanation]

---

# MIDDLE SECTION - Details, Examples, Procedures

## Quick Start (80% of Cases)
### New Project
[Steps to initialize]

### Existing Project
[Steps to extract specs]

## Decision Tree
[Which phase/prompt to use when]

## The 5 Phases
[From workflows.spec.md - entry/exit, outputs, key prompts]

## MSL Format Quick Reference
[From patterns.spec.md - four sections, minimalism]

## Folder Structure Pattern
[From patterns.spec.md - workspace vs strategy distinction]

## Folder Organization Decision Tests
[Critical for proper spec placement]

**workspace/ test:** "Could I copy this spec to ANY project?"
- YES → workspace/ (portable process)
- NO → Check strategy/ or behaviors/

**strategy/ test:** "Does this apply across the whole product?"
- YES → strategy/ (cross-cutting technical decision)
- NO → Check behaviors/

**behaviors/ test:** "Is this an observable outcome users/system must exhibit?"
- YES → behaviors/ (what system does)
- NO → Re-examine classification

**Common Mistakes:**
- ❌ "API returns JSON" → NOT workspace (product-specific) → strategy/
- ❌ "Use 4-space indentation" → NOT strategy (not critical) → workspace/ (if it matters)
- ❌ "System authenticates users" → NOT strategy (observable) → behaviors/

**Correct Examples:**
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md (applies to any project)
- ✅ "API responses must be JSON" → strategy/architecture.spec.md (product-wide decision)
- ✅ "System authenticates users via OAuth" → behaviors/authentication.spec.md (observable outcome)

## Essential Templates
### Workspace Constitution
### Behavior Specification
### API Contract
### Extracted Specification (Low Confidence)
[Templates from patterns.spec.md - include confidence markers example]

## Core Principles
[From constitution.spec.md - numbered list with explanations]

## Constraints (Critical Boundaries)
[From constraints.spec.md - each constraint with brief explanation]

## Specification Dependencies
[From patterns.spec.md - frontmatter convention, dependency types]

## Common Anti-Patterns
[From workflows.spec.md and constitution.spec.md]

## Bidirectional Linking
[From patterns.spec.md - frontmatter usage]

## When to Fetch Full Prompts
[Table mapping user needs to specific prompts]

## Workspace Specs Guide AI
[Explain the three workspace specs and their purpose]

## Quick Examples by Use Case
[Common scenarios with commands/prompts]

## Development Patterns
[From patterns.spec.md - key patterns summary]

## Development Workflows
[From workflows.spec.md - key workflows summary]

## Reference Library (Deep Detail Navigation)

AGENTS.md provides 80% coverage. For deep detail, fetch these references using `.livespec/` paths:

### Conventions (How to Structure)
- **Context Compression**: `.livespec/standard/conventions/context-compression.spec.md` (inline vs extract decisions)
- **Folder Structure**: `.livespec/standard/conventions/folder-structure.spec.md` (workspace vs strategy vs behaviors)
- **Dependencies**: `.livespec/standard/conventions/dependencies.spec.md` (frontmatter, bidirectional linking)
- **Naming Conventions**: `.livespec/standard/conventions/naming.spec.md` (file naming patterns)

### Metaspecs (Templates for Spec Types)
- **Prompt/Behavior/Contract/Workspace**: `.livespec/standard/metaspecs/*.spec.md`

### Guides (How to Apply)
- **MSL Minimalism**: `.livespec/guides/msl-minimalism.md` (decision framework)
- **TDD**: `.livespec/guides/tdd.md` (test-driven development)
- **Context Positioning**: `.livespec/guides/context-positioning.md` (START/MIDDLE/END optimization)
- **AI Commits**: `.livespec/guides/ai-commits.md` (commit standards)

Each entry: "Fetch when" trigger + "Provides" description + "Cross-ref" to AGENTS.md section

---

# END SECTION - Prompt Registry & Current Priorities

## When to Fetch Full Prompts
[Table mapping user needs to specific prompts]

## Current Priorities
[What agent should focus on based on project state]

## Final Notes
[Closing remarks about simplicity and trust]
[Note about context positioning design]
```

### 3. Generate File

**Using AI agent:**
"Please regenerate AGENTS.md following the structure defined in specs/workspace/workspace-agent.spec.md. Extract content from PURPOSE.md and all specs/workspace/*.spec.md files. Include agent verification templates from `.livespec/templates/agents/` in START section. Keep the file under 100KB and ensure it's self-contained for agent caching."

**Key requirements:**
- File size < 100KB (trim examples if needed)
- Self-contained (80% of questions answerable without additional context)
- Decision tree prominent (helps agent suggest next steps)
- Phase descriptions with entry/exit conditions clear
- MSL format template included
- Frontmatter shows generation timestamp and source

### 3.5. Apply Context Compression

**Based on declared compression level, adjust content strategy:**

**Light Compression** (verbose, self-contained):
- Inline full verification checklists in START section
- Include complete examples (don't just reference)
- Detailed explanations inline
- Minimal references to external templates
- Redundancy tolerated for clarity
- Target size: 90-100KB (use available space)

**Moderate Compression** (balanced - default):
- Insert template verification content in START section
- Show example patterns inline, reference full details
- Balanced explanations (key points inline, details referenced)
- Strategic template references (`.livespec/templates/agents/*.md`)
- Reduce redundancy, keep critical duplications
- Target size: 70-85KB (optimized balance)

**Aggressive Compression** (focused, extracted):
- Reference templates only in START section (don't insert full content)
- Minimal inline examples (pattern only, reference separate files)
- Concise explanations (rules inline, rationale extracted)
- Heavy template referencing throughout
- Strict redundancy elimination
- Target size: <70KB (maximum compression)

**Extraction decisions**:
- Light: Extract only if reused 3+ times
- Moderate: Extract if reused 2+ times or >50 lines
- Aggressive: Extract almost everything, inline only critical rules

### 3.6. Apply MSL Minimalism to Generated Content

**After applying compression, rationalize content:**

**Section-level MSL test**:

For each H2 section, ask:
1. **Would AGENTS.md fail without this section?**
   - NO → Remove or consolidate with related section
   - YES → Keep but check if it can be more concise

2. **Does this duplicate another section?**
   - YES → Consolidate (combine related content)
   - NO → Keep

3. **Is this in correct position** (START/MIDDLE/END)?
   - Critical rules → START
   - Examples/procedures → MIDDLE
   - Prompt registry → END
   - Reposition if needed

**Critical warning budget**:
- Count ⚠️ CRITICAL sections
- Maximum 3 allowed (methodology failure prevention only)
- If >3 → Downgrade least-critical to ## Important

**Content-level MSL test**:
- Remove redundant examples (keep 1-2 best examples per concept)
- Trim verbose explanations (trust agents to infer)
- Remove HOW details that belong in implementation

**Size management**:
- Target: <80KB (leaves 20KB headroom before 100KB limit)
- If 80-90KB: Review for consolidation opportunities
- If 90-100KB: Mandatory trimming (remove nice-to-have sections)
- If >100KB: Aggressive consolidation (keep only critical sections)

### 4. Validate

**Check generated file:**
```bash
# Size check
ls -lh AGENTS.md  # Should be < 100KB

# Structure check
grep "^## " AGENTS.md  # Verify all main sections present

# Frontmatter check
head -n 10 AGENTS.md  # Verify generated, generator, version fields
```

**Manual review:**
- [ ] Can agent answer "what phase should I use?" from this file alone?
- [ ] Does decision tree cover common scenarios?
- [ ] Are all 5 phases explained with entry/exit conditions?
- [ ] Is MSL format template present and complete?
- [ ] Do core principles match constitution.spec.md?
- [ ] Are constraints accurately represented?
- [ ] **Are agent verification templates included in START section?**
  - [ ] Pre-implementation verification checklist present
  - [ ] No plumbing exception warning present
  - [ ] Active self-check questions present
  - [ ] Plan review checklist present

### 5. Commit

**If regeneration changes methodology:**
```bash
git add AGENTS.md
git commit -m "Regenerate AGENTS.md from updated workspace specs

Updated to reflect changes in:
- [list changed specs]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

## Notes

**Agent-specific variants:**
- AGENTS.md → Generic/Claude Code
- CLAUDE.md → Claude-specific features
- COPILOT.md → GitHub Copilot
- CURSOR.md → Cursor IDE

Content is identical, filename changes for agent recognition.

**Automation opportunity:**
Consider creating a script to regenerate automatically when workspace specs change:
```bash
# Watch for changes
ls specs/workspace/*.spec.md PURPOSE.md | entr prompts/4-evolve/4d-regenerate-agents.md
```

## Success Criteria

- AGENTS.md reflects current workspace specifications
- Agent can guide user through LiveSpec without additional context
- File remains cacheable (<100KB)
- Regeneration takes <5 minutes
