#!/bin/bash
# Generates compliance dashboard from session logs
# Usage: bash scripts/generate-compliance-dashboard.sh [period]
# Period: weekly, monthly (default), quarterly

set -euo pipefail

# Colors for output
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default period
PERIOD="${1:-monthly}"

# Determine date range based on period
case "$PERIOD" in
    "weekly")
        START_DATE=$(date -d "7 days ago" +%Y-%m-%d)
        PERIOD_LABEL="Weekly"
        ;;
    "monthly")
        START_DATE=$(date -d "30 days ago" +%Y-%m-%d)
        PERIOD_LABEL="Monthly"
        ;;
    "quarterly")
        START_DATE=$(date -d "90 days ago" +%Y-%m-%d)
        PERIOD_LABEL="Quarterly"
        ;;
    *)
        echo "Unknown period: $PERIOD (use: weekly, monthly, quarterly)"
        exit 1
        ;;
esac

DASHBOARD_DATE=$(date +%Y-%m)
DASHBOARD_FILE="var/compliance/dashboard-${DASHBOARD_DATE}.md"

# Create compliance directory if it doesn't exist
mkdir -p var/compliance

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required for dashboard generation"
    echo "Install with: sudo apt-get install jq"
    exit 1
fi

echo -e "${BLUE}Generating ${PERIOD_LABEL} Compliance Dashboard...${NC}"

# Find all session logs in period
SESSION_LOGS=($(find var/compliance -name "session-*.json" -type f 2>/dev/null | sort || echo ""))

if [ ${#SESSION_LOGS[@]} -eq 0 ]; then
    echo "No session logs found in var/compliance/"
    echo "Create session logs using dist/prompts/utils/measure-session-compliance.md"
    exit 1
fi

# Filter sessions by date
FILTERED_SESSIONS=()
for log in "${SESSION_LOGS[@]}"; do
    if [ -f "$log" ]; then
        SESSION_DATE=$(jq -r '.session_id // empty' "$log" | cut -d'-' -f1-3)
        if [[ "$SESSION_DATE" > "$START_DATE" ]] || [[ "$SESSION_DATE" == "$START_DATE" ]]; then
            FILTERED_SESSIONS+=("$log")
        fi
    fi
done

SESSION_COUNT=${#FILTERED_SESSIONS[@]}

if [ "$SESSION_COUNT" -lt 5 ]; then
    echo "Warning: Only $SESSION_COUNT sessions found. Minimum 5 recommended for trends."
fi

echo "Processing $SESSION_COUNT session logs..."

# Initialize counters
TOTAL_PROCESS=0
TOTAL_FOCUS=0
TOTAL_OVERALL=0
FILES_CREATED=0

# Layer counters
L1_TOTAL=0
L1_MAX=0
L2_TOTAL=0
L2_MAX=0
L3_TOTAL=0
L3_MAX=0
L4_TOTAL=0
L4_MAX=0

# Focus dimension counters
TOOL_TOTAL=0
TOOL_MAX=0
CONTEXT_TOTAL=0
CONTEXT_MAX=0
TASK_TOTAL=0
TASK_MAX=0

# Compliance level counters
PERFECT_COUNT=0
GOOD_COUNT=0
FAIR_COUNT=0
POOR_COUNT=0

# Agent tracking
declare -A AGENT_SESSIONS
declare -A AGENT_COMPLIANCE
declare -A AGENT_FOCUS

# Failure pattern tracking
declare -A FAILURE_PATTERNS

# Process each session log
for log in "${FILTERED_SESSIONS[@]}"; do
    # Extract scores (convert to integers to handle any decimal values)
    PROCESS=$(jq -r '.scores.process_compliance // 0' "$log" | awk '{printf "%.0f", $1}')
    FOCUS=$(jq -r '.scores.focus_efficiency // 0' "$log" | awk '{printf "%.0f", $1}')
    OVERALL=$(jq -r '.scores.overall_percentage // 0' "$log" | awk '{printf "%.0f", $1}')
    LEVEL=$(jq -r '.compliance_level // "unknown"' "$log")
    AGENT=$(jq -r '.agent // "unknown"' "$log")

    # Accumulate totals
    TOTAL_PROCESS=$((TOTAL_PROCESS + PROCESS))
    TOTAL_FOCUS=$((TOTAL_FOCUS + FOCUS))
    TOTAL_OVERALL=$((TOTAL_OVERALL + OVERALL))

    # Count files created
    FILE_COUNT=$(jq -r '.files_created | length // 0' "$log")
    FILES_CREATED=$((FILES_CREATED + FILE_COUNT))

    # Layer scores
    L1=$(jq -r '.layers.todowrite_gate // 0' "$log" | awk '{printf "%.0f", $1}')
    L2=$(jq -r '.layers.validation_check // 0' "$log" | awk '{printf "%.0f", $1}')
    L3=$(jq -r '.layers.plan_mode // 0' "$log" | awk '{printf "%.0f", $1}')
    L4=$(jq -r '.layers.precommit // 0' "$log" | awk '{printf "%.0f", $1}')

    L1_TOTAL=$((L1_TOTAL + L1))
    L1_MAX=$((L1_MAX + 2))
    L2_TOTAL=$((L2_TOTAL + L2))
    L2_MAX=$((L2_MAX + 2))
    L3_TOTAL=$((L3_TOTAL + L3))
    L3_MAX=$((L3_MAX + 3))
    L4_TOTAL=$((L4_TOTAL + L4))
    L4_MAX=$((L4_MAX + 1))

    # Focus dimensions
    TOOL=$(jq -r '.focus.tool_efficiency // 0' "$log" | awk '{printf "%.0f", $1}')
    CONTEXT=$(jq -r '.focus.context_navigation // 0' "$log" | awk '{printf "%.0f", $1}')
    TASK=$(jq -r '.focus.task_focus // 0' "$log" | awk '{printf "%.0f", $1}')

    TOOL_TOTAL=$((TOOL_TOTAL + TOOL))
    TOOL_MAX=$((TOOL_MAX + 5))
    CONTEXT_TOTAL=$((CONTEXT_TOTAL + CONTEXT))
    CONTEXT_MAX=$((CONTEXT_MAX + 3))
    TASK_TOTAL=$((TASK_TOTAL + TASK))
    TASK_MAX=$((TASK_MAX + 2))

    # Compliance levels
    case "$LEVEL" in
        "Perfect") PERFECT_COUNT=$((PERFECT_COUNT + 1)) ;;
        "Good") GOOD_COUNT=$((GOOD_COUNT + 1)) ;;
        "Fair") FAIR_COUNT=$((FAIR_COUNT + 1)) ;;
        "Poor") POOR_COUNT=$((POOR_COUNT + 1)) ;;
    esac

    # Agent tracking
    if [ -n "$AGENT" ] && [ "$AGENT" != "unknown" ]; then
        AGENT_SESSIONS["$AGENT"]=$((${AGENT_SESSIONS["$AGENT"]:-0} + 1))
        AGENT_COMPLIANCE["$AGENT"]=$((${AGENT_COMPLIANCE["$AGENT"]:-0} + PROCESS))
        AGENT_FOCUS["$AGENT"]=$((${AGENT_FOCUS["$AGENT"]:-0} + FOCUS))
    fi

    # Failure pattern detection
    if [ "$L1" -lt 2 ]; then
        FAILURE_PATTERNS["TodoWrite skip"]=$((${FAILURE_PATTERNS["TodoWrite skip"]:-0} + 1))
    fi
    if [ "$L2" -lt 2 ]; then
        FAILURE_PATTERNS["Validation check skip"]=$((${FAILURE_PATTERNS["Validation check skip"]:-0} + 1))
    fi
    if [ "$L3" -lt 2 ]; then
        FAILURE_PATTERNS["Missing spec path in plan"]=$((${FAILURE_PATTERNS["Missing spec path in plan"]:-0} + 1))
    fi
    if [ "$L4" -lt 1 ]; then
        FAILURE_PATTERNS["Pre-commit failure"]=$((${FAILURE_PATTERNS["Pre-commit failure"]:-0} + 1))
    fi
done

# Calculate averages
AVG_PROCESS=$((TOTAL_PROCESS / SESSION_COUNT))
AVG_FOCUS=$((TOTAL_FOCUS / SESSION_COUNT))
AVG_OVERALL=$((TOTAL_OVERALL / SESSION_COUNT))

# Calculate percentages
L1_PCT=$((L1_TOTAL * 100 / L1_MAX))
L2_PCT=$((L2_TOTAL * 100 / L2_MAX))
L3_PCT=$((L3_TOTAL * 100 / L3_MAX))
L4_PCT=$((L4_TOTAL * 100 / L4_MAX))

TOOL_PCT=$((TOOL_TOTAL * 100 / TOOL_MAX))
CONTEXT_PCT=$((CONTEXT_TOTAL * 100 / CONTEXT_MAX))
TASK_PCT=$((TASK_TOTAL * 100 / TASK_MAX))

# Calculate spec-first compliance rate (sessions scoring ≥6/8)
SPEC_FIRST_COMPLIANT=0
for log in "${FILTERED_SESSIONS[@]}"; do
    PROCESS=$(jq -r '.scores.process_compliance // 0' "$log" | awk '{printf "%.0f", $1}')
    if [ "$PROCESS" -ge 6 ]; then
        SPEC_FIRST_COMPLIANT=$((SPEC_FIRST_COMPLIANT + 1))
    fi
done
SPEC_FIRST_RATE=$((SPEC_FIRST_COMPLIANT * 100 / SESSION_COUNT))

# Generate dashboard
cat > "$DASHBOARD_FILE" <<EOF
# LiveSpec Compliance Dashboard

**Period**: $PERIOD_LABEL ($(date +%Y-%m-%d))
**Sessions Analyzed**: $SESSION_COUNT
**Files Created**: $FILES_CREATED

---

## Aggregate Scores

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Spec-first compliance | ${SPEC_FIRST_RATE}% | 90% | $([ "$SPEC_FIRST_RATE" -ge 90 ] && echo "✅" || ([ "$SPEC_FIRST_RATE" -ge 85 ] && echo "⚠️" || echo "❌")) |
| Avg process compliance | ${AVG_PROCESS}/8 ($(( AVG_PROCESS * 100 / 8 ))%) | 6/8 (75%) | $([ "$AVG_PROCESS" -ge 6 ] && echo "✅" || echo "⚠️") |
| Avg focus efficiency | ${AVG_FOCUS}/10 ($(( AVG_FOCUS * 100 / 10 ))%) | 8/10 (80%) | $([ "$AVG_FOCUS" -ge 8 ] && echo "✅" || echo "⚠️") |
| Pre-commit pass rate | ${L4_PCT}% | 95% | $([ "$L4_PCT" -ge 95 ] && echo "✅" || ([ "$L4_PCT" -ge 90 ] && echo "⚠️" || echo "❌")) |
| Tool efficiency | ${TOOL_PCT}% | 75% | $([ "$TOOL_PCT" -ge 75 ] && echo "✅" || echo "⚠️") |
| Context navigation | ${CONTEXT_PCT}% | 70% | $([ "$CONTEXT_PCT" -ge 70 ] && echo "✅" || echo "⚠️") |

---

## Layer-by-Layer Breakdown

**Layer 1 (TodoWrite Gate): ${L1_PCT}%**
- ${L1_TOTAL}/${L1_MAX} points earned
- $([ "$L1_PCT" -ge 85 ] && echo "✅ Strong compliance" || echo "⚠️ Improvement needed")

**Layer 2 (Validation Check): ${L2_PCT}%**
- ${L2_TOTAL}/${L2_MAX} points earned
- $([ "$L2_PCT" -ge 85 ] && echo "✅ Strong compliance" || echo "⚠️ Improvement needed")

**Layer 3 (Plan Mode): ${L3_PCT}%**
- ${L3_TOTAL}/${L3_MAX} points earned
- $([ "$L3_PCT" -ge 80 ] && echo "✅ Strong compliance" || echo "⚠️ Improvement needed")

**Layer 4 (Pre-commit): ${L4_PCT}%**
- ${L4_TOTAL}/${L4_MAX} points earned
- $([ "$L4_PCT" -ge 95 ] && echo "✅ Strong compliance" || echo "❌ Needs attention")

---

## Compliance Distribution

| Level | Count | Percentage |
|-------|-------|------------|
| Perfect (100%) | $PERFECT_COUNT | $(( PERFECT_COUNT * 100 / SESSION_COUNT ))% |
| Good (75-99%) | $GOOD_COUNT | $(( GOOD_COUNT * 100 / SESSION_COUNT ))% |
| Fair (50-74%) | $FAIR_COUNT | $(( FAIR_COUNT * 100 / SESSION_COUNT ))% |
| Poor (<50%) | $POOR_COUNT | $(( POOR_COUNT * 100 / SESSION_COUNT ))% |

---

## Common Failure Patterns

EOF

# Add failure patterns if any detected
PATTERN_FOUND=false
for pattern in "${!FAILURE_PATTERNS[@]}"; do
    count=${FAILURE_PATTERNS[$pattern]}
    if [ "$count" -ge 3 ]; then
        PATTERN_FOUND=true
        cat >> "$DASHBOARD_FILE" <<EOF
**$pattern** ($count occurrences)
- Severity: $([ "$count" -ge 10 ] && echo "High" || ([ "$count" -ge 5 ] && echo "Medium" || echo "Low"))
- Impact: $([ "$pattern" == "TodoWrite skip" ] && echo "Bypasses Layer 1 spec-first gate" || echo "Reduces process compliance")

EOF
    fi
done

if [ "$PATTERN_FOUND" = false ]; then
    echo "No significant patterns detected (minimum 3 occurrences required)." >> "$DASHBOARD_FILE"
    echo "" >> "$DASHBOARD_FILE"
fi

cat >> "$DASHBOARD_FILE" <<EOF
---

## Agent Performance Comparison

EOF

if [ ${#AGENT_SESSIONS[@]} -gt 0 ]; then
    cat >> "$DASHBOARD_FILE" <<EOF
| Agent | Sessions | Avg Compliance | Avg Focus | Notes |
|-------|----------|----------------|-----------|-------|
EOF

    for agent in "${!AGENT_SESSIONS[@]}"; do
        sessions=${AGENT_SESSIONS[$agent]}
        compliance_avg=$(( AGENT_COMPLIANCE[$agent] / sessions ))
        focus_avg=$(( AGENT_FOCUS[$agent] / sessions ))
        compliance_pct=$(( compliance_avg * 100 / 8 ))
        focus_pct=$(( focus_avg * 100 / 10 ))

        notes=""
        [ "$compliance_pct" -ge 90 ] && notes="Excellent process adherence"
        [ "$focus_pct" -ge 85 ] && notes="$notes, Strong focus"
        [ "$compliance_pct" -lt 75 ] && notes="Needs improvement"
        [ -z "$notes" ] && notes="Good performance"

        echo "| $agent | $sessions | ${compliance_avg}/8 (${compliance_pct}%) | ${focus_avg}/10 (${focus_pct}%) | $notes |" >> "$DASHBOARD_FILE"
    done
else
    echo "Single agent tracked across all sessions." >> "$DASHBOARD_FILE"
fi

cat >> "$DASHBOARD_FILE" <<EOF

---

## Recommendations

EOF

# Generate recommendations based on metrics
RECS=()

if [ "$SPEC_FIRST_RATE" -lt 90 ]; then
    RECS+=("**Increase spec-first compliance** (current: ${SPEC_FIRST_RATE}%, target: 90%) - Emphasize Layer 1-3 in AGENTS.md")
fi

if [ "$L1_PCT" -lt 85 ]; then
    RECS+=("**Strengthen TodoWrite gate usage** (current: ${L1_PCT}%) - Add TodoWrite reminder to prompt templates")
fi

if [ "$L4_PCT" -lt 95 ]; then
    RECS+=("**Improve pre-commit pass rate** (current: ${L4_PCT}%, target: 95%) - Review common validation failures")
fi

if [ "$TOOL_PCT" -lt 75 ]; then
    RECS+=("**Optimize tool efficiency** (current: ${TOOL_PCT}%, target: 75%) - Train agents on specialized tools")
fi

if [ "$CONTEXT_PCT" -lt 70 ]; then
    RECS+=("**Enhance context navigation** (current: ${CONTEXT_PCT}%, target: 70%) - Improve AGENTS.md structure")
fi

if [ ${#RECS[@]} -eq 0 ]; then
    echo "✅ All metrics meeting targets. Maintain current practices!" >> "$DASHBOARD_FILE"
else
    for i in "${!RECS[@]}"; do
        echo "$((i + 1)). ${RECS[$i]}" >> "$DASHBOARD_FILE"
    done
fi

cat >> "$DASHBOARD_FILE" <<EOF

---

## Next Steps

- Review session logs in \`var/compliance/\` for detailed analysis
- Use \`dist/prompts/utils/measure-session-compliance.md\` for new sessions
- Run \`bash scripts/measure-agent-compliance.sh <session-log>\` for individual reports
- Update AGENTS.md if patterns suggest guidance improvements

---

*Generated $(date +"%Y-%m-%d %H:%M:%S") from $SESSION_COUNT session logs*
EOF

echo -e "${BLUE}Dashboard generated: $DASHBOARD_FILE${NC}"
echo ""
echo "Summary:"
echo "- Spec-first compliance: ${SPEC_FIRST_RATE}%"
echo "- Average process score: ${AVG_PROCESS}/8"
echo "- Average focus score: ${AVG_FOCUS}/10"
echo "- Sessions analyzed: $SESSION_COUNT"
