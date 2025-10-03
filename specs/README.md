# LiveSpec Specifications

This folder contains all specifications for LiveSpec v2.

## Structure

- **workspace/**: How LiveSpec is developed (development methodology, patterns, workflows)
- **behaviors/**: Observable behaviors of LiveSpec (what it does)
- **contracts/**: API contracts (if any - currently none for v2)
- **problem.md**: The core problem LiveSpec solves
- **constraints.md**: Hard boundaries that must be respected

## Format

All specifications follow MSL (Minimal Specification Language) format:

```markdown
# [Name]
**Criticality**: CRITICAL | IMPORTANT
**Failure Mode**: [What breaks]

## Specification
[Minimal description]

## Validation
[How to verify]
```

## Purpose

These specifications define LiveSpec itself using LiveSpec methodology (dogfooding). They demonstrate:
- How to structure specifications
- How to write MSL format
- How to separate workspace from product specs
- How to keep specifications minimal yet complete
