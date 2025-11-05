---
implements: specs/3-behaviors/prompts/0x-validate-understanding.spec.md
phase: 0-define
estimated_time: "5-10 minutes"
---

# Prompt Behavior: Validate Understanding

**Purpose**: Verify user understands core LiveSpec concepts before implementation to prevent organizational confusion

## Context

Before implementing LiveSpec in a project, users should understand fundamental concepts that affect file organization:
- Abstraction layers vs temporal phases
- Workspace scope patterns by domain type
- Generated artifacts organization
- Strategic vs behavioral specifications

This validation catches conceptual gaps early, preventing the need to restructure later.

**When to use this**:
- After reading AGENTS.md but before creating specs
- When transitioning from Quick Start to actual implementation
- If uncertain about fundamental organizational concepts
- Before brownfield integration (existing codebases)

**When to skip**:
- Confidence is high (used LiveSpec successfully before)
- Quick experimentation (can restructure later)
- Following detailed customize-workspace.md (includes inline guidance)

## Task

### Step 1: Explain Validation Purpose

Tell user:

"**Pre-flight validation**: Let's verify you understand core LiveSpec concepts to avoid organizational confusion. This takes 5-10 minutes and prevents hours of restructuring later.

I'll ask 4 questions about fundamental concepts. If any answers indicate confusion, I'll point you to specific documentation sections before we continue."

### Step 2: Phases vs Layers Check

**Ask**: "In your own words, what's the difference between LiveSpec's 5 phases (0-DEFINE through 4-EVOLVE) and the numbered folders in specs/ (1-requirements/, 2-strategy/, 3-behaviors/)?"

**Evaluate response:**

✅ **PASS indicators**:
- Mentions phases = WHEN/workflow/temporal
- Mentions folders = WHERE/organization/abstraction
- Understands they're different systems
- Example: "Phases are the development workflow steps, folders organize specs by abstraction level"

❌ **FAIL indicators**:
- Thinks they're the same thing
- Thinks numbered folders = lifecycle stages
- Unclear or "I don't know"
- Says "1-requirements is Phase 1"

**If FAIL**:
"Let's clarify this critical distinction. Please read AGENTS.md section '⚠️ CRITICAL DISTINCTION: Phases vs Layers' (lines ~302-344).

**Key point**: You might write a spec during **Phase 1 (DESIGN)** but it belongs in **`2-strategy/`** folder. The phase describes WHEN you work, the layer describes WHAT you're specifying.

Ready to continue?"

### Step 3: Workspace Scope Check

**Ask**: "What type of project are you working on? (Software/Hybrid/Governance/etc.) And what goes in `specs/workspace/` for your project domain?"

**Evaluate response:**

✅ **PASS indicators**:
- Identifies their project domain correctly
- For Software: workspace/ = portable development methodology
- For Hybrid: workspace/ = operational methodology OR portable methodology (depends on primary activity)
- For Governance: workspace/ = framework methodology (demonstrating patterns)
- Understands portability test or operations vs artifacts split

❌ **FAIL indicators**:
- "Everything goes in workspace/"
- "Product features go in workspace/"
- Unclear about project domain
- Doesn't understand workspace scope pattern for their domain

**If FAIL**:
"Let's clarify workspace scope for your project type.

**Decision test**: 'Could I copy this spec to ANY similar project?'
- YES → workspace/ (portable methodology)
- NO → numbered folders (product-specific)

For **Hybrid operational projects** (like techops-workspace):
- workspace/ = What you DO (operations, protocols, orchestration)
- numbered specs/ = What you BUILD (agents, scripts, artifacts)

See AGENTS.md 'Project Taxonomy' section (lines ~187-280) and 'Folder Organization Decision Tests' (lines ~426-457).

Ready to continue?"

### Step 4: Strategic vs Behavioral Check

**Ask**: "Where would you put a spec for 'API responses must be JSON'? And where would you put 'System authenticates users via OAuth'?"

**Evaluate response:**

✅ **PASS indicators**:
- "API JSON" → 2-strategy/ (cross-cutting architectural decision)
- "OAuth auth" → 3-behaviors/ (observable behavior)
- Understands strategy = HOW approach, behaviors = WHAT system does

❌ **FAIL indicators**:
- Both in same folder
- "API JSON" in 3-behaviors/ (too specific for strategy)
- "OAuth auth" in 2-strategy/ (not a strategy, it's a behavior)
- "Both in workspace/" (no, product-specific)
- Unclear or guessing

**If FAIL**:
"Let's clarify abstraction layers:

- **2-strategy/**: Cross-cutting HOW (architecture, design patterns, tech stack)
  - Example: 'API responses must be JSON' (applies to ALL endpoints)
- **3-behaviors/**: Observable WHAT (specific features, behaviors)
  - Example: 'System authenticates via OAuth' (what users experience)

See AGENTS.md 'Folder Structure Pattern' (lines ~434-469) and 'Folder Organization Decision Tests' (lines ~471-500).

Ready to continue?"

### Step 5: Generated Artifacts Check

**Ask**: "If your project generates artifacts from specs (like AGENTS.md from agent specs, or scripts from runbooks), where do those generated files belong?"

**Evaluate response:**

✅ **PASS indicators**:
- NOT in specs/ folder
- Mentions: project root, separate top-level folder (agents/, scripts/), or generated/ subfolders
- Understands specs/ = source specifications only
- Mentions marking generated files with sources

❌ **FAIL indicators**:
- "In specs/ folder"
- "Next to the spec files"
- Unclear or "I don't know"
- Doesn't understand specs/ boundary

**If FAIL**:
"specs/ contains ONLY .spec.md source specifications.

**Generated artifacts** go elsewhere:
- **Meta artifacts** (AGENTS.md, CLAUDE.md): Project root (marked with generation sources)
- **Product artifacts** (scripts, agents): Separate folders (agents/, scripts/, runbooks/)
- **Build outputs**: generated/ subfolders or standard build locations (dist/, build/)

The taxonomy.spec.md 'Specs Boundary' section clarifies this (see your project's taxonomy).

Ready to continue?"

### Step 6: Validation Results

**If all PASS**:
"✅ **Validation complete!** You understand core LiveSpec concepts:
- Phases (WHEN) vs Layers (WHERE)
- Workspace scope for your domain
- Strategic vs Behavioral specifications
- Generated artifacts organization

You're ready to implement LiveSpec confidently. Next steps:
- Continue with Quick Start or Customize Workspace
- Refer to AGENTS.md when questions arise
- Check `specs/2-strategy/layer-definitions.spec.md` for deep architectural understanding"

**If any FAIL** (but user corrected after guidance):
"✅ **Validation complete** (with corrections). You now understand:
- Phases (WHEN) vs Layers (WHERE)
- Workspace scope for your domain
- Strategic vs Behavioral specifications
- Generated artifacts organization

**Recommended**: Bookmark these sections in AGENTS.md for reference:
- ⚠️ CRITICAL DISTINCTION: Phases vs Layers
- Folder Organization Decision Tests
- Project Taxonomy

Ready to proceed with implementation?"

**If multiple repeated FAILs**:
"⚠️ **Recommendation**: Spend 15-20 minutes reading AGENTS.md sections:
1. 'CRITICAL DISTINCTION: Phases vs Layers' (~302-344)
2. 'Folder Structure Pattern' (~434-469)
3. 'Folder Organization Decision Tests' (~471-500)
4. 'Project Taxonomy' (~187-280)

These concepts are fundamental to correct LiveSpec organization. Understanding them now prevents hours of restructuring later.

Would you like to:
- Take time to read those sections first
- Continue anyway (risk of needing restructure later)
- Use `.livespec/0-define/0b-customize-workspace.md` (includes inline guidance)"

## Output

No files created. This prompt produces validation results and guidance only.

## Validation

- Prompt asks 4 conceptual questions
- Evaluates understanding vs specific PASS/FAIL criteria
- Points to specific documentation sections when gaps identified
- Provides clear next steps based on validation results
- Prevents organizational confusion before implementation starts

## Success Criteria

- Users with weak understanding discover gaps early
- Clear pointers to relevant documentation sections
- Users proceed confidently or know what to study first
- Reduces likelihood of organizational mistakes during implementation
- Takes 5-10 minutes (fast safety check)
