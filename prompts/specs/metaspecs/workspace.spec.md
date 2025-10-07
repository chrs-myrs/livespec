---
criticality: CRITICAL
failure_mode: Without workspace spec requirements, workspace specs become product-specific and lose portability
constrained_by:
  - .livespec/specs/metaspecs/base.spec.md
---

# Workspace Specification Requirements

## Requirements
- [!] Workspace specifications define portable development methodology that applies to any project using LiveSpec.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located in `specs/workspace/` folder
  - Spec describes HOW to build (process, not product)
  - Spec is portable (could be copied to different project)
  - Spec does NOT include product-specific requirements
  - Spec does NOT include technical implementation details
  - Spec does NOT reference project-specific features
  - Spec includes `applies_to` frontmatter field (e.g., `all_projects`, `all_ai_agents`)
  - Decision test passes: "Could I use this spec in a different project?" → YES

## Notes

**Common workspace specs:**
- `constitution.spec.md` - Development principles and governance
- `patterns.spec.md` - Naming conventions, code patterns, spec structure
- `workflows.spec.md` - Development workflows (how to add features, fix bugs)

**Good workspace requirements:**
- ✅ "All specs follow MSL format" (applies to any project)
- ✅ "Feature development follows spec → implement → test workflow" (portable process)
- ✅ "Commits reference relevant spec files" (general practice)

**Not workspace requirements:**
- ❌ "API endpoints use REST" (product-specific → strategy spec)
- ❌ "Database uses PostgreSQL" (product-specific → strategy spec)
- ❌ "User authentication required" (product behavior → behavior spec)

**Key distinction:**
- Workspace = "Here's how we work on ANY project"
- Strategy = "Here's how THIS project solves its problem"

Workspace specs go in target project's `specs/workspace/` folder.
