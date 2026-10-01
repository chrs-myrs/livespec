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

# Exemptions and governance come from the coverage validator, so this gate and
# the coverage report cannot disagree. A path is governed only when a spec's
# specifies: names it; a colocated spec or a mention in a spec's text is not.
COVERAGE="$(dirname "${BASH_SOURCE[0]}")/validate-coverage.sh"
if [[ ! -f "$COVERAGE" ]]; then
    echo "ERROR: $COVERAGE not found; this gate needs it" >&2
    exit 2
fi
ANSWER="$(bash "$COVERAGE" --which "$NORM")"
STATUS=$?
(( STATUS == 2 )) && exit 2

if [[ "$ANSWER" == exempt$'\t'* ]]; then
    echo "${GREEN}NO SPEC NEEDED${RESET}: $NORM"
    echo "  Reason: ${ANSWER#exempt$'\t'}"
    exit 0
fi

if (( STATUS == 0 )); then
    echo "${GREEN}SPEC FOUND${RESET}: $NORM"
    echo "  Governed by:"
    while IFS=$'\t' read -r _ spec; do
        [[ -n "$spec" ]] && echo "    ${BLUE}$spec${RESET}"
    done <<< "$ANSWER"
    exit 0
fi

# --- Missing: actionable guidance ---
STEM="${BASENAME%%.*}"

echo "${RED}SPEC REQUIRED${RESET}: $NORM"
echo ""
echo "  No spec's specifies: names this file. It is a permanent deliverable"
echo "  and LiveSpec requires a spec before implementation."
echo ""
echo "  ${YELLOW}Suggested locations${RESET}:"
echo "    ${BLUE}specs/features/${STEM}.spec.md${RESET}      (observable behaviour)"
echo "    ${BLUE}specs/artifacts/${STEM}.spec.md${RESET}     (prompt, agent, command, validator)"
echo "    ${BLUE}specs/interfaces/${STEM}.spec.md${RESET}    (API or data contract)"
echo ""
echo "  An existing spec may cover this file if they share one observable"
echo "  purpose: add the file, its directory or a glob to that spec's specifies:."
echo "  Otherwise create one: ${BLUE}/livespec:design spec${RESET}"
exit 1
