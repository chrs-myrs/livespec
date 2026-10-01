---
type: strategy
category: strategy
fidelity: decisions-only
criticality: CRITICAL
failure_mode: Without validation strategy, LiveSpec cannot verify it follows own rules, undermining dogfooding and risking spec-implementation drift
governed-by:
  - specs/foundation/constraints.spec.md (Testable Behaviors, No Framework Lock-in, Manual Adoption)
derives-from:
  - specs/foundation/outcomes.spec.md (Minimal Maintenance, Voluntary Adoption)
  - specs/workspace/constitution.spec.md (Dogfooding principle)
---

# Validation Strategy

## Requirements
- [!] LiveSpec validates adherence to own methodology through bash-based test suite that checks observable behaviors (folder structure, MSL format, traceability, prompt alignment) without testing implementation details, enabling continuous verification that repository follows defined conventions and maintaining dogfooding integrity.
  - Validators live in `scripts/` as executable bash scripts (`.sh`)
  - Each validator has an artifact spec under `specs/artifacts/validators/`
  - Validators check observable behaviours only (file existence, format, naming, structure, resolvability)
  - Validators do NOT check implementation details (code quality, content accuracy, user workflows)
  - Validation passes when LiveSpec follows its own rules (dogfooding validated)
  - Validation failure indicates drift between specs and practice
  - Exit codes: 0 success, 1 violations, 2 usage error
  - `--json` gives machine-readable findings in the shared envelope of `specs/interfaces/formats/validator-output.spec.md`, so a consumer can gate CI without parsing text
  - No test framework dependencies (bash, grep, sed, awk only)
  - `scripts/setup-hooks.sh` installs them as a pre-commit hook so they run without being remembered

## Testing Philosophy

**What we test:**
- **Observable behaviors**: Can this be verified by examining files?
- **Conventions compliance**: Does structure match folder-structure.spec.md?
- **Format compliance**: Do specs follow MSL format?
- **Traceability**: Are dependency chains complete?
- **Naming**: Do files follow naming conventions?
- **Alignment**: Do prompts reference their defining specs?

**What we DON'T test:**
- **Implementation quality**: How well specs are written
- **Content accuracy**: Whether specs describe system correctly
- **User workflows**: Whether methodology helps users
- **Code generation**: Whether AI agents generate good code
- **Subjective quality**: Clarity, usefulness, comprehensiveness

**Rationale:**
- Observable behaviors are automatable
- Implementation quality requires human judgment
- Tests prove structure, humans prove value
- Fast feedback loop (seconds, not minutes)
- No false positives (behavior present or not)

## Why Bash Scripts Not Frameworks

**Decision: Bash scripts with standard Unix tools**

**Alternatives considered:**
- Python unittest framework
- Jest/Mocha test framework
- Custom test runner
- GitHub Actions only

**Why bash chosen:**
- **Simplicity constraint**: No dependencies beyond bash/grep/sed
- **Manual adoption**: Users can run without installing frameworks
- **Universal**: Works on any Unix-like system
- **Readable**: Non-programmers can understand tests
- **Fast**: No framework startup time
- **Portable**: Same scripts work locally and in CI/CD
- **Dogfooding**: Follows "no custom tooling" constraint

**Trade-offs accepted:**
- Less sophisticated assertions (basic string matching)
- No mocking/stubbing capabilities
- Manual validator discovery (the hook runs whichever it can resolve)
- Basic reporting (pass/fail counts)

**Benefits realized:**
- Zero installation friction
- Tests run anywhere bash exists
- Easy to add new tests (just add .sh file)
- Users can run same tests on their projects
- Transparent (can read test source easily)

## Validators

Each has an artifact spec under `specs/artifacts/validators/`.

| Validator | Checks | Failure means |
|-----------|--------|---------------|
| `validate-frontmatter.sh` | Base six fields, type/category/fidelity values, per-category mandatory fields, relationship graph population | A spec cannot be placed or related correctly |
| `validate-crossrefs.sh` | Every relationship target resolves from the repository root; upward links reach PURPOSE.md through specs at the same or a higher layer | A spec points at something that does not exist, or traces to nothing |
| `validate-constraints.sh` | Every `/livespec:` command, invoked script and `routes-to:` target resolves; project context is usable without the toolchain | LiveSpec asserts something about itself that is untrue |
| `validate-registries.sh` | Required registries present, entries well-formed, no work-item summaries, staleness flagged | Accepted current state is unrecorded or misrecorded |
| `validate-purpose.sh` | PURPOSE.md within the content-line boundary, required sections, misplaced content routed | Vision has absorbed content belonging in specs |

Two further scripts support the spec-first protocol rather than validating specs:
`check-requires-spec.sh` answers whether a path requires a specification, and
`setup-hooks.sh` installs the validators as a chaining pre-commit hook.

## Continuous Validation Approach

**When tests run:**
- **Pre-commit**: Developer runs manually before committing
- **CI/CD**: GitHub Actions runs on every push
- **Pre-release**: Full test suite before version increment
- **Manual**: Developer unsure if change broke conventions

**Automation:**

Validation is delivered by the validator scripts, installed as a pre-commit hook
by `scripts/setup-hooks.sh`:

```bash
bash scripts/validate-frontmatter.sh    # frontmatter schema and relationship graph
bash scripts/validate-crossrefs.sh      # relationship targets resolve and trace to PURPOSE.md
bash scripts/validate-constraints.sh    # commands, scripts and routes LiveSpec claims exist
bash scripts/validate-registries.sh     # registry integrity
bash scripts/validate-purpose.sh        # PURPOSE.md boundary
```

**Feedback loop:**
1. Developer makes change (add spec, modify skill)
2. Pre-commit hook runs the validators it can resolve
3. Validation fails → fix issue → commit again
4. Validation passes → commit proceeds

**Not yet delivered:** there is no `tests/` suite and no CI workflow in this
repository. Enforcement is local to each clone via the installed hook, so a
contributor who has not run `setup-hooks.sh` is unvalidated until review. Closing
that gap needs a CI step, which is not yet designed.

**Benefits:**
- Catches drift immediately (before it spreads)
- Prevents accumulating technical debt
- Validates dogfooding continuously
- Builds confidence in changes

## Connection to Drift Detection

**Drift detection is the EVOLVE workflow applied to LiveSpec itself:**

**Manual drift detection:**
- Developer notices spec doesn't match deliverable
- Uses `/livespec:audit health` to analyze gap
- Uses `/livespec:audit extract` to document new reality
- Confirms alignment restored via re-running the audit

**Automated drift detection:**
- Tests run continuously
- Test failures indicate drift
- Developer investigates failed test
- Determines root cause (spec outdated? deliverable wrong?)
- Syncs spec and deliverable
- Tests pass again

**Examples:**

**Drift type 1: Unspec'd deliverable**
```
# Test detects
skill added: skills/upgrade/SKILL.md + commands/upgrade.md
Not listed in: specs/artifacts/commands/generation.spec.md's Command Mapping table

# Resolution
Add the mapping row to specs/artifacts/commands/generation.spec.md
Verify the command routes correctly to the skill
Tests pass
```

**Drift type 2: Spec changed, deliverable stale**
```
# Test detects
specs/features/folder-structure.spec.md says "4 standard folders"
But references/standards/conventions/folder-structure.spec.md says "3 standard folders"

# Resolution
Update references/standards/conventions/folder-structure.spec.md
Sync with specs/features/folder-structure.spec.md
Tests pass
```

**Connection to dogfooding.spec.md:**
- Dogfooding explains WHY we validate ourselves
- Validation explains HOW we validate ourselves
- Both prove LiveSpec methodology works in practice

## What We DON'T Test (And Why)

**1. Content quality**
- **Why not**: Subjective, requires human judgment
- **How validated**: Manual review, user feedback

**2. Spec accuracy**
- **Why not**: Requires understanding implementation intent
- **How validated**: Dogfooding (we use it, catch problems)

**3. User experience**
- **Why not**: Context-dependent, varies by project
- **How validated**: User testing, voluntary adoption metrics

**4. AI agent effectiveness**
- **Why not**: Non-deterministic, agent-dependent
- **How validated**: Manual testing with Claude Code

**5. Methodology value**
- **Why not**: Outcome-based, long-term
- **How validated**: Real-world adoption, user testimonials

**Philosophy:**
- Tests prove STRUCTURE compliance
- Humans prove VALUE delivery
- Automation catches mistakes
- Judgment ensures quality

## Validation

- Five validators exist in `scripts/`, each executable bash
- Each validator has an artifact spec declaring `specifies` for it
- Validators check structure, format, traceability, naming, and resolvability
- Validators do NOT check content quality, UX, or outcomes
- All five pass on the current LiveSpec repository
- Validators use only bash, grep, sed and awk (no frameworks)
- Validators are runnable locally; CI is absent and recorded as GAP-002
- Validation failure indicates drift between specs and practice
- Connection to dogfooding clear (validators check we follow our own rules)
