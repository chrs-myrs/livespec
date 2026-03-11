---
criticality: IMPORTANT
failure_mode: Without taxonomy, ecommerce implementation becomes inconsistent and agents confuse checkout logic with operating context
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

  **Workspace Scope** (operating context only):
  - ✅ workspace/constitution.spec.md - Development principles (operating context)
  - ✅ workspace/patterns.spec.md - Naming and format conventions (operating context)
  - ✅ workspace/workflows.spec.md - Development process (operating context)
  - ✅ workspace/taxonomy.spec.md - This classification document (operating context)
  - ❌ NOT workspace: E-commerce specific architecture or checkout processes
    - Examples: "checkout-flow.spec.md", "payment-integration.spec.md", "cart-management.spec.md"
    - These define HOW THIS E-COMMERCE SYSTEM works (product strategy/behaviors), not operating context
    - Correct location: specs/strategy/architecture.spec.md (system design) or specs/features/ (checkout behaviors)
    - Test: "Is this ABOUT the workspace or IN the workspace?" → IN = Not workspace

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
  - Example: ✅ specs/features/cart-management.spec.md (defines cart behavior), ❌ src/components/Cart.tsx (actual implementation)

  **AI agents must**:
  - Check this taxonomy.spec.md FIRST before creating files
  - Verify workspace/ additions pass "about vs in" test ("Is this ABOUT the workspace?" → YES = workspace)
  - Keep code, builds, and implementation details OUT of specs/
  - Place e-commerce architecture in specs/strategy/, NOT workspace/
  - Place checkout behaviors in specs/features/, NOT workspace/
  - Follow React/TypeScript conventions for code organization (src/components/, src/hooks/, src/utils/)
  - Follow build tool conventions for artifact locations (dist/, build/)
  - Update this taxonomy when project classification fundamentally changes

## Validation
- All workspace/ files are operating context (pass "about vs in" test)
- specs/ contains only .spec.md files (no code, configs, or build artifacts)
- Source code clearly separated from specifications (src/ vs specs/)
- E-commerce architecture/behaviors placed in appropriate specs/ subdirectories, not workspace/
- Build outputs follow standard toolchain conventions (dist/, build/)
- React/TypeScript project structure conventions followed
