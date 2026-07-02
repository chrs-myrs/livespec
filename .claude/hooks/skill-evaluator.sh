#!/bin/bash
# LiveSpec Skill Evaluator Hook
# Suggests skill invocation when relevant keywords detected

# Read hook input (contains prompt field)
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt' 2>/dev/null)

# If jq fails or prompt is empty, allow through
if [ -z "$PROMPT" ]; then
  exit 0
fi

# Convert to lowercase for matching
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')

# Check for design/spec keywords → /livespec:design
if echo "$PROMPT_LOWER" | grep -qE "design|spec|specification|feature|requirement|behavior|refine"; then
  # Don't suggest if already invoking a skill
  if echo "$PROMPT" | grep -qE "^/livespec:"; then
    exit 0
  fi
  echo "Detected specification-related request. Consider using /livespec:design for spec creation/refinement."
  exit 0
fi

# Check for audit/health keywords → /livespec:audit
if echo "$PROMPT_LOWER" | grep -qE "health|validate|agents\.md|context|audit|extract|drift"; then
  if echo "$PROMPT" | grep -qE "^/livespec:"; then
    exit 0
  fi
  echo "Detected audit-related request. Consider using /livespec:audit for health checks and context generation."
  exit 0
fi

# Check for init/setup keywords → /livespec:init
if echo "$PROMPT_LOWER" | grep -qE "init|initialize|setup|bootstrap|new project"; then
  if echo "$PROMPT" | grep -qE "^/livespec:"; then
    exit 0
  fi
  echo "Detected initialization request. Consider using /livespec:init for project setup."
  exit 0
fi

# Check for session/learn keywords → /livespec:learn
if echo "$PROMPT_LOWER" | grep -qE "complete|session|learn|capture|compliance"; then
  if echo "$PROMPT" | grep -qE "^/livespec:"; then
    exit 0
  fi
  echo "Detected session-related request. Consider using /livespec:learn for session completion."
  exit 0
fi

# Check for upgrade/migrate keywords → /livespec:upgrade
if echo "$PROMPT_LOWER" | grep -qE "upgrade|migrate|v5|submodule"; then
  if echo "$PROMPT" | grep -qE "^/livespec:"; then
    exit 0
  fi
  echo "Detected upgrade request. Consider using /livespec:upgrade for migration to v5."
  exit 0
fi

# No match - allow prompt through without additional context
exit 0
