---
criticality: IMPORTANT
failure_mode: LiveSpec utilities not discoverable via slash commands, users must manually navigate .livespec/ structure, reduced productivity
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/patterns.spec.md
specifies:
  - dist/.claude/commands/livespec/*.md (distributed commands)
  - dist/prompts/utils/generate-custom-slash-commands.md (customization prompt)
---

# Slash Command Distribution and Customization

## Requirements

- [!] LiveSpec ships pre-generated slash commands in `dist/.claude/commands/livespec/` (fast path)
  - 11 standard commands included in distribution (8 essential + 3 optional)
  - Commands checked into git, travel with framework
  - Installation script copies to `.claude/commands/livespec/` when Claude Code detected
  - Zero-time setup for 99% of users
  - Simple format: frontmatter + "Use [prompt-path]" instruction

- [!] LiveSpec provides customization prompt for custom variations (flexibility path)
  - `generate-custom-slash-commands.md` available for project-specific needs
  - Reads prompt registry to determine command list
  - Shows diff for existing commands
  - Opt-in usage only (standard commands preferred)

- [!] Commands align with four-level improvement taxonomy
  - Session-level: `/livespec/complete-session`
  - Context-level: `/livespec/rebuild-context`, `/livespec/refine-workspace`
  - Strategic-level: `/livespec/suggest-improvements [scope]`
  - Diagnostic-level: `/livespec/health-report`
  - Plus 6 other utilities: validate, audit, next-steps, run-spike, analyze-failure, upgrade

- [!] Commands support parameters via space-separated syntax
  - `/livespec/suggest-improvements context` - Scope parameter
  - `/livespec/audit minimalism` - Type parameter
  - Parameters documented in command frontmatter
  - Agent receives parameters as context when command invoked

- [!] Generated commands include metadata for customization detection
  - Frontmatter field: `generated_by: livespec`
  - Frontmatter field: `generated_at: YYYY-MM-DD`
  - Frontmatter field: `prompt: dist/prompts/utils/[name].md`
  - Absence of `generated_by` indicates user customization (skip regeneration)

- [!] Commands installed automatically during setup (install script)
  - Installation script detects `.claude/` directory existence
  - Creates `.claude/commands/livespec/` if needed
  - Copies all commands from `dist/.claude/commands/livespec/`
  - Creates AGENTS.md symlink in `.claude/` for agent discovery
  - Phase 0 prompts verify installation (no generation needed)

- [!] Validation detects missing or stale commands
  - validate-project.md checks all 11 commands exist
  - Checks descriptions match prompt registry
  - Offers TWO repair options:
    1. Fast: Copy from `dist/.claude/commands/` (instant)
    2. Custom: Use `generate-custom-slash-commands.md` (for variations)
  - Skips customized commands (missing `generated_by`)

- [!] Manual customization available via utility prompt
  - `generate-custom-slash-commands.md` can be invoked explicitly
  - Reads prompt registry to determine command list
  - Shows diff for existing commands
  - Prompts before overwriting any customized command
  - Reports: Created X, Updated Y, Skipped Z (customized)
  - Only recommended when user needs project-specific variations

- [!] Command format follows template structure
  - Uses template from `.livespec/templates/commands/utility-command.md`
  - Frontmatter: description, generated_by, generated_at, prompt, parameters (if applicable)
  - Body: Title, "Use [prompt-path]", What/When sections, parameter docs
  - Footer: Customization instructions

## Command Mapping

**Essential Commands (8):**
1. `/livespec/complete-session` → `complete-session.md` (no params)
2. `/livespec/rebuild-context` → `4d-regenerate-context.md` (no params)
3. `/livespec/refine-workspace` → `reorganize-workspace.md` (no params)
4. `/livespec/suggest-improvements [scope]` → `suggest-improvements.md` (params: all/context/registries/validation)
5. `/livespec/health-report` → `run-health-report.md` (no params)
6. `/livespec/validate` → `validate-project.md` (no params)
7. `/livespec/audit [type]` → Multiple audit prompts (params: minimalism/context/coverage/workspace-specs/workspace-scope/all)
8. `/livespec/next-steps` → `next-steps.md` (no params)

**Optional Commands (3):**
9. `/livespec/run-spike [topic]` → `run-spike.md` (params: free text topic)
10. `/livespec/analyze-failure` → `analyze-failure.md` (no params)
11. `/livespec/upgrade` → `upgrade-methodology.md` (no params)

## Validation

**Command Existence:**
```bash
# All 11 commands must exist
test -f .claude/commands/livespec/complete-session.md
test -f .claude/commands/livespec/rebuild-context.md
# ... (all 11 commands)
```

**Metadata Presence:**
```bash
# Generated commands have metadata
grep "^generated_by: livespec$" .claude/commands/livespec/*.md | wc -l
# Should be count of non-customized commands
```

**Description Accuracy:**
- [ ] Command descriptions match prompt registry
- [ ] Parameter documentation present for parameterized commands
- [ ] Prompt paths correct and files exist

**Distribution Workflow:**
- [ ] Standard commands exist in `dist/.claude/commands/livespec/` (11 files)
- [ ] Installation script copies commands when `.claude/` detected
- [ ] Phase 0 prompts verify installation (not generation)
- [ ] Validation offers copy or custom generation for missing commands
- [ ] Manual customization prompt exists (`generate-custom-slash-commands.md`)
- [ ] Customization detection works (skip when `generated_by` missing)

## Failure Mode

Without slash command generation:
- Users must manually navigate `.livespec/` directory structure
- Utility prompts not discoverable (no `/` menu autocomplete)
- Reduced productivity (extra steps to invoke utilities)
- Inconsistent command naming (no standard)
- Parameters not documented (users guess syntax)
