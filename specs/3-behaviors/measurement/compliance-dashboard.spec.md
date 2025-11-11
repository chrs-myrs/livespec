---
criticality: IMPORTANT
failure_mode: Cannot track compliance trends over time, missing systemic issues and improvement opportunities
derives_from:
  - specs/workspace/constitution.spec.md
  - specs/3-behaviors/measurement/agent-compliance.spec.md
supports:
  - Process improvement decisions
  - Agent performance comparison
  - Methodology effectiveness validation
specifies:
  - scripts/generate-compliance-dashboard.sh
---

# Compliance Dashboard

## Requirements

### Aggregate Metrics Calculation

- [!] System aggregates session logs to calculate metrics
  - Local scope: From `var/compliance/` for single-project dashboard
  - Global scope: From `~/.claude/livespec/compliance/` for cross-project dashboard
  - Filtering: Can filter global logs by project name for project-specific analysis
  - Spec-first compliance rate (percentage of sessions scoring ≥6/8)
  - Average compliance score across all sessions
  - Average focus efficiency score across all sessions (out of 13 points)
  - Pre-commit pass rate (percentage passing on first attempt)
  - Layer-by-layer success rates (L1-L4 individual percentages)
  - Tool efficiency rate (percentage using correct tools)
  - Context efficiency rate (average signal-to-noise ratio across sessions)
  - TDD adoption rate (from session task analysis)
  - Per-project breakdown (global dashboard only)

### Trend Analysis

- [!] System calculates trends comparing current period to previous period
  - Percentage change indicators (↑ +X%, → stable, ↓ -X%)
  - Period definition configurable (weekly, monthly, quarterly)
  - Minimum 5 sessions required for trend calculation
  - Trend direction shown for each metric

### Compliance Target Tracking

- [!] System compares metrics against defined targets
  - Tier 1 (Critical): Spec-first ≥90%, Pre-commit 100%, MSL 100%
  - Tier 2 (Important): TDD ≥80%, TodoWrite ≥85%, Tool efficiency ≥75%, Context efficiency ≥60%
  - Tier 3 (Desirable): Context nav ≥70%, Task focus ≥75%, Plan mode ≥80%
  - Visual indicators: ✅ (meeting target), ⚠️ (within 5% of target), ❌ (below target)

### Common Failure Pattern Detection

- [!] System identifies recurring compliance issues
  - TodoWrite skip pattern: Sessions bypassing Layer 1
  - Missing spec path pattern: Plans without specific spec location
  - TDD escape hatch overuse: Frequency of justified test skips
  - Tool inefficiency pattern: Recurring Bash usage instead of specialized tools
  - Context inefficiency pattern: Signal-to-noise ratio consistently <40%
  - Minimum 3 occurrences to flag as pattern
  - Pattern includes frequency count and severity assessment

### Agent Performance Comparison

- [!] System tracks metrics by agent type when multiple agents used
  - Separate compliance scores per agent (Claude, Copilot, Cursor, etc.)
  - Session count per agent
  - Average scores comparison table
  - Performance notes highlighting strengths/weaknesses

### Project Performance Comparison (Global Dashboard Only)

- [!] System tracks metrics by project when analyzing global compliance data
  - Separate compliance scores per project
  - Session count per project
  - Average scores comparison table
  - Project-specific patterns (which projects struggle with spec-first, context efficiency, etc.)
  - Identifies best-practice projects to learn from

### Dashboard Format

- [!] System generates markdown dashboard with:
  - Header: Period, session count, files created count, scope (single project or cross-project)
  - Aggregate scores table: Metric | Current | Target | Trend
  - Layer-by-layer breakdown with percentages
  - Context efficiency analysis (avg signal-to-noise, most/least used sections)
  - Common failure patterns with counts
  - Agent comparison table (if multiple agents)
  - Project comparison table (global dashboard only)
  - Recommendations section with actionable improvements
  - Context optimization section (when avg signal-to-noise <60%)
  - Global context insights (sections NEVER used across ANY project)
  - File location: `var/compliance/dashboard-YYYY-MM.md` (local) or `~/.claude/livespec/compliance/global-dashboard-YYYY-MM.md` (global)

### Recommendation Generation

- [!] System generates actionable recommendations based on:
  - Metrics below target (prioritized by tier)
  - Negative trends (declining performance)
  - Common failure patterns (recurring issues)
  - Best practices from high-performing sessions
  - Context inefficiency patterns (sections to remove/optimize)
  - Maximum 5 recommendations ranked by impact

## Validation

- [ ] Dashboard aggregates 10+ session logs correctly
- [ ] Compliance rate calculated accurately (sessions ≥6/8 / total sessions)
- [ ] Trend calculation shows correct percentage change
- [ ] Metrics compared against targets with visual indicators
- [ ] Context efficiency calculated as average signal-to-noise ratio across sessions
- [ ] Context efficiency target ≥60% tracked with visual indicators
- [ ] Context inefficiency pattern detected when ≥3 sessions <40% signal-to-noise
- [ ] Dashboard shows most/least used context sections across sessions
- [ ] Context optimization recommendations when avg signal-to-noise <60%
- [ ] Common failure patterns detected when ≥3 occurrences
- [ ] Agent comparison table shows separate scores when multiple agents present
- [ ] Recommendations generated prioritized by tier and impact
- [ ] Dashboard markdown renders correctly with tables and formatting
- [ ] Dashboard generation fails gracefully when <5 sessions available
- [ ] Monthly dashboard archives properly in var/compliance/
