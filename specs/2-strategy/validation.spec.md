---
derives-from:
  - specs/1-requirements/strategic/outcomes.spec.md (Minimal Maintenance, Voluntary Adoption)
  - specs/workspace/constitution.spec.md (Dogfooding principle)
governed-by:
  - specs/1-requirements/strategic/constraints.spec.md (Testable Behaviors, No Framework Lock-in, Manual Adoption)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without validation strategy, LiveSpec cannot verify it follows own rules, undermining dogfooding and risking spec-implementation drift
---

# Validation Strategy

## Requirements
- [!] LiveSpec validates adherence to own methodology through bash-based test suite that checks observable behaviors (folder structure, MSL format, traceability, prompt alignment) without testing implementation details, enabling continuous verification that repository follows defined conventions and maintaining dogfooding integrity.
  - Test suite in tests/ directory (prompts/, structure/ subdirectories)
  - All tests are executable bash scripts (.sh extension)
  - run-all-tests.sh orchestrates full validation
  - Tests check observable behaviors only (file existence, format, naming, structure)
  - Tests do NOT check implementation details (code quality, content accuracy, user workflows)
  - Test categories: structure compliance, MSL format, traceability, naming, alignment
  - Tests pass when LiveSpec follows its own rules (dogfooding validated)
  - Test failures indicate drift (specs vs practice misalignment)
  - Tests runnable in CI/CD (exit codes: 0 success, 1 failure)
  - No test framework dependencies (bash, grep, sed only)

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
- Manual test discovery (run-all-tests.sh lists scripts)
- Basic reporting (pass/fail counts)

**Benefits realized:**
- Zero installation friction
- Tests run anywhere bash exists
- Easy to add new tests (just add .sh file)
- Users can run same tests on their projects
- Transparent (can read test source easily)

## Test Categories

### 1. Structure Compliance Tests (tests/prompts/test_folder_structure.sh)

**Validates:**
- specs/workspace/ contains development methodology
- specs/3-behaviors/ contains observable behaviors
- specs/2-strategy/ contains technical decisions
- PURPOSE.md exists at root
- dist/ contains deliverables
- .livespec/ symlink points to dist/

**Spec:** specs/3-behaviors/folder-structure.spec.md (via dist/standard/conventions/)

**Example checks:**
```bash
# Validation: workspace/ contains required specs
[ -f "specs/workspace/constitution.spec.md" ]
[ -f "specs/workspace/patterns.spec.md" ]
[ -f "specs/workspace/workflows.spec.md" ]

# Validation: .livespec/ is symlink to dist/
[ -L ".livespec" ] && [ "$(readlink .livespec)" = "dist" ]
```

### 2. MSL Format Compliance (tests/prompts/test_msl_format.sh)

**Validates:**
- All .spec.md files have YAML frontmatter
- Frontmatter contains criticality field (CRITICAL or IMPORTANT)
- Frontmatter contains failure_mode field
- File has ## Requirements section
- Requirements use [!] marker for critical items
- Title exists (# Heading)

**Spec:** dist/standard/metaspecs/base.spec.md

**Example checks:**
```bash
# Check frontmatter exists
head -1 "$spec_file" | grep -q "^---$"

# Check criticality field
grep -q "^criticality: \(CRITICAL\|IMPORTANT\)$" frontmatter

# Check ## Requirements section exists
grep -q "^## Requirements$" "$spec_file"
```

### 3. Traceability Tests (tests/structure/test_traceability.sh)

**Validates:**
- Specs have frontmatter dependency fields (derives_from, constrained_by, satisfies, supports, applies_to)
- Dependency chains are complete (referenced specs exist)
- No circular dependencies (A → B → A)
- Every spec traceable back to requirements or metaspecs

**Spec:** specs/workspace/patterns.spec.md (dependency conventions)

**Example checks:**
```bash
# Check for dependency frontmatter
echo "$FRONTMATTER" | grep -qE "derives_from:|constrained_by:|satisfies:"

# Validate referenced files exist
for ref in $REFERENCES; do
  [ -f "$ref" ] || echo "FAIL - Missing $ref"
done
```

### 4. Naming Convention Tests (tests/prompts/test_spec_naming.sh)

**Validates:**
- Behavior specs use .spec.md extension
- Prompts use phase-letter pattern (0a-, 1b-, etc.)
- Workspace specs follow kebab-case naming
- No spaces in filenames
- Lowercase preferred

**Spec:** dist/standard/conventions/naming.spec.md

**Example checks:**
```bash
# Behavior specs must end in .spec.md
for spec in specs/3-behaviors/*.spec.md; do
  [[ "$spec" =~ \.spec\.md$ ]] || FAIL
done

# Prompts match phase-letter pattern
for prompt in dist/prompts/[0-4]-*/*.md; do
  basename "$prompt" | grep -qE "^[0-4][a-z]-" || FAIL
done
```

### 5. Prompt Alignment Tests (tests/prompts/test_prompt_behaviors.sh)

**Validates:**
- Prompts have spec: frontmatter pointing to defining spec
- Referenced spec files exist
- Spec file contains behavior definition for prompt

**Spec:** specs/workspace/patterns.spec.md (spec ↔ prompt alignment)

**Example checks:**
```bash
# Extract spec reference from prompt frontmatter
SPEC_REF=$(sed -n '/^spec:/s/^spec: //p' "$prompt")

# Validate spec exists
[ -f "$SPEC_REF" ] || echo "FAIL - $prompt references missing spec"
```

### 6. Full Validation (tests/structure/test_full_validation.sh)

**Validates:**
- Circularity: Every spec has constrained_by
- Completeness: Every deliverable has defining spec
- Consistency: No orphaned specs or deliverables
- Metaspecs: All metaspecs exist in dist/standard/metaspecs/

**Spec:** specs/2-strategy/dogfooding.spec.md (circularity requirement)

**Example checks:**
```bash
# Check every spec constrained
for spec in specs/**/*.spec.md; do
  grep -q "^constrained_by:" "$spec" || echo "MISSING constrained_by: $spec"
done

# Count deliverables vs defining specs
DELIVERABLE_COUNT=$(find dist/ -type f | wc -l)
SPEC_COUNT=$(find specs/3-behaviors/ -name "*.spec.md" | wc -l)
```

## Test Runner (run-all-tests.sh)

**Purpose:**
- Execute all test scripts
- Aggregate results
- Provide summary
- Exit with appropriate code

**Design:**
```bash
for test_file in tests/prompts/*.sh tests/structure/*.sh; do
  if "$test_file"; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
  else
    FAILED_TESTS=$((FAILED_TESTS + 1))
  fi
done

[ $FAILED_TESTS -gt 0 ] && exit 1 || exit 0
```

**Benefits:**
- Single command runs all tests
- CI/CD integration (GitHub Actions checks exit code)
- Local development feedback
- Pre-commit validation

## Continuous Validation Approach

**When tests run:**
- **Pre-commit**: Developer runs manually before committing
- **CI/CD**: GitHub Actions runs on every push
- **Pre-release**: Full test suite before version increment
- **Manual**: Developer unsure if change broke conventions

**Automation:**
```yaml
# .github/workflows/test.yml
name: Validate LiveSpec
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run test suite
        run: ./tests/run-all-tests.sh
```

**Feedback loop:**
1. Developer makes change (add spec, modify prompt)
2. Run tests locally: `./tests/run-all-tests.sh`
3. Tests fail → fix issue → rerun
4. Tests pass → commit
5. CI/CD runs tests on push
6. GitHub shows test status
7. PRs require tests passing

**Benefits:**
- Catches drift immediately (before it spreads)
- Prevents accumulating technical debt
- Validates dogfooding continuously
- Builds confidence in changes

## Connection to Drift Detection

**Drift detection is Phase 4 applied to LiveSpec itself:**

**Manual drift detection:**
- Developer notices spec doesn't match deliverable
- Uses 4a-detect-drift.md to analyze gap
- Uses 4b-extract-specs.md to document new reality
- Uses 4c-sync-complete.md to verify alignment

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
prompt added: dist/prompts/utils/upgrade-methodology.md
No spec found: specs/3-behaviors/prompts/utils-upgrade.spec.md

# Resolution
Create specs/3-behaviors/prompts/utils-upgrade.spec.md
Add spec: frontmatter to prompt
Tests pass
```

**Drift type 2: Spec changed, deliverable stale**
```
# Test detects
specs/3-behaviors/folder-structure.spec.md says "4 standard folders"
But dist/standard/conventions/folder-structure.spec.md says "3 standard folders"

# Resolution
Update dist/standard/conventions/folder-structure.spec.md
Sync with specs/3-behaviors/folder-structure.spec.md
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

- Test suite exists in tests/ directory
- All tests are executable bash scripts
- run-all-tests.sh aggregates and runs all tests
- Tests validate structure, format, traceability, naming, alignment
- Tests do NOT validate content quality, UX, or outcomes
- Test suite passes on current LiveSpec repository
- Tests use only bash, grep, sed (no frameworks)
- Tests runnable locally and in CI/CD
- Test failures indicate drift between specs and practice
- Connection to dogfooding clear (tests validate we follow own rules)
