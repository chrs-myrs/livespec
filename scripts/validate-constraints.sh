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
# Existence checks run broad: any surface asserting a command or tool exists.
SCAN_PATHS=(README.md AGENTS.md CLAUDE.md commands skills agents ctxt references/guides specs templates)
EXISTING=()
for p in "${SCAN_PATHS[@]}"; do [[ -e "$p" ]] && EXISTING+=("$p"); done

# Retired-layout checks run narrow: only project-facing artefacts. Migration
# guides and historical specs legitimately describe the layout being retired.
LAYOUT_PATHS=(README.md AGENTS.md CLAUDE.md commands skills agents ctxt)
LAYOUT_EXISTING=()
for p in "${LAYOUT_PATHS[@]}"; do [[ -e "$p" ]] && LAYOUT_EXISTING+=("$p"); done

err()  { echo "${RED}ERROR${RESET}: $1"; ERRORS=$((ERRORS+1)); }
warnn() { echo "${YELLOW}WARN${RESET}:  $1"; WARNINGS=$((WARNINGS+1)); }

# --- Check 1: every referenced /livespec:<name> resolves to commands/<name>.md ---
echo "Checking referenced commands..."
while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    file="${line%%:*}"; rest="${line#*:}"; lineno="${rest%%:*}"
    name="$(grep -oE '/livespec:[a-z-]+' <<< "$line" | head -1 | cut -d: -f2)"
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
    # A ${CLAUDE_PLUGIN_ROOT}/ prefix leaves a leading slash once the variable
    # is stripped; the path is plugin-relative, so test it as such.
    ref="${ref#/}"
    if [[ ! -f "$ref" ]]; then
        err "$ref referenced in documentation but does not exist"
        if $VERBOSE; then
            grep -rn -F "$ref" "${EXISTING[@]}" 2>/dev/null | head -3 | sed 's/^/         /'
        fi
    fi
done < <(grep -rh -oE '(bash |\./|Run |sh )[a-zA-Z0-9_/-]+\.sh' "${EXISTING[@]}" 2>/dev/null \
         | grep -oE '[a-zA-Z0-9_/-]+\.sh' \
         | grep -vE '^(setup|install|build|deploy|run)\.sh$' | sort -u || true)

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
done < <(grep -rn -E '\.livespec/|\.livespec-version' "${LAYOUT_EXISTING[@]}" 2>/dev/null \
         | grep -v '^references/guides/' \
         | grep -v 'CHANGELOG' \
         | grep -v 'Assuming a `.livespec/` folder exists' \
         | grep -v 'No `.livespec/` directory' \
         | grep -v 'not a copied `dist/` folder' \
         | cut -c1-140 || true)

# --- Check 5: toolchain independence of project artefacts ---
# Project context must be usable by an agent with no LiveSpec tooling installed.
echo "Checking toolchain independence of project context..."
PROJECT_CTX=()
for p in AGENTS.md CLAUDE.md ctxt; do [[ -e "$p" ]] && PROJECT_CTX+=("$p"); done

if (( ${#PROJECT_CTX[@]} > 0 )); then
    while IFS= read -r hit; do
        [[ -z "$hit" ]] && continue
        err "project context references the toolchain root: ${hit%%:*}"
    done < <(grep -rln 'CLAUDE_PLUGIN_ROOT' "${PROJECT_CTX[@]}" 2>/dev/null || true)

    # Every script the project context instructs must exist in the project,
    # not merely in the plugin: the reader may not have the plugin.
    while IFS= read -r ref; do
        [[ -z "$ref" ]] && continue
        [[ -f "$ref" ]] || err "project context instructs '$ref' which the project does not ship"
    done < <(grep -rh -oE '(bash |\./|Run |sh )scripts/[a-zA-Z0-9_-]+\.sh' "${PROJECT_CTX[@]}" 2>/dev/null \
             | grep -oE 'scripts/[a-zA-Z0-9_-]+\.sh' | sort -u || true)

    # Deliberately NOT checked: whether spec paths named in project context
    # resolve. Generated context legitimately carries teaching examples
    # (specs/features/auth.spec.md) in the same syntax as real references, so
    # no mechanical rule separates assertion from illustration. A check that
    # cannot tell them apart produces false errors and trains readers to
    # ignore the validator.
fi

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
