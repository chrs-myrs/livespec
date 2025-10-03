---
spec: specs/prompts/4c-sync-complete.spec.md
---

# 4c: Synchronisation Complete

**Phase**: EVOLVE
**Purpose**: Confirm specs and code are synchronized
**Context**: Final step in drift resolution

## Task

Verify that specifications and implementation are now synchronized and document the evolution.

## Synchronisation Checklist

### 1. Verify All Changes Addressed

Review drift report from 4a:
```markdown
## Drift Report Status

### Auto-Accepted
✅ All accepted (no spec changes needed)

### Requiring Review
✅ Password reset: Spec extracted (specs/behaviors/password-reset.md)
✅ CSV timestamps: Spec updated (specs/behaviors/data-export.md)

### Manual Resolution
✅ API pagination: Versioned to v2, spec updated
```

All items should be ✅ resolved.

### 2. Run Validation

Repeat verification from Phase 3:
```bash
# Run all tests
pytest tests/

# Validate contracts
oasdiff specs/contracts/api/v1.yaml specs/contracts/api/v2.yaml

# Check behaviors
# Each behavior spec validated by tests
```

**Success Criteria:**
- ✅ All tests pass
- ✅ All behaviors have specs
- ✅ All contracts documented
- ✅ No undocumented features

### 3. Update Evolution Log

Document the evolution in `evolution-log.md`:

```markdown
# Evolution Log

## 2025-01-10: Password Reset & Pagination

### Changes
- Added password reset feature
- Added timestamps to CSV export
- Versioned API to v2 with pagination

### Specifications Updated
- Created: specs/behaviors/password-reset.md
- Updated: specs/behaviors/data-export.md
- Versioned: specs/contracts/api/v2/users-api.yaml

### Rationale
- Password reset: Critical user need for account recovery
- CSV timestamps: Audit requirement (CRITICAL)
- API pagination: Performance requirement (>10K users)

### Validation
- ✅ All behaviors tested
- ✅ All contracts validated
- ✅ Breaking changes versioned

### Next Review
2025-01-17 (weekly)
```

### 4. Commit Changes

Commit spec updates with clear message:

```bash
git add specs/
git commit -m "Evolve specs: password reset, CSV timestamps, API v2

- Extract password reset behavior spec
- Update data export with timestamp requirement
- Version API to v2 with pagination contract

All behaviors validated with tests.
Closes drift report 2025-01-10.

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

### 5. Update Workspace if Needed

If patterns or workflows changed, update workspace specs:

```markdown
# specs/workspace/patterns.md

## New Pattern: API Versioning

**Specification**: API breaking changes require version increment

**Validation**:
- Breaking changes create new version folder
- Old versions maintain compatibility
- Migration guide provided
```

## Continuous Evolution

EVOLVE is a continuous phase:

### Ongoing Activities
- **Weekly drift checks**: Run 4a-detect-drift.md
- **After features**: Extract specs (4b) immediately
- **Before releases**: Verify synchronisation (4c)
- **Quarterly reviews**: Audit MSL compliance

### Triggering Phase Cycles

From EVOLVE, you may cycle back:
- **New requirements** → Phase 0 (DEFINE)
- **Architecture changes** → Phase 1 (DESIGN)
- **New features** → Phase 2 (BUILD)
- **Validation issues** → Phase 3 (VERIFY)

### Maintaining Minimalism

Periodically audit specs for MSL compliance:
- Can any spec be further reduced?
- Are all requirements still critical?
- Can validation criteria be simplified?
- Is anything obvious that doesn't need stating?

## Exit Criteria

- [ ] All drift resolved
- [ ] All specs synchronized with code
- [ ] Validation passing
- [ ] Evolution logged
- [ ] Changes committed
- [ ] Workspace updated if needed

## Phase Complete

✅ **Phase 4: EVOLVE cycle complete**

Continuous cycle:
- Monitor for drift → 4a
- Extract new specs → 4b
- Verify synchronisation → 4c
- Repeat

---

## LiveSpec v2 Full Cycle

**Initial Development:**
0. DEFINE → 1. DESIGN → 2. BUILD → 3. VERIFY → 4. EVOLVE

**Continuous Evolution:**
4. EVOLVE ↔ (2. BUILD ↔ 3. VERIFY) → 4. EVOLVE

**Major Changes:**
4. EVOLVE → 0. DEFINE → ... (full cycle)

**The system stays synchronized because specifications are living documents that evolve with the code.**
