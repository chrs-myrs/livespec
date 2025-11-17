---
criticality: CRITICAL
failure_mode: Without centralized build configuration, context generation and phased workflows lack consistency
governed-by:
  - .livespec/standard/metaspecs/behavior.spec.md
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/2-strategy/three-layer-architecture.spec.md
---

# Project Build Configuration

## Requirements
- [!] Project build configuration centralizes flags that guide AGENTS.md generation and phased workflow selection.
  - Configuration file named `project.yaml` at project root
  - File contains project identification (name, description, keywords)
  - File contains LiveSpec methodology decisions (spec_first enforcement, TDD approach, context_compression level)
  - File contains project taxonomy (domain, workspace_scope, specs_boundary)
  - File contains agent guidance config (doc_format, context_budget, coverage_target, verification_mode)
  - Configuration is **build-time only** (guides context generation, not runtime behavior)
  - Configuration NOT loaded into AI context during normal work (gitignored for context purposes)
  - Configuration coexists with spec-level frontmatter (project-level in yaml, spec-level in frontmatter)
  - Configuration mandatory when present (validation scripts enforce flags if file exists)
  - Missing configuration results in default behavior (graceful degradation)

## Validation
- `project.yaml` exists at project root
- File contains all required sections: project, livespec, agent
- `livespec.methodology.spec_first` is valid enum (mandatory | encouraged | optional)
- `livespec.methodology.tdd` is valid enum (mandatory | mandatory_with_escape | encouraged | optional)
- `livespec.methodology.context_compression` is valid enum (light | moderate | aggressive)
- `livespec.taxonomy.domain` is valid enum (software | generation | planning | documentation | governance | hybrid)
- `agent.doc_format` specifies agent documentation file name
- Validation scripts read config when present, use defaults when missing
- AGENTS.md regeneration (4d-regenerate-context.md) reads config to customize output

## Schema

```yaml
# Project identification
project:
  name: string                         # Project name
  description: string                  # Brief project description
  keywords: [string]                   # Discovery keywords

# LiveSpec methodology configuration
livespec:
  version: string                      # LiveSpec version (e.g., "3.4.0")

  # Core methodology decisions (guides context generation)
  methodology:
    spec_first: enum                   # mandatory | encouraged | optional
    tdd: enum                          # mandatory | mandatory_with_escape | encouraged | optional
    context_compression: enum          # light | moderate | aggressive

  # Project taxonomy (determines phase applicability)
  taxonomy:
    domain: enum                       # software | generation | planning | documentation | governance | hybrid
    workspace_scope: [string]          # List of workspace specs (e.g., [constitution, patterns, workflows])
    specs_boundary: enum               # specifications_only | includes_data | includes_research

# Agent guidance configuration (build AGENTS.md)
agent:
  doc_format: string                   # Agent documentation filename (e.g., "AGENTS.md")
  context_budget: string               # Target size for agent docs (e.g., "100KB")
  coverage_target: integer             # Percentage of cases handled without fetch (e.g., 80)
  verification_mode: enum              # active | passive
```

## Usage Examples

**LiveSpec project:**
```yaml
project:
  name: livespec
  description: Specifications that live with your code
  keywords: [documentation, specifications, ai-agents]

livespec:
  version: 3.4.0
  methodology:
    spec_first: mandatory
    tdd: mandatory_with_escape
    context_compression: moderate
  taxonomy:
    domain: governance
    workspace_scope: [constitution, patterns, workflows, taxonomy]
    specs_boundary: specifications_only

agent:
  doc_format: AGENTS.md
  context_budget: 100KB
  coverage_target: 80
  verification_mode: active
```

**Software project:**
```yaml
project:
  name: api-gateway
  description: REST API gateway with authentication
  keywords: [api, gateway, authentication]

livespec:
  version: 3.4.0
  methodology:
    spec_first: mandatory
    tdd: mandatory
    context_compression: light
  taxonomy:
    domain: software
    workspace_scope: [constitution, patterns]
    specs_boundary: specifications_only

agent:
  doc_format: CLAUDE.md
  context_budget: 120KB
  coverage_target: 75
  verification_mode: active
```

## Integration Points

**AGENTS.md regeneration** (prompts/4-evolve/4d-regenerate-context.md):
- Reads `context_compression` to control inline vs reference balance
- Reads `spec_first` to adjust verification prompt severity
- Reads `tdd` to customize Phase 2 guidance
- Reads `domain` to filter applicable phases
- Reads `agent.doc_format` to determine output filename

**Phase 0 setup** (prompts/0-define/0a-quick-start.md, 0b-customize-workspace.md):
- Generates `project.yaml` with defaults
- Reads PURPOSE.md for project metadata
- Prompts for domain and methodology preferences

**Validation scripts** (scripts/validate-*.sh):
- Read config when present to enforce flags
- Skip validation or use defaults when config missing
- Example: `spec_first: mandatory` → strict validation fails on missing specs
- Example: `spec_first: encouraged` → validation warns on missing specs

## Notes

**Not for runtime behavior:**
- Configuration guides **build processes** (AGENTS.md generation, phase selection)
- Configuration does NOT control **everyday AI actions** (file editing, code reviews)
- AI agents don't read this during normal work (gitignored from context)

**Coexistence with frontmatter:**
- `project.yaml`: Project-level decisions (applies to entire project)
- Spec frontmatter: Spec-level metadata (applies to individual spec)
- No duplication: settings live in appropriate location

**Migration:**
- Existing projects generate during AGENTS.md regeneration
- Missing config → defaults apply (graceful degradation)
- No manual migration required
