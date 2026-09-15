#!/usr/bin/env bash
# check-requires-spec.sh — Does this file path require a specification?
#
# Usage: bash scripts/check-requires-spec.sh <path>
# Exit 0: spec exists, or none required (temporary/data/self-defining path)
# Exit 1: spec required but missing
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/check-requires-spec.spec.md

set -uo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <path>" >&2
    exit 2
fi

TARGET="$1"

if [[ -t 1 ]]; then
    RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'
    BLUE=$'\033[0;34m'; RESET=$'\033[0m'
else
    RED=""; GREEN=""; YELLOW=""; BLUE=""; RESET=""
fi

# Normalise leading ./
NORM="${TARGET#./}"
BASENAME="$(basename "$NORM")"

# --- Exception 1: temporary / build / vendor directories ---
for dir in var generated .archive .git node_modules .cache build dist worktrees; do
    if [[ "$NORM" == "$dir/"* || "$NORM" == *"/$dir/"* ]]; then
        echo "${GREEN}NO SPEC NEEDED${RESET}: $NORM"
        echo "  Reason: lives under ${BLUE}$dir/${RESET} (transient, not committed as a deliverable)"
        exit 0
    fi
done

# --- Exception 2: workspace specs are self-defining ---
if [[ "$NORM" == specs/workspace/* ]]; then
    echo "${GREEN}NO SPEC NEEDED${RESET}: $NORM"
    echo "  Reason: workspace specs ARE specifications (no meta-spec required)"
    exit 0
fi

# --- Exception 3: any .spec.md is itself a spec ---
if [[ "$BASENAME" == *.spec.md ]]; then
    echo "${GREEN}NO SPEC NEEDED${RESET}: $NORM"
    echo "  Reason: file is itself a specification"
    exit 0
fi

# --- Exception 4: pure data / log files ---
case "$BASENAME" in
    *.log|*.lock|*.cache)
        echo "${GREEN}NO SPEC NEEDED${RESET}: $NORM"
        echo "  Reason: data/log artefact, carries no specified behaviour"
        exit 0 ;;
esac

# --- Check 1: colocated spec ---
COLOCATED="${NORM%.*}.spec.md"
if [[ -f "$COLOCATED" ]]; then
    echo "${GREEN}SPEC FOUND${RESET}: $NORM"
    echo "  Colocated: ${BLUE}$COLOCATED${RESET}"
    exit 0
fi

# --- Check 2: any spec in specs/ that mentions this path or filename ---
# A path appearing as an argument in a usage example is not evidence that a
# spec governs it, so shell-invocation lines are excluded from the match.
MENTIONS=""
if [[ -d specs ]]; then
    MENTIONS="$(grep -rn -F -e "$NORM" specs/ 2>/dev/null \
        | grep -v -E ':[[:space:]]*(\$ |\./|bash |sh )' \
        | grep -v -E '\.sh[[:space:]]' \
        | cut -d: -f1 | sort -u || true)"
fi

if [[ -n "$MENTIONS" ]]; then
    echo "${GREEN}SPEC FOUND${RESET}: $NORM"
    echo "  Referenced by:"
    while IFS= read -r m; do
        [[ -n "$m" ]] && echo "    ${BLUE}$m${RESET}"
    done <<< "$MENTIONS"
    exit 0
fi

# --- Missing: actionable guidance ---
DIRNAME="$(dirname "$NORM")"
STEM="${BASENAME%%.*}"

echo "${RED}SPEC REQUIRED${RESET}: $NORM"
echo ""
echo "  No specification governs this file. It is a permanent deliverable"
echo "  and LiveSpec requires a spec before implementation."
echo ""
echo "  ${YELLOW}Suggested locations${RESET}:"
echo "    ${BLUE}specs/features/${STEM}.spec.md${RESET}      (observable behaviour)"
echo "    ${BLUE}specs/artifacts/${STEM}.spec.md${RESET}     (prompt, agent, command, validator)"
echo "    ${BLUE}specs/interfaces/${STEM}.spec.md${RESET}    (API or data contract)"
echo "    ${BLUE}${DIRNAME}/${STEM}.spec.md${RESET}          (colocated)"
echo ""
echo "  An existing spec may cover this file if they share one observable"
echo "  purpose. Otherwise create one: ${BLUE}/livespec:design spec${RESET}"
exit 1
