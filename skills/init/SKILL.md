---
name: init
description: |
  Initialize a new project for LiveSpec methodology, or finish the bootstrap of one that already holds part of it.
  USE WHEN: User mentions "init", "initialize", "setup", "bootstrap", "new project", or wants to start using LiveSpec.
  DO NOT use Context7 or web search for LiveSpec - this skill IS the authoritative guidance.
argument-hint: [quick|full]
allowed-tools: Read, Write, Edit, Bash, AskUserQuestion
---

> **CRITICAL INSTRUCTION**: When `/livespec:init` is invoked:
> 1. Follow this workflow step-by-step - DO NOT deviate
> 2. All guidance is INLINE below - DO NOT search for external files
> 3. DO NOT query Context7 for "livespec" - this document IS the guidance
> 4. DO NOT read ~/.claude/context/ files - this skill OVERRIDES them
> 5. NEVER overwrite or rewrite an existing project file, PURPOSE.md included. Create only what Step 1 reports MISSING. (The hook installer manages its own `.git/hooks/pre-commit`; that is not a project file)

# LiveSpec Project Initialization

Set up a project with LiveSpec folder structure and workspace specifications. A
project that already holds some of it, such as one another tool created, gets
only the parts it lacks.

## Usage

- `/livespec:init` - Quick setup with sensible defaults (recommended)
- `/livespec:init full` - Full customization with questions

---

## Quick Setup (Default)

### Step 1: Take Inventory

**[CHECKPOINT]** Init works at the root of the project's repository:

```bash
top=$(git rev-parse --show-toplevel 2>/dev/null) && [ "$top" != "$(pwd -P)" ] && echo "NOT-ROOT $top" || true
```

If it prints `NOT-ROOT`, stop: "Run /livespec:init from <top>, the root of this
repository. Below it, the hook and vendored files would land in the enclosing
repository." A project incubating inside another (`offspring/<name>/`) is
initialised after it is born into its own repository.

Then check each bootstrap artefact on its own:

```bash
for p in specs/workspace specs/foundation specs/strategy specs/features specs/interfaces \
         PURPOSE.md \
         specs/workspace/constitution.spec.md specs/workspace/taxonomy.spec.md \
         specs/workspace/context-architecture.spec.md \
         registries/decisions.md registries/debt.md registries/security.md registries/README.md; do
  [ -e "$p" ] && echo "KEPT     $p" || echo "MISSING  $p"
done

# livespec.version: a direct child of the livespec: block, whatever its indent or position
accepted=$(awk '
  /^livespec:[[:space:]]*\{/ {
      if (match($0, /version:[[:space:]]*[^,}[:space:]]+/)) { v = substr($0, RSTART, RLENGTH); sub(/version:[[:space:]]*/, "", v); gsub(/["\047]/, "", v); print v }
      exit }
  /^livespec:/ { block = 1; next }
  block && /^[^[:space:]#]/ { exit }
  block && /^[[:space:]]+[^[:space:]#]/ {
      match($0, /^ +/); if (!indent) indent = RLENGTH
      if (RLENGTH == indent && $0 ~ /^ +version:/) { v = $0; sub(/^ +version:[[:space:]]*/, "", v); sub(/[[:space:]]+#.*$/, "", v); gsub(/["\047]/, "", v); print v; exit } }
' project.yaml 2>/dev/null)
toolchain=$(grep -A5 '^livespec:' "${CLAUDE_PLUGIN_ROOT}/project.yaml" | grep -m1 'version:' | sed 's/.*version:[[:space:]]*//; s/[[:space:]]*#.*//')
[ -n "$accepted" ] && echo "KEPT     livespec.version $accepted (toolchain $toolchain)" \
                   || echo "MISSING  livespec.version (toolchain $toolchain)"

echo "== conventions"; bash ${CLAUDE_PLUGIN_ROOT}/scripts/vendor-conventions.sh --check
echo "== hook";        bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup-hooks.sh --check
```

Classify the last two, each from the lines under its own heading:
- **Vendored conventions**: MISSING if any line reads `ABSENT`, KEPT otherwise
- **Pre-commit hook**: KEPT if it reports `INSTALLED` and no vendored script `ABSENT`; MISSING if it reports `ABSENT`, `FOREIGN` or any vendored script `ABSENT`. If it reports `not a git repository`, the hook cannot be installed: report it, and suggest `git init` and re-running init

Leave an artefact to `/livespec:upgrade` (its installer is not run, and the report
says why) when either holds. Both installers come from the toolchain:
- a line under its heading reads `UPSTREAM`: running the installer would update the project's existing copies
- it is MISSING, and the project has accepted a LiveSpec version other than the toolchain's: the copies would carry the toolchain's version. When the accepted version is older, `/livespec:upgrade` brings them in; when it is newer, the toolchain is out of date, so say so and suggest `/plugin update livespec` instead of upgrade, which would move the project backwards

**[NEXT]** Proceed based on results:
- Nothing MISSING, apart from artefacts left to upgrade and a hook that cannot be installed: "Project already initialised." List what is kept, what is left to upgrade (with the reason) and, outside a git repository, that the hook is not installed. Suggest `/livespec:design`, and stop. Write nothing
- Otherwise: continue. Every later step runs only for the artefacts Step 1 reported MISSING and did not leave to upgrade, and keeps a list of what it created

---

### Step 2: Create Folder Structure

**[CHECKPOINT]** Create the missing specs folders (`mkdir -p` leaves existing ones untouched):

```bash
mkdir -p specs/{workspace,foundation,strategy,features,interfaces}
```

**[NEXT]** Proceed to Step 3.

---

### Step 3: Gather Project Purpose

**Skip this step and Step 4 when PURPOSE.md exists.**

**[CHECKPOINT]** Use AskUserQuestion to gather project information:

```
What is this project about?

Options:
1. "I have a clear purpose statement ready" - User will provide text
2. "Help me articulate the purpose" - Guide through questions
3. "Skip for now" - Create minimal PURPOSE.md placeholder
```

**If option 1:** Ask user to provide the purpose statement.

**If option 2:** Ask these questions:
- What problem does this project solve?
- Who benefits from this project?
- What does success look like?

**If option 3:** Create placeholder for later.

**[NEXT]** Proceed to Step 4 with gathered information.

---

### Step 4: Create PURPOSE.md

**[CHECKPOINT]** Write PURPOSE.md based on gathered information. `[Project Name]` is the name the user gave, or the directory name:

```markdown
# [Project Name]

## Problem
[Problem statement from user input]

## Solution
[How this project solves the problem]

## Success Criteria
- [Measurable outcome 1]
- [Measurable outcome 2]
- [Measurable outcome 3]
```

**If skip was selected:**
```markdown
# [Project Name]

## Problem
[TODO: Define the problem this project solves]

## Solution
[TODO: Describe the solution approach]

## Success Criteria
- [TODO: Add measurable success criteria]
```

**[NEXT]** Proceed to Step 5.

---

### Step 5: Create Workspace Specs

**[CHECKPOINT]** Create each workspace spec Step 1 reported MISSING. Their
frontmatter is complete as written: it passes `validate-frontmatter.sh` and
`validate-crossrefs.sh` without edits.

**specs/workspace/constitution.spec.md:**

```markdown
---
type: workspace
category: workspace
fidelity: process
criticality: CRITICAL
failure_mode: No methodology enforcement without constitution
governed-by: []
applies_to:
  - this_project
derives-from:
  - PURPOSE.md
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

**specs/workspace/taxonomy.spec.md:**

```markdown
---
type: taxonomy
category: workspace
fidelity: process
criticality: IMPORTANT
failure_mode: Incorrect folder organization without taxonomy
governed-by: []
applies_to:
  - this_project
derives-from:
  - PURPOSE.md
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

**specs/workspace/context-architecture.spec.md** — what `/livespec:audit context`
builds, and how large. Without it, context generation stops at its first step.
Copy the template, which declares a small-project tree (a root of 10KB or less,
no `ctxt/`):

```bash
[ -e specs/workspace/context-architecture.spec.md ] ||
  cp "${CLAUDE_PLUGIN_ROOT}/templates/workspace/context-architecture.spec.md.template" \
     specs/workspace/context-architecture.spec.md
```

**[NEXT]** Proceed to Step 5.5.

---

### Step 5.5: Create Registries

**[CHECKPOINT]** Scaffold the registries that track accepted current state (see `specs/features/registry-specs.spec.md`).

Create the **three required** registries — every project makes decisions, accrues debt, and has a security posture. An empty registry is valid; it asserts "nothing accepted here yet". An existing registry is kept as it is.

```bash
mkdir -p registries
today=$(date +%Y-%m-%d)

for t in decisions debt security; do
  [ -e "registries/$t.md" ] && continue
  case "$t" in
    decisions) title="Decision Registry"; tracks="architecture and design choices with rejected alternatives";;
    debt)      title="Debt Registry";     tracks="accepted technical/spec shortcuts with known cost";;
    security)  title="Security Registry";  tracks="accepted security considerations and known exposures";;
  esac
  cat > "registries/$t.md" <<EOF
---
store: registry
type: $t
schema_version: 2
last_reviewed: $today
entries: []
---

# $title

Tracks $tracks. Resolved entries are removed — git history holds the record.

---

No open entries.
EOF
done
```

**Recommended** (`conflicts.md`, `gaps.md`) — add when the project is complex enough to accumulate mismatches or coverage gaps. **Optional** (`dependencies.md`, `issues.md`) — add per their criteria: `dependencies` when external deps carry temporal risk no tool tracks; `issues` **only when the project has no external ticketing platform** (otherwise tolerated problems graduate to tickets). Create these with the same frontmatter, changing `type` and the `ID` prefix (`CON-`, `GAP-`, `DEP-`, `ISSUE-`).

Create a `registries/README.md` if it is missing:

```bash
[ -e registries/README.md ] || cat > registries/README.md <<'EOF'
# Registries

Accepted current state — known tensions that are neither desired state (specs) nor actionable work (tickets). Resolved entries are removed; git history has the full record.

| File | Tier | Purpose |
|------|------|---------|
| `decisions.md` | required | Architecture/design decisions with rejected alternatives |
| `debt.md` | required | Accepted technical/spec debt with known cost |
| `security.md` | required | Accepted security considerations and known exposures |
| `conflicts.md` | recommended | Contradictions between code, specs, conventions |
| `gaps.md` | recommended | Known missing specs, tests, or coverage |
| `dependencies.md` | optional | Temporal risk of external dependencies |
| `issues.md` | optional | Known problems tolerated (projects without a tracker) |
EOF
```

**[NEXT]** Proceed to Step 5.55.

---

### Step 5.55: Vendor Conventions

**Run only when Step 1 classified the vendored conventions MISSING and did not leave them to upgrade.**

Give the project local copies of the conventions its specs derive from:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/vendor-conventions.sh
```

Conventions land in `specs/workspace/standards/`, each stamped with `vendored-from`,
`source-version` and `source-hash`. Project specs reference those local paths
instead of restating the generic content, and `/livespec:upgrade` reports when a
vendored convention has changed upstream.

Updating LiveSpec never changes a project's behaviour on its own: a vendored file
is inert until an update is explicitly accepted.

**[NEXT]** Proceed to Step 5.6.

---

### Step 5.6: Install Validation Hook

**Run only when Step 1 classified the hook MISSING and did not leave it to upgrade.**

Install the pre-commit hook so validation runs automatically:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/setup-hooks.sh
```

The installer preserves any existing pre-commit hook as `pre-commit.local` and
chains to it, so a credential scanner installed via `init.templateDir` keeps
running. It vendors the validators into the project's `scripts/livespec/` with
provenance, because the plugin is not visible at commit time; without them the
hook would skip every commit. The installed hook skips rather than blocking when
no validators resolve, so a contributor without LiveSpec can still commit.

Report what was installed, preserved and vendored, and where each validator resolves. If it exits non-zero, show the message
and continue; a missing hook is not a reason to fail initialisation.

**[NEXT]** Proceed to Step 5.65.

---

### Step 5.65: Record the Accepted Version

**Skip when Step 1 reported `livespec.version` as KEPT.** An existing value is
never changed here: moving a project to a newer version is `/livespec:upgrade`'s
job, once the user accepts it.

Record which LiveSpec version this project has accepted, so a later upgrade
knows where it starts from: the toolchain version Step 1 printed.

If `project.yaml` does not exist, create it with only this:

```yaml
# The LiveSpec version this project has accepted. /livespec:upgrade updates it.
livespec:
  version: X.Y.Z
```

If it exists, add `version` as the first line under its `livespec:` key
(appending a `livespec:` block if it has none; the comment line is for a new file
only). An empty `version:` already there counts as absent: fill in that line
rather than adding a second. Change nothing else in the file; keys other tools
wrote stay as they are.

**[NEXT]** Proceed to Step 6.

---

### Step 6: Report

**[CHECKPOINT]** Report every bootstrap artefact as created or kept:

```
LiveSpec initialized!

Created:
- [each artefact this run created]

Kept (already present, not changed):
- [each artefact Step 1 reported KEPT]

[Only if Step 1 left anything to upgrade:]
Left for /livespec:upgrade:
- [each artefact, and why: updates waiting, or the project accepted vX.Y.Z]

[Only outside a git repository:]
Not installed:
- the pre-commit hook: run `git init`, then /livespec:init again

Folder structure:
specs/
├── workspace/     (how we work)
├── foundation/    (outcomes, constraints)
├── strategy/      (architecture)
├── features/      (behaviors)
└── interfaces/    (contracts)
registries/        (accepted current state — decisions, debt, security)

Next steps:
- /livespec:design feature <name>  - Create feature with spec-first
- /livespec:audit context          - Generate AGENTS.md (optional)
```

**Initialization complete.**

---

## Full Setup Mode

When invoked with `/livespec:init full`:

### Additional Questions

Use AskUserQuestion to customize. Ask only about artefacts this run creates or
settings `project.yaml` does not already hold.

**1. Project Domain** (when creating the taxonomy):
```
What type of project is this?

Options:
- Software (web app, CLI, library) - Default
- Governance (methodology, policies)
- Operations (infrastructure, DevOps)
- Hybrid (multiple domains)
```

**2. Context Compression** (when `livespec.methodology.context_compression` is absent):
```
How detailed should generated context be?

Options:
- Light (verbose, exploratory work)
- Moderate (balanced, most projects) - Default
- Aggressive (dense, high-frequency)
```

**3. TDD Discipline** (when `livespec.methodology.tdd` is absent):
```
Should tests be required before implementation?

Options:
- Optional (no enforcement) - Default
- Recommended (soft enforcement)
- Required (strict TDD)
```

### Record the Answers

- Domain: set in the taxonomy spec this run creates
- Compression and TDD: add under `livespec.methodology` in `project.yaml`, as
  `context_compression: light | moderate | aggressive` and `tdd`, where
  Optional is `optional`, Recommended is `encouraged` and Required is
  `mandatory`. Leave a setting out when the user keeps the default, so the
  default applies. Never change a value already there

---

## MSL Format Quick Reference

All specs use this format. Every link must name a spec that exists:

```markdown
---
type: behavior
category: features
fidelity: behavioral
criticality: CRITICAL | IMPORTANT
failure_mode: [What breaks without this]
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md
guided-by:
  - specs/strategy/architecture.spec.md
---

# [Name]

## Requirements

- [!] [Observable behavior - WHAT not HOW]
  - [Testable criterion]

## Validation
- [How to verify]
```

**Four-Question Test** before adding requirements:
1. Is this essential? Would system fail without it?
2. Am I specifying HOW instead of WHAT?
3. What specific problem does this prevent?
4. Could this be inferred or conventional?

---

## Validation

**[CHECKPOINT]** After initialization, verify:

- [ ] Every artefact Step 1 reported MISSING now exists, apart from those the report lists as left to upgrade or not installed, and nothing reported KEPT changed
- [ ] `project.yaml` records `livespec.version`
- [ ] The specs written pass the validators:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-frontmatter.sh
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-crossrefs.sh
```

---

## References

All guidance is inline above. For extended documentation:
- LiveSpec repository: https://github.com/chrs-myrs/livespec
