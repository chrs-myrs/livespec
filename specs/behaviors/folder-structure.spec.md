---
criticality: CRITICAL
failure_mode: Without clear folder structure, AI agents cannot find relevant context and users become confused
---

# Folder Structure Behavior

## Requirements
- [!] LiveSpec projects separate workspace specifications (how to build) from product specifications (what to build) using a standardized folder hierarchy.
  - specs/workspace/ contains only development methodology, never product requirements
  - specs/ root or type folders contain product specifications
  - prompts/ organized by 5 phases with consistent naming
  - AI agents can locate relevant context by phase and type
  - Users understand where to add new specifications

## Structure

```
project/
├── specs/
│   ├── workspace/      # How we build (persistent context)
│   ├── behaviors/      # Observable system behaviors
│   ├── contracts/      # API/data contracts (if needed)
│   └── *.md           # High-level specs (problem, constraints)
├── prompts/           # Phase-based prompts
│   ├── 0-define/
│   ├── 1-design/
│   ├── 2-build/
│   ├── 3-verify/
│   └── 4-evolve/
└── [implementation]   # User's code
```
