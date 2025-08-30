# LiveSpec Changelog

All notable changes to LiveSpec will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2024-01-30

### Beta Release

LiveSpec is a living documentation framework that maintains synchronized specifications throughout the software lifecycle. This beta release provides a working system for bidirectional specification management, ready for early adopters and testing.

### Core Features

#### Documentation Management
- **Living Specifications** - Documentation that evolves with your code
- **Bidirectional Flow** - Create specs from ideas OR extract from code
- **Staged Workflow** - Clear progression through specification levels
- **Automatic Discovery** - Smart detection of what needs updating

#### UX-First Development
- User persona templates and workflows
- User journey mapping
- Information architecture documentation
- User success metrics tracking
- UX strategy documentation
- Interaction design tools
- Behavior specifications
- UI specifications
- Usability testing protocols

#### Stakeholder Review System
- **Workflow Orchestrator** - Intelligent guidance through the entire process
- **Review Gates** - Mandatory review points at key stages
- **Review Templates** - Structured feedback collection
- **Approval Tracking** - Complete audit trail
- **Feedback Integration** - Systematic incorporation of stakeholder input

#### Development Support
- **Test-Driven Development** - Built-in TDD support and validation
- **Rapid Prototyping** - Auto-build mode for quick experiments
- **Progress Tracking** - Comprehensive progress monitoring
- **Gap Analysis** - Identify missing documentation
- **Alignment Checking** - Ensure docs match code

#### Deployment System
- Easy installation via deployment scripts
- Framework configuration management
- Version tracking and migration support
- Helper scripts for common tasks
- Clean separation of framework and project files

### Documentation Structure

```
reqs/
├── 0-ux/             # UX documentation
├── 1-purpose/        # System purpose
├── 2-strategy/       # Technical strategy
├── 3-design/         # System design
├── 4-components/     # Component specs
├── 5-implementation/ # Implementation details
└── reviews/          # Stakeholder reviews
```

### Workflow Stages

1. **Stage 0** - Project Setup & UX Discovery
2. **Stage 1** - Discovery & Purpose
3. **Stage 2** - Strategy
4. **Stage 3** - Design
5. **Stage 4** - Components
6. **Stage 5** - Implementation
7. **Stage 6** - Maintenance

### Installation

```bash
# Clone LiveSpec
git clone https://github.com/chrs-myrs/livespec.git

# Deploy to your project
./deploy-livespec.sh /path/to/your/project

# Start using
./livespec-start.sh
```

### Key Commands

- `0-orchestrate-workflow` - Start here for guidance
- `0a-setup-project` - Initialize new project
- `extract-specs-from-code` - Document existing code
- `align-specs-to-code` - Check synchronization
- `0d-prepare-stakeholder-review` - Prepare for reviews

### Requirements

- Claude Code CLI
- Markdown editor
- Git (recommended)

### Contributors

- Framework design and implementation
- Documentation and examples
- Testing and validation

---

**LiveSpec v0.2.0 (Beta)** - Specifications that live with your code.