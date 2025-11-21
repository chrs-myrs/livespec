---
criticality: CRITICAL
failure_mode: Context builder agent produces invalid tree structure, incomplete content, or violates size budgets, resulting in broken agent guidance
derives_from:
  - specs/3-behaviors/context-generation.spec.md
governed_by:
  - .livespec/standard/conventions/context-tree.spec.md
  - .livespec/standard/metaspecs/agent.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 6: Sustainable Evolution)
guided-by:
  - specs/2-strategy/architecture.spec.md
specifies:
  - .claude/agents/context-builder/instructions.md
---

# Context Builder Agent

## Requirements

### Prerequisites Validation

- [!] Agent validates all required source files exist before starting generation
  - Core sources: PURPOSE.md, specs/workspace/*.spec.md (constitution, patterns, workflows, agent-contexts)
  - Templates: .livespec/templates/agents/spec-first-enforcement.md
  - Optional sources: specs/workspace/taxonomy.spec.md, specs/2-strategy/architecture.spec.md
  - VERSION or dist/VERSION for version information
  - Clear error messages identifying missing files
  - Stops immediately if required files missing (no partial generation)
  - Provides guidance to resolve missing files (e.g., "Run Phase 0 first")

### Source Content Extraction

- [!] Agent systematically reads and extracts content from workspace specifications
  - Reads all specs/workspace/*.spec.md files
  - Extracts constitution.spec.md → Core principles (8 principles)
  - Extracts patterns.spec.md → MSL format, naming conventions, folder structure
  - Extracts workflows.spec.md → 5 phases (entry/exit, outputs, key prompts)
  - Extracts taxonomy.spec.md → Project domain classification
  - Extracts agent-contexts.spec.md → Context tree structure requirements
  - Reads PURPOSE.md → Project vision and success criteria
  - Reads compression configuration from constitution.spec.md frontmatter

### Root AGENTS.md Generation

- [!] Agent generates root AGENTS.md with correct structure and size
  - Target size: 30-40KB complete inline content
  - NO frontmatter (clean context for agents)
  - Inline edit warning at top (not in frontmatter)
  - Inlines spec-first enforcement template from .livespec/templates/agents/
  - Inlines core principles compressed from constitution
  - Inlines folder organization tests from taxonomy
  - Includes "When to Load Sub-Agents" section (routing decision tree)
  - Includes Quick Start (80% of cases - Phase 0 bash commands)
  - Includes MSL format quick reference
  - Includes Reference Library (navigation to ctxt/ and .livespec/)
  - NO external references to specs/workspace/*.spec.md (content extracted inline)
  - Applies compression level from configuration

### Phase Sub-Agent Generation

- [!] Agent generates exactly 5 phase sub-agents in ctxt/phases/
  - Files: 0-define.md, 1-design.md, 2-build.md, 3-verify.md, 4-evolve.md
  - Target size per file: 10-15KB
  - NO frontmatter (clean context)
  - Inline edit warning at top
  - Phase-specific methodology content
  - Load triggers matching natural user language
  - References to .livespec/prompts/[phase]/*.md
  - Examples and patterns for phase
  - Reference Library section linking to detailed specs
  - Footer: "Phase [N] specialist for [Project Name] / Parent: AGENTS.md"

### Domain Sub-Agent Generation

- [!] Agent generates domain sub-agents based on taxonomy classification
  - Reads project domain from taxonomy.spec.md
  - Governance domain → ctxt/domains/governance.md
  - Software domain → ctxt/domains/software.md
  - Hybrid domain → Multiple domain files as needed
  - Target size per file: 8-12KB
  - NO frontmatter (clean context)
  - Inline edit warning at top
  - Domain-specific patterns and examples
  - Folder organization guidance for domain
  - Load triggers for domain-specific work
  - Footer: "[Domain] specialist for [Project Name] / Parent: AGENTS.md"

### Utility Sub-Agent Generation

- [!] Agent generates exactly 3 utility sub-agents in ctxt/utils/
  - Files: session-completion.md, drift-detection.md, msl-audit.md
  - Target size per file: 8-12KB
  - NO frontmatter (clean context)
  - Inline edit warning at top
  - Utility-specific workflow guidance
  - Load triggers matching utility use cases
  - References to related .livespec/ prompts/guides
  - Examples and patterns
  - Footer: "[Utility] specialist for [Project Name] / Parent: AGENTS.md"

### Compression Application

- [!] Agent applies configured compression level consistently across all generated files
  - Reads context_compression from constitution.spec.md frontmatter
  - Light: More inline content, less extraction to Reference Library
  - Moderate: Strategic extraction, balanced inline/reference (default)
  - Aggressive: Heavy extraction, minimal inline, maximum Reference Library
  - Applies same compression rules to root and all sub-agents
  - Extracts reusable content to Reference Library sections
  - Prioritizes essential content inline (80% usage)

### Size Budget Enforcement

- [!] Agent validates generated file sizes and reports violations
  - Root AGENTS.md: 20-30KB (strict)
  - Phase sub-agents: 8-12KB each (strict)
  - Domain sub-agents: 6-10KB each (strict)
  - Utility sub-agents: 6-10KB each (strict)
  - Total tree: <150KB (validation)
  - Typical loaded: <50KB (root + 1-2 sub-agents)
  - Uses wc -c for byte count validation
  - Reports size violations with file paths and actual sizes
  - Provides guidance if sizes exceeded (adjust compression, review content)

### Structure Validation

- [!] Agent validates complete context tree structure before reporting success
  - Verifies root AGENTS.md exists and is correct size
  - Verifies root has NO frontmatter (grep check)
  - Verifies root has inline edit warning
  - Verifies root has "When to Load Sub-Agents" section
  - Verifies ctxt/phases/ contains exactly 5 files
  - Verifies ctxt/domains/ contains expected files based on taxonomy
  - Verifies ctxt/utils/ contains exactly 3 files
  - Spot-checks 2-3 sub-agents for NO frontmatter
  - Spot-checks sub-agents have inline edit warnings
  - Reports validation results with pass/fail per check

### Results Reporting

- [!] Agent provides comprehensive generation report to calling session
  - Lists all generated files with sizes
  - Root AGENTS.md size (target: 30-40KB)
  - Phase sub-agents: 5 files with individual sizes
  - Domain sub-agents: Count and sizes
  - Utility sub-agents: 3 files with sizes
  - Total context tree size
  - Typical loaded context size (root + 1 phase)
  - Compression level used
  - LiveSpec version
  - Validation results (all checks pass/fail)
  - Next steps: Review files, test loading, commit

### Isolation and Context Management

- [!] Agent runs in isolated context without polluting parent session
  - Launched via Task tool as sub-agent
  - Performs all generation work in isolation
  - Returns only final report to parent session
  - No intermediate generation details leak to parent
  - Parent session remains focused on user's task
  - Generation complexity hidden from user

## Validation

### Prerequisites Validation
- [ ] Agent checks for PURPOSE.md existence
- [ ] Agent checks for specs/workspace/*.spec.md existence
- [ ] Agent checks for .livespec/templates/agents/ existence
- [ ] Agent stops with clear error if prerequisites missing
- [ ] Agent provides guidance to resolve missing files

### Content Extraction
- [ ] Agent reads all workspace specs completely
- [ ] Agent extracts constitution principles correctly
- [ ] Agent extracts patterns conventions correctly
- [ ] Agent extracts workflows phase details correctly
- [ ] Agent extracts taxonomy domain classification correctly
- [ ] Agent reads compression configuration correctly

### Root AGENTS.md Generation
- [ ] Root file generated with correct structure
- [ ] Root size 20-30KB (within budget)
- [ ] Root has NO frontmatter
- [ ] Root has inline edit warning at top
- [ ] Root inlines spec-first enforcement template
- [ ] Root inlines core principles (compressed)
- [ ] Root inlines folder organization tests
- [ ] Root includes "When to Load Sub-Agents" section
- [ ] Root has NO references to specs/workspace/*.spec.md
- [ ] Root has Reference Library section

### Sub-Agent Generation
- [ ] Exactly 5 phase sub-agents generated in ctxt/phases/
- [ ] Domain sub-agents generated based on taxonomy
- [ ] Exactly 3 utility sub-agents generated in ctxt/utils/
- [ ] All sub-agents have NO frontmatter
- [ ] All sub-agents have inline edit warning at top
- [ ] All sub-agents within size budgets (8-12KB phases, 6-10KB domains/utils)
- [ ] All sub-agents have load triggers
- [ ] All sub-agents reference parent AGENTS.md in footer

### Compression and Size
- [ ] Compression level read from constitution.spec.md
- [ ] Compression applied consistently across all files
- [ ] Size validation performed using wc -c
- [ ] Size violations detected and reported
- [ ] Total tree <150KB
- [ ] Typical loaded context <50KB

### Validation and Reporting
- [ ] Structure validation performed before reporting
- [ ] All validation checks pass
- [ ] Comprehensive report generated
- [ ] Report includes all file sizes
- [ ] Report includes validation results
- [ ] Report includes next steps
- [ ] Agent runs in isolated context (no parent pollution)
