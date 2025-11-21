---
implements: specs/3-artifacts/prompts/0b-customize-workspace.spec.md
generated: '2025-10-10'
phase: 0-define
estimated_time: "20-30 minutes"
---

# Prompt Behavior: Customize Workspace

**Purpose**: Initialize LiveSpec methodology structure with full customization

## Context

You're setting up a new project or adding LiveSpec to an existing codebase. This establishes the foundation for specification-driven development.

## Task

### Step 1: Gather Project Context

Ask the user:

1. **What type of project is this?** (web app, CLI tool, library, governance/documentation, etc.)
2. **What's the expected development pattern?** (exploratory/prototyping, production development, maintenance mode)
3. **Which AI agent(s) will primarily work on this project?** (Claude Opus/Sonnet/Haiku, GPT-4, Cursor, other)
4. **How frequently will agents interact with specs?** (daily, weekly, occasional)

### Step 2: Recommend Context Compression Level

Based on responses, recommend compression level:

**Light Compression** if:
- Large context window agent (Claude Opus, GPT-4)
- Exploratory or learning phase
- Infrequent agent interactions
- Team learning LiveSpec methodology

**Moderate Compression** if:
- Standard agents (Claude Sonnet, GPT-4-turbo)
- Production development
- Regular agent interactions
- Established LiveSpec understanding

**Aggressive Compression** if:
- Smaller context agents or cost-sensitive
- High-frequency agent usage
- Well-established LiveSpec patterns
- Maximum focus needed

Explain recommendation with specific reasoning.

### Step 3: Create Project Taxonomy

**CRITICAL**: Establish project classification to guide all subsequent file placement decisions.

Ask the user:

1. **"What domain best describes this project?"**
   - **Software** - Produces executable code, libraries, or applications (src/ → dist/)
   - **Documentation** - Produces published documentation (docs/ → public/)
   - **Planning** - Supports decision-making through analysis (research/ → analysis outputs)
   - **Generation** - Transforms data into tailored deliverables (data/ → generated outputs)
   - **Governance** - Produces methodology or frameworks (specs/ → dist/)
   - **Hybrid** - Combination (explain which domains)

2. **"Does this project process user-provided data or research materials?"**
   - If YES: "You'll need data/ or research/ folders. These stay OUT of specs/"
   - If NO: "specs/ will contain behavior specifications only"

3. **"Will this project have domain-specific processes or workflows?"**
   - Examples: job application workflows, deployment procedures, analysis methodologies
   - If YES: "These go in specs/3-behaviors/processes/ or specs/2-strategy/, NOT specs/workspace/"
   - If NO: "workspace/ will contain only portable methodology (constitution, patterns, workflows, taxonomy)"

4. **Select appropriate taxonomy template** from `.livespec/templates/workspace/taxonomy-[domain].spec.md.template`

5. **Create specs/workspace/taxonomy.spec.md**
   - Use selected domain template
   - Customize based on user responses
   - Explicitly list what's in workspace/ (typically: constitution, patterns, workflows, taxonomy)
   - Explicitly state product-specific content locations with examples
   - Confirm "specs/ = specifications only, no data/research/artifacts"

6. **Show user the taxonomy** and explain:
   - "This taxonomy defines your project's classification"
   - "AI agents will check taxonomy.spec.md FIRST before creating files"
   - "It prevents common mistakes like putting product features in workspace/ or data in specs/"
   - "Does this classification make sense for your project?" (allow user to refine)

7. **Validate taxonomy structure:**
   - Run: `bash scripts/validate-taxonomy-structure.sh`
   - Verify all four required sections present:
     - Project Domain
     - Workspace Scope
     - Specs Boundary
     - AI agents must
   - If validation fails, add missing sections using metaspec guidance
   - Validation ensures taxonomy provides complete agent guidance

### Step 3.5: Configure MCP Integration (Optional)

**CRITICAL**: MCP servers extend Claude Desktop capabilities. Establishing configuration patterns early prevents debugging issues.

Ask the user:

1. **"Will this project use MCP (Model Context Protocol) servers?"**
   - Examples: Custom tools, data integrations, external API access
   - If NO: Skip to Step 4
   - If YES: Continue with MCP configuration

2. **"What platform will run Claude Desktop?"**
   - **Windows with WSL**: Note path translation requirements (`\\wsl.localhost\Ubuntu-22.04\...`)
   - **macOS/Linux**: Standard Unix paths
   - **Important**: Affects config file location and path formats

3. **"Will MCP servers require credentials?"**
   - **API keys**: Environment variables in config
   - **AWS credentials**: Note Claude Desktop cannot use SSO (static credentials only)
   - **GitHub packages**: May need authentication tokens

4. **Create MCP integration spec:**

   Create `specs/3-behaviors/dev-environment/mcp-integration.spec.md`:
   - Document MCP server requirements (what servers, what capabilities)
   - Specify validation criteria (how to verify server working)
   - Include platform-specific considerations
   - Reference debugging workflow (see below)

5. **Show debugging workflow:**

   Explain to user:

   "When MCP servers fail, use this systematic debugging process:

   **Step 1**: Check log location
   - Windows: `C:\Users\<Username>\AppData\Roaming\Claude\logs\`
   - macOS: `~/Library/Logs/Claude/`
   - Linux: `~/.config/Claude/logs/`

   **Step 2**: Identify server log
   - Pattern: `mcp-server-<server-name>.log`
   - Example: `mcp-server-tmp-project.log`

   **Step 3**: Examine recent errors
   ```bash
   tail -100 <log-file-path>
   ```

   **Step 4**: Common error patterns
   - `npm ERR! 404` → Package not found (use local path instead)
   - `Server transport closed unexpectedly` → Check earlier errors
   - `ENOENT` → Path incorrect (check WSL format on Windows)
   - `Authentication failed` → Verify credentials in env

   **Step 5**: Test components
   - Verify file exists: `ls -la <path>`
   - Test command standalone: `node <path> --help`
   - Validate config JSON: `python3 -m json.tool <config>`"

6. **Document platform-specific patterns:**

   Add to workflows.spec.md reference:

   **WSL Path Translation (Windows only):**
   ```
   Linux: /home/chris/projects/tmp/project-mcp/dist/server.js
   Windows: \\wsl.localhost\Ubuntu-22.04\home\chris\projects\tmp\project-mcp\dist\server.js
   ```

   **AWS Credentials (Claude Desktop):**
   - Cannot use AWS_PROFILE or SSO
   - Must use static credentials (AWS_ACCESS_KEY_ID + AWS_SECRET_ACCESS_KEY)
   - Terminal-based Claude Code CAN use SSO

   **Config File Locations:**
   - Windows: `C:\Users\<Username>\AppData\Roaming\Claude\claude_desktop_config.json`
   - macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`

7. **Store detailed debugging guide:**

   "I've placed a complete MCP debugging guide in `var/mcp-setup-debugging-guide.md` for reference. This includes:
   - Complete error pattern library
   - Platform-specific solutions
   - Credential handling strategies
   - Validation workflows"

### Step 4: Create Workspace Specifications

Using appropriate templates from `dist/templates/workspace/`, create five workspace specifications:

1. **specs/workspace/constitution.spec.md**
   - Template: `dist/templates/workspace/constitution-[level].md.template`
   - Include `context_compression: [level]` in frontmatter
   - Define 3-5 core development principles
   - Customize from template for project context

2. **specs/workspace/patterns.spec.md**
   - Template: `dist/templates/workspace/patterns.spec.md.template`
   - Naming conventions
   - File structure patterns
   - Specification format requirements

3. **specs/workspace/workflows.spec.md**
   - Template: `dist/templates/workspace/workflows.spec.md.template`
   - Development process workflows
   - When to use which Phase prompts
   - How specs evolve with code

4. **specs/workspace/agent-contexts.spec.md**
   - Template: `dist/templates/workspace/agent-contexts.spec.md.template`
   - Define project's context tree structure
   - Specify which sub-agents exist (phases, domains, utils)
   - Customize load triggers for project workflow
   - References `.livespec/standard/conventions/context-tree.spec.md` for mechanism

5. **specs/workspace/workspace-agent.spec.md**
   - Template: `dist/templates/workspace/workspace-agent.spec.md.template`
   - Define AGENTS.md content generation sources
   - Specify content structure (START/MIDDLE/END positioning)
   - Customize for project's methodology presentation
   - References `.livespec/guides/context-positioning.md` for optimization

Note: taxonomy.spec.md created in Step 3 is also part of workspace/ (portable methodology).

### Step 5: Explain Context Compression Impact

Brief explanation of what the chosen compression level means:

- What will be inline vs extracted
- Where to find detailed guidance (templates/, prompts/)
- How this affects AGENTS.md structure
- Can be changed later via audit utility (`.livespec/prompts/utils/audit-context-compression.md`)

### Step 6: Regenerate AGENTS.md

**CRITICAL**: Now that workspace specs exist, regenerate AGENTS.md with project context.

Tell user:

"Workspace specs created! Now regenerating AGENTS.md with your project-specific context..."

**Use prompt 4d to regenerate**:
```
"Use .livespec/4-evolve/4d-regenerate-context.md to update AGENTS.md"
```

**What this does**:
- Incorporates YOUR workspace specs into AGENTS.md
- Applies chosen context compression level
- Preserves generic LiveSpec methodology
- Gives AI agents your project's specific context
- Critical for agent effectiveness going forward

**Wait for 4d completion** before proceeding to slash command generation.

### Step 6.5: Generate Slash Commands

**Make LiveSpec utilities discoverable** via Claude Code slash commands.

Tell user:

"Generating slash commands for LiveSpec utilities..."

**Use generation prompt**:
```
"Use dist/prompts/utils/generate-slash-commands.md to create discoverable commands"
```

**What this does**:
- Creates 11 slash commands in `.claude/commands/livespec/` namespace
- Makes utilities discoverable via `/` autocomplete in Claude Code
- Enables parameterized commands (`/livespec/audit minimalism`)
- Avoids polluting project root command namespace

**Wait for generation completion** before confirming setup.

Tell user after generation:

**✅ Workspace customization complete!**

Created:
- `specs/workspace/taxonomy.spec.md` - Your project domain
- `specs/workspace/constitution.spec.md` - Your development principles
- `specs/workspace/patterns.spec.md` - Your conventions
- `specs/workspace/workflows.spec.md` - Your processes
- `specs/workspace/agent-contexts.spec.md` - Your agent context tree structure
- `specs/workspace/workspace-agent.spec.md` - Your AGENTS.md content definition
- `AGENTS.md` - **Regenerated** with your project context
- `.claude/commands/livespec/*.md` - 11 discoverable slash commands

## Output

Create or update specification files in specs/ directory with clear, testable requirements.

## Validation

- Prompt produces four workspace spec files (constitution, patterns, workflows, taxonomy)
- All specs follow MSL format (Criticality, Failure Mode, Requirements, Validation)
- taxonomy.spec.md declares project domain, workspace scope, and specs boundary
- Specs are specific to target project, not generic
- User understands workspace defines HOW to build, not WHAT to build
- User understands taxonomy.spec.md is checked FIRST before file creation
- Prompt references folder-structure behavior and MSL format requirements

## Looking Ahead: How These Specs Are Used

**In Phase 1 (DESIGN):**
- Architecture decisions guided by patterns.spec.md
- Behavior specs follow format from constitution.spec.md
- Workflows.spec.md defines how design progresses

**In Phase 2 (BUILD):**
- Implementations verified against workspace patterns
- Constitution.spec.md enforces spec-first discipline
- Workflows.spec.md guides TDD/implementation process

**In Phase 4 (EVOLVE):**
- Drift detection uses patterns.spec.md to validate consistency
- Constitution principles guide spec evolution
- Workflows define how to handle discovered drift

**Value of this investment**: 30 minutes here prevents hours of methodology confusion later. Workspace specs are referenced throughout development - they're your project's "how we work" foundation.

## Success Criteria

**This prompt succeeds when:**
- All requirements from spec are satisfied
- Output is actionable and immediately usable
- No ambiguity in what needs to be done
- Clear path from current state to desired state

---

**Criticality**: CRITICAL
**Failure Mode**: Users cannot create workspace specifications without guidance
