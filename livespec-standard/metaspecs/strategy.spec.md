---
criticality: CRITICAL
failure_mode: Without strategy spec requirements, technical decisions scatter across behavior specs or mix with portable workspace methodology
constrained_by:
  - livespec-standard/metaspecs/base.spec.md
---

# Strategy Specification Requirements

## Requirements
- [!] Strategy specifications define product-specific technical decisions and architecture for THIS project.
  - Spec follows base.spec.md requirements (MSL + criticality + failure_mode)
  - Spec located in `specs/strategy/` folder (single file) or `specs/strategy/*.spec.md` (multiple files)
  - Spec describes HOW this specific product solves its problem technically
  - Spec is product-specific (NOT portable to other projects)
  - Spec includes technical approach, components, interactions
  - Spec does NOT include observable user behaviors (→ behavior specs)
  - Spec does NOT include portable process methodology (→ workspace specs)
  - Simple projects use single `strategy/architecture.spec.md` file
  - Complex projects split by concern (`integration.spec.md`, `data.spec.md`, `security.spec.md`, `deployment.spec.md`)
  - Each strategy file stays minimal (<100 lines for single file, <50 lines per split file)
  - Decision test fails: "Could I use this spec in a different project?" → NO (correct)

## Notes

**Common strategy specs:**
- `architecture.spec.md` - System structure, components, technical approach
- `integration.spec.md` - APIs, messaging, service communication (if split)
- `data.spec.md` - Storage, caching, data flow (if split)
- `security.spec.md` - Authentication, authorization, encryption (if split)
- `deployment.spec.md` - Infrastructure, CI/CD, environments (if split)

**Good strategy requirements:**
- ✅ "REST API server handles HTTP requests" (technical component)
- ✅ "PostgreSQL stores persistent data" (technical decision)
- ✅ "JWT tokens authenticate API requests" (technical mechanism)

**Not strategy requirements:**
- ❌ "Users can log in" (user behavior → behavior spec)
- ❌ "All specs follow MSL format" (portable process → workspace spec)
- ❌ "Code reviewed before merging" (portable workflow → workspace spec)

**Scaling guidance:**
- Start with single `architecture.spec.md`
- When it exceeds ~100 lines, split by concern
- Each split file should be <50 lines (keep minimal)

Strategy specs go in target project's `specs/strategy/` folder.
