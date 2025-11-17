---
derives-from:
  - specs/1-requirements/strategic/outcomes.spec.md (AI Agent Support, Voluntary Adoption)
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md (Agent Agnostic, No Framework Lock-in, Manual Adoption)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without effective AI discoverability, agents cannot assist users and voluntary adoption fails
---

# AI Discoverability Strategy

## Requirements
- [!] LiveSpec maximizes AI agent effectiveness through Context7 integration, cacheable documentation (AGENTS.md <100KB), machine-readable index (llms.txt), navigable folder hierarchy, semantic prompt frontmatter, and version-aware upgrade process, enabling agents to guide users without requiring manual context provision.
  - Context7 indexes LiveSpec repository at github.com/chrs-myrs/livespec
  - llms.txt provides Context7-compatible entry point
  - AGENTS.md generated from workspace specs provides <100KB cacheable reference
  - Folder structure uses clear hierarchy (workspace/, behaviors/, strategy/, contracts/ optional)
  - Prompts include spec: frontmatter pointing to defining specifications
  - VERSION file enables version-aware operations and upgrade detection
  - Upgrade process preserves agent context (AGENTS.md regeneration)
  - Agent-agnostic approach (same content works for Claude, Copilot, Cursor)
  - Remote reference mode (Context7) and local copy mode both supported

## Context7 Integration

**Rationale:**
- Enables AI agents to discover and reference LiveSpec remotely
- Reduces friction for users (no manual setup to get help)
- Provides canonical source of truth for methodology
- Supports rapid iteration (updates immediately available)

**Implementation:**
- LiveSpec repository indexed by Context7
- llms.txt at root provides structured entry point
- Agents can reference via `@context7/chrs-myrs/livespec`
- Full prompts/ and docs/ available remotely

**Trade-offs:**
- **Remote reference**: Always up-to-date, no local copy needed, requires internet
- **Local copy**: Works offline, user-customizable, requires manual upgrade
- **Hybrid approach**: Local .livespec/ + remote fallback for unknown patterns

**Usage pattern:**
```bash
# Quick help without local copy
"Use @context7/chrs-myrs/livespec to explain Phase 1"

# After adopting locally
"Use .livespec/1-design/1a-design-architecture.md"
```

## llms.txt Design

**Purpose:**
- Context7-compatible index file
- Quick overview for AI agents discovering LiveSpec
- Links to detailed content (prompts, docs, specs)

**Content structure:**
1. **Overview**: 2-paragraph summary (what LiveSpec is, why it exists)
2. **Core Methodology**: 5 phases with links to prompt folders
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
- Context7 can parse and index successfully
- Contains links to all 5 phase folders
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
- Prompt: prompts/4-evolve/4d-regenerate-context.md
- Sources: PURPOSE.md, specs/workspace/, specs/1-requirements/strategic/outcomes.spec.md, specs/1-requirements/strategic/constraints.spec.md
- Output: AGENTS.md with frontmatter (generated timestamp, version, spec reference)
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

## Prompt Frontmatter Design

**Purpose:**
- Links prompts to defining specifications
- Enables bidirectional traceability
- Helps agents understand prompt intent and validation criteria

**Pattern:**
```yaml
---
implements: specs/3-artifacts/prompts/4a-detect-drift.spec.md
---
```

**Benefits:**
- Agent can read spec to understand prompt deeply
- Validates prompt implements spec requirements
- Supports regeneration (prompt rebuilt from updated spec)
- Creates traceable chain: requirements → strategy → behaviors → prompts

**Frontmatter conventions:**
- `spec:` points to defining specification
- `derives_from:` points to upstream dependencies
- `constrained_by:` points to constraints
- Relative paths from repository root

**Agent usage:**
- "Show me the spec for this prompt" → read spec: field
- "What requirements does this satisfy?" → follow derives_from chain
- "What constraints apply?" → read constrained_by references

## VERSION File and Upgrade Integration

**Purpose:**
- Enables version-aware upgrade detection
- Documents current methodology version
- Supports Context7 version pinning (future)

**Location:**
- dist/VERSION (distributed to target projects as .livespec/VERSION)

**Format:**
- Single line: `2.0.0`
- Semantic versioning: MAJOR.MINOR.PATCH

**Usage in upgrade workflow:**
1. Pre-flight: Read .livespec/VERSION (detect current version)
2. Fetch: Read new dist/VERSION (detect target version)
3. Diff: Compare versions, show what changed between versions
4. Apply: Selective upgrade with version awareness
5. Update: Copy new VERSION to .livespec/VERSION

**Agent context preservation:**
- After upgrade: Prompt to regenerate AGENTS.md
- Ensures agent has latest methodology in cache
- Maintains 80% coverage without additional context

**Validation:**
- VERSION file exists at dist/VERSION
- Upgrade prompt references VERSION for detection
- AGENTS.md regeneration triggered post-upgrade
- Version visible in llms.txt

## Remote vs Local Trade-offs

**Decision matrix:**

| Scenario | Approach | Rationale |
|----------|----------|-----------|
| Quick help/discovery | Remote (Context7) | No setup needed, always current |
| Adopted LiveSpec | Local (.livespec/) | Offline, customizable, faster |
| Exploring methodology | Remote (Context7) | Try before committing to local copy |
| Production project | Local (.livespec/) | Stable, versioned, team-controlled |
| Learning LiveSpec | Remote (Context7) | Lower barrier to entry |
| Custom workflows | Local (.livespec/) | Can modify prompts for project needs |

**Hybrid pattern (recommended):**
1. Discover via Context7: `"Use @context7/chrs-myrs/livespec to explain drift detection"`
2. Adopt locally: `cp -r livespec/dist/* .livespec/`
3. Customize: Modify .livespec/ for project needs
4. Upgrade: Use upgrade-methodology.md when new version released
5. Fallback: Reference Context7 for new features not yet adopted

**Agent handling:**
- Prefer local .livespec/ if exists (user has adopted)
- Fall back to Context7 if .livespec/ missing or incomplete
- Suggest local adoption after repeated Context7 references

## Agent-Agnostic Implementation

**Goal:**
Same content structure works across Claude Code, GitHub Copilot, Cursor IDE, and any markdown-aware agent.

**Strategies:**

1. **Plain markdown prompts:**
   - No proprietary formats
   - No special syntax beyond standard markdown
   - Readable by humans and AI equally

2. **Multiple discovery filenames:**
   - AGENTS.md (canonical)
   - CLAUDE.md (symlink - implemented), others optional (COPILOT.md, CURSOR.md)
   - Agents discover methodology via familiar filename

3. **Conventional folder structure:**
   - .livespec/ (common convention)
   - specs/ (semantic clarity)
   - No magic folders requiring specific agent features

4. **Execution flexibility:**
   - Claude Code: Direct prompt execution
   - Cursor: Open prompt, use Composer
   - Copilot: Add prompt as context
   - Manual: Copy/paste prompt content

5. **Context7 as universal reference:**
   - Any agent can reference @context7/chrs-myrs/livespec
   - Canonical remote methodology
   - No vendor lock-in

**Validation:**
- 3+ different AI agents successfully execute prompts
- No prompt requires agent-specific features
- Documentation explains usage for each agent
- AGENTS.md works across all agents tested

## Validation

- Context7 indexes LiveSpec repository successfully
- llms.txt exists at root with correct structure
- AGENTS.md generated from workspace specs, <100KB
- Folder structure uses clear semantic hierarchy
- All prompts include spec: frontmatter
- VERSION file exists in dist/
- Upgrade prompt triggers AGENTS.md regeneration
- Remote (Context7) and local (.livespec/) modes both functional
- Same prompts work across Claude, Copilot, Cursor
- Agents can navigate folder structure semantically
- Prompt frontmatter enables bidirectional traceability
