---
spec: specs/workspace/agents.spec.md
---

# 4d: Regenerate Agent Configuration

**Phase**: EVOLVE
**Purpose**: Rebuild AGENTS.md from current workspace specifications
**Context**: See `specs/workspace/agents.spec.md` for structure requirements

## Task

Regenerate root AGENTS.md file from PURPOSE.md and workspace specifications to ensure AI agents have current methodology context.

## When to Regenerate

Run this prompt when:
- **Workspace specs change**: constitution.spec.md, patterns.spec.md, workflows.spec.md modified
- **PURPOSE.md changes**: Project vision or success criteria updated
- **New workspace spec added**: Additional methodology specification created
- **Strategy architecture changes**: Major architectural decisions that affect agent guidance
- **After LiveSpec version upgrade**: Methodology updates from upstream

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
specs/strategy/architecture.spec.md
```

**Extract from each:**
- PURPOSE.md → Summary section (why this exists, success criteria)
- requirements.spec.md → Core requirements list
- constraints.spec.md → Critical boundaries list
- constitution.spec.md → Development principles
- patterns.spec.md → Naming, format, folder conventions
- workflows.spec.md → 5 phases with entry/exit conditions
- architecture.spec.md → High-level approach (2-3 sentences)

### 2. Structure AGENTS.md

**Follow this template structure:**

```markdown
---
generated: [ISO timestamp]
generator: livespec/generate-project-config
version: [LiveSpec version from package.json or VERSION file]
note: Generated from PURPOSE.md and specs/workspace/ - to update, regenerate this file
---

# [Project Name] Agent Configuration

## Summary
[From PURPOSE.md - why exists, success criteria]

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

## Final Notes
[Closing remarks about simplicity and trust]
```

### 3. Generate File

**Using AI agent:**
"Please regenerate AGENTS.md following the structure defined in specs/workspace/agents.spec.md. Extract content from PURPOSE.md and all specs/workspace/*.spec.md files. Keep the file under 100KB and ensure it's self-contained for agent caching."

**Key requirements:**
- File size < 100KB (trim examples if needed)
- Self-contained (80% of questions answerable without additional context)
- Decision tree prominent (helps agent suggest next steps)
- Phase descriptions with entry/exit conditions clear
- MSL format template included
- Frontmatter shows generation timestamp and source

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
