---
criticality: IMPORTANT
failure_mode: Without taxonomy, ecommerce implementation becomes inconsistent and agents confuse checkout logic with portable methodology
applies_to: this_project
governed-by:
  - .livespec/standard/metaspecs/taxonomy.spec.md
---

# E-Commerce Checkout Project Taxonomy

## Requirements
- [!] This project is classified as SOFTWARE domain (web application) with explicit workspace scope and specs boundary to prevent organizational confusion.

  **Project Domain**: Software
  - This project produces a web-based e-commerce checkout system
  - Primary pattern: specs/ define behavior → src/ implements → dist/ contains build artifacts
  - Technology: React/TypeScript web application with backend API integration

  **Workspace Scope** (portable methodology only):
  - ✅ workspace/constitution.spec.md - Development principles (portable)
  - ✅ workspace/patterns.spec.md - Naming and format conventions (portable)
  - ✅ workspace/workflows.spec.md - Development process (portable)
  - ✅ workspace/taxonomy.spec.md - This classification document (portable)
  - ❌ NOT workspace: E-commerce specific architecture or checkout processes
    - Examples: "checkout-flow.spec.md", "payment-integration.spec.md", "cart-management.spec.md"
    - These define HOW THIS E-COMMERCE SYSTEM works (product strategy/behaviors), not HOW to build any project (methodology)
    - Correct location: specs/2-strategy/architecture.spec.md (system design) or specs/3-behaviors/ (checkout behaviors)
    - Test: "Could a documentation project use this exact spec?" → NO → Not workspace

  **Specs Boundary** (specifications only, no code/data):
  - specs/ contains ONLY .spec.md files defining observable system behavior
  - Implementation and artifacts live OUTSIDE specs/:
    - Source code → src/ folder (React components, business logic)
    - Build artifacts → dist/, build/ folders (gitignored - webpack output)
    - Test code → tests/ folder (unit tests, integration tests)
    - Configuration → config/ or root-level config files (webpack.config.js, tsconfig.json)
    - Static assets → public/, assets/ folders (images, CSS)
    - Transient work → var/ folder (gitignored)
  - specs/ defines WHAT checkout system does (cart management, payment processing, order confirmation)
  - specs/ NEVER contains actual code, build outputs, or test implementations
  - Example: ✅ specs/3-behaviors/cart-management.spec.md (defines cart behavior), ❌ src/components/Cart.tsx (actual implementation)

  **AI agents must**:
  - Check this taxonomy.spec.md FIRST before creating files
  - Verify workspace/ additions pass portability test ("works in ANY project?" → YES = workspace)
  - Keep code, builds, and implementation details OUT of specs/
  - Place e-commerce architecture in specs/2-strategy/, NOT workspace/
  - Place checkout behaviors in specs/3-behaviors/, NOT workspace/
  - Follow React/TypeScript conventions for code organization (src/components/, src/hooks/, src/utils/)
  - Follow build tool conventions for artifact locations (dist/, build/)
  - Update this taxonomy when project classification fundamentally changes

## Validation
- All workspace/ files are portable methodology (pass "any project" test)
- specs/ contains only .spec.md files (no code, configs, or build artifacts)
- Source code clearly separated from specifications (src/ vs specs/)
- E-commerce architecture/behaviors placed in appropriate specs/ subdirectories, not workspace/
- Build outputs follow standard toolchain conventions (dist/, build/)
- React/TypeScript project structure conventions followed
