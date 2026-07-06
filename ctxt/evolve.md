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

**Run validation at key checkpoints:**
```bash
# Frontmatter compliance (IMP-005)
scripts/validate-frontmatter.sh

# Cross-reference integrity
scripts/validate-crossrefs.sh

# Purpose boundary check
scripts/validate-purpose.sh
```

Full sweep: `/livespec:audit validate`

**Severity levels:**
- ERROR: Must fix before committing
  - Missing mandatory frontmatter fields
  - Wrong type/category values
  - Underscore field names (use hyphens)
  - Broken cross-references
  - governed-by containing metaspec paths
- WARNING: Should fix soon
  - Missing backlinks, stale generated files

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

# Confirm frontmatter compliance
scripts/validate-frontmatter.sh

# Confirm sync
/livespec:audit validate
```

### Pre-Release Validation

```bash
# All validations must pass
scripts/validate-frontmatter.sh

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
- Vocabulary spec: `references/standards/vocabulary.spec.md` (canonical controlled terms)
- Base metaspec: `references/standards/metaspecs/base.spec.md`
- Parent context: AGENTS.md

---

*Evolve mode specialist for LiveSpec v5.7.0*
*Parent: AGENTS.md*
