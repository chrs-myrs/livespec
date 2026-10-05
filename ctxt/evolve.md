# EVOLVE Mode

> **Generated file** - Do not edit directly. Regenerate using `/livespec:audit context`

Sub-agent context for implementation, validation, and regeneration.

## Summary

Evolve mode handles implementation concerns: spec-first bootstrap for implementation (Phase 2), validating against specifications (Phase 3), and detecting when specs need regeneration (Phase 4). LiveSpec doesn't prescribe implementation methodology (TDD or otherwise) — see Phase 2 below.

## When to Use

**Entry conditions:**
- Design complete (specs in features/, strategy/, interfaces/)
- Implementation needed (Phase 2 BUILD)
- Validation needed (Phase 3 VERIFY)
- Regeneration signals detected (Phase 4 EVOLVE)

## Phase 2: BUILD

### LiveSpec's Role: Spec-First Bootstrap Only

LiveSpec's involvement in Phase 2 stops at spec-first enforcement — a spec must exist with `[!]` requirements before implementation starts (see Spec-First Protocol in AGENTS.md). LiveSpec does not prescribe TDD, another test strategy, or any other implementation methodology; that choice belongs to the coding agent and team.

**TDD is optional, not mandated:**
- `project.yaml` → `methodology.tdd: optional` (default) governs this per-project
- `references/guides/tdd.md` is optional reference material — a structured Red-Green-Refactor approach with an escape-hatch scoring rubric, for teams who deliberately want TDD discipline
- If you use it: Red (failing test mapped to a spec requirement) → Green (minimal code to pass) → Refactor (improve design, tests stay green)

### Tests Map to Specs

```
specs/features/authentication.spec.md
  Requirement: "Users can authenticate with email and password"
    → tests/test_auth.py::test_valid_credentials_grant_access
    → tests/test_auth.py::test_invalid_credentials_show_error
```

**Test structure mirrors spec structure.** When a spec changes, find corresponding tests first.

### Implementation Checklist

Before implementing any feature:
- [ ] Spec exists with [!] requirements
- [ ] Spec has full frontmatter (type, category, fidelity, criticality, failure_mode, governed-by + per-category fields)
- [ ] Tests (if the team's chosen methodology writes them first) reference spec requirements in docstrings/comments

## Phase 3: VERIFY

### Validation Against Specs

**Run validation at key checkpoints (seven validators):**
```bash
scripts/validate-frontmatter.sh    # frontmatter compliance (IMP-005)
scripts/validate-crossrefs.sh      # links resolve, trace to PURPOSE.md; --fix regenerates supports: (--fix --prune drops orphans)
scripts/validate-constraints.sh    # commands/scripts/routes LiveSpec claims exist
scripts/validate-registries.sh     # registries/ integrity
scripts/validate-purpose.sh        # PURPOSE.md boundary
scripts/validate-coverage.sh       # which spec's specifies: governs each file (report only)
scripts/validate-context.sh        # generated context current, stale or unstamped
```

Every validator accepts `--json` (one versioned document; contract in `specs/interfaces/formats/validator-output.spec.md`). CI (`.github/workflows/validate.yml`) runs all seven on every push, cross-references with `--strict`.

Full sweep: `/livespec:audit validate`. `scripts/setup-hooks.sh` installs a pre-commit hook (chains to any existing hook rather than replacing it) and vendors the hooked validators into the project's `scripts/` with provenance. The hook validates staged `*.spec.md` files only: frontmatter and cross-references block, constraints is advisory. It also runs the project's own tracked pre-commit script when it has one; `--check` reports where validators resolve.

**Severity levels:**
- ERROR: Must fix before committing
  - Missing mandatory frontmatter fields
  - Wrong type/category values
  - Underscore field names (use hyphens)
  - Broken cross-references (link target missing or relative)
  - governed-by containing metaspec paths
  - Unresolved `/livespec:` command, `scripts/*.sh`, or `routes-to:` reference
- WARNING: Should fix soon
  - `supports:` out of step with upward links (fix with `validate-crossrefs.sh --fix`), spec not reaching PURPOSE.md, link pointing down a layer, retired `implements:`
  - Stale or unstamped generated context, ungoverned files
  - Retired-layout reference (`.livespec/`, `.livespec-version`) outside migration guides

### Acceptance Review

After tests pass:
- Verify behaviors match specs (not just tests)
- Check edge cases documented in specs
- Validate frontmatter still accurate (governed-by content-only, type correct)

## Phase 4: EVOLVE — Regeneration Signals

### Detecting Regeneration Signals

**Not "drift" — these are signals that regeneration time has come:**

**Code without specs:**
```
Found: src/api/new-endpoint.py
Missing: specs/features/new-endpoint.spec.md

Signal: Extract spec from implementation
Action: /livespec:audit extract
```

**Spec without implementation:**
```
Found: specs/features/obsolete-feature.spec.md
Missing: Implementation (deleted)

Signal: Remove stale spec
Action: git rm specs/features/obsolete-feature.spec.md
```

**Behavior changed without spec update:**
```
Found: src/auth/oauth.py (flow changed)
Outdated: specs/features/authentication.spec.md

Signal: Update spec to reflect reality
Action: /livespec:design refine specs/features/authentication.spec.md
```

**AGENTS.md stale:**
```bash
for spec in specs/workspace/*.spec.md; do
  if [ "$spec" -nt "AGENTS.md" ]; then
    echo "STALE: AGENTS.md older than $spec"
  fi
done

Signal: Context needs rebuilding
Action: /livespec:audit context
```

### Spec Extraction (Brownfield)

When extracting specs from existing code:

```
Implementation exists → Extract WHAT, not HOW
         ↓
Draft spec with confidence markers
         ↓
Apply MSL gate (essential? not HOW?)
         ↓
Apply full frontmatter schema (IMP-005)
         ↓
Review with user
         ↓
Promote to active spec
```

**Confidence markers for extracted specs:**
```markdown
- [!] System authenticates users [extracted from oauth.py, confidence: high]
  - Valid credentials return JWT [extracted]
  - Tokens expire after 24h [inferred from code]
```

### Regeneration Workflow

```
1. Detect signal (code/spec/context mismatch)
2. Decide: Update spec OR regenerate code
   - Spec was right, code wrong → Revert code
   - Code is right, spec outdated → Update spec
3. Validate spec has correct frontmatter
4. Regenerate if context changed
5. Commit after validation passes
```

## Frontmatter When Extracting Specs

When extracting from existing code, use correct per-category fields:

**For features (most common extraction target):**
```yaml
---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: [What breaks for users without this]
governed-by: []
satisfies:
  - specs/foundation/outcomes.spec.md (Requirement N: Name)
guided-by:
  - specs/strategy/architecture.spec.md
---
```

**For strategy (architectural decisions found in code):**
```yaml
---
type: strategy
category: strategy
fidelity: decisions-only
criticality: IMPORTANT
failure_mode: [Architectural gap description]
governed-by: []
derives-from:
  - specs/foundation/constraints.spec.md
---
```

## Continuous Evolution Pattern

### Weekly Maintenance

```bash
# Check spec health
/livespec:audit health

# Triage:
# - CRITICAL: Fix immediately
# - IMPORTANT: Fix this week
# - MINOR: Backlog

# Confirm frontmatter and constraint compliance
scripts/validate-frontmatter.sh
scripts/validate-constraints.sh

# Confirm sync
/livespec:audit validate
```

### Pre-Release Validation

```bash
# All seven validators must pass (coverage and context report only)
scripts/validate-frontmatter.sh
scripts/validate-crossrefs.sh --strict
scripts/validate-constraints.sh
scripts/validate-registries.sh
scripts/validate-purpose.sh
scripts/validate-coverage.sh
scripts/validate-context.sh

# Rebuild context if workspace specs changed
/livespec:audit context
```

### Session End

```bash
# Capture learnings
/livespec:learn

# Result: Fresh session with captured knowledge
```

## References

- Audit skill: `/livespec:audit`
- Learn skill: `/livespec:learn`
- TDD guide (optional): `references/guides/tdd.md`
- Frontmatter validation: `scripts/validate-frontmatter.sh`
- Constraint validation: `scripts/validate-constraints.sh`
- Spec governance query: `scripts/validate-coverage.sh --which <path>` (what `scripts/check-requires-spec.sh` uses)
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms)
- Base metaspec: `references/standards/metaspecs/base.spec.md`
- Parent context: AGENTS.md

---

*Evolve mode specialist for LiveSpec v5.10.1*
*Parent: AGENTS.md*

<!-- livespec-context-sources: sha256:05325e2061ac33a004d5b3b90e0e80bea7a2ac2483e70b5f3cf692cbfc407461 n=96 -->
