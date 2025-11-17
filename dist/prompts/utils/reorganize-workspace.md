---
implements: specs/3-behaviors/workspace-optimization.spec.md
phase: utilities
---

# Reorganize Workspace Context

**Purpose**: Analyze context usage patterns from session data to reorganize AGENTS.md structure, optimize START/MIDDLE/END positioning, and identify extraction candidates for better context efficiency.

**When to use**: When context feels bloated, signal-to-noise ratios consistently low (<40%), or after major methodology changes requiring context restructuring.

---

## Instructions for AI Agent

You are optimizing workspace context organization based on actual usage patterns. Focus on moving frequently-used content to START positions and extracting repeated inline content to templates.

### Step 1: Analyze Context Usage Patterns

Read last 10-15 compliance JSON files to understand what's actually used:

```bash
ls -t ~/.claude/livespec/compliance/*.json | head -15 | while read f; do
  echo "=== File: $(basename $f) ==="
  jq '.context_analysis.sections_referenced, .context_analysis.sections_unused' "$f"
done
```

**Count frequency:**
- Which AGENTS.md sections referenced most often? (hot sections)
- Which sections rarely/never referenced? (cold sections)
- Which sections appear in "unused" lists repeatedly? (noise)

**Calculate statistics:**
- Section frequency: Times referenced / Total sessions analyzed
- Hot threshold: >70% of sessions (START candidates)
- Warm threshold: 40-70% of sessions (MIDDLE appropriate)
- Cold threshold: <40% of sessions (END candidates or remove)

### Step 2: Measure Current Context Efficiency

Read AGENTS.md and calculate current state:

```bash
# Section count
grep "^##" AGENTS.md | wc -l

# Total size
wc -c AGENTS.md

# Current positioning (approximate)
total_lines=$(wc -l < AGENTS.md)
start_end=$((total_lines * 40 / 100))
middle_end=$((total_lines * 80 / 100))

echo "START section: lines 1-$start_end"
echo "MIDDLE section: lines $start_end-$middle_end"
echo "END section: lines $middle_end-$total_lines"
```

**Assess current layout:**
- Are hot sections in START? (should be)
- Are cold sections in END? (should be)
- Are warm sections in MIDDLE? (should be)
- What's mispositioned?

### Step 3: Identify Redundancy

Compare CLAUDE.md and AGENTS.md for overlap:

```bash
# Read both files
cat ~/.claude/CLAUDE.md > /tmp/claude.md
cat AGENTS.md > /tmp/agents.md
```

**Look for:**
- Same topics covered in both files
- Estimate overlap percentage
- Which file has more detail?
- Can one reference the other?

**From session data:**
- Which redundant content appears in "unused" lists?
- Is redundancy helping or hurting?

### Step 4: Detect Repeated Inline Content

Analyze AGENTS.md for repeated patterns:

```bash
# Common patterns (example)
grep -o "Phase [0-4]:" AGENTS.md | sort | uniq -c
grep -o "Use \`.*\\.md\`" AGENTS.md | sort | uniq -c
```

**Extraction candidates:**
- Content repeated 3+ times (template opportunity)
- Long inline examples (could be templates)
- Verification checklists (standardize as templates)
- Decision matrices (extract to .livespec/templates/)

**Don't extract:**
- Content used only once
- Critical decision logic (keep inline)
- Content that varies by context

### Step 5: Propose Reorganization

**START Section (30-40% of file):**
- Hot sections (>70% usage frequency)
- Critical decision points always needed
- Active enforcement instructions (spec-first protocol)
- Session completion triggers (NEW - needs START positioning)

**Example START candidates:**
- Spec-First Protocol
- Core Principles (if frequently referenced)
- Session Completion Monitoring (active triggers)
- MSL Minimalism (if used every session)

**MIDDLE Section (40% of file):**
- Warm sections (40-70% usage)
- Detailed workflows
- Development patterns
- Reference material used often

**Example MIDDLE candidates:**
- 5 Phases overview
- Folder Organization
- MSL Format (if not in START)
- Development Workflows

**END Section (20-30% of file):**
- Cold sections (<40% usage)
- Advanced topics
- Edge cases
- Rarely-used utilities
- "For more info" pointers

**Example END candidates:**
- Common Anti-Patterns (unless frequently hit)
- Reference Library (pointers to deep detail)
- Multi-Domain Organization (if project single-domain)

### Step 6: Identify Extractions

**Create templates for repeated content:**

```markdown
## Proposed Extractions

### 1. Phase Verification Checklist
**Currently:** Inline in AGENTS.md, repeated for each phase
**Extract to:** `.livespec/templates/agents/phase-verification.md`
**Usage:** Reference from AGENTS.md: "See phase-verification template"
**Savings:** ~500 characters × 5 phases = 2.5KB

### 2. Session Completion Report Format
**Currently:** Inline example in Session Completion section
**Extract to:** `.livespec/templates/agents/session-report.md`
**Usage:** Reference when needed
**Savings:** ~300 characters

### 3. [Other extraction candidates]
```

**Calculate total savings:**
- Size reduction estimate
- Impact on context budget (30-40KB target)
- Readability improvement

### Step 7: Check Compression Level

Read current compression setting:

```bash
grep "context_compression:" specs/workspace/constitution.spec.md
```

**Assess if compression level appropriate:**
- Light: Verbose, self-contained (exploratory, large models)
- Moderate: Balanced inline/reference (production, most agents)
- Aggressive: Dense, focused (cost-sensitive, high-frequency)

**Current file size vs target:**
- 30-40KB target for moderate compression
- >40KB suggests need for aggressive compression or extractions
- <30KB might allow lighter compression for clarity

### Step 8: Generate Reorganization Plan

Present comprehensive plan:

```markdown
# Workspace Context Reorganization Plan

**Analysis Date:** YYYY-MM-DD
**Data Sources:** [X] session compliance files
**Current AGENTS.md:** [XX] KB, [X] sections
**Target:** 30-40 KB, optimal START/MIDDLE/END positioning

---

## Usage Patterns

| Section | Frequency | Current | Recommended |
|---------|-----------|---------|-------------|
| Spec-First Protocol | 95% | MIDDLE | → START |
| Session Completion | 15% | MIDDLE | → START (add active triggers) |
| MSL Minimalism | 85% | START | ✓ (keep START) |
| Multi-Domain Org | 10% | MIDDLE | → END |
| [Other sections] | [%] | [pos] | [recommendation] |

---

## Proposed Moves

### To START (Hot - >70% usage)
1. Session Completion Monitoring (active triggers)
2. [Other hot sections]

### To MIDDLE (Warm - 40-70% usage)
1. [Sections moving from START/END]

### To END (Cold - <40% usage)
1. [Sections moving from START/MIDDLE]

---

## Proposed Extractions

1. **Phase Verification Template** → `.livespec/templates/agents/phase-verification.md`
   - Savings: ~2.5 KB
   - Referenced 5× currently inline

2. **[Other extractions]**

**Total Savings:** ~X KB (reduces AGENTS.md to ~XX KB)

---

## Redundancy Reduction

| Topic | CLAUDE.md | AGENTS.md | Overlap | Recommendation |
|-------|-----------|-----------|---------|----------------|
| MSL Minimalism | Detailed | Detailed | ~80% | Keep CLAUDE.md detail, AGENTS.md reference |
| [Others] | | | | |

**Total Redundancy:** ~X KB could be reduced

---

## Compression Level

**Current:** [light / moderate / aggressive]
**Recommended:** [same / change to X]
**Reasoning:** [File size, usage patterns, model context]

---

## Expected Outcomes

**After reorganization:**
- AGENTS.md: ~XX KB (was XX KB)
- Signal-to-noise: ~XX% (was YY%)
- Hot sections in START: [X]/[X] (was [Y]/[X])
- Cold sections in END: [X]/[X] (was [Y]/[X])
- Templates extracted: [X]
- Context efficiency: [improvement estimate]

---

## Implementation Steps

1. Create templates (extractions)
2. Update AGENTS.md (move sections, add references)
3. Update constitution.spec.md (if compression level changes)
4. Regenerate context tree (use regenerate-contexts.md)
5. Validate (check file sizes, cross-references)
6. Monitor next 5 sessions (measure improvement)
```

### Step 9: Ask for Approval

```
This reorganization is based on [X] sessions of usage data. What should I do?

1. Implement full reorganization - All moves + extractions
2. Implement moves only - Reposition sections (no extractions yet)
3. Implement extractions only - Create templates (no moves yet)
4. Review specific section - [Let me know which]
5. Cancel - Keep current organization
```

### Step 10: Implement (If Approved)

**If user approves:**

1. **Create extraction templates:**
```bash
mkdir -p .livespec/templates/agents
# Create each template file
```

2. **Update AGENTS.md:**
   - Move sections to new positions
   - Replace extracted content with references
   - Update table of contents if present

3. **Regenerate context tree:**
   - Use `regenerate-contexts.md` prompt
   - Ensures ctxt/ structure updated

4. **Validate:**
   - Check file sizes
   - Verify cross-references work
   - Test prompt discovery

5. **Monitor:**
   - Track signal-to-noise in next 5 sessions
   - Verify hot sections in START are used
   - Adjust if needed

---

## When NOT to Use This Prompt

**Don't use if:**
- Less than 10 sessions of data (insufficient usage patterns)
- Major methodology changes happening (wait until stable)
- Context efficiency already good (>60% signal-to-noise, within budget)
- Just want to regenerate (use regenerate-contexts.md instead)

**Use instead:**
- **regenerate-contexts.md** - Just regenerate existing structure
- **audit-context-compression.md** - Measure compression without reorganizing
- **suggest-improvements.md** - Strategic analysis (not just context)

---

## Quality Checklist

Before implementing reorganization:
- [ ] Usage patterns analyzed (10+ sessions)
- [ ] Current positioning assessed (START/MIDDLE/END)
- [ ] Hot sections (>70%) identified for START
- [ ] Cold sections (<40%) identified for END
- [ ] Extraction candidates evaluated (3+ repetitions)
- [ ] Redundancy with CLAUDE.md checked
- [ ] Compression level assessed
- [ ] Expected outcomes calculated (file size, efficiency)
- [ ] Implementation plan specific and complete
- [ ] User approval obtained

---

**Remember:** Reorganization based on data, not intuition. Verify improvements in next 5 sessions after implementation.
