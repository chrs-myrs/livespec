---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL
failure_mode: Without ambient intelligence, specs are created without templates (wrong structure), in wrong locations (layer violations), or not created at all (no spec-first), causing compounding quality degradation
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/ai-discoverability.spec.md
supersedes:
  - specs/features/plugin-skills.spec.md (partial - skill architecture)
  - specs/features/context-generation.spec.md (partial - generation triggers)
---

# Ambient Architecture

## Problem Statement

Users want the agent to "just know" spec-first behavior without explicit commands. Current architecture requires:
- Remembering which command to use
- Explicit skill invocation for basic compliance
- Session restarts to pick up context changes
- Plugin content copying that becomes stale

Interview finding: "This shouldn't happen - it should be automatic that specs are created and kept inline."

## Requirements

### Ambient Spec-First Behavior

- [!] Agent automatically creates specs before permanent files WITHOUT explicit commands
  - Behavior triggered by file creation intent, not user invocation
  - Agent states "[SPEC-CHECK]" visibly before any src/, lib/, scripts/, tests/ file creation
  - If spec missing: agent creates spec FIRST, then proceeds
  - If spec exists: agent references spec path, then proceeds
  - User sees compliance happening (visibility requirement from interview)

### Inline Essential Rules (CLAUDE.md)

- [!] Project CLAUDE.md contains spec-first behavior and layer boundaries inline, not via plugin references
  - Spec-first trigger rules (when to check, when to create)
  - Layer boundary definitions (foundation/strategy/features distinction)
  - Layer routing table (content type → correct location)
  - MSL format quick reference (frontmatter + Requirements section minimum)
  - NOT inlined: full metaspec templates (reference plugin for details)
  - NOT inlined: workflow guides (skills provide when needed)

### Layer Boundary Enforcement

- [!] Agent places specs in correct layer without user specifying location
  - "Must comply with X" → specs/foundation/constraints.spec.md
  - "Users can do X" → specs/foundation/outcomes.spec.md
  - "Will use X tech" → specs/strategy/
  - "System does X" → specs/features/
  - Agent states layer decision visibly: "[LAYER] This is a feature behavior → specs/features/"
  - Foundation specs contain NO implementation detail (hard boundary)

### Bootstrap Process (init)

- [!] Bootstrap creates minimal scaffold + inline essentials, without copying plugin content
  - Creates: PURPOSE.md template, specs/ directory structure
  - Generates: CLAUDE.md with inline essential rules (spec-first + layers)
  - Generates: AGENTS.md with project-specific context
  - Does NOT copy: .livespec/ directory, plugin prompts, metaspec files
  - References: plugin paths for detailed templates when needed
  - Interactive: asks about project type, domain, constraints via AskUserQuestion

### Intelligent Router (go)

- [!] Single entry point `/livespec:go` guides users to appropriate action via questions
  - Does NOT auto-detect intent from prompt (too error-prone)
  - Presents options via AskUserQuestion: create spec, check health, fix issues, guided design
  - Routes to: init (if uninitialized), design (spec creation), audit (health check), learn (session end)
  - Fallback: if invoked with argument, interprets as design intent

### Simplified Skill Set

- [!] Plugin provides exactly 5 skills with clear, non-overlapping purposes
  - `/livespec:go` - Intelligent router, guides user to appropriate action
  - `/livespec:init` - Bootstrap new project (interactive scaffold)
  - `/livespec:design` - Create/refine specs (guided flow for complex work)
  - `/livespec:audit` - Check health, detect drift, report issues (was: evolve)
  - `/livespec:learn` - Capture session learnings, update specs from experience
  - Removed/merged: evolve (split into audit + ambient behavior)

### Dynamic Plugin Reference

- [!] Project files reference plugin content dynamically, not via copied files
  - Metaspec templates read from plugin path when creating specs
  - Workflow guides loaded from plugin when skills invoked
  - No `.livespec/` directory in target projects (plugin provides)
  - Version updates happen in plugin, projects automatically get latest
  - Technical constraint: requires Read tool to fetch plugin content at runtime

### Drift Detection and Alignment

- [!] Agent detects and prompts for alignment when context artifacts drift
  - Monitors: AGENTS.md, CLAUDE.md, specs/workspace/ relationship
  - Detection: checksums or timestamps, checked at session start
  - Response: "Context may be stale. Run /livespec:audit to check alignment"
  - Does NOT auto-fix (requires user decision)
  - Catches drift early, prevents compounding misalignment

## Validation

### Ambient Behavior
- [ ] Agent creates spec before src/ file without user invoking skill
- [ ] [SPEC-CHECK] marker visible in agent output
- [ ] Spec follows MSL format (frontmatter + Requirements)
- [ ] Spec placed in correct layer based on content

### Bootstrap
- [ ] /livespec:init works on empty directory
- [ ] No .livespec/ directory created in target project
- [ ] CLAUDE.md contains spec-first rules inline
- [ ] AGENTS.md generated with project context

### Router
- [ ] /livespec:go presents options via AskUserQuestion
- [ ] Routes correctly to init, design, audit, learn
- [ ] Works without arguments (asks what user wants)

### Layer Enforcement
- [ ] Foundation spec has NO implementation detail
- [ ] Agent states [LAYER] decision visibly
- [ ] Layer violations caught before file creation

### Dynamic Reference
- [ ] Metaspec template loaded from plugin path
- [ ] No plugin content copied to project
- [ ] Plugin update reflects in next skill invocation

## Technical Constraints

**Claude Code Limitations** (cannot be solved by this spec):
- No mid-session context injection (static CLAUDE.md only)
- No SessionStart hooks (cannot pre-load at session begin)
- No plugin virtual filesystem (must use Read tool for dynamic access)

**Workarounds Applied**:
- Maximize static context in CLAUDE.md (front-load rules)
- Skills use Read tool to fetch plugin content at runtime
- Drift detection via file comparison, not live monitoring
