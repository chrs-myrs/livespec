# LiveSpec Agent Bootstrap

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

---

## Summary

This is a **bootstrap agent configuration**. Once your workspace specs are established, regenerate this file to create your full context tree.

**What you're seeing**: Minimal guidance for new projects before workspace customization.

**What you need**: Full agent context tree (AGENTS.md + ctxt/) generated from YOUR workspace specifications.

**Why**: Agent guidance must reflect YOUR project's purpose, domain, constraints, and patterns - not generic methodology.

---

## Quick Start for New Projects

**If starting fresh**:
1. **Install LiveSpec** (if not already present):
   - **Recommended**: `bash scripts/install-livespec.sh` (auto-detects best method)
   - **Alternative methods**: See `README.md` in this directory for sparse submodule, full submodule, or copy options
   - **Verify**: Check that `.livespec/VERSION` exists after installation
2. Run Phase 0: Use `.livespec/0-define/0a-quick-start.md` (5 min, defaults) OR `.livespec/0-define/0b-customize-workspace.md` (20-30 min, full customization)
3. Phase 0 will establish workspace specs (constitution, patterns, workflows)
4. **Immediately after Phase 0**: Regenerate this file using `.livespec/prompts/utils/regenerate-contexts.md`

**Why regenerate immediately**: This bootstrap lacks YOUR project context. Regenerated AGENTS.md will include:
- YOUR project purpose and success criteria
- YOUR domain classification (software/governance/hybrid)
- YOUR development principles and constraints
- YOUR specialized agent contexts (phase/domain/utility specialists)
- Proactive loading (agents load specialized contexts based on YOUR work)

---

## Generate Full Context Tree

**Prerequisites** (established by Phase 0):
- specs/workspace/constitution.spec.md (development principles)
- specs/workspace/patterns.spec.md (conventions)
- specs/workspace/workflows.spec.md (5 phases)
- specs/workspace/agent-contexts.spec.md (context structure)
- PURPOSE.md (project vision)

**Command**:
```
Use .livespec/prompts/utils/regenerate-contexts.md
```

**What this generates**:
- **Root AGENTS.md** (30-40KB): Routing to specialized contexts, compressed methodology
- **ctxt/phases/**: 5 phase specialists (0-define through 4-evolve)
- **ctxt/domains/**: Domain-specific patterns (based on YOUR taxonomy)
- **ctxt/utils/**: Utility specialists (session completion, drift detection, MSL audit)

**Proactive loading**: Agents will autonomously load specialized contexts based on your task. You don't manage contexts - agents do.

---

## Before Context Tree Exists

**Until you regenerate**, here are the absolute essentials:

### ⚠️ CRITICAL: Spec-First

Every deliverable requires specification before implementation:
- Code, prompts, templates, documentation, configs ALL need specs
- Even "obvious" deliverables need specs (README, CHANGELOG, .gitignore)
- Create spec FIRST, then implement

**Four-layer enforcement**:
1. **TodoWrite gate**: Add "Create spec for [file]" todo BEFORE file creation
2. **Validation tool**: Run `scripts/check-requires-spec.sh path/to/file`
3. **Plan mode**: Present plan showing spec creation step
4. **Permanent test**: "Is this committed to git?" → YES = needs spec

### MSL Format (Minimal)

Specifications use MSL (Markdown Specification Language):

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: What breaks without this
---

# Feature/Component Name

## Requirements
- [!] Concise description of WHAT (not HOW)
  - Testable criterion 1
  - Testable criterion 2
  - Testable criterion 3
```

**That's it**: Title, frontmatter, Requirements. Keep minimal.

### MSL Minimalism

Before adding any requirement, ask:
1. **Is this essential?** Would system fail without it?
2. **Am I specifying HOW instead of WHAT?** Implementation detail?
3. **What specific problem does this prevent?** Theoretical only?
4. **Could this be inferred?** Standard practice?

Only include if answers YES, NO, specific problem, NO respectively.

### Folder Organization Decision Tests

**Critical for proper spec placement:**

**workspace/ test:** "Could I copy this spec to ANY project?"
- YES → workspace/ (portable process)
- NO → Check 1-requirements/, 2-strategy/, or 3-behaviors/

**1-requirements/ test:** "Is this a strategic outcome or hard constraint?"
- YES, strategic → 1-requirements/strategic/
- YES, functional → 1-requirements/functional/
- NO → Check 2-strategy/ or 3-behaviors/

**2-strategy/ test:** "Does this apply across the whole product?"
- YES → 2-strategy/ (cross-cutting architecture)
- NO → Check 3-behaviors/

**3-behaviors/ test:** "Is this an observable outcome?"
- YES → 3-behaviors/ (what system does)
- NO → Re-examine classification

**Common mistakes**:
- ❌ "API returns JSON" → NOT workspace → 2-strategy/
- ❌ "Use MSL format" → NOT strategy → workspace/
- ❌ "User can login" → NOT strategy → 3-behaviors/

**Correct examples**:
- ✅ "Use MSL format for all specs" → workspace/patterns.spec.md
- ✅ "API responses must be JSON" → 2-strategy/architecture.spec.md
- ✅ "System authenticates users via OAuth" → 3-behaviors/authentication.spec.md

### Folder Structure (Minimal)

```
your-project/
├── PURPOSE.md              # Why this exists
├── .livespec/              # Copied from livespec/dist/
└── specs/
    ├── workspace/          # HOW you work (process)
    ├── 1-requirements/     # WHY (strategic/functional requirements)
    ├── 2-strategy/         # HOW (architectural approach)
    ├── 3-behaviors/        # WHAT (observable outcomes)
    └── 3-contracts/        # WHAT (interfaces)
```

---

## The 5 Phases (Minimal)

**Phase 0: DEFINE** - Problem space, constraints, workspace
**Phase 1: DESIGN** - Architecture, behaviors, contracts
**Phase 2: BUILD** - Test-driven implementation
**Phase 3: VERIFY** - Validation testing
**Phase 4: EVOLVE** - Spec-code synchronization

**Start with**: Phase 0 (`0a-quick-start.md` or `0b-customize-workspace.md`)

---

## Why You Need Full Context Tree

**This bootstrap cannot**:
- Tell you YOUR project's purpose
- Know YOUR domain classification
- Guide YOUR specific constraints
- Apply YOUR compression level
- Provide specialized phase guidance
- Load contexts proactively for YOUR work

**Full context tree provides**:
- Specialized agent contexts (phases, domains, utilities)
- Proactive loading (agent decides what context to load)
- Compressed root + focused sub-agents
- YOUR project's methodology, not generic LiveSpec
- Better focus efficiency (60% vs 20% signal-to-noise)

---

## What Happens When You Regenerate

**Reading sources**:
- PURPOSE.md → Your project vision
- specs/workspace/*.spec.md → Your development governance
- Compression level → From constitution.spec.md
- Domain classification → From taxonomy.spec.md

**Generating tree**:
- Root AGENTS.md (30-40KB, routing)
- ctxt/phases/ (5 phase specialists)
- ctxt/domains/ (YOUR domain patterns)
- ctxt/utils/ (3 utility specialists)

**Result**: Agent guidance tailored to YOUR project, with specialized contexts loaded proactively.

---

## Next Steps

1. **New project?** → Run Phase 0 (0a-quick-start or 0b-customize-workspace)
2. **Phase 0 complete?** → Regenerate this file (`.livespec/prompts/utils/regenerate-contexts.md`)
3. **Context tree exists?** → Agent will load specialized contexts as you work
4. **Need guidance?** → Use `.livespec/utils/next-steps.md`

---

## Technical Notes

**Why no frontmatter**: Frontmatter adds noise to agent context. Full AGENTS.md also has no frontmatter - clean context for agents.

**Why regenerate**: This bootstrap is generic. Your agent needs YOUR project context, not template guidance.

**Frequency**: Regenerate when workspace specs change, PURPOSE.md updates, or after LiveSpec version upgrades.

**Distribution**: This bootstrap lives in dist/ and gets copied to new projects. Full AGENTS.md + ctxt/ are generated per-project from workspace specs.

---

*Bootstrap agent for LiveSpec - Regenerate after Phase 0 workspace setup*
*For methodology details, see `.livespec/` directory after copying dist/*
