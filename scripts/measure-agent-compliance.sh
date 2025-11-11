#!/bin/bash
# Measures agent compliance from session log JSON
# Usage: bash scripts/measure-agent-compliance.sh var/compliance/session-*.json

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if session log provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No session log provided${NC}"
    echo "Usage: bash scripts/measure-agent-compliance.sh var/compliance/session-*.json"
    exit 1
fi

SESSION_LOG="$1"

# Check if file exists
if [ ! -f "$SESSION_LOG" ]; then
    echo -e "${RED}Error: Session log not found: $SESSION_LOG${NC}"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}Warning: jq not installed. Install with: sudo apt-get install jq${NC}"
    echo "Falling back to basic parsing..."
    USE_JQ=false
else
    USE_JQ=true
fi

echo -e "${BLUE}=== Agent Compliance Report ===${NC}"
echo ""

# Parse session metadata
if [ "$USE_JQ" = true ]; then
    SESSION_ID=$(jq -r '.session_id // "unknown"' "$SESSION_LOG")
    AGENT=$(jq -r '.agent // "unknown"' "$SESSION_LOG")
    TASK=$(jq -r '.task // "No description"' "$SESSION_LOG")
    START_TIME=$(jq -r '.start_time // "unknown"' "$SESSION_LOG")
    END_TIME=$(jq -r '.end_time // "unknown"' "$SESSION_LOG")

    # Extract scores
    PROCESS_SCORE=$(jq -r '.scores.process_compliance // 0' "$SESSION_LOG")
    FOCUS_SCORE=$(jq -r '.scores.focus_efficiency // 0' "$SESSION_LOG")
    OVERALL_PCT=$(jq -r '.scores.overall_percentage // 0' "$SESSION_LOG")
    COMPLIANCE_LEVEL=$(jq -r '.compliance_level // "unknown"' "$SESSION_LOG")

    # Extract layer scores
    L1_SCORE=$(jq -r '.layers.todowrite_gate // 0' "$SESSION_LOG")
    L2_SCORE=$(jq -r '.layers.validation_check // 0' "$SESSION_LOG")
    L3_SCORE=$(jq -r '.layers.plan_mode // 0' "$SESSION_LOG")
    L4_SCORE=$(jq -r '.layers.precommit // 0' "$SESSION_LOG")

    # Extract focus dimension scores
    TOOL_SCORE=$(jq -r '.focus.tool_efficiency // 0' "$SESSION_LOG")
    CONTEXT_SCORE=$(jq -r '.focus.context_navigation // 0' "$SESSION_LOG")
    TASK_SCORE=$(jq -r '.focus.task_focus // 0' "$SESSION_LOG")

    # Extract file list
    FILES_CREATED=$(jq -r '.files_created[]? // empty' "$SESSION_LOG" | tr '\n' ', ' | sed 's/,$//')
else
    # Basic grep-based parsing (fallback)
    SESSION_ID=$(grep -oP '"session_id"\s*:\s*"\K[^"]+' "$SESSION_LOG" || echo "unknown")
    AGENT=$(grep -oP '"agent"\s*:\s*"\K[^"]+' "$SESSION_LOG" || echo "unknown")
    TASK=$(grep -oP '"task"\s*:\s*"\K[^"]+' "$SESSION_LOG" || echo "No description")
    PROCESS_SCORE=$(grep -oP '"process_compliance"\s*:\s*\K[0-9]+' "$SESSION_LOG" || echo "0")
    FOCUS_SCORE=$(grep -oP '"focus_efficiency"\s*:\s*\K[0-9]+' "$SESSION_LOG" || echo "0")
    OVERALL_PCT=$(grep -oP '"overall_percentage"\s*:\s*\K[0-9]+' "$SESSION_LOG" || echo "0")
    COMPLIANCE_LEVEL=$(grep -oP '"compliance_level"\s*:\s*"\K[^"]+' "$SESSION_LOG" || echo "unknown")
fi

# Display session info
echo "Session: $SESSION_ID"
echo "Agent: $AGENT"
echo "Task: $TASK"
if [ "$USE_JQ" = true ]; then
    echo "Duration: $START_TIME to $END_TIME"
    if [ -n "$FILES_CREATED" ]; then
        echo "Files Created: $FILES_CREATED"
    fi
fi
echo ""

# Calculate compliance percentage
PROCESS_PCT=$((PROCESS_SCORE * 100 / 8))

# Determine compliance level color
case "$COMPLIANCE_LEVEL" in
    "Perfect")
        LEVEL_COLOR=$GREEN
        ;;
    "Good")
        LEVEL_COLOR=$BLUE
        ;;
    "Fair")
        LEVEL_COLOR=$YELLOW
        ;;
    "Poor")
        LEVEL_COLOR=$RED
        ;;
    *)
        LEVEL_COLOR=$NC
        ;;
esac

echo -e "Compliance Level: ${LEVEL_COLOR}${COMPLIANCE_LEVEL} (${OVERALL_PCT}%)${NC}"
echo ""

# Process Compliance Section
echo -e "${BLUE}## Process Compliance: $PROCESS_SCORE/8 (${PROCESS_PCT}%)${NC}"
echo ""

# Layer 1
if [ "$L1_SCORE" -eq 2 ]; then
    echo -e "${GREEN}✅${NC} Layer 1: TodoWrite Gate (2/2)"
elif [ "$L1_SCORE" -eq 1 ]; then
    echo -e "${YELLOW}⚠️${NC} Layer 1: TodoWrite Gate (1/2)"
else
    echo -e "${RED}❌${NC} Layer 1: TodoWrite Gate (0/2)"
fi

# Layer 2
if [ "$L2_SCORE" -eq 2 ]; then
    echo -e "${GREEN}✅${NC} Layer 2: Validation Check (2/2)"
elif [ "$L2_SCORE" -eq 1 ]; then
    echo -e "${YELLOW}⚠️${NC} Layer 2: Validation Check (1/2)"
else
    echo -e "${RED}❌${NC} Layer 2: Validation Check (0/2)"
fi

# Layer 3
if [ "$L3_SCORE" -eq 3 ]; then
    echo -e "${GREEN}✅${NC} Layer 3: Plan Mode (3/3)"
elif [ "$L3_SCORE" -ge 1 ]; then
    echo -e "${YELLOW}⚠️${NC} Layer 3: Plan Mode ($L3_SCORE/3)"
else
    echo -e "${RED}❌${NC} Layer 3: Plan Mode (0/3)"
fi

# Layer 4
if [ "$L4_SCORE" -eq 1 ]; then
    echo -e "${GREEN}✅${NC} Layer 4: Pre-commit (1/1)"
else
    echo -e "${RED}❌${NC} Layer 4: Pre-commit (0/1)"
fi

echo ""

# Focus Efficiency Section
if [ "$USE_JQ" = true ]; then
    FOCUS_PCT=$((FOCUS_SCORE * 100 / 10))
    echo -e "${BLUE}## Focus Efficiency: $FOCUS_SCORE/10 (${FOCUS_PCT}%)${NC}"
    echo ""

    echo "- Tool Efficiency: $TOOL_SCORE/5"
    echo "- Context Navigation: $CONTEXT_SCORE/3"
    echo "- Task Focus: $TASK_SCORE/2"
    echo ""
fi

# Summary
echo -e "${BLUE}## Summary${NC}"
echo ""

if [ "$OVERALL_PCT" -ge 90 ]; then
    echo -e "${GREEN}Excellent compliance!${NC} Agent followed spec-first protocol effectively."
elif [ "$OVERALL_PCT" -ge 75 ]; then
    echo -e "${BLUE}Good compliance.${NC} Minor improvements possible."
elif [ "$OVERALL_PCT" -ge 50 ]; then
    echo -e "${YELLOW}Fair compliance.${NC} Significant gaps in spec-first adherence."
else
    echo -e "${RED}Poor compliance.${NC} Spec-first protocol mostly bypassed."
fi

# Recommendations
echo ""
echo -e "${BLUE}## Recommendations${NC}"
echo ""

RECOMMENDATIONS=()

if [ "$L1_SCORE" -lt 2 ]; then
    RECOMMENDATIONS+=("- Use TodoWrite BEFORE creating permanent files (Layer 1 gap)")
fi

if [ "$L2_SCORE" -lt 2 ]; then
    RECOMMENDATIONS+=("- Run check-requires-spec.sh validation (Layer 2 gap)")
fi

if [ "$L3_SCORE" -lt 2 ]; then
    RECOMMENDATIONS+=("- Present plan with explicit spec creation step (Layer 3 gap)")
fi

if [ "$L4_SCORE" -lt 1 ]; then
    RECOMMENDATIONS+=("- Ensure commits pass pre-commit validation (Layer 4 gap)")
fi

if [ "$USE_JQ" = true ]; then
    if [ "$TOOL_SCORE" -lt 3 ]; then
        RECOMMENDATIONS+=("- Use specialized tools (Read/Grep/Glob) instead of Bash (Tool efficiency)")
    fi

    if [ "$CONTEXT_SCORE" -lt 2 ]; then
        RECOMMENDATIONS+=("- Reference AGENTS.md before fetching full prompts (Context navigation)")
    fi

    if [ "$TASK_SCORE" -lt 1 ]; then
        RECOMMENDATIONS+=("- Stay focused on original task, avoid scope creep (Task focus)")
    fi
fi

if [ ${#RECOMMENDATIONS[@]} -eq 0 ]; then
    echo "No significant issues identified. Maintain current practices!"
else
    for rec in "${RECOMMENDATIONS[@]}"; do
        echo "$rec"
    done
fi

echo ""
echo -e "${BLUE}=== End of Report ===${NC}"

# Exit with status based on compliance
if [ "$OVERALL_PCT" -ge 75 ]; then
    exit 0
else
    exit 1
fi
