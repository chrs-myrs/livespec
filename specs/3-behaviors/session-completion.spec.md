---
criticality: IMPORTANT
failure_mode: Sessions continue indefinitely without analysis, missing learning opportunities and context optimization
satisfies:
  - specs/1-requirements/strategic/outcomes.spec.md (Requirement 6: Sustainable Evolution - feedback loop)
derives_from:
  - specs/workspace/constitution.spec.md
supports:
  - Continuous methodology improvement
  - Agent performance tracking
  - Context optimization
  - Session hygiene (fresh context per task)
specifies:
  - dist/prompts/utils/complete-session.md
---

# Session Completion Analysis

## Requirements

### Session End Detection

- [!] Agent eagerly detects when session should end
  - Task completed successfully (all todos done)
  - Context approaching 100K tokens (50% of 200K budget)
  - Natural stopping point (ready to commit, switching tasks)
  - User appears stuck (suggest break + fresh session)
  - Agent recommends completion proactively, not waiting for user request

### Unified Analysis

- [!] Agent performs single integrated analysis combining compliance measurement, learning capture, and methodology feedback
  - Process compliance scoring (4-layer spec-first enforcement, 0-8 points)
  - Focus efficiency scoring (4 dimensions including context signal-to-noise, 0-13 points)
  - Session learning capture (corrections, clarifications, patterns, spec updates needed)
  - Accomplishment summary (what was completed)
  - Success assessment (what went well)
  - Improvement opportunities (what could be better, concise)
  - LiveSpec methodology feedback (what guidance was unclear, missing, or unhelpful)

### Session Learning Capture

- [!] Agent scans current session to extract actionable insights
  - Corrections made (mistaken assumptions, misunderstandings clarified, wrong approaches abandoned)
  - Clarifications user provided (requirements refined, scope adjusted, ambiguities resolved)
  - Patterns that emerged (repeated issues, new conventions, workflow improvements)
  - Specs needing updates (workspace specs for process changes, behavior specs for requirement changes, contract specs for interface changes)
  - Specific to THIS session only (not cross-session pattern analysis)
  - Both project-specific learnings (update project specs) and methodology learnings (improve LiveSpec framework)
  - If no learnings identified, skip learnings section in report (perfectly acceptable)

### User Report

- [!] Agent shows concise session summary to user immediately
  - Accomplishments (bullet list)
  - Compliance scores (X/8 process, X/13 focus, percentage)
  - Session learnings (if any captured: key insights, specs to update)
  - Highlights (2-3 things that went well)
  - Improvements (2-3 specific suggestions, actionable)
  - Maximum 15 lines total (concise)

### Global Data Storage

- [!] Agent writes two files to `~/.claude/livespec/` directory
  - Compliance data: `compliance/YYYY-MM-DD-HHMMSS-projectname.json` (structured metrics)
  - Feedback report: `feedback/YYYY-MM-DD-HHMMSS-projectname.md` (concise markdown, max 10 lines)
  - Directories created automatically if don't exist
  - Project name detected from git remote or directory name
  - Silent failure if write fails (show report regardless)

### Compliance JSON Structure

- [!] Structured compliance data captures quantitative metrics
  - Session metadata (ID, timestamps, agent, task, project)
  - Scores (process compliance, focus efficiency, overall percentage)
  - Layer breakdown (TodoWrite gate, validation check, plan mode, pre-commit)
  - Focus dimensions (tool efficiency, context navigation, task focus, context efficiency)
  - Context analysis (tokens loaded, sections referenced, sections unused, signal-to-noise ratio, redundant content)
  - Files created (list of permanent files)
  - Compliance level (Perfect/Good/Fair/Poor)

### Feedback Markdown Structure

- [!] Concise feedback captures qualitative insights
  - Maximum 10 lines total
  - What didn't work well (specific examples)
  - LiveSpec guidance gaps (what was unclear or missing)
  - Methodology improvement suggestions (concrete)
  - No praise or success content (JSON has scores, markdown is for learning)

### Fresh Session Encouragement

- [!] Agent encourages starting fresh session after completion
  - Explains benefits of fresh context (reduced cognitive load, better focus)
  - Suggests committing work before ending
  - Mentions compliance data saved for future analysis
  - Positive framing (completion is success, not failure)

## Validation

- [ ] Agent detects task completion and recommends analysis
- [ ] Agent detects context approaching 100K tokens and recommends completion
- [ ] Agent detects natural stopping point and suggests analysis
- [ ] Agent scans session for learnings (corrections, clarifications, patterns, spec updates)
- [ ] User report shows accomplishments, scores, learnings (if any), highlights, improvements in ≤15 lines
- [ ] Compliance JSON written to ~/.claude/livespec/compliance/ with correct structure
- [ ] Feedback markdown written to ~/.claude/livespec/feedback/ in ≤10 lines
- [ ] Directories created automatically if missing
- [ ] Project name detected from git remote or directory
- [ ] Session completes gracefully if file write fails
- [ ] Process compliance scored correctly (0-8 points)
- [ ] Focus efficiency scored correctly (0-13 points including context efficiency)
- [ ] Signal-to-noise ratio calculated (sections used / total sections)
- [ ] Context analysis identifies redundant content between CLAUDE.md and AGENTS.md
- [ ] Feedback focuses on what didn't work (no praise)
- [ ] Agent encourages fresh session after completion
