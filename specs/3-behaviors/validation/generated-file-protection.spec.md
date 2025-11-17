---
criticality: IMPORTANT
failure_mode: Direct edits to generated files bypass source-of-truth, cause regeneration conflicts, and violate methodology
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/architecture.spec.md
---

# Generated File Protection

## Requirements

- [!] System detects and prevents direct edits to generated files, enforcing source-of-truth discipline and preventing methodology violations.
  - Generated files marked with standard headers ("DO NOT EDIT", "Generated from:", generation timestamp)
  - Validation detects when generated file modified after sources
  - Validation detects when generated file modified without regeneration
  - Reports which source files should be updated instead
  - Suggests regeneration command when sources changed
  - Can block commits via git hook (optional)
  - Handles partial generation (files with manual sections)

## Validation

- Validator detects generated file markers (headers, frontmatter)
- Validator compares file timestamps (generated vs sources)
- Validator reports direct edits with evidence
- Validator suggests correct workflow (update sources, regenerate)
- Validator handles files with manual sections correctly
- Validator can run pre-commit or on-demand

## Examples

**Generated file with proper markers:**
```markdown
<!--
DO NOT EDIT: This file is generated from specs/workspace/*.spec.md and PURPOSE.md

To update this file:
1. Edit the source specifications in specs/workspace/
2. Run: Use prompts/4-evolve/4d-regenerate-context.md

Generated: 2025-10-12T10:30:00Z
Generator: livespec/prompts/4-evolve/4d-regenerate-context.md
Version: 2.4.0
-->

# AGENTS.md

...
```

**Detection of direct edit:**
```
❌ ERROR: AGENTS.md modified after sources
- AGENTS.md last modified: 2025-10-12 11:00:00
- specs/workspace/constitution.spec.md last modified: 2025-10-12 09:00:00
- AGENTS.md header says: Generated: 2025-10-12T10:30:00Z

This violates generated file discipline.

To fix:
1. Revert AGENTS.md to last generated version
2. Edit source specs in specs/workspace/
3. Regenerate: Use prompts/4-evolve/4d-regenerate-context.md
```

**Partial generation (file with manual sections):**
```markdown
<!--
PARTIALLY GENERATED: This file combines generated content with manual sections

Generated sections are marked with:
<!-- GENERATED SECTION START: [section-name] -->
...
<!-- GENERATED SECTION END: [section-name] -->

Manual sections are marked with:
<!-- MANUAL SECTION START: [section-name] -->
...
<!-- MANUAL SECTION END: [section-name] -->

DO NOT EDIT generated sections directly. Edit sources and regenerate.
Manual sections may be edited freely.
-->
```

## Generation Markers

**Standard header format:**
```markdown
<!--
DO NOT EDIT: This file is generated

Sources:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md

Regeneration:
  Use: prompts/4-evolve/4d-regenerate-context.md

Generated: [ISO-8601 timestamp]
Generator: [prompt or script path]
Version: [LiveSpec version]
-->
```

**Frontmatter format (for specs that generate other specs):**
```yaml
---
generated: 2025-10-12T10:30:00Z
generator: prompts/utils/generate-self-improvement.md
generated_from:
  - PURPOSE.md
  - specs/workspace/constitution.spec.md
  - specs/1-requirements/strategic/outcomes.spec.md
---
```

## Failure Scenarios

**If generated file edited directly:**
- Validation fails with ERROR
- Reports timestamp evidence
- Shows which sources should be updated
- Suggests regeneration command
- Blocks commit if running in git hook

**If sources changed but file not regenerated:**
- Validation warns with WARNING
- Reports which sources changed
- Suggests regeneration command
- Does not block commit (maybe intentional staging)

**If partial generation markers violated:**
- Validation fails with ERROR if generated section edited
- Validation allows edits to manual sections
- Reports specific section violations
