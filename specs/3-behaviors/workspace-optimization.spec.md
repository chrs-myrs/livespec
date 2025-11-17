---
criticality: IMPORTANT
failure_mode: Context organization static despite usage patterns, frequently-used content buried, rarely-used content takes prime space, context efficiency degrades over time
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md
guided-by:
  - specs/workspace/agent-contexts.spec.md
specifies:
  - dist/prompts/utils/reorganize-workspace.md
---

# Workspace Context Optimization

## Requirements

- [!] Agent analyzes context usage patterns from session data
  - Last 10-15 compliance JSON files
  - Sections referenced (hot content)
  - Sections unused (cold content)
  - Frequency calculation: Times referenced / Total sessions
  - Thresholds: Hot >70%, Warm 40-70%, Cold <40%

- [!] Agent measures current AGENTS.md structure
  - Total size vs 30-40KB target
  - Section count
  - Current START/MIDDLE/END positioning (approximate line ranges)
  - Hot sections in START? (should be)
  - Cold sections in END? (should be)

- [!] Agent identifies redundancy with CLAUDE.md
  - Same topics in both files
  - Overlap percentage estimation
  - Which file has more detail
  - Can one reference the other?
  - Redundant content in "unused" lists (remove or consolidate)

- [!] Agent detects repeated inline content
  - Patterns repeated 3+ times (template candidates)
  - Long inline examples (could be templates)
  - Verification checklists (standardize)
  - Decision matrices (extract to .livespec/templates/)
  - Calculate savings from extraction

- [!] Agent proposes section repositioning
  - Hot sections (>70%) → START
  - Warm sections (40-70%) → MIDDLE
  - Cold sections (<40%) → END
  - Critical decision points → START regardless of frequency
  - "For more info" pointers → END

- [!] Agent proposes content extractions
  - Specific template paths (.livespec/templates/agents/)
  - Current location and repetition count
  - Usage pattern (how it's referenced)
  - Estimated savings (characters/KB)
  - Impact on readability

- [!] Agent assesses compression level appropriateness
  - Current: light / moderate / aggressive (from constitution.spec.md)
  - File size vs target budget
  - Usage patterns (exploratory vs production)
  - Model context size
  - Recommendation: Keep same or change to X

- [!] Agent generates comprehensive reorganization plan
  - Usage pattern statistics (section frequencies)
  - Proposed moves (TO START, TO MIDDLE, TO END with justification)
  - Proposed extractions (template paths, savings)
  - Redundancy reduction (what to consolidate)
  - Expected outcomes (new size, efficiency improvement)
  - Implementation steps (what to do in order)

- [!] Agent asks for approval before implementing
  - Full reorganization (moves + extractions)
  - Moves only (reposition sections)
  - Extractions only (create templates)
  - Review specific section
  - Cancel (keep current)

- [!] Agent implements approved reorganization
  - Creates extraction templates in .livespec/templates/agents/
  - Updates AGENTS.md (moves sections, adds references)
  - Regenerates context tree (uses regenerate-contexts.md)
  - Validates (file sizes, cross-references)
  - Recommends monitoring (track next 5 sessions)

## Validation

**Data Requirements:**
```bash
# Need sufficient usage data
test $(ls -1 ~/.claude/livespec/compliance/*.json 2>/dev/null | wc -l) -ge 10 || echo "Need 10+ sessions"
```

**Analysis Quality:**
- [ ] Usage patterns analyzed (10+ sessions)
- [ ] Section frequencies calculated
- [ ] Hot/Warm/Cold thresholds applied
- [ ] Current positioning assessed
- [ ] Redundancy with CLAUDE.md checked
- [ ] Extraction candidates identified (3+ repetitions)
- [ ] Compression level assessed

**Plan Quality:**
- [ ] Proposed moves justified by usage data
- [ ] Hot sections (>70%) going to START
- [ ] Cold sections (<40%) going to END
- [ ] Extraction savings calculated
- [ ] Expected outcomes quantified
- [ ] Implementation steps complete

**Implementation:**
- [ ] Templates created in correct location
- [ ] AGENTS.md updated correctly
- [ ] Context tree regenerated
- [ ] File sizes within target
- [ ] Cross-references work

## Failure Mode

Without workspace optimization:
- Context efficiency degrades over time
- Frequently-used content buried deep
- Rarely-used content wastes prime space
- Repeated content bloats file size
- Signal-to-noise ratio declines
- Agent performance suffers
