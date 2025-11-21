---
implements: specs/3-artifacts/prompts/utils-regenerate-context.spec.md
phase: utilities
estimated_time: "5-10 minutes"
---

# Regenerate Agent Contexts

**Purpose**: Generate hierarchical agent context tree (AGENTS.md + ctxt/) from workspace specifications.

**When to use**:
- **⚠️ CRITICAL: Immediately after Phase 0 workspace setup** (workspace specs established)
- Workspace specs modified (constitution, patterns, workflows, agent-contexts)
- PURPOSE.md updated (project vision changed)
- New workspace spec added
- After LiveSpec version upgrade
- Switching compression levels (light ↔ moderate ↔ aggressive)

**Why after workspace setup**: Bootstrap AGENTS.md is minimal. Full context tree requires workspace specs to generate from.

**Evolution from 4d-regenerate-context**: This prompt generates full context tree (root + ctxt/ hierarchy) instead of monolithic AGENTS.md. Enables specialized agent contexts for improved focus efficiency.

---

## Instructions for AI Agent

You are regenerating the agent context tree. Launch the context-builder agent to perform the generation in isolated context.

### Step 1: Validate Prerequisites

**Check required workspace specs exist:**
```bash
ls specs/workspace/constitution.spec.md
ls specs/workspace/patterns.spec.md
ls specs/workspace/workflows.spec.md
ls specs/workspace/agent-contexts.spec.md
```

**Check required project files exist:**
```bash
ls PURPOSE.md
ls .livespec/templates/agents/spec-first-enforcement.md
```

**If ANY files missing**:
- STOP immediately
- Report what's missing
- If workspace specs missing: "Run Phase 0 (0a-quick-start or 0b-customize-workspace) first"
- If templates missing: "Copy dist/ → .livespec/ or check .livespec/ setup"
- Do NOT proceed with incomplete sources

### Step 2: Launch Context Builder Agent

**Use Task tool to launch isolated sub-agent**:
```
Launch the context-builder agent (.claude/agents/context-builder/) to generate the agent context tree from workspace specifications.

The agent will:
1. Read specs/workspace/agent-contexts.spec.md for structure
2. Read all workspace specs as source content
3. Apply compression level from constitution.spec.md
4. Generate root AGENTS.md (compressed, routing)
5. Generate ctxt/phases/ (5 phase specialists)
6. Generate ctxt/domains/ (based on taxonomy)
7. Generate ctxt/utils/ (3 utility specialists)
8. Validate size budgets
9. Report results

Expected outputs:
- AGENTS.md (20-30KB, no frontmatter)
- ctxt/phases/*.md (5 files, 8-12KB each)
- ctxt/domains/*.md (1-3 files, 6-10KB each)
- ctxt/utils/*.md (3 files, 6-10KB each)

Total context tree: <150KB
Typical loaded context: <50KB (root + 1-2 sub-agents)
```

**Agent parameters**:
- subagent_type: "general-purpose" (or "Explore" if context-builder not yet registered)
- model: "sonnet" (context generation requires reasoning)
- description: "Generate agent context tree"

### Step 3: Receive Results

**Context builder agent will report**:
- Files generated with sizes
- Total context tree size
- Typical loaded context size
- Compression level applied
- Validation status

**Review output**:
- [ ] Root AGENTS.md exists (20-30KB)
- [ ] ctxt/phases/ contains 5 files
- [ ] ctxt/domains/ contains domain-specific files
- [ ] ctxt/utils/ contains 3 utility files
- [ ] Total tree <150KB
- [ ] All files have proper edit warnings

### Step 4: Validation

**Check structure**:
```bash
ls -lh AGENTS.md
ls -lh ctxt/phases/*.md
ls -lh ctxt/domains/*.md
ls -lh ctxt/utils/*.md
```

**Verify root AGENTS.md**:
- [ ] NO frontmatter (clean context)
- [ ] Inline edit warning present
- [ ] Contains "When to Load Sub-Agents" section
- [ ] Load triggers for all phases/domains/utils
- [ ] Size 20-30KB

**Verify sub-agents** (spot-check 2-3 files):
- [ ] Frontmatter complete (generated, parent, applies_to, load_triggers, etc.)
- [ ] Edit warning in frontmatter (not body)
- [ ] References parent: AGENTS.md
- [ ] Has load_triggers list
- [ ] Links to .livespec/ detailed specs

### Step 5: Test Proactive Loading (Optional)

**To verify context tree works**:
1. Start fresh Claude Code session
2. User message: "I need to write tests for the authentication module"
3. Expected behavior:
   - Agent reads root AGENTS.md
   - Agent sees "tests" matches Phase 2 load trigger
   - Agent loads ctxt/phases/2-build.md
   - Agent provides TDD guidance
4. User doesn't need to know ctxt/ exists (proactive, transparent)

**If agent doesn't load context**:
- Check load_triggers in ctxt/phases/2-build.md frontmatter
- Check "When to Load Sub-Agents" section in root AGENTS.md
- Verify triggers are intuitive keywords users naturally use

### Step 6: Commit

**If generation successful**:
```bash
git add AGENTS.md ctxt/
git commit -m "Generate agent context tree from workspace specs

Context tree structure:
- Root AGENTS.md (routing, compressed)
- ctxt/phases/ (5 phase specialists)
- ctxt/domains/ (domain-specific patterns)
- ctxt/utils/ (3 utility specialists)

Enables proactive context loading for improved focus efficiency.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

## Common Issues

**"Workspace specs missing"**:
- Run Phase 0 first (0a-quick-start or 0b-customize-workspace)
- Workspace specs must exist to generate from

**"Templates missing"**:
- Copy dist/ → .livespec/
- Specifically need .livespec/templates/agents/spec-first-enforcement.md

**"Context builder agent not found"**:
- Verify .claude/agents/context-builder/instructions.md exists
- If missing, this is a LiveSpec installation issue

**"Generated files too large"**:
- Check compression level in constitution.spec.md frontmatter
- Consider switching to aggressive compression
- Review for redundancy in workspace specs

**"Load triggers not working"**:
- Check keywords in sub-agent frontmatter (load_triggers)
- Verify "When to Load Sub-Agents" section in root matches
- Test with natural user language, not technical terms

---

## Notes

**Relation to 4d-regenerate-context**:
- Old: Generates monolithic AGENTS.md (~50-60KB)
- New: Generates context tree (root + ctxt/) for specialized loading
- Both read same workspace specs as source
- Context tree enables better focus efficiency

**Frequency**:
- Run after workspace changes (like 4d-regenerate-context)
- Also run when compression level changes
- Run if context tree feels stale or misaligned

**Distribution**:
- dist/AGENTS.md = Bootstrap (minimal, instructs to run this)
- Project AGENTS.md + ctxt/ = Generated locally from workspace
- ctxt/ NOT distributed (generated per-project like AGENTS.md)

**Agent isolation**:
- Context builder runs as sub-agent (doesn't pollute session)
- Parent session stays focused on user's task
- Generation happens in isolated context bubble

---

## Success Criteria

- Root AGENTS.md compressed to 20-30KB
- Full context tree generated (<150KB total)
- All sub-agents have complete frontmatter
- Load triggers functional (clear keyword patterns)
- Proactive loading works (agent loads without user managing)
- Commit successful with all generated files
- Agent guidance improved (more focused, less context overload)
