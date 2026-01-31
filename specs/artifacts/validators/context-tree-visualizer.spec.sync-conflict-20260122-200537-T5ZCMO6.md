---
criticality: IMPORTANT
failure_mode: Without link-based visualization, developers cannot understand the actual contextual relationships and how agent context expands through document references
governed-by:
  - specs/workspace/patterns.spec.md
satisfies:
  - specs/workspace/agent-contexts.spec.md
---

# Context Tree Visualizer

## Requirements

- [!] Tool visualizes link-based context tree showing actual document references
  - Parses root AGENTS.md to extract ctxt/* references (Level 1 → Level 2)
  - Parses each ctxt/* file to extract references to specs, workflows, other ctxt files (Level 2 → Level 3+)
  - Builds dependency graph showing actual link relationships
  - Displays as ASCII tree where each level represents files linked by parent level
  - Shows duplicates where same file referenced by multiple contexts
  - Includes files outside ctxt/ folder (specs/*, .livespec/*)
  - Annotates with file sizes and load trigger keywords

- [!] Output provides actionable insights
  - Shows total context size if all links loaded
  - Highlights budget violations (>100KB total context)
  - Identifies duplicate references (same file in multiple branches)
  - Color-codes by file type (ctxt=blue, specs=green, prompts=yellow)

- [!] Tool is self-documenting and maintainable
  - Usage examples in help text
  - Script location: scripts/visualize-context-tree.sh
  - No external dependencies beyond bash, grep, find

## Validation

- [ ] Correctly parses AGENTS.md "When to Load Sub-Agents" section
- [ ] Extracts all ctxt/* references from markdown links
- [ ] Recursively parses ctxt/* files for outbound references
- [ ] Detects references to .livespec/* and specs/* files
- [ ] Shows duplicate nodes where file referenced multiple times
- [ ] Calculates cumulative context size per branch
- [ ] Color output works in standard terminal
- [ ] Help text explains usage clearly
