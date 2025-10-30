---
criticality: IMPORTANT
failure_mode: Without audit specification, context compression measurement is undefined and compression level migration is unreliable
specifies: dist/prompts/utils/audit-context-compression.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
---

# Prompt Behavior: Audit Context Compression

## Requirements
- [!] Prompt measures project's actual context compression level and compares against declared target, producing recommendations for optimization or migration if misalignment detected.
  - Measures AGENTS.md size (current vs target for compression level)
  - Calculates extraction ratio (inline content vs referenced content)
  - Measures reference depth (direct vs hierarchical references)
  - Analyzes example coverage (inline snippets vs separate files)
  - Compares actual metrics against declared compression level (light/moderate/aggressive)
  - Identifies content suitable for extraction (repeated patterns, large examples)
  - Produces migration plan if level change needed (extract operations, inline operations)
  - Reports compression effectiveness (80/20 principle: 80% cases handled without fetching?)
  - Recommends compression level adjustment if actual usage doesn't match declared
  - Provides before/after size estimates for proposed changes

## Validation
- Prompt accurately measures AGENTS.md size and extraction ratio
- Comparison against compression targets is correct (light >85KB, moderate 70-85KB, aggressive <70KB)
- Migration recommendations are actionable (specific files to extract/inline)
- Audit identifies over-compressed (agents must fetch too often) and under-compressed (AGENTS.md too large) states
- Recommendations preserve 80/20 principle (common operations remain fast)
