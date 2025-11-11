# Phase 0: DEFINE

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Phase 0 establishes the problem space and project constraints before any design or implementation. This phase creates the foundation by defining why the project exists, what success looks like, and how the team will work together.

## When to Use This Phase

**Entry conditions:**
- Starting new project (no specs exist yet)
- Existing project without specifications (need to extract and document)
- Problem space unclear or assumptions unchallenged

**Exit conditions:**
- PURPOSE.md defines why project exists and success criteria
- Constraints and outcomes documented in specs/1-requirements/strategic/
- Workspace specs (constitution, patterns, workflows) customized
- Team aligned on approach and terminology

## Phase Workflow

### Step 1: Choose Your Path

**Quick Start (5 minutes, zero questions):**
- Use `.livespec/0-define/0a-quick-start.md`
- Copies defaults, minimal customization
- Best for: Solo developers, familiar with LiveSpec, time-sensitive

**Full Customization (20-30 minutes):**
- Use `.livespec/0-define/0b-customize-workspace.md`
- Interactive setup, tailored to project needs
- Best for: Teams, new to LiveSpec, complex projects

### Step 2: Define Problem and Outcomes

1. **Articulate the problem:**
   - Use `.livespec/0-define/0c-define-problem.md`
   - Document what problem exists and why it matters
   - Capture in PURPOSE.md "Why This Exists" section

2. **Define strategic outcomes:**
   - Use `.livespec/0-define/0c-define-outcomes.md`
   - Define measurable success criteria
   - Document high-level requirements (not features)
   - Creates specs/1-requirements/strategic/outcomes.spec.md

### Step 3: Assess Complexity and Research Needs

1. **Assess project complexity:**
   - Use `.livespec/0-define/0d-assess-complexity.md`
   - Estimate timeline and resource needs
   - Identify technical risks early
   - Determines appropriate detail level for specs

2. **Evaluate research needs:**
   - Use `.livespec/0-define/0e-evaluate-research-needs.md`
   - Determine if UX research needed (skip for pure backend/API)
   - Identifies user interaction patterns requiring validation
   - Creates research plan if needed

### Step 4: Identify Constraints

- Use `.livespec/0-define/0f-identify-constraints.md`
- Document hard boundaries (technical, legal, organizational)
- Creates specs/1-requirements/strategic/constraints.spec.md
- These constraints govern all future decisions

### Step 5: Validation (Optional)

- Use `.livespec/0-define/0x-validate-understanding.md`
- AI checks your comprehension of LiveSpec concepts
- Corrects misunderstandings before they cause problems
- 5-10 minutes, interactive quiz format

## Key Prompts

| Prompt | When to Use | Output |
|--------|-------------|--------|
| 0a-quick-start.md | Fast setup, defaults | Workspace specs (constitution, patterns, workflows) |
| 0b-customize-workspace.md | Full customization | Customized workspace specs |
| 0c-define-problem.md | Problem unclear | PURPOSE.md "Why This Exists" |
| 0c-define-outcomes.md | Need success criteria | specs/1-requirements/strategic/outcomes.spec.md |
| 0d-assess-complexity.md | Timeline planning | Complexity assessment, risk identification |
| 0e-evaluate-research-needs.md | UX-heavy projects | Research plan (if needed) |
| 0f-identify-constraints.md | Need boundaries | specs/1-requirements/strategic/constraints.spec.md |
| 0x-validate-understanding.md | Check comprehension | Concept validation, corrections |

## Common Patterns

### Existing Codebase (No Specs)

Skip Phase 0 entirely. Jump to Phase 4 (EVOLVE):
- Use `.livespec/4-evolve/4b-extract-specs.md`
- Extracts specifications from existing code
- Generates PURPOSE.md, requirements, behaviors
- Then customize extracted specs to project needs

### Solo Developer Fast Path

1. Run 0a-quick-start.md (5 min)
2. Edit PURPOSE.md with your problem/success criteria (5 min)
3. Skip to Phase 1 (DESIGN)

Total: 10 minutes to working specs

### Team Onboarding Path

1. Run 0b-customize-workspace.md (20-30 min)
2. Run 0x-validate-understanding.md with each team member (5-10 min each)
3. Workshop PURPOSE.md together (30-60 min)
4. Document constraints from team discussion (10-20 min)

Total: 1-2 hours, entire team aligned

## Examples

### Example 1: New Web API

```bash
# 1. Quick start
Use .livespec/0-define/0a-quick-start.md

# 2. Define problem
Use .livespec/0-define/0c-define-problem.md
# Documents: "Users need programmatic access to data"

# 3. Skip research evaluation (no UX)

# 4. Document constraints
Use .livespec/0-define/0f-identify-constraints.md
# Captures: "Must use OAuth 2.0, rate limiting required"

# 5. Proceed to Phase 1 (DESIGN)
```

### Example 2: Complex Multi-Domain System

```bash
# 1. Full customization
Use .livespec/0-define/0b-customize-workspace.md
# Defines: Hybrid domain (software + governance)

# 2. Assess complexity
Use .livespec/0-define/0d-assess-complexity.md
# Identifies: Multi-service architecture, 6-12 month timeline

# 3. Evaluate research needs
Use .livespec/0-define/0e-evaluate-research-needs.md
# Determines: UX research needed for admin interface

# 4. Document all aspects
# Creates comprehensive strategic requirements

# 5. Proceed to Phase 1 (DESIGN) with research plan
```

## Decision Points

**Should I skip Phase 0?**
- YES if: Extracting from existing codebase (use Phase 4 instead)
- NO if: Starting new project (need foundation)

**Quick start or full customization?**
- Quick: Solo, familiar, time-sensitive
- Full: Team, new to LiveSpec, complex domain

**Do I need UX research?**
- YES if: User interface, complex interactions, novel UX patterns
- NO if: API only, backend services, well-understood patterns

**How detailed should outcomes be?**
- Strategic level only (high-level success criteria)
- NOT feature lists (those come in Phase 1 behaviors)
- Test: "Can I measure this?" → Good outcome

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Prompts: `.livespec/0-define/*.md` (full prompt text)
- Spec format: `.livespec/standard/metaspecs/outcomes.spec.md`
- Constraints spec: `.livespec/standard/metaspecs/constraints.spec.md`

**Cross-references:**
- Phase 1 (DESIGN): Where outcomes become behaviors
- Phase 4 (EVOLVE): Alternative for existing codebases
- Taxonomy: specs/workspace/taxonomy.spec.md (project classification)

---

*Phase 0 specialist for LiveSpec*
*Parent: AGENTS.md*
