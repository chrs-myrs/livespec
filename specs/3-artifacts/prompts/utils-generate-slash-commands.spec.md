---
criticality: IMPORTANT
failure_mode: Slash commands not generated, LiveSpec utilities not discoverable, users must manually navigate .livespec/ structure
specifies: dist/prompts/utils/generate-slash-commands.md
implements: specs/3-artifacts/commands/generation.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
  - specs/workspace/patterns.spec.md
---

# Utility Prompt: Generate Slash Commands

## Requirements

- [!] Prompt MUST guide agent through command generation workflow
  - Step 1: Read command template
  - Step 2: Read prompt registry
  - Step 3: Define 11 command mappings
  - Step 4: Create command directory
  - Step 5: Generate each command (with customization detection)
  - Step 6: Handle customized commands (prompt before overwrite)
  - Step 7: Validation (all commands exist, metadata present)
  - Step 8: Generate report

- [!] Prompt MUST define 11 command mappings
  - 8 essential commands (complete-session, rebuild-context, refine-workspace, suggest-improvements, health-report, validate, audit, next-steps)
  - 3 optional commands (run-spike, analyze-failure, upgrade)
  - Each mapping includes: name, prompt path, description, parameters (if applicable)
  - Router logic for `audit` command (maps type parameter to specific audit prompt)

- [!] Prompt MUST specify customization detection logic
  - Check for `generated_by: livespec` field in frontmatter
  - Missing field = User customized → Prompt before overwriting
  - Present field = Safe to regenerate
  - Show diff option for customized commands

- [!] Prompt MUST specify command file structure
  - Frontmatter: description, generated_by, generated_at, prompt, supports_parameters, parameters
  - Body: Title, "Use [prompt-path]" instruction
  - What/When sections
  - Parameter documentation (if applicable)
  - Customization footer with removal instructions

- [!] Prompt MUST define parameter support
  - `suggest-improvements [scope]`: all, context, registries, validation (default: all)
  - `audit [type]`: minimalism, context, coverage, workspace-specs, workspace-scope, all (default: all)
  - `run-spike [topic]`: free text (required)
  - Router logic maps parameters to specific prompts

- [!] Prompt MUST specify validation checks
  - All 11 commands exist (.claude/commands/livespec/*.md)
  - Generated commands have metadata (generated_by, generated_at, prompt)
  - Prompt paths valid (files exist)
  - Parameter documentation present (where applicable)

- [!] Prompt MUST specify report format
  - Summary table (Created/Updated/Skipped counts)
  - Details section (which commands in each category)
  - Usage examples (how to invoke with parameters)
  - Validation checklist

- [!] Prompt MUST specify when NOT to generate
  - Commands recently generated and unchanged
  - User customizing commands (wait)
  - Project not using Claude Code

- [!] Prompt MUST specify integration points
  - Phase 0 setup (0a-quick-start, 0b-customize-workspace)
  - Validation (validate-project.md checks)
  - Manual invocation (user can trigger explicitly)

## Validation

- [ ] All 8 workflow steps documented
- [ ] 11 command mappings defined (8 essential + 3 optional)
- [ ] Customization detection logic specified
- [ ] Command file structure detailed
- [ ] Parameter support defined (3 parameterized commands)
- [ ] Router logic documented (audit command)
- [ ] Validation checks specified
- [ ] Report format detailed
- [ ] "When NOT to use" section present
- [ ] Integration points specified

## Failure Mode

Without proper prompt specification:
- Missing commands (incomplete generation)
- Overwriting customizations (no detection)
- Invalid prompt paths (broken references)
- Missing parameter documentation (users guess syntax)
- No validation (broken commands undetected)
- Poor discoverability (users don't know about commands)
