---
implements: specs/3-behaviors/slash-command-generation.spec.md
phase: utilities
---

# Audit Spec Coverage

**Purpose:** Verify all permanent files have corresponding specifications.

**When to use:** Before releases, monthly audits, when adding new files, or as part of `/livespec/audit coverage` command.

---

## Instructions for AI Agent

You are auditing the project to ensure all permanent files have specifications. Identify files that should have specs but don't.

### Step 1: Understand What Requires Specs

**Permanent files (require specs):**
- Code: `src/`, `lib/`, `scripts/`
- Tests: `tests/`, `__tests__/`
- Config: `.gitignore`, `tsconfig.json`, `package.json`, lock files
- Documentation: `README.md`, guides
- Agents: `.claude/agents/*/instructions.md`
- Slash commands: `.claude/commands/`

**Ephemeral files (no spec needed):**
- `var/`, `generated/`, `.archive/`
- Build outputs: `dist/`, `build/`
- Logs, caches

**Exception:** `specs/workspace/*.spec.md` ARE specs (no meta-spec needed)

### Step 2: Use Validation Script

```bash
# Run coverage check on entire project
scripts/check-requires-spec.sh

# Or check specific file
scripts/check-requires-spec.sh path/to/file.js
```

**Exit codes:**
- `0` = Spec exists or not needed
- `1` = Spec required but missing

### Step 3: Categorize Missing Specs

**For each file missing spec, determine category:**

**Category A: Individual behavior (needs own spec)**
- Unique functionality
- Standalone script/component
- Example: `scripts/validate.sh` → `specs/3-behaviors/validation.spec.md`

**Category B: Related group (can share spec)**
- Multiple files serving same purpose
- Configuration files
- Related utilities
- Example: `.gitignore`, `.dockerignore` → `specs/3-behaviors/project-config.spec.md`

**Category C: False positive (actually exempt)**
- Build outputs incorrectly classified
- Files in ephemeral directories
- Files that should be in `.archive/`

### Step 4: Calculate Coverage Metrics

**Overall coverage:**
```bash
total_permanent_files=$(find . -type f \
  -not -path './var/*' \
  -not -path './generated/*' \
  -not -path './.archive/*' \
  -not -path './node_modules/*' \
  -not -path './.git/*' \
  | wc -l)

files_with_specs=$(scripts/check-requires-spec.sh | grep -c "✓")

coverage_percentage=$(( files_with_specs * 100 / total_permanent_files ))
```

**Coverage levels:**
- 🟢 Excellent: 95-100% coverage
- 🟡 Good: 80-94% coverage
- 🔴 Poor: <80% coverage

### Step 5: Identify Patterns

**Common gaps:**
- Recently added files (check git log)
- Configuration files (often grouped, should share spec)
- Utility scripts (may share behavior spec)
- Lock files (should be in project-config.spec.md)

**Check for systematic issues:**
- Entire directories missing specs (indicates process failure)
- Old files without specs (technical debt)
- Generated files not marked ephemeral (should be in var/)

### Step 6: Generate Audit Report

**Format (concise):**

```markdown
# Spec Coverage Audit Report

**Date:** YYYY-MM-DD
**Coverage:** XX% (YY/ZZ files)
**Status:** [🟢🟡🔴]

---

## Summary

| Category | Count | Files |
|----------|-------|-------|
| ✅ Covered | X | XX% |
| ❌ Missing Specs | X | XX% |
| ⚠️ Needs Review | X | XX% |

**Overall Health:** [🟢🟡🔴] - [X]% coverage

---

## ❌ Missing Specs (Category A: Individual)

### [filename] → specs/3-behaviors/[suggested-name].spec.md

**Purpose:** [What this file does]
**Criticality:** [CRITICAL/IMPORTANT]
**Why needs spec:** [Behavior/failure mode]

---

## ❌ Missing Specs (Category B: Can Share)

### [file1], [file2], [file3] → specs/3-behaviors/[group-name].spec.md

**Purpose:** [Common purpose]
**Suggestion:** Create shared spec covering:
- [Behavior 1]
- [Behavior 2]

---

## ⚠️ False Positives (Category C)

### [filename]

**Issue:** Classified as permanent but should be ephemeral
**Recommendation:** Move to `var/` or add to `.gitignore`

---

## Coverage Trends

**Compared to last audit:**
- Coverage: [Previous]% → [Current]% ([+/-X]%)
- New files added: [X] (with specs: [Y])
- Specs created: [X]
- Technical debt reduced: [X] files

---

## Recommendations

### Immediate Actions (Block release)

1. **Create specs for CRITICAL files:**
   - [file1] → [suggested spec path]
   - [file2] → [suggested spec path]

### Short-term (Next sprint)

2. **Create shared specs for related files:**
   - [Group 1]: [files] → [spec path]
   - [Group 2]: [files] → [spec path]

### Process Improvements

3. **Prevent future gaps:**
   - Enable pre-commit validation (scripts/setup-hooks.sh)
   - Review spec-first protocol in AGENTS.md
   - Add coverage check to CI/CD

### Technical Debt

4. **Address legacy files:**
   - [X] old files without specs
   - Prioritize by usage frequency
   - Consider archiving unused files

---

## Pattern Analysis

**Most common gap:** [Configuration/Scripts/Tests/Documentation]
**Root cause:** [Process gap/New team member/Legacy code]
**Prevention:** [Specific recommendation]

**Positive trends:**
- [What's working well]
- [Process improvements noticed]
```

### Step 7: Provide Actionable Next Steps

**For each missing spec, provide template:**

```markdown
## Create Spec: specs/3-behaviors/[name].spec.md

**Frontmatter:**
```yaml
---
criticality: [CRITICAL/IMPORTANT]
failure_mode: [What breaks without this]
specifies: [path/to/file]
---
```

**Requirements to capture:**
- [!] [Observable behavior 1]
  - [Validation criterion]
- [!] [Observable behavior 2]
  - [Validation criterion]

**Validation:**
- [ ] [How to verify behavior 1]
- [ ] [How to verify behavior 2]
```

---

## When NOT to Use This Audit

**Skip if:**
- Project just started (no permanent files yet)
- Coverage already >95% (minimal value)
- Major refactoring in progress (file structure changing)

**Use when:**
- Before releases (ensure complete coverage)
- After adding multiple new files
- Monthly health checks
- Onboarding new contributors (show expected standards)

---

## Integration with Other Audits

**Run together with:**
- `audit-msl-minimalism.md` - Check spec quality after coverage confirmed
- `audit-context-compression.md` - Verify context efficiency
- `validate-project.md` - Full project validation

**Workflow:**
1. **Coverage audit** (this) - Ensure specs exist
2. **Minimalism audit** - Ensure specs are minimal
3. **Validation** - Ensure specs are correct

---

## Output Quality Checklist

Before presenting report:
- [ ] All permanent files checked
- [ ] False positives identified and categorized
- [ ] Coverage percentage calculated correctly
- [ ] Missing specs categorized (individual vs shared)
- [ ] Recommendations specific with file paths
- [ ] Spec templates provided for each gap
- [ ] Pattern analysis identifies root causes

---

**Remember:** Specs prevent drift. Every permanent file needs specification before implementation. No exceptions for "obvious" files - your requirements may differ from conventions.
