# LiveSpec v2

**Specifications that live with your code**

A folder structure and methodology for keeping specifications and code synchronized throughout the development lifecycle. Works with any AI coding agent.

## What is LiveSpec?

LiveSpec is three things:

1. **A folder structure** - Separates workspace (HOW you build) from product (WHAT you build)
2. **MSL specification format** - Minimal Specification Language keeps specs small and maintainable
3. **Five-phase methodology** - DEFINE → DESIGN → BUILD → VERIFY → EVOLVE

**Not a framework. Not a tool. Just information architecture.**

## Quick Start

### New Project (5 minutes)

```bash
# Clone LiveSpec
git clone https://github.com/chrs-myrs/livespec.git
cd your-project

# Copy methodology to .livespec/ folder
cp -r livespec/prompts .livespec

# Create specs structure
mkdir -p specs/workspace specs/behaviors specs/contracts

# Start Phase 0
claude-code "Use .livespec/0-define/0a-setup-workspace.md"
```

### Existing Project

```bash
# Copy methodology
cp -r livespec/prompts .livespec

# Create structure
mkdir -p specs/workspace specs/behaviors specs/contracts

# Extract specifications from code
claude-code "Use .livespec/4-evolve/4b-extract-specs.md to document this codebase"
```

### Using Context7

```bash
# Just create structure
mkdir -p specs/workspace specs/behaviors specs/contracts

# Tell your AI agent:
# "Use @context7/chrs-myrs/livespec methodology"
# AI reads prompts remotely, helps create your specs
```

[Full quickstart guide →](docs/quickstart.md)

## Project Structure

```
your-project/
├── PURPOSE.md              # Why this project exists
│
├── specs/
│   ├── workspace/          # How you build
│   │   ├── constitution.spec.md # Development principles
│   │   ├── patterns.spec.md     # Code patterns
│   │   └── workflows.spec.md    # Development workflows
│   ├── behaviors/          # What system does
│   ├── contracts/          # API/data contracts
│   └── constraints.spec.md # Hard boundaries
│
├── .livespec/              # LiveSpec methodology (copied from prompts/)
│   ├── 0-define/           # Problem definition
│   ├── 1-design/           # Solution design
│   ├── 2-build/            # Implementation
│   ├── 3-verify/           # Validation
│   ├── 4-evolve/           # Synchronisation
│   └── templates/          # Workspace templates
│
└── [your code]             # Your implementation
```

## MSL Format

All specifications follow Minimal Specification Language (MSL):

```markdown
# User Authentication

**Criticality**: CRITICAL
**Failure Mode**: System unsecured without authentication

## Specification
System authenticates users via email and password before allowing access to protected resources.

## Validation
- Valid credentials allow login
- Invalid credentials rejected
- Sessions persist after authentication
- Protected resources require authentication
```

**That's it.** Four sections. Minimal. Testable.

[MSL Guide →](docs/msl-guide.md)

## The Five Phases

### Phase 0: DEFINE
Establish problem space and development approach
- Define problem statement
- Identify constraints
- Setup workspace specifications

### Phase 1: DESIGN
Design solution architecture
- Define architecture
- Specify behaviors
- Create contracts

### Phase 2: BUILD
Implement the solution
- Build to specifications
- Create tests
- Validate implementation

### Phase 3: VERIFY
Validate solution meets requirements
- Run validation
- Acceptance review
- Document results

### Phase 4: EVOLVE
Keep specs and code synchronized (continuous)
- Detect drift
- Extract new specs
- Update existing specs

[Methodology Guide →](docs/methodology.md)

## Key Features

- ✅ **AI Agent Agnostic** - Works with Claude, Copilot, Cursor, any agent
- ✅ **Bidirectional Flow** - Specs → Code AND Code → Specs
- ✅ **Living Documentation** - Specifications evolve with code
- ✅ **Minimal Specifications** - MSL format reduces specs by 70%
- ✅ **No Lock-in** - Just markdown files and folders
- ✅ **Manual-Friendly** - Can use without AI agents
- ✅ **Any Language** - Pure information architecture

## Why LiveSpec?

**The Problem:**
- Specifications and code inevitably drift apart
- Documentation becomes outdated
- AI agents lack context about project intent

**The Solution:**
- Clear separation of workspace (HOW) and product (WHAT) specs
- Minimal specifications that stay maintainable
- Continuous synchronization through EVOLVE phase
- Structure that makes AI agents more effective

## Works With

- **Claude Code** - Direct prompt execution
- **Cursor** - Use Composer with prompts
- **GitHub Copilot** - Use prompts as context
- **Any AI Agent** - Copy/paste prompts

[See examples →](docs/quickstart.md#using-with-different-ai-agents)

## Documentation

### For AI Agents
- **[llms.txt](llms.txt)** - Context7-compatible overview (cache this!)
- **[AGENTS.md](AGENTS.md)** - Quick reference for AI assistants

### For Humans
- **[Quickstart](docs/quickstart.md)** - Get started in 5 minutes
- **[MSL Guide](docs/msl-guide.md)** - Learn minimal specification format
- **[Methodology](docs/methodology.md)** - Understand the philosophy

## Version

**Current Version: 2.0.0**

LiveSpec v2 is a complete rebuild focused on simplicity and effectiveness:
- Simplified from 7+ stages to 5 phases
- Flattened specs/ structure
- Focused on information architecture, not tooling
- Adopted strict MSL minimalism

[v1 archived →](.archive/v1-2025-01/)

## Requirements

- Any AI coding agent (optional but recommended)
- Git (for version control)
- Text editor

**That's it. No installation. No dependencies.**

## Repository Structure

```
livespec/
├── PURPOSE.md              # Why LiveSpec exists
├── README.md               # This file
│
├── prompts/                # METHODOLOGY (copy this to .livespec/)
│   ├── 0-define/
│   ├── 1-design/
│   ├── 2-build/
│   ├── 3-verify/
│   ├── 4-evolve/
│   └── templates/          # Workspace templates
│
├── specs/                  # DOGFOODING (LiveSpec's own specs)
│   ├── workspace/          # How we build LiveSpec
│   ├── prompts/            # Meta-specs about our prompts
│   └── constraints.spec.md
│
├── .livespec/              # Symlink to prompts/ (we dogfood our own methodology)
├── tests/                  # Validation suite
└── docs/                   # User documentation
```

**For Users:** Copy `prompts/` to `.livespec/` in your project

**For Contributors:**
- Read `specs/workspace/` to understand how WE build LiveSpec
- Check `specs/prompts/` for what each prompt does
- We use `.livespec/` (symlinked to `prompts/`) for our own development

## Contributing

Contributions welcome! We dogfood our own methodology:
- Read [specs/workspace/](specs/workspace/) to understand how WE build LiveSpec
- Check [specs/prompts/](specs/prompts/) for what each prompt does
- Use `.livespec/` prompts when working on LiveSpec itself
- Submit PRs following workspace patterns

## License

MIT License - see [LICENSE](LICENSE)

## Support

- **Documentation**: See [docs/](docs/)
- **Issues**: [GitHub Issues](https://github.com/chrs-myrs/livespec/issues)
- **Discussions**: [GitHub Discussions](https://github.com/chrs-myrs/livespec/discussions)

---

**LiveSpec v2** - Information architecture for AI-first development.

Simple. Minimal. Effective.
