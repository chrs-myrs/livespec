# LiveSpec

**Specifications that live with your code** ✨

A living documentation framework that maintains synchronized specifications throughout the software lifecycle, working equally well for new projects and existing codebases.

## Quick Start

### I have a new project idea
```bash
# Set up your project with LiveSpec
claude-code "Use prompts/setup-project-claude-md.md"

# Start by defining your system's purpose
claude-code "Use prompts/1a-write-purpose.md for my new inventory system"

# Continue through the specification levels
claude-code "Use prompts/2a-write-strategy.md"
claude-code "Use prompts/3a-write-design.md"
# ... and so on
```

### I have existing code without documentation
```bash
# Extract documentation from your codebase
claude-code "Use prompts/extract-specs-from-code.md to document this codebase"
```

### I need to check if my docs match my code
```bash
# Run alignment check
claude-code "Use prompts/align-specs-to-code.md"
```

### I want a quick prototype (⚠️ PROTOTYPE ONLY)
```bash
# Auto-build from whatever exists
claude-code "Use prompts/auto-build.md"
```

## What is LiveSpec?

Traditional documentation flows one way: Ideas → Requirements → Code → Outdated Docs 😢

LiveSpec works **bidirectionally**:
- **Forward**: Ideas → Living Specs → Code
- **Backward**: Code → Extracted Specs → Understanding
- **Continuous**: Code ↔ Specs (always in sync)

## Key Features

- 🔄 **Bidirectional Flow** - Create specs from ideas OR extract from code
- 📋 **Living Documentation** - Specs that evolve with your code
- 🎯 **Multiple Workflows** - New projects, updates, validation, reverse engineering  
- 🧪 **Test-Driven Development** - Built-in TDD support and validation
- 🚀 **Rapid Prototyping** - Auto-build mode for quick experiments
- 👥 **Stakeholder Reviews** - Integrated review and approval workflow
- 🎨 **UX-First Support** - User personas, journeys, and interaction design

## Documentation

- [System Overview](docs/overview.md) - Concepts and architecture
- [User Guide](docs/user-guide.md) - Detailed usage instructions
- [Architecture](docs/architecture.md) - Technical design of the system
- [Deployment Guide](docs/deployment-guide.md) - Installation and setup

## Project Structure

```
your-project/
├── src/               # Your code
├── reqs/              # Your specifications
│   ├── 0-ux/         # UX documentation
│   ├── 1-purpose/    # WHY system exists
│   ├── 2-strategy/   # Technical decisions
│   ├── 3-design/     # Architecture
│   ├── 4-components/ # What components do
│   ├── 5-implementation/ # How they work
│   └── reviews/      # Stakeholder reviews
└── prompts/          # LiveSpec tools
```

## Installation

### Quick Install

```bash
# Clone LiveSpec
git clone https://github.com/chrs-myrs/livespec.git
cd livespec

# Deploy to your project
./deploy-livespec.sh /path/to/your/project
```

### Start Using LiveSpec

```bash
cd /path/to/your/project

# Start the workflow orchestrator
./livespec-start.sh

# Or use directly with Claude
claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
```

## Requirements

- Claude Code CLI installed
- Access to your project codebase
- Basic understanding of your system's purpose

## Core Concepts

### Living Documentation
Documentation that evolves with your code, not a one-time artifact. Changes in code trigger documentation updates, and documentation changes inform code modifications.

### Bidirectional Flow
Information flows both ways:
- **Forward**: Ideas shape specifications which guide implementation
- **Backward**: Code reality updates specifications which clarify purpose

### Staged Workflow
Progress through clear stages:
1. **Discovery & Purpose** - Why build this?
2. **Strategy** - How will we approach it?
3. **Design** - What's the architecture?
4. **Components** - What are the building blocks?
5. **Implementation** - How does it work?
6. **Maintenance** - Keep specs synchronized

### Workflow Orchestration
Intelligent guidance through the entire process:
- Analyzes current state
- Identifies next steps
- Manages review gates
- Tracks progress

## Version

Current Version: **0.2.0** (Beta)

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Support

- **Documentation**: See the [User Guide](docs/user-guide.md)
- **Issues**: [GitHub Issues](https://github.com/chrs-myrs/livespec/issues)
- **Discussions**: [GitHub Discussions](https://github.com/chrs-myrs/livespec/discussions)

---

**LiveSpec** - Because your specifications should live and breathe with your code, not gather dust in a drawer.

Built with ❤️ for developers who believe documentation should be a living part of their codebase.