#!/usr/bin/env bash
# validate-constraints.sh — Verify the assertions LiveSpec makes about itself
#
# Usage: bash scripts/validate-constraints.sh [--verbose]
# Exit 0: no errors (warnings permitted)
# Exit 1: unresolved command, script or route
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/validate-constraints.spec.md

set -uo pipefail

VERBOSE=false
for arg in "$@"; do
    case "$arg" in
        --verbose) VERBOSE=true ;;
        *) echo "Usage: $0 [--verbose]" >&2; exit 2 ;;
    esac
done

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 2

if [[ -t 1 ]]; then
    RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'; RESET=$'\033[0m'
else
    RED=""; GREEN=""; YELLOW=""; RESET=""
fi

ERRORS=0
WARNINGS=0

# Documentation surfaces that make claims about what ships.
SCAN_PATHS=(README.md AGENTS.md CLAUDE.md commands skills agents ctxt references/guides)
EXISTING=()
for p in "${SCAN_PATHS[@]}"; do [[ -e "$p" ]] && EXISTING+=("$p"); done

err()  { echo "${RED}ERROR${RESET}: $1"; ERRORS=$((ERRORS+1)); }
warnn() { echo "${YELLOW}WARN${RESET}:  $1"; WARNINGS=$((WARNINGS+1)); }

# --- Check 1: every referenced /livespec:<name> resolves to commands/<name>.md ---
echo "Checking referenced commands..."
while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    file="${line%%:*}"; rest="${line#*:}"; lineno="${rest%%:*}"
    name="$(echo "$line" | grep -oE '/livespec:[a-z-]+' | head -1 | cut -d: -f2)"
    [[ -z "$name" ]] && continue
    if [[ ! -f "commands/${name}.md" ]]; then
        err "/livespec:${name} referenced but commands/${name}.md does not exist"
        echo "         $file:$lineno"
    fi
done < <(grep -rn -oE '/livespec:[a-z-]+' "${EXISTING[@]}" 2>/dev/null \
         | sort -u -t: -k1,1 -k3,3 || true)

# --- Check 2: every referenced scripts/*.sh exists ---
echo "Checking referenced scripts..."
while IFS= read -r ref; do
    [[ -z "$ref" ]] && continue
    if [[ ! -f "$ref" ]]; then
        err "$ref referenced in documentation but does not exist"
        if $VERBOSE; then
            grep -rn -F "$ref" "${EXISTING[@]}" 2>/dev/null | head -3 | sed 's/^/         /'
        fi
    fi
done < <(grep -rh -oE '(bash |\./|Run |sh )scripts/[a-zA-Z0-9_-]+\.sh' "${EXISTING[@]}" 2>/dev/null \
         | grep -oE 'scripts/[a-zA-Z0-9_-]+\.sh' | sort -u || true)

# --- Check 3: command-to-skill routing integrity ---
echo "Checking command routing..."
for cmd in commands/*.md; do
    [[ -e "$cmd" ]] || continue
    target="$(grep -m1 '^routes-to:' "$cmd" | sed 's/^routes-to:[[:space:]]*//' | tr -d '"'"'"' ')"
    if [[ -z "$target" ]]; then
        err "$cmd has no routes-to: field"
    elif [[ ! -f "$target" ]]; then
        err "$cmd routes to $target which does not exist"
    fi
done

# --- Check 4: references to retired distribution layouts ---
echo "Checking for retired layout references..."
while IFS= read -r hit; do
    [[ -z "$hit" ]] && continue
    warnn "retired layout referenced: ${hit}"
done < <(grep -rn -E '\.livespec/|\.livespec-version' "${EXISTING[@]}" 2>/dev/null \
         | grep -v '^references/guides/' \
         | grep -v 'CHANGELOG' \
         | grep -v 'Assuming a `.livespec/` folder exists' \
         | grep -v 'No `.livespec/` directory' \
         | grep -v 'not a copied `dist/` folder' \
         | cut -c1-140 || true)

echo ""
echo "Summary:"
echo "  Errors:   $ERRORS"
echo "  Warnings: $WARNINGS"
echo ""

if (( ERRORS > 0 )); then
    echo "${RED}FAILED${RESET}: $ERRORS constraint violation(s)"
    exit 1
fi
echo "${GREEN}PASSED${RESET}: all referenced commands, scripts and routes resolve"
exit 0
