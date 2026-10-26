---
type: agent
category: artifacts
fidelity: behavioral
criticality: CRITICAL
failure_mode: Context builder agent produces a tree in a shape the project did not declare, incomplete content, or files over their size budgets, resulting in broken or bloated agent guidance
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

- [!] Agent validates the required source files exist before starting generation
  - Required: PURPOSE.md and `specs/workspace/context-architecture.spec.md` (the tree's shape and content sources)
  - Read when present: the constitution, taxonomy, patterns and workflows workspace specs, and `specs/strategy/architecture.spec.md`. A missing one leaves out the content it would feed; it never stops the run
  - Settings from `project.yaml`: `livespec.version`, `livespec.methodology.context_compression` and `agent.context_budget`, each falling back to its default when absent (`specs/features/project-config.spec.md`)
  - Template: `templates/agents/spec-first-enforcement.md`
  - A missing required file stops the run before anything is written, with an error naming the file and how to create it

### Scope Determination

- [!] Agent accepts a scope parameter (`full` or a specific target file list) and honours it throughout generation
  - `full`: behaves exactly as whole-tree generation always has (all remaining requirements apply to every generated file)
  - Scoped (file list): only reads, rewrites, and size-validates the listed file(s) — no other generated file is opened or touched
  - Scope is determined by the caller (per `specs/features/context-generation.spec.md` Incremental Update Mode) using `specs/workspace/context-architecture.spec.md` Spec → Generated File Map; the agent trusts the scope it's given rather than re-deriving it
  - Final report states which mode ran (`full` vs `scoped: [files]`) so it's unambiguous how much of the tree changed

### Tree Shape

- [!] Agent generates the tree the project's context-architecture spec declares, and nothing else
  - Root AGENTS.md within the declared root ceiling
  - Exactly the declared ctxt/ files, flat plus ctxt/domains/, 4-10KB each; no ctxt/ when none are declared
  - Exactly the declared methodology sections: the five phases, phases vs layers, multi-domain organisation, session completion
  - Total tree within `agent.context_budget`

### Root AGENTS.md Generation

- [!] Agent generates root AGENTS.md with clean context and the project's priorities first
  - NO frontmatter; inline edit warning at top
  - The project's own constraints near the top, before any methodology content
  - Inlines the spec-first enforcement template, writing its `scripts/livespec/` paths as `scripts/` where the project is the toolchain source, so every script path resolves in the project
  - Inlines core principles compressed from the constitution and folder organisation tests from the taxonomy, when those specs exist
  - Includes MSL format quick reference and a Reference Library
  - Includes a "When to Load Sub-Agents" section only when ctxt/ files are declared
  - NO external references to specs/workspace/*.spec.md (content extracted inline)
  - Footer names `livespec.version`, and leaves the version out when `project.yaml` records none

### Sub-Agent Generation

- [!] Agent generates each declared ctxt/ file as a self-contained specialist
  - NO frontmatter; inline edit warning at top
  - Load triggers matching natural user language, and routed to from the root
  - Domain files draw on the taxonomy's domain classification
  - Footer: "[Specialist] for [Project Name] / Parent: AGENTS.md"

### Compression Application

- [!] Agent applies the compression level declared in `project.yaml` consistently across all generated files
  - Light: More inline content, less extraction to Reference Library
  - Moderate: Strategic extraction, balanced inline/reference (default)
  - Aggressive: Heavy extraction, minimal inline, maximum Reference Library

### Size Budget Enforcement

- [!] Agent validates generated file sizes and reports violations
  - Root AGENTS.md: within the declared ceiling (strict)
  - Each ctxt/ file, including domain files: 4-10KB (strict)
  - Total tree: within `agent.context_budget`
  - Reports violations with file paths and actual sizes, and how to resolve them (adjust compression, review content, or raise the declared ceiling)

### Structure Validation

- [!] Agent validates the generated tree against the declared shape before reporting success
  - Root exists, within its ceiling, with no frontmatter and an edit warning
  - ctxt/ holds the declared files
  - Reports any ctxt/ subfolder other than domains/ as not produced by this generation, listing its files and excluding them from the size totals; never deletes them, since no marker reliably identifies generated files across generations
  - A full run takes section ordering and content patterns from the existing tree, never a folder layout the flat structure forbids, nor a section or file the declaration leaves out
  - Reports validation results with pass/fail per check

### Source Stamp

- [!] Agent stamps the generated files as its last step
  - Runs `validate-context.sh --stamp` after validation, for full and scoped runs alike, so every file records the same source hash
  - A model cannot compute the hash, so the agent never writes or edits the stamp line itself

### Results Reporting

- [!] Agent provides a generation report to the calling session
  - Every generated file with its size, against its budget
  - Total tree size and typical loaded size (root + 1-2 sub-agents)
  - Compression level used, and the LiveSpec version or that none is recorded
  - Validation results (all checks pass/fail) and next steps

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
- [ ] A project without PURPOSE.md or context-architecture.spec.md stops with an error naming the file, and nothing is written
- [ ] A project with no patterns or workflows spec generates without error
- [ ] A `project.yaml` with no `livespec` key produces a footer without a version, not a failure

### Scope Determination
- [ ] Agent accepts and honours a `full` or scoped-file-list parameter
- [ ] Scoped runs only read/write/validate the listed file(s)
- [ ] Report states which mode ran (`full` vs `scoped: [files]`)

### Tree Shape
- [ ] A project declaring no ctxt/ files gets no ctxt/ and no "When to Load Sub-Agents" section
- [ ] A project declaring no methodology sections gets none of the four
- [ ] Root carries the project's constraints before any methodology content
- [ ] LiveSpec's own full run produces a root within its 40KB ceiling and its seven declared ctxt/ files

### Compression and Size
- [ ] Compression level read from `project.yaml`, moderate when absent
- [ ] Root within declared ceiling; each ctxt/ file 4-10KB; total within `agent.context_budget`
- [ ] Size violations detected and reported

### Validation and Reporting
- [ ] Structure validation performed before reporting
- [ ] Report includes every file size and the validation results
- [ ] Agent runs in isolated context (no parent pollution)
