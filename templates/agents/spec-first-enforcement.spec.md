---
criticality: CRITICAL
failure_mode: Agents lack structural enforcement guidance, resulting in spec-first bypasses and methodology violations
specifies: .livespec/templates/agents/spec-first-enforcement.md
governed-by: specs/workspace/workspace-agent.spec.md
---

# Spec-First Enforcement Template

## Requirements

- [!] Template provides four-layer enforcement mechanism for 90%+ spec-first compliance
  - Layer 1: TodoWrite gate (must add "Create spec" todo before file creation)
  - Layer 2: Validation tool invocation (`scripts/check-requires-spec.sh`)
  - Layer 3: Mandatory plan mode for new permanent files
  - Layer 4: Simple "permanent in git?" classification test

- [!] Template defines "permanent file" with concrete examples
  - Positive examples: code, tests, configs, documentation, agents, commands
  - Negative examples: var/, generated/, .archive/, build outputs, logs, caches
  - Exception documented: workspace specs are self-defining

- [!] Template enables flexible spec organization
  - Agents decide coherence-based grouping (related files can share spec)
  - Provides test: "Do these files serve same observable purpose?"
  - Examples of grouped specs (documentation.spec.md for all docs)

- [!] Template explains enforcement mechanism ("path of least resistance")
  - Step-by-step workflow from user request to validation
  - Clear failure recovery: TodoWrite → Plan → Pre-commit cascade
  - Explicit target: 90%+ prevention, 10% caught by validation

- [!] Template includes "No Exceptions" section with common bypass patterns
  - Addresses familiarity bias ("this is obvious", "everyone knows")
  - Counters infrastructure excuse ("just infrastructure")
  - Refutes auto-generation argument (lock files still need spec coverage)

## Validation

- Template is concise (~60-80 lines, replacing 195 lines of old templates)
- Template inserted into AGENTS.md START section during regeneration
- Agents using this template exhibit 90%+ compliance in testing
- Template enables structural enforcement (TodoWrite/Plan/Validation) not just passive guidance
