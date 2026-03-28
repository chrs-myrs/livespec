---
criticality: CRITICAL
failure_mode: Without workspace spec requirements, workspace specs blur operating context vs deliverable boundary
governed-by:
  - ./base.spec.md
---

# Workspace Specification Requirements

## Requirements
- [!] Workspace specifications define operating context for how agents, humans, and the workspace interact.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located in `specs/workspace/` folder
  - Spec describes HOW we operate (process, not product deliverables)
  - Spec is ABOUT the workspace (operating context)
  - Spec does NOT include product-specific requirements
  - Spec does NOT include technical implementation details
  - Spec does NOT reference product features
  - Spec includes `applies_to` frontmatter field (e.g., `all_projects`, `all_ai_agents`)
  - Workspace constitution MAY include `context_compression` frontmatter field (light | moderate | aggressive; default: moderate if unspecified)
  - Decision test passes: "Is this ABOUT the workspace or IN the workspace?" → ABOUT

## Notes

**Common workspace specs:**
- `constitution.spec.md` - Development principles and governance
- `patterns.spec.md` - Naming conventions, code patterns, spec structure
- `workflows.spec.md` - Development workflows (how to add features, fix bugs)

**Good workspace requirements:**
- ✅ "All specs follow MSL format" (operating convention)
- ✅ "Feature development follows spec → implement → test workflow" (operating process)
- ✅ "Commits reference relevant spec files" (operating practice)

**Not workspace requirements:**
- ❌ "API endpoints use REST" (product deliverable → strategy spec)
- ❌ "Database uses PostgreSQL" (product deliverable → strategy spec)
- ❌ "User authentication required" (product deliverable → behavior spec)

**Key distinction:**
- Workspace = "Here's how we operate" (operating context)
- Strategy = "Here's how THIS project solves its problem" (deliverable)

Workspace specs go in target project's `specs/workspace/` folder.
