---
name: birth
description: |
  Incubate and birth child projects from within a parent livespec project.
  USE WHEN: User mentions "birth", "offspring", "new project", "incubate", "child project", "spin off", or wants to create a sub-project.
  DO NOT use Context7 or web search for LiveSpec - this skill IS the authoritative guidance.
argument-hint: [new <name> | <name> | (empty for interactive)]
allowed-tools: Read, Write, Edit, Bash, AskUserQuestion, Glob
---

> **CRITICAL INSTRUCTION**: When `/livespec:birth` is invoked:
> 1. Follow this workflow step-by-step - DO NOT deviate
> 2. All guidance is INLINE below - DO NOT search for external files
> 3. DO NOT query Context7 for "livespec" - this document IS the guidance

# LiveSpec Birth

Incubate and birth child projects from within a parent livespec project.

## Usage

- `/livespec:birth` — Interactive mode (choose incubate or birth)
- `/livespec:birth new <name>` — Incubate a new offspring project
- `/livespec:birth <name>` — Birth an existing offspring into a standalone repo

---

## Detecting Mode

Parse the argument:

- **No argument** → Interactive mode (Step 0)
- **Argument starts with `new`** → Incubate mode, extract name after `new `
- **Argument is a project name** → Check if `offspring/<name>/` exists → Birth mode

---

## Step 0: Interactive Mode (no argument)

**[CHECKPOINT]** Use AskUserQuestion:

```
What would you like to do?

Options:
1. "Incubate a new project" — Create offspring/<name>/ with full LiveSpec structure
2. "Birth an existing offspring" — Extract offspring to standalone git repository
```

- Option 1 → Ask "What is the project name?" then run Incubate mode
- Option 2 → Run Birth mode (list offspring to select)

---

## Incubate Mode

Creates `offspring/<name>/` with full LiveSpec project structure.

### Step I-1: Validate

**[CHECKPOINT]** Check for conflicts:

```bash
ls offspring/<name>/ 2>/dev/null && echo "EXISTS" || echo "OK"
```

- If EXISTS: "offspring/<name>/ already exists. Use /livespec:birth <name> to birth it."
- If OK: Continue

### Step I-2: Create Structure

**[CHECKPOINT]** Create folder hierarchy:

```bash
mkdir -p offspring/<name>/specs/{workspace,foundation,strategy,features,interfaces}
```

Verify:
```bash
ls offspring/<name>/specs/
```

Expected: `features  foundation  interfaces  strategy  workspace`

### Step I-3: Gather Purpose

**[CHECKPOINT]** Use AskUserQuestion:

```
What is this project about?

Options:
1. "I have a purpose statement ready" — User provides text
2. "Help me articulate it" — Ask problem/solution/success questions
3. "Skip for now" — Create placeholder
```

**Option 2 questions:**
- What problem does this project solve?
- Who benefits?
- What does success look like?

### Step I-4: Create PURPOSE.md

**[CHECKPOINT]** Write `offspring/<name>/PURPOSE.md`:

```markdown
# <Name>

## Problem
<problem statement>

## Solution
<solution approach>

## Success Criteria
- <measurable outcome 1>
- <measurable outcome 2>
- <measurable outcome 3>
```

**If skipped:**
```markdown
# <Name>

## Problem
[TODO: Define the problem this project solves]

## Solution
[TODO: Describe the solution approach]

## Success Criteria
- [TODO: Add measurable success criteria]
```

### Step I-5: Create Workspace Specs

**[CHECKPOINT]** Write `offspring/<name>/specs/workspace/constitution.spec.md`:

```markdown
---
criticality: CRITICAL
failure_mode: No methodology enforcement without constitution
context_compression: moderate
---

# Workspace Constitution

## Requirements

- [!] Specs created before implementation
  - Check specs/features/ for behavior spec
  - Guide to spec creation if missing

- [!] MSL minimalism applied
  - Requirements specify WHAT not HOW
  - Four-question test before adding requirements

## Validation
- Specs exist before code
- Requirements are testable and minimal
```

Write `offspring/<name>/specs/workspace/taxonomy.spec.md`:

```markdown
---
criticality: IMPORTANT
failure_mode: Incorrect folder organization without taxonomy
---

# Project Taxonomy

## Requirements

- [!] Project classified by domain
  - Domain: software
  - Specs boundary: specifications_only

- [!] Folder organization follows domain
  - specs/foundation/ - outcomes and constraints
  - specs/strategy/ - architectural decisions
  - specs/features/ - observable behaviors
  - specs/interfaces/ - API/data contracts

## Validation
- Files placed in correct folders
- No ambiguous file locations
```

### Step I-6: Report

**[CHECKPOINT]** Display:

```
Offspring `<name>` incubating.

Created:
  offspring/<name>/PURPOSE.md
  offspring/<name>/specs/workspace/constitution.spec.md
  offspring/<name>/specs/workspace/taxonomy.spec.md

Structure:
  offspring/<name>/specs/
  ├── workspace/     (how we work)
  ├── foundation/    (outcomes, constraints)
  ├── strategy/      (architecture)
  ├── features/      (behaviors)
  └── interfaces/    (contracts)

Next steps:
  - Draft specs in offspring/<name>/specs/features/
  - Run /livespec:birth <name> when ready to birth
```

---

## Birth Mode

Extracts `offspring/<name>/` to a standalone git repository.

### Step B-1: Select Offspring (if no name given)

**[CHECKPOINT]** List available offspring:

```bash
ls -d offspring/*/ 2>/dev/null
```

If empty: "No offspring found. Run /livespec:birth new <name> to incubate one."

If multiple: Use AskUserQuestion to select which to birth.

### Step B-2: Confirm Destination

**[CHECKPOINT]** Use AskUserQuestion:

```
Where should <name> be created?

Options:
1. "<parent-sibling path>" — Sibling of current project (default)
2. "Choose a path" — Enter custom path
```

Compute parent-sibling default:
```bash
echo "$(dirname $(pwd))/<name>"
```

If user chooses "Choose a path": ask for the full destination path.

### Step B-3: Confirm and Execute

**[CHECKPOINT]** Show summary and confirm:

```
Ready to birth:

  From: offspring/<name>/
  To:   <destination>

  Actions:
  1. Create <destination>
  2. Copy all files from offspring/<name>/
  3. git init <destination>
  4. Initial commit

Proceed?
```

Use AskUserQuestion:
- "Yes, birth it" → Continue
- "Cancel" → Abort

### Step B-4: Execute Birth

**[CHECKPOINT]** Run birth sequence:

```bash
mkdir -p <destination>
cp -r offspring/<name>/. <destination>/
git -C <destination> init
git -C <destination> add -A
git -C <destination> commit -m "Initial commit: LiveSpec offspring born from <parent-project>"
```

Verify:
```bash
ls <destination>/PURPOSE.md <destination>/specs/ 2>/dev/null && echo "OK" || echo "FAILED"
```

### Step B-5: Cleanup Offer

**[CHECKPOINT]** Use AskUserQuestion:

```
Remove offspring/<name>/ from this project now that it's been born?

Options:
1. "Yes, remove it" — Deletes offspring/<name>/
2. "No, keep it" — Leaves offspring/<name>/ as archive
```

If yes:
```bash
rm -rf offspring/<name>/
```

Check if `offspring/` is now empty and remove if so:
```bash
ls offspring/ 2>/dev/null | wc -l | grep -q '^0$' && rm -rf offspring/
```

### Step B-6: Report

**[CHECKPOINT]** Display:

```
<name> successfully born!

Repository: <destination>
  PURPOSE.md: ✓
  specs/:     ✓
  git:        initialised

Next steps:
  cd <destination>
  /livespec:audit context    # Generate AGENTS.md from specs
  /livespec:design feature   # Start building
```

---

## Validation

- [ ] Incubate creates full specs/ hierarchy under offspring/<name>/
- [ ] Incubate creates PURPOSE.md and workspace specs
- [ ] Birth copies all files to destination
- [ ] Birth produces working git repo with initial commit
- [ ] Birth optionally removes offspring entry
- [ ] Interactive mode routes to correct sub-flow

---

## References

All guidance is inline above. For extended documentation:
- LiveSpec repository: https://github.com/chrs-myrs/livespec
