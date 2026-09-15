#!/usr/bin/env bash
# validate-purpose.sh — Enforce the PURPOSE.md boundary (<20 content lines, vision only)
#
# Usage: bash scripts/validate-purpose.sh [path]
#   path  PURPOSE.md to check (default: ./PURPOSE.md)
# Exit 0: valid
# Exit 1: violations found
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/validate-purpose.spec.md

set -uo pipefail

TARGET="${1:-PURPOSE.md}"

if [[ ! -f "$TARGET" ]]; then
    echo "ERROR: no such file: $TARGET" >&2
    exit 2
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
warn() { echo "${YELLOW}WARN${RESET}: $1"; WARN=$((WARN+1)); }
fail() { echo "${RED}FAIL${RESET}: $1"; FAIL=$((FAIL+1)); }

echo "Validating $TARGET"
echo ""

# --- No YAML frontmatter (PURPOSE is not a spec) ---
if [[ "$(head -1 "$TARGET")" == "---" ]]; then
    fail "YAML frontmatter present (PURPOSE.md is not a spec, remove it)"
else
    pass "No YAML frontmatter"
fi

# --- Content line count: excludes blanks and headers ---
CONTENT_LINES=$(grep -v -E '^[[:space:]]*$' "$TARGET" | grep -v -E '^[[:space:]]*#' | wc -l | tr -d ' ')

if (( CONTENT_LINES > 20 )); then
    fail "Content lines ($CONTENT_LINES) exceed the 20-line limit"
elif (( CONTENT_LINES > 15 )); then
    warn "Content lines ($CONTENT_LINES) approaching the 20-line limit"
else
    pass "Content lines ($CONTENT_LINES) within limit"
fi

# --- Required sections ---
if grep -q -i -E '^#+.*\bwhy\b' "$TARGET"; then
    pass "'Why' section found"
else
    fail "'Why' section missing"
fi

if grep -q -i -E '^#+.*(success|what)' "$TARGET"; then
    pass "'Success' section found"
else
    fail "'Success' section missing"
fi

# --- Misplaced-content detection with routing ---
echo ""
detect() {
    local pattern="$1" label="$2" destination="$3" hits
    hits="$(grep -n -i -E "$pattern" "$TARGET" | grep -v -E '^[0-9]+:[[:space:]]*#' || true)"
    if [[ -n "$hits" ]]; then
        warn "$label detected -> route to ${BLUE}$destination${RESET}"
        while IFS= read -r h; do
            [[ -n "$h" ]] && echo "        line ${h%%:*}: $(echo "${h#*:}" | cut -c1-70)"
        done <<< "$hits"
    fi
}

detect 'must (comply|not|have)|shall |required to|constraint|regulat' \
       "Constraint language" "specs/foundation/constraints.spec.md"
# Matches technology CHOICES ("will use X"), not the word "architecture",
# which is legitimate vision vocabulary in many projects.
detect 'will use |built (on|with)|database|framework|deploy|infrastructure|microservice' \
       "Technology-choice language" "specs/strategy/architecture.spec.md"
detect 'workflow|process|team (follows|will)|procedure|sprint|standup' \
       "Process language" "specs/workspace/workflows.spec.md"

BULLETS=$(grep -c -E '^[[:space:]]*[-*+] ' "$TARGET" || true)
if (( BULLETS > 6 )); then
    warn "Bullet list has $BULLETS items (>6) -> route detail to ${BLUE}specs/foundation/outcomes.spec.md${RESET}"
fi

# --- Extra sections beyond Why / What Success ---
EXTRA="$(grep -E '^#{1,3} ' "$TARGET" \
    | grep -v -i -E '\b(why|success|what|purpose)\b' || true)"
if [[ -n "$EXTRA" ]]; then
    warn "Sections beyond Why/What Success -> extract to specs"
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
