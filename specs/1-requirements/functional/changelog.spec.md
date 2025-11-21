---
criticality: IMPORTANT
failure_mode: Without structured changelog, users cannot understand version changes or assess upgrade impact, leading to confusion about what improved
governed-by:
  - .livespec/standard/metaspecs/base.spec.md
  - .livespec/standard/metaspecs/behavior.spec.md
notes: |
  This spec was created retrospectively after CHANGELOG.md was implemented.
  Demonstrates the importance of spec-first even for "obvious" deliverables.
  See commit 40411e3 (CHANGELOG implementation) vs this spec (specification).
---

# CHANGELOG Behavior

## Requirements
- [!] CHANGELOG enables users to understand changes between LiveSpec versions and assess upgrade impact.
  - Lists all changed prompts/templates with exact file paths (prompts/0-define/0a-setup-workspace.md format)
  - Explains WHY each change was made (user feedback, bug fix, improvement, real-world issue)
  - Categorizes impact level (BREAKING = incompatible change, FEATURE = new capability, FIX = bug fix, IMPROVEMENT = enhancement)
  - Provides migration guidance for breaking changes (rare)
  - Follows Keep a Changelog format with Added/Changed/Fixed/Removed sections
  - Integrates with upgrade-methodology.md (AI can parse [Unreleased] section and summarize changes)
  - Each released version gets dated entry in format [X.Y.Z] - YYYY-MM-DD
  - [Unreleased] section at top documents uncommitted changes for next release
  - Header section explains how to upgrade (submodule vs copy method)
  - Header links to upgrade-methodology.md prompt
  - New files (templates, utilities) listed with descriptions
  - Metaspec changes noted with backward compatibility status

## Validation

### User Upgrading Framework
User upgrading from v3.6.0 to v3.7.0 can read CHANGELOG and answer:
- **What changed?** "Added value structure traceability, improved documentation"
- **Why changed?** "Enable better requirements tracking and clearer onboarding"
- **Breaking changes?** "None - backwards compatible"
- **How do I upgrade?** "Submodule: `git submodule update --remote`, Copy: manual"

### AI During Upgrade
AI using upgrade-methodology.md can:
- Parse CHANGELOG.md [Unreleased] section
- Summarize changes in user-friendly language
- Identify breaking changes (rare - BREAKING tag)
- Explain upgrade impact (framework changes don't affect project specs)

### Entry Completeness
For each Changed entry:
- **File path**: Exact prompt/template/metaspec path (prompts/X/Y.md)
- **WHY field**: Explanation of reason for change (user feedback, bug, improvement)
- **IMPACT field**: Classification (HIGH IMPACT / MEDIUM IMPACT / LOW IMPACT) with parenthetical context
- **CHANGES field**: Bulleted list of specific modifications
- **MIGRATION field**: Concrete steps for merging into custom version

### History Traceability
Users can:
- Trace decisions across multiple versions (v2.1.0 → v2.1.1 → v2.2.0)
- Understand evolution of methodology (why prompts changed over time)
- Identify when customization conflicts were introduced
- Make informed decisions about when to regenerate from templates vs preserve customizations

### Format Compliance
- Follows Keep a Changelog format (https://keepachangelog.com/)
- Semantic versioning for releases (Major.Minor.Patch)
- Breaking changes clearly documented in release notes
- Links between versions for navigation

## Notes

**Why this spec matters:**

This CHANGELOG was initially created without a specification (commit 40411e3), violating LiveSpec's core principle of spec-before-implementation. This spec was created retrospectively to:

1. **Establish requirements** - Define what CHANGELOG must achieve
2. **Enable validation** - Test if current implementation succeeds
3. **Guide improvements** - Provide success criteria for future changes
4. **Demonstrate vulnerability** - Even "obvious" deliverables need specs

**Lessons learned:**

- Familiarity bias: "Everyone knows what a CHANGELOG is" led to skipping specification
- "Documentation" misconception: Treating CHANGELOG as "just docs" rather than behavior with requirements
- Momentum effect: Rapid execution mode bypassed design phase
- Ironically not dogfooding: Building spec-driven methodology without following spec-driven process

**Related behaviors:**
- upgrade-methodology.md integrates with CHANGELOG (shows version changes during upgrade)
- Framework immutability eliminates customization tracking (no merge conflicts)
- AGENTS.md explains folder organization (references CHANGELOG for version history)

**Validation status:**
Current CHANGELOG.md (as of commit 40411e3) satisfies all requirements above. This spec validates the implementation retrospectively and establishes foundation for future improvements.
