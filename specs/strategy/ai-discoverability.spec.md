---
type: strategy
category: strategy
fidelity: decisions-only
criticality: CRITICAL
failure_mode: Without effective AI discoverability, agents cannot assist users and voluntary adoption fails
governed-by:
  - specs/foundation/constraints.spec.md (Agent Agnostic, No Framework Lock-in, Manual Adoption)
derives-from:
  - specs/foundation/outcomes.spec.md (AI Agent Support, Voluntary Adoption)
---

# AI Discoverability Strategy

## Requirements
- [!] LiveSpec maximizes AI agent effectiveness through plugin-based distribution, cacheable documentation (AGENTS.md <100KB), machine-readable index (llms.txt), navigable folder hierarchy, semantic skill/command frontmatter, and version-aware upgrade process, enabling agents to guide users without requiring manual context provision.
  - LiveSpec is discovered and installed as a Claude Code plugin (`/plugin install livespec@livespec`)
  - llms.txt provides a machine-readable entry point
  - AGENTS.md generated from workspace specs provides <100KB cacheable reference
  - Folder structure uses clear hierarchy (workspace/, behaviors/, strategy/, contracts/ optional)
  - Skills and commands include frontmatter pointing to defining specifications
  - Plugin version (plugin.json) enables version-aware operations and upgrade detection
  - Upgrade process preserves agent context (AGENTS.md regeneration)
  - Agent-agnostic approach (same content works for Claude, Copilot, Cursor)
  - Plugin installation (Claude Code) and direct repository use both supported

## Plugin Discoverability

**Rationale:**
- Enables AI agents to discover and reference LiveSpec via the Claude Code plugin marketplace
- Reduces friction for users (single install command, no manual copying)
- Provides canonical source of truth for methodology
- Supports rapid iteration (plugin updates available via `/plugin update`)

**Implementation:**
- LiveSpec distributed as a Claude Code plugin (`/plugin install livespec@livespec`)
- llms.txt at root provides structured entry point for agents reading the repository directly
- Skills, agents, and commands are self-contained under skills/, agents/, commands/
- Full skills/ and references/ content available once installed

**Trade-offs:**
- **Plugin install**: Always current version per marketplace release, single command, requires Claude Code plugin support
- **Direct repository use**: Works for dogfooding and development, requires being in this repository

**Usage pattern:**
```bash
# Install the plugin
/plugin install livespec@livespec

# Invoke a skill
/livespec:design
```

## llms.txt Design

**Purpose:**
- Machine-readable index file
- Quick overview for AI agents discovering LiveSpec
- Links to detailed content (skills, docs, specs)

**Content structure:**
1. **Overview**: 2-paragraph summary (what LiveSpec is, why it exists)
2. **Core Methodology**: skills with links to skill definitions
3. **Project Structure**: Folder tree showing standard layout
4. **Quick Start**: New project and existing project workflows
5. **MSL Format**: Brief example showing minimal spec format
6. **Key Features**: Bullet points highlighting main benefits
7. **Documentation**: Links to detailed guides
8. **Topics**: Keywords for discoverability

**Design principles:**
- Single file, no dependencies
- Links relative to repository root
- Balanced: enough context to understand, not so much to overwhelm
- Updated manually when major structure changes (low maintenance)

**Validation:**
- File exists at root: llms.txt
- Content is parseable structured markdown
- Contains links to all core skills
- MSL example demonstrates format

## AGENTS.md Design

**Purpose:**
- Cacheable reference enabling agents to guide users through 80% of use cases
- Single source of truth for project methodology
- Regeneratable from workspace specs (stays current)

**Size constraint: <100KB**
- Rationale: Most AI agents cache context up to ~100KB efficiently
- Enables persistent methodology awareness across sessions
- Reduces need for repeated context provision
- Improves agent response quality and speed

**Content coverage (80/20 rule):**
- Summary (purpose, success criteria)
- Quick start (new project, existing project)
- Decision tree (which phase/prompt to use)
- 5 phases overview (entry/exit conditions)
- MSL format quick reference
- Folder structure pattern
- Essential templates (workspace, behavior, contract)
- Core principles (constitution.spec.md)
- Constraints (critical boundaries)
- Dependency structure (frontmatter conventions)
- Common anti-patterns
- Prompt mapping table (needs → prompts)

**Generation workflow:**
- Triggered by workspace spec changes, PURPOSE.md updates, or version upgrades
- Skill: `/livespec:evolve context` (delegates to the context-builder agent)
- Sources: PURPOSE.md, specs/workspace/, specs/foundation/outcomes.spec.md, specs/foundation/constraints.spec.md
- Output: regenerated AGENTS.md
- Validation: file size check, section completeness, manual review

**Agent-specific variants (optional):**
- AGENTS.md (canonical)
- CLAUDE.md → symlink to AGENTS.md (Claude Code - implemented)
- COPILOT.md → symlink to AGENTS.md (GitHub Copilot - example)
- CURSOR.md → symlink to AGENTS.md (Cursor IDE - example)

Same content, different filenames for agent-specific discovery patterns. LiveSpec currently implements CLAUDE.md only.

## Folder Structure for AI Navigation

**Design rationale:**
- Clear hierarchy reduces agent confusion
- Semantic folder names (workspace/, behaviors/, strategy/, contracts/)
- Separation of concerns (HOW vs WHAT)
- Consistent placement aids pattern matching

**Navigation patterns:**

```
specs/
├── workspace/          # "How does this project work?"
│   ├── constitution.spec.md    # "What are the principles?"
│   ├── patterns.spec.md        # "What patterns should I follow?"
│   └── workflows.spec.md       # "What's the development workflow?"
│
├── behaviors/          # "What does the system do?"
│   ├── prompts/        # Organizational subfolder
│   └── *.spec.md      # Observable behaviors
│
├── strategy/          # "How is this technically solved?"
│   ├── architecture.spec.md
│   └── ai-discoverability.spec.md
│
├── contracts/         # "What are the API boundaries?"
│   └── api/v1/*.yaml
│
└── mission/           # "What are the high-level goals?"
    ├── outcomes.spec.md    # "What must be achieved?"
    └── constraints.spec.md # "What are the hard limits?"
```

**Agent benefits:**
- Question-driven folder lookup
- Clear semantic boundaries
- Subfolders permitted for organization
- Standard structure across all LiveSpec projects

**Validation:**
- Folder structure matches folder-structure.spec.md convention
- AI agents can locate specs by asking semantic questions
- No ambiguity about where specs belong

## Skill/Command Frontmatter Design

**Purpose:**
- Links skills and commands to defining specifications
- Enables bidirectional traceability
- Helps agents understand skill intent and validation criteria

**Pattern:**
```yaml
---
specifies: skills/audit/SKILL.md
---
```

**Benefits:**
- Agent can read spec to understand skill deeply
- Validates skill implements spec requirements
- Supports regeneration (skill rebuilt from updated spec)
- Creates traceable chain: requirements → strategy → behaviors → skills

**Frontmatter conventions:**
- `specifies:` (in the spec) points to the deliverable it governs
- `derives-from:` points to upstream dependencies
- `governed-by:` points to constraints
- Relative paths from repository root

**Agent usage:**
- "Show me the spec for this skill" → find the spec whose `specifies:` references it
- "What requirements does this satisfy?" → follow `satisfies` chain
- "What constraints apply?" → read `governed-by` references

## Plugin Version and Upgrade Integration

**Purpose:**
- Enables version-aware upgrade detection
- Documents current methodology version
- Supports future marketplace version pinning

**Location:**
- `plugin.json` (plugin manifest version field)

**Format:**
- Semantic versioning: MAJOR.MINOR.PATCH

**Usage in upgrade workflow:**
1. Pre-flight: Detect legacy install (`.livespec-repo/` submodule or copied `.livespec/`) or current plugin version
2. Fetch: Latest plugin release via `/plugin update` or marketplace
3. Diff: Compare versions, show what changed between versions
4. Apply: `/livespec:upgrade` migrates legacy installs to the plugin model
5. Update: Plugin manifest reflects new version after update

**Agent context preservation:**
- After upgrade: Prompt to regenerate AGENTS.md
- Ensures agent has latest methodology in cache
- Maintains 80% coverage without additional context

**Validation:**
- plugin.json version field present and current
- `/livespec:upgrade` detects legacy installs and migrates them
- AGENTS.md regeneration triggered post-upgrade
- Version visible in llms.txt

## Plugin Install vs Dogfooding Trade-offs

**Decision matrix:**

| Scenario | Approach | Rationale |
|----------|----------|-----------|
| Adopting LiveSpec in a project | Plugin install | Single command, versioned, always current release |
| Developing LiveSpec itself | Direct repository use | Dogfooding, immediate iteration on skills/specs |
| Production project | Plugin install | Stable, versioned, team-controlled via marketplace |
| Learning LiveSpec | Plugin install | Lower barrier to entry, no manual copying |

**Recommended pattern:**
1. Install: `/plugin install livespec@livespec`
2. Use: Invoke skills (`/livespec:design`, `/livespec:audit`, etc.) directly
3. Upgrade: `/plugin update` when a new version releases; `/livespec:upgrade` migrates any legacy pre-plugin install
4. Customize: Project-level specs and workspace configuration remain project-owned

**Agent handling:**
- Prefer the installed plugin skills
- Detect legacy installs (`.livespec-repo/` submodule, copied `.livespec/`) and recommend `/livespec:upgrade`

## Agent-Agnostic Implementation

**Goal:**
Same content structure works across Claude Code, GitHub Copilot, Cursor IDE, and any markdown-aware agent.

**Strategies:**

1. **Plain markdown skills and commands:**
   - No proprietary formats
   - No special syntax beyond standard markdown
   - Readable by humans and AI equally

2. **Multiple discovery filenames:**
   - AGENTS.md (canonical)
   - CLAUDE.md (symlink - implemented), others optional (COPILOT.md, CURSOR.md)
   - Agents discover methodology via familiar filename

3. **Conventional folder structure:**
   - skills/, agents/, commands/ (Claude Code plugin convention)
   - specs/ (semantic clarity)
   - No magic folders requiring specific agent features

4. **Execution flexibility:**
   - Claude Code: Direct skill/command execution via the installed plugin
   - Cursor: Open skill content, use Composer
   - Copilot: Add skill content as context
   - Manual: Copy/paste skill content

5. **Plain-markdown content as universal reference:**
   - Any agent can read skills/agents/commands directly from the repository
   - Canonical methodology lives in this repository
   - No vendor lock-in

**Validation:**
- 3+ different AI agents successfully execute skill instructions
- No skill requires agent-specific features
- Documentation explains usage for each agent
- AGENTS.md works across all agents tested

## Validation

- LiveSpec installs successfully as a Claude Code plugin
- llms.txt exists at root with correct structure
- AGENTS.md generated from workspace specs, <100KB
- Folder structure uses clear semantic hierarchy
- All skills/commands include spec-linking frontmatter
- plugin.json version field present and current
- `/livespec:upgrade` triggers AGENTS.md regeneration after migrating legacy installs
- Plugin install and direct repository (dogfooding) use both functional
- Same skill content works across Claude, Copilot, Cursor
- Agents can navigate folder structure semantically
- Skill/command frontmatter enables bidirectional traceability
