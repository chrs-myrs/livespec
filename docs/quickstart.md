# LiveSpec Quickstart

Get started with LiveSpec in 5 minutes.

## What is LiveSpec?

LiveSpec is a folder structure and methodology for keeping specifications and code synchronized. It works with any AI coding agent (Claude, Copilot, Cursor, etc.).

**Three core components:**
1. **Folder structure** - Organizes specs and prompts
2. **MSL format** - Minimal specification language
3. **Five phases** - DEFINE → DESIGN → BUILD → VERIFY → EVOLVE

## Installation

### Option 1: Claude Code Plugin (Recommended)

```bash
cd your-project
claude /install-plugin https://github.com/chrs-myrs/livespec
```

The plugin provides skills (`/livespec:go`, `/livespec:design`, `/livespec:evolve`) and agent context automatically.

### Option 2: Manual Setup

```bash
cd your-project

# Create specs structure
mkdir -p specs/{workspace,foundation,strategy,features,interfaces,artifacts}
mkdir -p registries
```

## Quick Start: New Project

### Step 1: Setup Workspace (5 min)

Use your AI agent with the first prompt:

```bash
# With Claude Code
claude-code "Use .livespec/0-define/0a-quick-start.md"

# With Cursor
# Open .livespec/0-define/0a-quick-start.md and use Composer

# With Copilot
# Open .livespec/0-define/0a-quick-start.md as context
```

This creates:
- `specs/workspace/constitution.spec.md` - Your development principles
- `specs/workspace/patterns.spec.md` - Code and spec patterns
- `specs/workspace/workflows.spec.md` - Development workflows

### Step 2: Define Problem (3 min)

```bash
claude-code "Use .livespec/0-define/0b-define-problem.md"
```

This creates `PURPOSE.md` - Clear purpose statement at root level.

### Step 3: Identify Constraints (3 min)

```bash
claude-code "Use .livespec/0-define/0c-identify-constraints.md"
```

This creates `specs/foundation/constraints.spec.md` - Hard boundaries for your project.

**✅ Phase 0 (DEFINE) complete! You now have:**
- Workspace setup
- Problem defined
- Constraints documented

### Step 4: Continue Through Phases

Follow the prompts in order:

```bash
# Phase 1: DESIGN
claude-code "Use .livespec/1-design/1a-design-architecture.md"
claude-code "Use .livespec/1-design/1b-define-behaviors.md"
claude-code "Use .livespec/1-design/1c-create-contracts.md"

# Phase 2: BUILD
claude-code "Use .livespec/2-build/2a-implement-from-specs.md"
claude-code "Use .livespec/2-build/2b-create-tests.md"

# Phase 3: VERIFY
claude-code "Use .livespec/3-verify/3a-run-validation.md"
claude-code "Use .livespec/3-verify/3b-acceptance-review.md"

# Phase 4: EVOLVE (continuous)
claude-code "Use .livespec/4-evolve/4a-detect-drift.md"
```

## Quick Start: Existing Project

### Step 1: Setup Structure

```bash
# Install plugin
claude /install-plugin https://github.com/chrs-myrs/livespec

# Create specs folders
mkdir -p specs/{workspace,foundation,strategy,features,interfaces,artifacts}
```

### Step 2: Extract Specifications

Start with Phase 4 (EVOLVE) to extract specs from existing code:

```bash
claude-code "Use .livespec/4-evolve/4b-extract-specs.md to document this existing codebase"
```

### Step 3: Backfill Workspace

Create workspace specs for how you actually work:

```bash
claude-code "Use .livespec/0-define/0a-quick-start.md based on existing patterns in this codebase"
```

### Step 4: Maintain Synchronisation

Use Phase 4 prompts to keep specs synchronized:

```bash
# Weekly drift check
claude-code "Use .livespec/4-evolve/4a-detect-drift.md"
```

## File Structure

After setup, your project looks like:

```
your-project/
├── PURPOSE.md              # Why this project exists
│
├── specs/
│   ├── foundation/         # High-level goals and constraints
│   │   ├── outcomes.spec.md     # What we must achieve
│   │   └── constraints.spec.md  # Hard boundaries
│   ├── workspace/          # How you build
│   │   ├── constitution.spec.md
│   │   ├── patterns.spec.md
│   │   └── workflows.spec.md
│   ├── strategy/           # Technical approach
│   ├── features/           # What system does
│   └── interfaces/         # API/data contracts
│
├── .livespec/              # LiveSpec methodology
│   ├── 0-define/
│   ├── 1-design/
│   ├── 2-build/
│   ├── 3-verify/
│   ├── 4-evolve/
│   └── templates/
│
└── [your code]             # Your implementation
```

## MSL Format Example

All specs follow [Markdown Specification Language (MSL)](https://github.com/chrs-myrs/msl-specification):

```markdown
---
criticality: CRITICAL
failure_mode: System unsecured without authentication
---

# User Authentication

## Requirements
- [!] System authenticates users via email and password before allowing access to protected resources.
  - Valid credentials allow login
  - Invalid credentials are rejected
  - Session persists after authentication
  - Protected resources require authentication
```

**That's it.** Title, frontmatter, Requirements. Minimal. Testable.

## Using with Different AI Agents

### Claude Code

```bash
claude-code "Use .livespec/0-define/0a-quick-start.md"
```

### Cursor

1. Open the prompt file (`.livespec/0-define/0a-quick-start.md`)
2. Select content
3. Use Composer (Cmd+K)
4. "Follow these instructions"

### GitHub Copilot

1. Open the prompt file as context
2. In your code file, write: `// Following .livespec/0-define/0a-quick-start.md`
3. Let Copilot complete

### Any Agent

All prompts are plain markdown. Copy/paste them into your AI agent's input.

## Next Steps

- Read [MSL Guide](msl-guide.md) - Learn minimal specification format
- Read [Methodology](methodology.md) - Understand the philosophy
- See [Examples](examples/) - Real LiveSpec projects

## Getting Help

- Issues: [GitHub Issues](https://github.com/chrs-myrs/livespec/issues)
- Discussions: [GitHub Discussions](https://github.com/chrs-myrs/livespec/discussions)

---

**You're ready to go! Start with Phase 0 and let your AI agent guide you through the rest.**
