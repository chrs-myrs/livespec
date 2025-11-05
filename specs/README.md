# LiveSpec Specifications

This folder contains all specifications for LiveSpec v3.2.1.

**CRITICAL**: Before creating any files, check `specs/workspace/taxonomy.spec.md` - it defines LiveSpec's project classification.

## Structure

- **workspace/**: How LiveSpec is developed (portable methodology)
  - **taxonomy.spec.md**: Project classification - CHECK THIS FIRST
  - constitution.spec.md, patterns.spec.md, workflows.spec.md
- **1-requirements/**: Strategic and functional requirements
  - **strategic/**: High-level outcomes and constraints
  - **functional/**: Feature-level requirements
- **2-strategy/**: Technical approach and architecture
- **3-behaviors/**: Observable behaviors (what LiveSpec does)
- **3-contracts/**: API contracts (currently minimal for governance project)

## LiveSpec's Taxonomy

LiveSpec is a **Governance domain** project:
- Produces methodology frameworks (not software products)
- Pattern: specs/ (source) → dist/ (distributable framework)
- Dogfooding: LiveSpec uses its own methodology

## Format

All specifications follow [MSL (Markdown Specification Language)](https://github.com/chrs-myrs/msl-specification) format:

```markdown
---
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks]
---

# [Name]

## Requirements
- [!] [Minimal description]
  - [How to verify criterion 1]
  - [How to verify criterion 2]
```

## Purpose

These specifications define LiveSpec itself using LiveSpec methodology (dogfooding). They demonstrate:
- How to structure specifications
- How to write MSL format
- How to separate workspace from product specs
- How to keep specifications minimal yet complete
