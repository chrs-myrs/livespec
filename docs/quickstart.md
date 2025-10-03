# LiveSpec Quickstart

Get started with LiveSpec in 5 minutes.

## What is LiveSpec?

LiveSpec is a folder structure and methodology for keeping specifications and code synchronized. It works with any AI coding agent (Claude, Copilot, Cursor, etc.).

**Three core components:**
1. **Folder structure** - Organizes specs and prompts
2. **MSL format** - Minimal specification language
3. **Five phases** - DEFINE → DESIGN → BUILD → VERIFY → EVOLVE

## Installation

### Option 1: Clone and Copy

```bash
# Clone LiveSpec
git clone https://github.com/chrs-myrs/livespec.git

# Copy prompts to .livespec/ folder
cp -r livespec/prompts your-project/.livespec

# Create specs structure
mkdir -p your-project/specs/workspace your-project/specs/behaviors your-project/specs/contracts
```

### Option 2: Manual Setup

```bash
cd your-project

# Copy LiveSpec methodology
git clone https://github.com/chrs-myrs/livespec.git /tmp/livespec
cp -r /tmp/livespec/prompts .livespec

# Create specs structure
mkdir -p specs/workspace specs/behaviors specs/contracts
```

## Quick Start: New Project

### Step 1: Setup Workspace (5 min)

Use your AI agent with the first prompt:

```bash
# With Claude Code
claude-code "Use .livespec/0-define/0a-setup-workspace.md"

# With Cursor
# Open .livespec/0-define/0a-setup-workspace.md and use Composer

# With Copilot
# Open .livespec/0-define/0a-setup-workspace.md as context
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

This creates `specs/constraints.spec.md` - Hard boundaries for your project.

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
# Copy LiveSpec methodology
cp -r livespec/prompts .livespec

# Create specs folders
mkdir -p specs/workspace specs/behaviors specs/contracts
```

### Step 2: Extract Specifications

Start with Phase 4 (EVOLVE) to extract specs from existing code:

```bash
claude-code "Use .livespec/4-evolve/4b-extract-specs.md to document this existing codebase"
```

### Step 3: Backfill Workspace

Create workspace specs for how you actually work:

```bash
claude-code "Use .livespec/0-define/0a-setup-workspace.md based on existing patterns in this codebase"
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
│   ├── workspace/          # How you build
│   │   ├── constitution.spec.md
│   │   ├── patterns.spec.md
│   │   └── workflows.spec.md
│   ├── behaviors/          # What system does
│   ├── contracts/          # API/data contracts
│   └── constraints.spec.md # Hard boundaries
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

All specs follow Minimal Specification Language (MSL):

```markdown
# User Authentication

**Criticality**: CRITICAL
**Failure Mode**: System unsecured without authentication

## Specification

System authenticates users via email and password before allowing access to protected resources.

## Validation

- Valid credentials allow login
- Invalid credentials are rejected
- Session persists after authentication
- Protected resources require authentication
```

**That's it.** Four sections. Minimal. Testable.

## Using with Different AI Agents

### Claude Code

```bash
claude-code "Use .livespec/0-define/0a-setup-workspace.md"
```

### Cursor

1. Open the prompt file (`.livespec/0-define/0a-setup-workspace.md`)
2. Select content
3. Use Composer (Cmd+K)
4. "Follow these instructions"

### GitHub Copilot

1. Open the prompt file as context
2. In your code file, write: `// Following .livespec/0-define/0a-setup-workspace.md`
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
