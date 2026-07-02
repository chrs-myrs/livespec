---
type: agent
category: artifacts
fidelity: behavioral
criticality: CRITICAL
failure_mode: Context builder agent produces invalid tree structure, incomplete content, or violates size budgets, resulting in broken agent guidance
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement 6: Sustainable Evolution)
guided-by:
  - specs/strategy/architecture.spec.md
derives-from:
  - specs/features/context-generation.spec.md
specifies:
  - agents/context-builder.md
---

# Context Builder Agent

## Requirements

### Prerequisites Validation

- [!] Agent validates all required source files exist before starting generation
  - Core sources: PURPOSE.md, specs/workspace/*.spec.md (constitution, patterns, workflows, context-architecture)
  - context-architecture.spec.md is REQUIRED (provides content sources and structure)
  - Templates: templates/agents/spec-first-enforcement.md
  - Optional sources: specs/workspace/taxonomy.spec.md, specs/strategy/architecture.spec.md
  - .claude-plugin/plugin.json for version information
  - Clear error messages identifying missing files, especially context-architecture.spec.md
  - Stops immediately if required files missing (no partial generation)
  - Provides guidance to resolve missing files (e.g., "Run Phase 0 first")

### Scope Determination

- [!] Agent accepts a scope parameter (`full` or a specific target file list) and honours it throughout generation
  - `full`: behaves exactly as whole-tree generation always has (all remaining requirements apply to every generated file)
  - Scoped (file list): only reads, rewrites, and size-validates the listed file(s) — no other generated file is opened or touched
  - Scope is determined by the caller (per `specs/features/context-generation.spec.md` Incremental Update Mode) using `specs/workspace/context-architecture.spec.md` Spec → Generated File Map; the agent trusts the scope it's given rather than re-deriving it
  - Final report states which mode ran (`full` vs `scoped: [files]`) so it's unambiguous how much of the tree changed

### Source Content Extraction

- [!] Agent systematically reads and extracts content from workspace specifications
  - Reads all specs/workspace/*.spec.md files
  - Extracts constitution.spec.md → Core principles (8 principles)
  - Extracts patterns.spec.md → MSL format, naming conventions, folder structure
  - Extracts workflows.spec.md → 5 phases (entry/exit, outputs, key prompts)
  - Extracts taxonomy.spec.md → Project domain classification
  - Extracts context-architecture.spec.md → Context tree structure AND content sources
  - Reads PURPOSE.md → Project vision and success criteria
  - Reads compression configuration from constitution.spec.md frontmatter

### Root AGENTS.md Generation

- [!] Agent generates root AGENTS.md with correct structure and size
  - Target size: 30-40KB complete inline content
  - NO frontmatter (clean context for agents)
  - Inline edit warning at top (not in frontmatter)
  - Inlines spec-first enforcement template from templates/agents/
  - Inlines core principles compressed from constitution
  - Inlines folder organization tests from taxonomy
  - Includes "When to Load Sub-Agents" section (routing decision tree)
  - Includes Quick Start (80% of cases - Phase 0 bash commands)
  - Includes MSL format quick reference
  - Includes Reference Library (navigation to ctxt/ and references/)
  - NO external references to specs/workspace/*.spec.md (content extracted inline)
  - Applies compression level from configuration

### Sub-Agent Generation

- [!] Agent generates a flat set of sub-agents in ctxt/ — no phases/ or utils/ subfolders
  - Files: define.md (Phase 0), design.md (Phase 1), evolve.md (implement/verify/evolve combined), session.md (session completion), msl-audit.md (MSL minimalism), audit.md (spec health/validation)
  - Target size per file: 4-10KB
  - NO frontmatter (clean context)
  - Inline edit warning at top
  - Specialist-specific methodology content
  - Load triggers matching natural user language
  - References to relevant `references/prompts/` and feature specs
  - Examples and patterns for the specialist's scope
  - Reference Library section linking to detailed specs
  - Footer: "[Specialist] for [Project Name] / Parent: AGENTS.md"

### Domain Sub-Agent Generation

- [!] Agent generates domain sub-agents based on taxonomy classification
  - Reads project domain from taxonomy.spec.md
  - Governance domain → ctxt/domains/governance.md
  - Software domain → ctxt/domains/software.md
  - Hybrid domain → Multiple domain files as needed
  - Target size per file: 4-10KB
  - NO frontmatter (clean context)
  - Inline edit warning at top
  - Domain-specific patterns and examples
  - Folder organization guidance for domain
  - Load triggers for domain-specific work
  - Footer: "[Domain] specialist for [Project Name] / Parent: AGENTS.md"

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
  - Root AGENTS.md: 30-40KB (strict)
  - Each ctxt/ sub-agent, including domain files: 4-10KB (strict)
  - Total tree: <100KB (validation)
  - Uses wc -c for byte count validation
  - Reports size violations with file paths and actual sizes
  - Provides guidance if sizes exceeded (adjust compression, review content)

### Structure Validation

- [!] Agent validates complete context tree structure before reporting success
  - Verifies root AGENTS.md exists and is correct size
  - Verifies root has NO frontmatter (grep check)
  - Verifies root has inline edit warning
  - Verifies root has "When to Load Sub-Agents" section
  - Verifies ctxt/ contains define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (flat, no phases/ or utils/ subfolders)
  - Verifies ctxt/domains/ contains expected files based on taxonomy
  - Spot-checks 2-3 sub-agents for NO frontmatter
  - Spot-checks sub-agents have inline edit warnings
  - Reports validation results with pass/fail per check

### Results Reporting

- [!] Agent provides comprehensive generation report to calling session
  - Lists all generated files with sizes
  - Root AGENTS.md size (target: 30-40KB)
  - ctxt/ sub-agents: 6 files with individual sizes
  - Domain sub-agents: Count and sizes
  - Total context tree size
  - Typical loaded context size (root + 1-2 sub-agents)
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
- [ ] Agent checks for templates/agents/ existence
- [ ] Agent stops with clear error if prerequisites missing
- [ ] Agent provides guidance to resolve missing files

### Scope Determination
- [ ] Agent accepts and honours a `full` or scoped-file-list parameter
- [ ] Scoped runs only read/write/validate the listed file(s)
- [ ] Report states which mode ran (`full` vs `scoped: [files]`)

### Content Extraction
- [ ] Agent reads all workspace specs completely
- [ ] Agent extracts constitution principles correctly
- [ ] Agent extracts patterns conventions correctly
- [ ] Agent extracts workflows phase details correctly
- [ ] Agent extracts taxonomy domain classification correctly
- [ ] Agent reads compression configuration correctly

### Root AGENTS.md Generation
- [ ] Root file generated with correct structure
- [ ] Root size 30-40KB (within budget)
- [ ] Root has NO frontmatter
- [ ] Root has inline edit warning at top
- [ ] Root inlines spec-first enforcement template
- [ ] Root inlines core principles (compressed)
- [ ] Root inlines folder organization tests
- [ ] Root includes "When to Load Sub-Agents" section
- [ ] Root has NO references to specs/workspace/*.spec.md
- [ ] Root has Reference Library section

### Sub-Agent Generation
- [ ] ctxt/ contains define.md, design.md, evolve.md, session.md, msl-audit.md, audit.md (flat, no phases/ or utils/ subfolders)
- [ ] Domain sub-agents generated based on taxonomy
- [ ] All sub-agents have NO frontmatter
- [ ] All sub-agents have inline edit warning at top
- [ ] All sub-agents within size budget (4-10KB each)
- [ ] All sub-agents have load triggers
- [ ] All sub-agents reference parent AGENTS.md in footer

### Compression and Size
- [ ] Compression level read from constitution.spec.md
- [ ] Compression applied consistently across all files
- [ ] Size validation performed using wc -c
- [ ] Size violations detected and reported
- [ ] Total tree <100KB

### Validation and Reporting
- [ ] Structure validation performed before reporting
- [ ] All validation checks pass
- [ ] Comprehensive report generated
- [ ] Report includes all file sizes
- [ ] Report includes validation results
- [ ] Report includes next steps
- [ ] Agent runs in isolated context (no parent pollution)
