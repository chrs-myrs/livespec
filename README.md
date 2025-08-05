# Bidirectional Specifications System

A living documentation system that maintains synchronized specifications throughout the software lifecycle, working equally well for new projects and existing codebases.

## Quick Start

### I have a new project idea
```bash
# Set up your project with TDD and specs integration
claude-code "Use prompts/setup-project-claude-md.md"

# Start by defining your system's purpose
claude-code "Use prompts/1-write-purpose.md for my new inventory system"

# Continue through the specification levels
claude-code "Use prompts/2-write-strategy.md"
claude-code "Use prompts/3-write-design.md"
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

## What is This?

Traditional documentation flows one way: Ideas → Requirements → Code → Outdated Docs 😢

This system works **bidirectionally**:
- **Forward**: Ideas → Living Specs → Code
- **Backward**: Code → Extracted Specs → Understanding
- **Continuous**: Code ↔ Specs (always in sync)

## Key Features

- 🔄 **Bidirectional Flow** - Create specs from ideas OR extract from code
- 📋 **Living Documentation** - Specs that evolve with your code
- 🎯 **Multiple Workflows** - New projects, updates, validation, reverse engineering  
- 🧪 **Test-Driven Development** - Built-in TDD support and validation
- 🚀 **Rapid Prototyping** - Auto-build mode for quick experiments

## Documentation

- [System Overview](docs/overview.md) - Concepts and architecture
- [User Guide](docs/user-guide.md) - Detailed usage instructions
- [Architecture](docs/architecture.md) - Technical design of the system

## Project Structure

```
your-project/
├── src/               # Your code
├── reqs/              # Your specifications
│   ├── 1-purpose/     # WHY system exists
│   ├── 2-strategy/    # Technical decisions
│   ├── 3-design/      # Architecture
│   ├── 4-components/  # What components do
│   └── 5-implementation/ # How they work
└── prompts/           # Documentation tools
```

## Getting Started

1. Choose your starting point:
   - New project? Start with [purpose documentation](prompts/1-write-purpose.md)
   - Existing code? Use [spec extraction](prompts/extract-specs-from-code.md)
   - Not sure? Read the [overview](docs/overview.md)

2. Follow the appropriate workflow in the [user guide](docs/user-guide.md)

3. Keep your documentation synchronized as you develop

## Requirements

- Claude Code CLI installed
- Access to your project codebase
- Basic understanding of your system's purpose

## Documentation

- **[Overview](docs/overview.md)** - Understand the concepts and philosophy
- **[User Guide](docs/user-guide.md)** - Detailed how-to instructions
- **[Architecture](docs/architecture.md)** - Technical design and principles
- **[Prompt Reference](docs/prompt-reference.md)** - Quick reference for all prompts
- **[CLAUDE.md Guide](docs/claude-md-guide.md)** - Creating effective context files
- **[Changelog](docs/CHANGELOG.md)** - Version history and updates
- **[Examples](docs/examples/)** - Complete working examples

## Support

For detailed workflows, troubleshooting, and FAQ, see the [User Guide](docs/user-guide.md).

## License

This documentation system is designed to work with any project and imposes no licensing requirements on your code or documentation.