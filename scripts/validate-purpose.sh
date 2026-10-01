#!/usr/bin/env bash
# validate-purpose.sh — Enforce the PURPOSE.md boundary (<20 content lines, vision only)
#
# Usage: bash scripts/validate-purpose.sh [--json] [path]
#   path    PURPOSE.md to check (default: ./PURPOSE.md)
#   --json  machine-readable output (specs/interfaces/formats/validator-output.spec.md)
# Exit 0: valid
# Exit 1: violations found
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/validate-purpose.spec.md

set -uo pipefail

JSON=false
TARGET=""
for arg in "$@"; do
    case "$arg" in
        --json) JSON=true ;;
        -*)     echo "Usage: $0 [--json] [path]" >&2; exit 2 ;;
        *)      TARGET="$arg" ;;
    esac
done
TARGET="${TARGET:-PURPOSE.md}"

if [[ ! -f "$TARGET" ]]; then
    echo "ERROR: no such file: $TARGET" >&2
    exit 2
fi

if $JSON; then
    VO_HELPER="$(dirname "${BASH_SOURCE[0]}")/validator-output.sh"
    [[ -f "$VO_HELPER" ]] || { echo "ERROR: --json needs $VO_HELPER" >&2; exit 2; }
    # shellcheck source=validator-output.sh
    source "$VO_HELPER"
    vo_init validate-purpose
fi

if [[ -t 1 ]]; then
    RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'
    BLUE=$'\033[0;34m'; RESET=$'\033[0m'
else
    RED=""; GREEN=""; YELLOW=""; BLUE=""; RESET=""
fi

FAIL=0
WARN=0

pass() { echo "${GREEN}PASS${RESET}: $1"; }
# warn|fail <rule> <subject> <message>: rule codes are part of the output contract
warn() { echo "${YELLOW}WARN${RESET}: $3"; WARN=$((WARN+1)); $JSON && vo_finding warning "$1" "$TARGET" "$2" "$3"; }
fail() { echo "${RED}FAIL${RESET}: $3"; FAIL=$((FAIL+1)); $JSON && vo_finding error "$1" "$TARGET" "$2" "$3"; }

echo "Validating $TARGET"
echo ""

# --- No YAML frontmatter (PURPOSE is not a spec) ---
if [[ "$(head -1 "$TARGET")" == "---" ]]; then
    fail frontmatter-present "" "YAML frontmatter present (PURPOSE.md is not a spec, remove it)"
else
    pass "No YAML frontmatter"
fi

# --- Content line count: excludes blanks and headers ---
CONTENT_LINES=$(grep -v -E '^[[:space:]]*$' "$TARGET" | grep -v -E '^[[:space:]]*#' | wc -l | tr -d ' ')

if (( CONTENT_LINES > 20 )); then
    fail too-long "" "Content lines ($CONTENT_LINES) exceed the 20-line limit"
elif (( CONTENT_LINES > 15 )); then
    warn near-limit "" "Content lines ($CONTENT_LINES) approaching the 20-line limit"
else
    pass "Content lines ($CONTENT_LINES) within limit"
fi

# --- Required sections ---
if grep -q -i -E '^#+.*\bwhy\b' "$TARGET"; then
    pass "'Why' section found"
else
    fail missing-section why "'Why' section missing"
fi

if grep -q -i -E '^#+.*(success|what)' "$TARGET"; then
    pass "'Success' section found"
else
    fail missing-section success "'Success' section missing"
fi

# --- Misplaced-content detection with routing ---
echo ""
detect() {
    local pattern="$1" label="$2" destination="$3" subject="$4" hits
    hits="$(grep -n -i -E "$pattern" "$TARGET" | grep -v -E '^[0-9]+:[[:space:]]*#' || true)"
    if [[ -n "$hits" ]]; then
        warn misplaced-content "$subject" "$label detected -> route to ${BLUE}$destination${RESET}"
        while IFS= read -r h; do
            [[ -n "$h" ]] && echo "        line ${h%%:*}: $(echo "${h#*:}" | cut -c1-70)"
        done <<< "$hits"
    fi
}

detect 'must (comply|not|have)|shall |required to|constraint|regulat' \
       "Constraint language" "specs/foundation/constraints.spec.md" constraint
# Matches technology CHOICES ("will use X"), not the word "architecture",
# which is legitimate vision vocabulary in many projects.
detect 'will use |built (on|with)|database|framework|deploy|infrastructure|microservice' \
       "Technology-choice language" "specs/strategy/architecture.spec.md" technology
detect 'workflow|process|team (follows|will)|procedure|sprint|standup' \
       "Process language" "specs/workspace/workflows.spec.md" process

BULLETS=$(grep -c -E '^[[:space:]]*[-*+] ' "$TARGET" || true)
if (( BULLETS > 6 )); then
    warn long-list "" "Bullet list has $BULLETS items (>6) -> route detail to ${BLUE}specs/foundation/outcomes.spec.md${RESET}"
fi

# --- Extra sections beyond Why / What Success ---
EXTRA="$(grep -E '^#{1,3} ' "$TARGET" \
    | grep -v -i -E '\b(why|success|what|purpose)\b' || true)"
if [[ -n "$EXTRA" ]]; then
    warn extra-sections "" "Sections beyond Why/What Success -> extract to specs"
    while IFS= read -r e; do
        [[ -n "$e" ]] && echo "        $e"
    done <<< "$EXTRA"
fi

echo ""
if (( FAIL > 0 )); then
    echo "${RED}PURPOSE.md validation FAILED${RESET} ($FAIL failure(s), $WARN warning(s))"
    exit 1
fi
echo "${GREEN}PURPOSE.md validation PASSED${RESET} ($WARN warning(s))"
exit 0
