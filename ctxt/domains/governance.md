# Governance Domain Patterns

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Governance domain projects produce methodology frameworks, policies, procedures, and process documentation. LiveSpec itself is a governance project—it develops specifications about specification-driven development.

**Key characteristic:** Outputs are guidance for other projects, not user-facing products.

## Domain-Specific Patterns

### Dogfooding Pattern (Critical for Governance)

**What it means:**
- Governance projects use their own methodology to develop themselves
- LiveSpec uses LiveSpec methodology to evolve LiveSpec
- Policies are written following the policy-writing framework
- Procedures are documented following the procedure-documentation process

**Why it matters:**
- Validates methodology works in practice
- Identifies gaps and pain points
- Demonstrates patterns for users
- Builds credibility ("we use this ourselves")

**Implementation:**
```
LiveSpec (governance project):
├── specs/workspace/           # HOW LiveSpec develops itself (dogfooding)
│   ├── constitution.spec.md   # LiveSpec's development principles
│   ├── patterns.spec.md       # LiveSpec's conventions
│   └── workflows.spec.md      # LiveSpec's process
│
├── specs/2-strategy/          # LiveSpec's architecture
│   └── distribution.spec.md   # How framework reaches users
│
└── specs/3-behaviors/         # LiveSpec's prompts as behaviors
    └── prompts/*.spec.md      # What each prompt does
```

### Framework Distribution Pattern

**Challenge:** Governance projects produce frameworks that other projects copy.

**Solution:**
```
livespec (source repo):
├── specs/                     # Source of truth (specifications)
├── dist/                      # Distributable framework (what users copy)
│   ├── prompts/              # Phase 0-4 prompts
│   ├── guides/               # MSL, TDD, etc.
│   ├── standard/             # Metaspecs, conventions
│   └── templates/            # Reusable content
└── AGENTS.md                  # Generated (from specs/workspace/)

target-project (user's repo):
└── .livespec/                 # Copied from livespec/dist/
    ├── prompts/
    ├── guides/
    └── ...
```

**Key insight:** `specs/` governs LiveSpec's development, `dist/` is distributed product.

### Specs About Specs Pattern

**Governance projects have specs at two levels:**

1. **Meta-level** (specs about the framework):
   ```
   specs/3-behaviors/prompts/0a-quick-start.spec.md
   → Defines what 0a-quick-start.md prompt does
   ```

2. **Metaspec level** (templates for specs):
   ```
   .livespec/standard/metaspecs/behavior.spec.md
   → Defines structure of ALL behavior specs
   ```

**Avoid confusion:** Metaspecs are templates, not instances.

### Learning Distribution Pattern

**When governance project learns something (e.g., violation detected):**

1. **Capture learning in template:**
   ```
   .livespec/templates/agents/spec-first-enforcement.md
   → Reusable verification content
   ```

2. **Update spec to mandate template:**
   ```
   specs/workspace/workflows.spec.md
   → "Agents use spec-first-enforcement template"
   ```

3. **Update prompt to reference template:**
   ```
   .livespec/prompts/4-evolve/4d-regenerate-agents.md
   → Includes template in AGENTS.md generation
   ```

4. **Regenerate AGENTS.md:**
   ```
   AGENTS.md now contains template content
   ```

5. **Copy to dist/:**
   ```
   dist/AGENTS.md, dist/templates/agents/*
   → Target projects receive improvement automatically
   ```

**Result:** Learnings flow from violations → templates → specs → prompts → AGENTS.md → dist/ → target projects

## Folder Organization (Governance Projects)

### Workspace Scope Test

**"Could I use this spec in ANY project?"**

**YES → workspace/ (portable methodology):**
- constitution.spec.md - Development principles (ANY project can use these)
- patterns.spec.md - MSL format, naming (ANY project can follow)
- workflows.spec.md - Spec-first workflow (ANY project can adopt)

**NO → strategy/behaviors/ (framework-specific):**
- distribution.spec.md - How LiveSpec distributes (specific to frameworks)
- prompt-behaviors.spec.md - What prompts do (specific to LiveSpec)

**Special case:** LiveSpec's workspace/ specs ARE demonstrating the framework (dogfooding), but they define HOW LIVESPEC DEVELOPS ITSELF, not the framework being distributed.

### Specs Boundary

**specs/ = specifications only (not distributable framework)**

**Inside specs/:**
- Behavior specs (what prompts do)
- Strategy specs (framework architecture)
- Requirements (framework outcomes)

**Outside specs/:**
- dist/ (distributable framework - what users copy)
- AGENTS.md (generated configuration)
- tests/ (validation)
- examples/ (demonstration)

**Test:** "Is this defining WHAT framework does, or IS this the framework itself?"
- Defining WHAT → specs/
- IS the framework → dist/

## Common Behaviors (Governance Domain)

### Policy Development
- Policy drafts follow policy-writing framework
- Policies have specifications (intended outcomes)
- Policy effectiveness measured against specs

### Procedure Documentation
- Procedures follow procedure-documentation template
- Procedures have contracts (exact steps)
- Procedure compliance validated

### Framework Development
- Framework has specifications (behaviors, prompts, guides)
- Framework dogfoods its own methodology
- Framework distribution follows distribution spec

### Methodology Evolution
- Learnings captured in templates
- Violations trigger methodology updates
- Changes flow through distribution mechanism

## Examples

### Example 1: Adding New Prompt (Governance Project)

```bash
# Step 1: Create behavior spec FIRST
Use .livespec/1-design/1c-define-behaviors.md
# Creates: specs/3-behaviors/prompts/0g-new-prompt.spec.md

# Step 2: Implement prompt
Use .livespec/2-build/2a-implement-from-specs.md
# Creates: .livespec/prompts/0-define/0g-new-prompt.md

# Step 3: Update registry
# Edit: specs/3-behaviors/prompts/registry.spec.md

# Step 4: Update distribution
# Copy: .livespec/prompts/0-define/0g-new-prompt.md → dist/prompts/0-define/

# Step 5: Regenerate agents
Use .livespec/4-evolve/4d-regenerate-agents.md
# Updates: AGENTS.md (references new prompt)

# Result: New prompt distributed to target projects
```

### Example 2: Capturing Violation Learning

```bash
# Violation detected: Agent skipped spec-first check

# Step 1: Create template
# Write: .livespec/templates/agents/spec-first-enforcement.md
# Contains: Reusable verification checklist

# Step 2: Update workflow spec
# Edit: specs/workspace/workflows.spec.md
# Mandate: "Use spec-first-enforcement template"

# Step 3: Update regeneration prompt
# Edit: specs/3-behaviors/prompts/4d-regenerate-agents.spec.md
# Require: Include template in AGENTS.md

# Step 4: Regenerate
Use .livespec/4-evolve/4d-regenerate-agents.md
# AGENTS.md now has spec-first enforcement inline

# Step 5: Copy to dist/
cp AGENTS.md dist/AGENTS.md
cp .livespec/templates/agents/spec-first-enforcement.md dist/templates/agents/

# Result: Target projects get improved methodology automatically
```

### Example 3: Dogfooding Validation

```bash
# Build new feature (e.g., session completion)

# Step 1: Use LiveSpec's own Phase 1 (DESIGN)
Use .livespec/1-design/1c-define-behaviors.md
# Creates: specs/3-behaviors/session-completion.spec.md

# Step 2: Use LiveSpec's own Phase 2 (BUILD)
Use .livespec/2-build/2b-create-tests.md
Use .livespec/2-build/2a-implement-from-specs.md
# Creates: tests + implementation

# Step 3: USE THE FEATURE in current session
# Run: .livespec/prompts/utils/complete-session.md
# Discovers: Version drift bug (dogfooding found gap)

# Step 4: Fix bug before committing
# Update: specs/3-behaviors/session-completion.spec.md
# Fix: Implementation

# Result: Dogfooding prevented shipping broken feature
```

## Decision Points

**Is this workspace/ or strategy/?**
- Test: "Could ANY project use this?" → YES = workspace/
- Example: "Use MSL format" → workspace/ (anyone can use)
- Example: "Distribute via dist/" → strategy/ (framework-specific)

**Is this specs/ or dist/?**
- Test: "Is this defining framework or IS the framework?"
- Defining → specs/ (specifications)
- IS → dist/ (distributable product)

**Should I dogfood this?**
- YES if: Governance project (always dogfood)
- Validates methodology works
- Demonstrates patterns
- Builds credibility

**When do learnings reach target projects?**
- Template created → Spec updated → Prompt updated → AGENTS.md regenerated → Copied to dist/
- Target projects copy dist/ → They get improvements

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Taxonomy: specs/workspace/taxonomy.spec.md (project classification)
- Distribution: specs/workspace/distribution.spec.md (framework patterns)
- Workflows: specs/workspace/workflows.spec.md (learning distribution)

**Cross-references:**
- Phase 0-4: Apply to governance projects (dogfooding)
- Constitution: specs/workspace/constitution.spec.md (dogfooding principle)

---

*Governance domain specialist for LiveSpec*
*Parent: AGENTS.md*
