---
implements: specs/behaviors/prompts/next-steps.spec.md
---

# Workflow Orchestrator - What To Do Next

Analyzes your project state and recommends next actions. Helpful when you're unsure where you are in the LiveSpec process or what to do next.

## When to Use This

**Use when:**
- Just starting and unsure where to begin
- Lost track of where you are in process
- Finished a phase and unsure what's next
- Returning to project after time away

**Example scenarios:**
- "I have PURPOSE.md and some code - what now?"
- "We finished design - do we implement or verify first?"
- "Our specs drifted - how do we get back on track?"

## Analysis Process

### 1. Check Current State

**Foundation:**
```bash
[ ] PURPOSE.md exists?
[ ] specs/mission/outcomes.spec.md exists?
[ ] specs/mission/constraints.spec.md exists?
[ ] specs/workspace/ exists (constitution, patterns, workflows)?
```

**Design:**
```bash
[ ] specs/architecture.spec.md exists?
[ ] specs/behaviors/ has behavior specs?
[ ] specs/contracts/ has contracts (if needed)?
```

**Implementation:**
```bash
[ ] Code exists in src/ or lib/?
[ ] Tests exist?
[ ] Implementation matches specs?
```

**Maintenance:**
```bash
[ ] When was last drift check? (git log -- specs/)
[ ] When was last code change? (git log -- src/ lib/)
[ ] Gap between spec updates and code updates?
```

### 2. Determine Current Phase

**Phase 0: DEFINE** - No foundation yet
**Phase 1: DESIGN** - Foundation exists, no architecture
**Phase 2: BUILD** - Design exists, implementing
**Phase 3: VERIFY** - Implementation done, need validation
**Phase 4: EVOLVE** - System running, maintaining sync

### 3. Identify Issues

**Blockers:**
- Missing prerequisites for next phase
- Drift detected (specs don't match code)
- Process failure (abandoned specs)

**Warnings:**
- Incomplete phase (started but not finished)
- Long gap since last update
- Missing workspace specs

## Recommended Actions

Output analysis in this format:

```markdown
# LiveSpec Status: [Project Name]

## Current State
- **Phase**: [0/1/2/3/4]
- **Status**: [Starting/In Progress/Blocked/Drifted]
- **Last Activity**: [Date from git log]

## Completed ✅
[What exists and looks good]

## Missing or Incomplete ⚠️
[What's started but not done]

## Issues Found 🔴
[Blockers or problems]

## Recommended Next Action

**Immediate:**
```

bash
claude-code "Use .livespec/[phase]/[prompt].md"
```

**Why:** [Explanation of why this is the right next step]

**Expected Output:** [What this will create]

**Time Estimate:** [How long this typically takes]

## Upcoming Milestones
1. [Next major checkpoint]
2. [Following milestone]

## Tips for Current Phase
- [Relevant advice]
- [Common pitfall to avoid]
```

## Decision Tree

### Starting from Scratch
```
No specs exist?
→ Use .livespec/0-define/0a-setup-workspace.md
```

### Foundation Incomplete
```
PURPOSE.md exists but no outcomes?
→ Use .livespec/0-define/0c-define-outcomes.md
→ Use .livespec/0-define/0d-identify-constraints.md

Complex project?
→ Consider .livespec/0-define/0e-assess-complexity.md
```

### Design Phase
```
Foundation complete but no architecture?
→ Use .livespec/1-design/1a-design-architecture.md
→ Use .livespec/1-design/1b-define-behaviors.md
→ Use .livespec/1-design/1c-create-contracts.md (if needed)
```

### Build Phase
```
Design complete but no implementation?
→ Use .livespec/2-build/2a-implement-from-specs.md
→ Use .livespec/2-build/2b-create-tests.md
```

### Verify Phase
```
Implementation done but not validated?
→ Use .livespec/3-verify/3a-run-validation.md
→ Use .livespec/3-verify/3b-acceptance-review.md
```

### Evolve Phase (Ongoing)
```
System running but specs might be drifted?
→ Use .livespec/4-evolve/4a-detect-drift.md

Code exists but no specs?
→ Use .livespec/4-evolve/4b-extract-specs.md

Drift resolved?
→ Use .livespec/4-evolve/4c-sync-complete.md
```

### Special Situations

**Specs drifted badly:**
```
→ Use .livespec/utils/analyze-failure.md
→ Follow recovery plan
→ Re-establish Phase 4 rhythm
```

**Complex project with unknowns:**
```
→ Use .livespec/0-define/0d-assess-complexity.md
→ Run spikes: .livespec/utils/run-spike.md
→ Then proceed to design
```

**Lost or confused:**
```
→ Use .livespec/utils/next-steps.md (this prompt!)
```

## Integration Tips

**For teams:**
- Run this at sprint planning to align on status
- Use when onboarding new members
- Check before major releases

**For solo developers:**
- Run after returning from break
- Use when context-switching between projects
- Check before demos or reviews

**For AI agents:**
- Ask agent to "analyze LiveSpec status and recommend next steps"
- Agent will read files and apply decision tree
- Follow agent's recommendation

## Example Outputs

### Example 1: Just Starting
```
Current Phase: 0 (DEFINE)
Status: Starting
Next: Use .livespec/0-define/0a-setup-workspace.md
Why: No specs exist yet - establish foundation first
```

### Example 2: Design Complete
```
Current Phase: 1 (DESIGN) → 2 (BUILD)
Status: Ready to implement
Next: Use .livespec/2-build/2a-implement-from-specs.md
Why: Architecture and behaviors defined, start implementation
```

### Example 3: Drift Detected
```
Current Phase: 4 (EVOLVE)
Status: Drifted (specs not updated in 6 weeks, code active)
Next: Use .livespec/4-evolve/4a-detect-drift.md
Why: Resynchronize specs with current code state
```

Remember: LiveSpec is flexible - these are guidelines, not rules. Adapt to your project's needs.
