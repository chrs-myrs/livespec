# LiveSpec Specifications

This folder contains all specifications for LiveSpec v2.

## Structure

- **workspace/**: How LiveSpec is developed (development methodology, patterns, workflows)
- **behaviors/**: Observable behaviors of LiveSpec (what it does)
- **contracts/**: API contracts (if any - currently none for v2)
- **problem.md**: The core problem LiveSpec solves
- **constraints.md**: Hard boundaries that must be respected

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
