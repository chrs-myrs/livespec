---
type: command
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: LiveSpec skills not discoverable via slash commands, users must know exact skill names, reduced productivity
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
specifies: []
---

# Slash Command Routing

## Requirements

- [!] Each skill has a matching command file at `commands/<name>.md` (repo root)
  - One command per skill, 1:1 mapping — no separate distribution copy
  - Checked into git directly, no install script or build step
  - Discovered automatically by Claude Code when the plugin is installed

- [!] Command files are thin routers, not implementations
  - Frontmatter: `description` (one line) + `routes-to: skills/<name>/SKILL.md`
  - Body: title, one-line summary, `## Usage` code block, `## What It Does` (or equivalent), `## See Also`
  - All actual workflow logic lives in the target `skills/<name>/SKILL.md`, inline (no external prompt files)

- [!] Command usage and parameters are documented in the target skill, not the command file
  - Skill frontmatter carries `argument-hint` (e.g. `[health|validate|context|extract]`)
  - Command file's `## Usage` block shows the same invocation forms for discoverability

## Command Mapping

Current commands (8, one per skill):

| Command | Routes to | Purpose |
|---------|-----------|---------|
| `/livespec:init` | `skills/init/SKILL.md` | Initialize project structure |
| `/livespec:design` | `skills/design/SKILL.md` | Create/refine specs (Phase 0/1) |
| `/livespec:audit` | `skills/audit/SKILL.md` | Spec health, validation, context generation |
| `/livespec:sweep` | `skills/sweep/SKILL.md` | Multi-project portfolio audit |
| `/livespec:learn` | `skills/learn/SKILL.md` | Session completion and learning capture |
| `/livespec:birth` | `skills/birth/SKILL.md` | Birth child projects from a parent |
| `/livespec:go` | `skills/go/SKILL.md` | Intent-based entry point routing |
| `/livespec:upgrade` | `skills/upgrade/SKILL.md` | Migrate a project to the current version |

## Validation

**Command Existence:**
```bash
# Every skill has a matching command
for skill in skills/*/; do
  name=$(basename "$skill")
  test -f "commands/${name}.md" || echo "MISSING: commands/${name}.md"
done
```

**Routing Correctness:**
```bash
# Every command's routes-to target exists
grep -h "^routes-to:" commands/*.md | sed 's/routes-to: //' | while read -r target; do
  test -f "$target" || echo "BROKEN routes-to: $target"
done
```

**Description Accuracy:**
- [ ] Command `description` matches the skill's purpose
- [ ] `## Usage` block matches the skill's documented invocation forms

## Failure Mode

Without command routing:
- Skills only discoverable by exact name or keyword-triggered auto-invocation
- No `/` menu autocomplete for LiveSpec operations
- Reduced productivity (users must know skill names rather than browsing commands)
