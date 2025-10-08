---
spec: specs/behaviors/prompts/utils-feedback-report.spec.md
---

# Generate LiveSpec Feedback Report

**Purpose**: Generate structured evaluation report on LiveSpec usage to help maintainers improve the methodology
**Context**: Can be run at any time - useful for health checks and providing feedback

## Overview

This prompt creates a comprehensive feedback report combining automated analysis of your LiveSpec adoption with qualitative user experience feedback. Reports help LiveSpec maintainers understand real-world usage patterns, identify pain points, and prioritize improvements.

**What you get:**
- Automated health check of your LiveSpec adoption
- Reflection on what's working and what isn't
- Contribution to methodology improvement
- Structured report you can submit to maintainers

## When to Use

**Good times to generate feedback:**
- After completing a major project milestone
- When adopting LiveSpec for first time (after 1-2 months)
- After upgrading to new LiveSpec version
- When experiencing persistent challenges
- Quarterly/periodic health checks
- When you want to contribute improvement suggestions

**Don't need to wait for problems** - success stories are equally valuable!

## Report Generation Process

### Phase 1: Automated Analysis

**AI should perform these analyses automatically:**

#### 1.1 Project Context

```bash
# Determine domain
grep -r "behaviors/policies\|behaviors/user-features\|behaviors/services\|behaviors/requirements" specs/ 2>/dev/null

# Project age (first commit)
git log --reverse --format="%ai" | head -1

# LiveSpec version
cat .livespec/.livespec-version 2>/dev/null || echo "unknown"

# Spec counts
find specs/ -name "*.spec.md" -type f | wc -l

# Code size (approximate)
find . -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.go" -o -name "*.rb" -o -name "*.java" 2>/dev/null | wc -l
```

**Determine:**
- **Domain**: software, governance, operations, planning, or hybrid (based on behaviors/ subfolders)
- **Project age**: When first commit was made
- **Project size**: Line counts, file counts, spec counts
- **LiveSpec version**: From .livespec-version file
- **Team size**: Approximate from git commit authors (last 3 months)

#### 1.2 Adoption Metrics

```bash
# Which prompts have been used (from git log)
git log --all --format="%s" | grep -iE "phase [0-4]|0a-|1a-|2a-|3a-|4a-" | sort | uniq -c

# Spec inventory by type
find specs/workspace -name "*.spec.md" 2>/dev/null | wc -l
find specs/behaviors -name "*.spec.md" 2>/dev/null | wc -l
find specs/contracts -name "*.spec.md" 2>/dev/null | wc -l
find specs/strategy -name "*.spec.md" 2>/dev/null | wc -l

# Check subfolder organization
ls -d specs/behaviors/*/ specs/contracts/*/ 2>/dev/null

# Check customizations
cat .livespec/customizations.yaml 2>/dev/null
```

**Determine:**
- **Phases used**: Which prompts appear in git history
- **Spec inventory**: Count by type (workspace, behaviors, contracts, strategy)
- **Folder organization**: Flat vs domain subfolders (behaviors/policies/, etc.)
- **Customizations**: From customizations.yaml (modified prompts, custom templates)
- **Integration pattern**: Symlink (.livespec/ → prompts/) vs copy vs Context7

#### 1.3 Quality Assessment

```bash
# Last drift detection
git log --all --grep="drift" --format="%ai %s" | head -1

# MSL format check (sample 5 random specs)
find specs/ -name "*.spec.md" -type f | shuf -n 5

# Test files exist
find . -name "*test*" -o -name "*spec.*" -o -name "*.test.*" 2>/dev/null | head -5
```

**Determine:**
- **Drift status**: When last drift detection ran, if ever
- **MSL adherence**: Sample specs and check format (frontmatter, Requirements section, [!] markers)
- **Test coverage**: Presence of test files
- **Dependency graph**: Frontmatter links present (derives_from, constrained_by, satisfies)
- **Validation status**: Recent validation runs in git history

#### 1.4 Usage Patterns

```bash
# Prompt usage frequency (from git history)
git log --all --format="%s" | grep -oE "(0[a-d]|1[a-c]|2[ab]|3[ab]|4[a-e])-" | sort | uniq -c | sort -rn

# Phases skipped (gaps in 0-4 sequence)
# Check if Phase 0, 1, 2, 3, 4 all appear

# Custom prompts/templates
find .livespec/prompts -name "*.md" | grep -v "^.livespec/prompts/[0-4]-" 2>/dev/null
find .livespec/templates -name "*.template" 2>/dev/null
```

**Determine:**
- **Prompt frequency**: Which prompts used most (from git commits)
- **Phases skipped**: Missing phases in workflow
- **Custom workflows**: Custom prompts created
- **Regeneration frequency**: How often AGENTS.md regenerated (4d prompt usage)

### Phase 2: User Experience Questions

**AI should ask user these questions:**

1. **What's working well with LiveSpec?**
   - Which aspects are most valuable?
   - What problems has it solved?
   - Any "aha!" moments or breakthroughs?

2. **What pain points have you encountered?**
   - What's frustrating or confusing?
   - What takes too much time/effort?
   - What feels unnecessarily complex?

3. **What aspects are confusing or unclear?**
   - Which concepts need better explanation?
   - Which prompts are hard to understand?
   - What documentation is missing?

4. **What features/capabilities are missing?**
   - What would make LiveSpec more useful?
   - What workarounds are you using?
   - What doesn't fit your workflow?

5. **Would you recommend LiveSpec? Why or why not?**
   - To what type of projects/teams?
   - What would need to improve for recommendation?
   - Net Promoter Score context (0-10)?

**Note:** User answers are qualitative free text. Capture verbatim.

### Phase 3: Anonymization Options

**Ask user before generating report:**

```
Would you like to anonymize this report before submission?

Anonymization options:
[ ] Strip project name and identifiers
[ ] Strip file names and paths
[ ] Strip git commit messages
[ ] Strip team size and composition
[ ] Full anonymization (only aggregated metrics)

Privacy note: Reports use random UUID for tracking, not tied to identity.

Your choice: [none/partial/full]
```

**Apply selected anonymization:**
- **none**: Include all details
- **partial**: Strip names/paths but keep structure
- **full**: Only aggregated metrics and qualitative feedback

### Phase 4: Generate Report

**Create report in var/feedback-reports/:**

```bash
mkdir -p var/feedback-reports
REPORT_DATE=$(date +%Y%m%d)
REPORT_FILE="var/feedback-reports/livespec-feedback-$REPORT_DATE.md"
```

**Report structure:**

```markdown
# LiveSpec Feedback Report

**Generated**: YYYY-MM-DD
**Report ID**: [random UUID - for tracking only]
**Anonymization Level**: [none/partial/full]

---

## 1. Project Context

**Domain**: [software/governance/operations/planning/hybrid]
**Project Age**: [X months from first commit]
**Project Size**: [X files, Y lines of code, Z specs]
**LiveSpec Version**: [X.Y.Z]
**Team Size**: [~N developers based on git authors] or [REDACTED]

**Domain Organization**:
- Uses subfolder organization: [yes/no]
- Folders present: [list behaviors/*/  and contracts/*/]

---

## 2. Adoption Metrics

### Phases Used
- Phase 0 (DEFINE): [used/skipped] - [prompts: 0a, 0b, 0c, 0d]
- Phase 1 (DESIGN): [used/skipped] - [prompts: 1a, 1b, 1c]
- Phase 2 (BUILD): [used/skipped] - [prompts: 2a, 2b]
- Phase 3 (VERIFY): [used/skipped] - [prompts: 3a, 3b]
- Phase 4 (EVOLVE): [used/skipped] - [prompts: 4a, 4b, 4c, 4d, 4e]

### Spec Inventory
- Workspace specs: [N]
- Behavior specs: [N]
- Contract specs: [N]
- Strategy specs: [N]
- **Total**: [N]

### Customizations
- Modified prompts: [N] - [list or REDACTED]
- Custom prompts added: [N] - [list or REDACTED]
- Custom templates added: [N] - [list or REDACTED]
- Never-overwrite paths: [list or REDACTED]

### Integration Pattern
- [symlink dogfooding / local copy / Context7 remote]

---

## 3. Quality Assessment

### Drift Management
- Last drift detection: [date or "never"]
- Drift status: [clean / minor drift / significant drift / unknown]

### MSL Format Adherence
- Specs checked: [N sampled]
- Format compliance: [N/N follow MSL format]
- Common issues: [missing frontmatter, no Requirements section, etc.]

### Test Coverage
- Test files present: [yes/no]
- Behaviors with tests: [~X%]

### Dependency Graph
- Specs with frontmatter links: [~X%]
- derives_from links: [present/sparse/absent]
- constrained_by links: [present/sparse/absent]

### Validation Status
- Last validation run: [date or "never"]
- Last validation result: [pass/fail/unknown]

---

## 4. Usage Patterns

### Prompt Frequency
[Top 5 most-used prompts with approximate usage counts]

Example:
- 4a-detect-drift: ~15 uses
- 2a-implement-from-specs: ~8 uses
- 1b-define-behaviors: ~6 uses
- 0a-setup-workspace: 1 use
- 3a-run-validation: ~3 uses

### Workflow Observations
- Phases skipped: [list if any]
- Utilizes Phase 4 regularly: [yes/no]
- Custom workflow patterns: [observations or "standard workflow"]

---

## 5. Experience Report

### What's Working Well
[User free text response]

### Pain Points
[User free text response]

### Confusing Aspects
[User free text response]

### Missing Features
[User free text response]

### Recommendation
**Would recommend LiveSpec?** [yes/no/maybe]

[User free text response - why or why not, to whom, what needs improvement]

---

## 6. Submission Instructions

Thank you for taking time to provide feedback! Your input helps improve LiveSpec for everyone.

### How to Submit This Report

**Option 1: GitHub Issue (Preferred)**

1. Visit: https://github.com/chrs-myrs/livespec/issues/new
2. Title: "Feedback Report - [optional: your project type]"
3. Label: "feedback"
4. Paste this report in issue body

**Option 2: Direct Contact**

Email: [feedback email for LiveSpec]
Subject: "LiveSpec Feedback Report [Report ID]"

**Optional**: Include contact info if you're open to follow-up discussion about your experience.

### Privacy

- Report ID is random UUID, not tied to your identity
- Anonymization level applied: [level chosen]
- You control what information is shared
- Contact info is optional

---

*Generated by LiveSpec utils/generate-feedback-report.md*
```

### Phase 5: Completion

**After generating report:**

1. **Show report location:**
   ```
   ✓ Feedback report generated: var/feedback-reports/livespec-feedback-YYYYMMDD.md
   ```

2. **Summarize key findings:**
   ```
   Summary:
   - Domain: [domain]
   - Specs: [N total]
   - Phases used: [0,1,2,3,4 or gaps]
   - Quality: [drift status, format compliance]
   - Experience: [positive/mixed/challenging]
   ```

3. **Remind about submission:**
   ```
   Next steps:
   1. Review report: var/feedback-reports/livespec-feedback-YYYYMMDD.md
   2. Edit if needed (it's just markdown)
   3. Submit via GitHub issue or email (instructions in report)

   Your feedback helps improve LiveSpec! Thank you.
   ```

## AI Agent Guidelines

### Data Collection Best Practices

**DO:**
- Analyze codebase systematically (git history, file structure, spec counts)
- Sample specs randomly for quality checks (don't cherry-pick)
- Report findings objectively (don't editorialize)
- Capture user feedback verbatim
- Respect anonymization choices
- Generate valid UUID for tracking

**DON'T:**
- Include sensitive data (API keys, passwords, PII)
- Make assumptions about user sentiment
- Interpret qualitative feedback (let maintainers interpret)
- Include project code or implementation details
- Guess at team size/structure if git history limited

### Handling Edge Cases

**If .livespec/ missing:**
```
⚠️ No .livespec/ directory found.
This report works best for projects using LiveSpec.
Proceed with partial analysis? (y/n)
```

**If git history unavailable:**
```
⚠️ No git history available.
Usage patterns will be incomplete. Proceed? (y/n)
```

**If user unsure about questions:**
```
It's okay to say "unsure" or "N/A" for any question.
Skip questions that don't apply to your experience.
```

### Report Quality Standards

**Good reports include:**
- Concrete metrics (spec counts, not "lots of specs")
- Specific examples (pain points with context)
- Balanced feedback (both positive and negative)
- Actionable suggestions (not just complaints)

**Prompt user to clarify:**
- Vague responses ("it's confusing")
- Missing context ("doesn't work")
- Unrealistic suggestions ("should do everything")

## Exit Criteria

- [ ] Automated analysis complete (context, adoption, quality, usage)
- [ ] User answered all 5 experience questions
- [ ] Anonymization options offered and applied
- [ ] Report generated in var/feedback-reports/
- [ ] Report follows standard structure (6 sections)
- [ ] Random UUID generated
- [ ] Submission instructions included
- [ ] Report location shown to user

## Notes

**Frequency recommendations:**
- First-time users: After 1-2 months
- Regular users: Quarterly or after major milestones
- Upgrades: After adopting new LiveSpec version
- Problems: When persistent challenges arise

**Report uses:**
- Maintainer feedback for methodology improvement
- User reflection on adoption journey
- Project health check
- Success/failure pattern recognition

**Privacy commitment:**
- UUID tracking only (no identity linkage)
- User controls anonymization level
- Contact info optional
- Raw feedback not publicly shared (aggregated insights only)
