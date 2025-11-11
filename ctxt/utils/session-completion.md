# Session Completion Utility

⚠️ **Generated file** - Do not edit directly. Regenerate using `.livespec/prompts/utils/regenerate-contexts.md`

## Summary

Session completion analyzes agent compliance and context efficiency to maintain focus and improve LiveSpec methodology. This utility provides eager session management—detecting when sessions should end and performing unified analysis.

## When to Use

**Agent should proactively detect and recommend completion when:**
- Task completed successfully (all todos done)
- Context approaching 100K tokens (50% of 200K budget)
- Natural stopping point (ready to commit, switching tasks)
- User appears stuck (repeated attempts, no progress)

**Benefits of fresh sessions:**
- Reduced context size = better focus
- Lower cognitive load
- Clearer task boundaries
- Better compliance with methodology

## Workflow

### Unified Session Analysis

**One action:** Use `.livespec/prompts/utils/complete-session.md`

**Agent performs:**

1. **Analyze process compliance (0-8 points):**
   - Layer 1 (TodoWrite gate): 0-2 points
   - Layer 2 (Validation check): 0-2 points
   - Layer 3 (Plan mode): 0-3 points
   - Layer 4 (Pre-commit hook): 0-1 point

2. **Analyze focus efficiency (0-13 points):**
   - Tool efficiency: 0-5 points (Read/Grep/Glob vs Bash)
   - Context navigation: 0-3 points (AGENTS.md usage)
   - Task focus: 0-2 points (scope adherence)
   - Context efficiency: 0-3 points (signal-to-noise ratio)

3. **Calculate signal-to-noise ratio:**
   - Signal = sections actually used during session
   - Noise = sections loaded but never referenced
   - Ratio = (sections used / total sections) × 100%

4. **Identify methodology gaps:**
   - What didn't work well (2-3 specific issues)
   - Why violations occurred (root causes)
   - How to prevent in future (improvements)

5. **Show concise report to user (≤15 lines):**
   ```
   Session Completion: [Task Name]

   Accomplishments:
   - [What was completed]
   - [Key deliverables]

   Compliance: X/8 process, Y/13 focus (Z% overall)

   What Went Well:
   - [2-3 highlights]

   What Could Improve:
   - [2-3 suggestions]

   Data saved to ~/.claude/livespec/
   ```

6. **Save data globally:**
   - `~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-projectname.json` (quantitative)
   - `~/.claude/livespec/feedback/YYYY-MM-DD-HHMMSS-projectname.md` (qualitative)

## Compliance Scoring

### Process Compliance (0-8 points)

**Layer 1: TodoWrite Gate (0-2 points)**
- 2 points: Used TodoWrite before creating all permanent files
- 1 point: Used TodoWrite for some files
- 0 points: Skipped TodoWrite gate

**Layer 2: Validation Check (0-2 points)**
- 2 points: Ran validation checks before creating files
- 1 point: Ran checks for some files
- 0 points: Skipped validation checks

**Layer 3: Plan Mode (0-3 points)**
- 3 points: Presented plan for all new permanent files
- 2 points: Presented plan for most files
- 1 point: Presented plan occasionally
- 0 points: Never presented plans

**Layer 4: Pre-commit Hook (0-1 point)**
- 1 point: Pre-commit validation passed (or not needed)
- 0 points: Pre-commit failed (violations committed)

### Focus Efficiency (0-13 points)

**Tool Efficiency (0-5 points)**
- 5 points: Always used specialized tools (Read/Grep/Glob)
- 3 points: Mostly used specialized tools
- 1 point: Frequently used Bash for file operations
- 0 points: Mostly used Bash (inefficient)

**Context Navigation (0-3 points)**
- 3 points: Loaded AGENTS.md, used sub-agents appropriately
- 2 points: Loaded AGENTS.md, didn't need sub-agents
- 1 point: Loaded AGENTS.md late
- 0 points: Never loaded AGENTS.md

**Task Focus (0-2 points)**
- 2 points: Stayed focused on defined scope
- 1 point: Minor scope creep
- 0 points: Significant scope drift

**Context Efficiency (0-3 points)**
- 3 points: Signal-to-noise >60%
- 2 points: Signal-to-noise 40-60%
- 1 point: Signal-to-noise 20-40%
- 0 points: Signal-to-noise <20%

### Compliance Levels

**Perfect (100%): 8/8 process + 11+ focus**
- All structural enforcement layers followed
- Efficient tool usage and context navigation
- High signal-to-noise ratio

**Good (75-99%): 6-7 process + 8+ focus**
- Most structural enforcement followed
- Generally efficient
- Acceptable context usage

**Fair (50-74%): 4-5 process**
- Some structural enforcement followed
- Moderate efficiency
- Room for improvement

**Poor (<50%): 0-3 process**
- Structural enforcement bypassed
- Inefficient practices
- Significant improvement needed

## Signal-to-Noise Ratio

**Measures context efficiency:**

**Calculation:**
```
Sections used = sections referenced during session
Total sections = all sections in loaded context
Ratio = (sections used / total sections) × 100%
```

**Example analysis:**
```
CLAUDE.md loaded:
- Used: MSL Minimalism (3 references)
- Used: Spec-First Protocol (5 references)
- Used: Folder Structure (2 references)
- NOT USED: TMP context (0 references)
- NOT USED: Personal details (0 references)
- NOT USED: Quick mode (0 references)
- Signal: 3/10 sections = 30%

AGENTS.md loaded:
- Used: Core Principles (4 references)
- Used: Phase 0 guidance (8 references)
- Used: Spec-First Protocol (12 references)
- NOT USED: Phase 2-4 guidance (0 references)
- NOT USED: Session completion (0 references)
- Signal: 3/8 sections = 37.5%

Overall: 6/18 sections used = 33% signal-to-noise
Score: 1 point (20-40% efficiency)
```

**Identifies:**
- Redundancy between files (same content in CLAUDE.md and AGENTS.md)
- Sections NEVER used across ANY project (remove or relocate)
- Opportunities for context optimization (extract or compress)

## Data Saved Globally

### Compliance Data (JSON)

**Location:** `~/.claude/livespec/compliance/YYYY-MM-DD-HHMMSS-projectname.json`

**Contains:**
```json
{
  "session_id": "2025-11-10-143022-livespec",
  "project": {
    "name": "livespec",
    "path": "/home/chris/projects/livespec",
    "git_remote": "https://github.com/chrs-myrs/livespec"
  },
  "compliance": {
    "process": {
      "score": 6,
      "max": 8,
      "percentage": 75,
      "layer1_todowrite": 2,
      "layer2_validation": 1,
      "layer3_plan": 2,
      "layer4_precommit": 1
    },
    "focus": {
      "score": 9,
      "max": 13,
      "percentage": 69,
      "tool_efficiency": 4,
      "context_navigation": 2,
      "task_focus": 2,
      "context_efficiency": 1
    },
    "overall": {
      "score": 15,
      "max": 21,
      "percentage": 71,
      "level": "Good"
    }
  },
  "context_analysis": {
    "signal_to_noise": 33,
    "sections_loaded": 18,
    "sections_used": 6,
    "unused_sections": ["TMP context", "Personal details", "..."]
  },
  "timestamp": "2025-11-10T14:30:22Z"
}
```

### Feedback Data (Markdown)

**Location:** `~/.claude/livespec/feedback/YYYY-MM-DD-HHMMSS-projectname.md`

**Contains (≤10 lines):**
```markdown
# Session Feedback: livespec (2025-11-10)

## What Didn't Work Well
- TodoWrite gate bypassed for 2/5 files (Layer 1 failure)
- Context loaded late (AGENTS.md after 30% of session)

## LiveSpec Methodology Gaps
- Spec-first enforcement not obvious enough (buried in AGENTS.md)
- TodoWrite requirement unclear (should be earlier in guidance)

## Improvement Suggestions
- Move Spec-First Protocol to START section of AGENTS.md
- Add TodoWrite reminder to file creation prompts
```

## How LiveSpec Learns

**This project can analyze global data:**

1. **Read all compliance data:**
   ```bash
   ~/.claude/livespec/compliance/*.json
   ```

2. **Find common patterns:**
   - Low Layer 1 scores across projects → TodoWrite not enforced
   - Low context efficiency everywhere → Too much noise
   - Consistent Phase X issues → Phase guidance needs improvement

3. **Read all feedback:**
   ```bash
   ~/.claude/livespec/feedback/*.md
   ```

4. **Identify methodology gaps:**
   - Repeated complaints about X → Fix in methodology
   - Common confusion about Y → Clarify in AGENTS.md
   - Frequent violations of Z → Strengthen enforcement

5. **Update methodology:**
   - Improve prompts based on real usage
   - Update AGENTS.md based on context analysis
   - Strengthen structural enforcement where violations occur

**Future capability:**
- Analyze all compliance data globally
- Identify systemic issues (low scores everywhere)
- Extract best practices from high-performing sessions
- Evolve methodology based on actual usage patterns

## Examples

### Example 1: Successful Session

```
Use .livespec/prompts/utils/complete-session.md

Session Completion: Implement user authentication

Accomplishments:
- Created authentication.spec.md
- Implemented OAuth flow with tests
- All tests passing (15/15)

Compliance: 8/8 process, 12/13 focus (95% overall - Perfect)

What Went Well:
- TodoWrite used before all file creation
- Validation checks passed
- Efficient tool usage (Read/Grep only)

What Could Improve:
- Could have loaded Phase 2 sub-agent earlier
- Minor scope creep (added logging without spec)

Data saved to ~/.claude/livespec/
```

### Example 2: Session with Issues

```
Use .livespec/prompts/utils/complete-session.md

Session Completion: Add caching layer

Accomplishments:
- Implemented Redis caching
- Tests created and passing (8/8)

Compliance: 4/8 process, 7/13 focus (52% overall - Fair)

What Went Well:
- TDD followed (tests before code)
- All behaviors validated

What Could Improve:
- Skipped spec creation (created code first)
- Used Bash for file searches (should use Grep)
- Context loaded late (AGENTS.md at 50% mark)
- Low signal-to-noise (25% - loaded too much unused content)

Data saved to ~/.claude/livespec/

Recommendation: Review Spec-First Protocol before next session
```

## Reference Library

**For detailed guidance:**
- Parent: AGENTS.md (root context)
- Prompt: `.livespec/prompts/utils/complete-session.md` (full workflow)
- Spec: `specs/3-behaviors/session-completion.spec.md` (behavior definition)

**Cross-references:**
- Constitution: specs/workspace/constitution.spec.md (methodology principles)
- Workflows: specs/workspace/workflows.spec.md (session completion workflow)

---

*Session completion specialist for LiveSpec*
*Parent: AGENTS.md*
