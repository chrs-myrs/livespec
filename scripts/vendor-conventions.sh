#!/usr/bin/env bash
# vendor-conventions.sh — Vendor LiveSpec conventions into a project with provenance
#
# Usage: bash scripts/vendor-conventions.sh [--check] [--source DIR] [--target DIR]
# Exit 0: vendored, already current, or --check reported state
# Exit 1: source conventions not found
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/vendor-conventions.spec.md

set -uo pipefail

CHECK=false
SOURCE=""
# specs/workspace/standards: category is derived from the directory immediately
# under specs/, so vendoring to specs/standards/ would derive an invalid category
# "standards". Conventions govern how the workspace operates, so workspace/ is
# both valid and correct.
TARGET="specs/workspace/standards"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --check)  CHECK=true; shift ;;
        --source) SOURCE="${2:-}"; shift 2 ;;
        --target) TARGET="${2:-}"; shift 2 ;;
        *) echo "Usage: $0 [--check] [--source DIR] [--target DIR]" >&2; exit 2 ;;
    esac
done

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 2

# Resolve source: plugin first, then this repository (LiveSpec developing itself)
if [[ -z "$SOURCE" ]]; then
    if [[ -n "${CLAUDE_PLUGIN_ROOT:-}" && -d "${CLAUDE_PLUGIN_ROOT}/references/standards/conventions" ]]; then
        SOURCE="${CLAUDE_PLUGIN_ROOT}/references/standards/conventions"
    elif [[ -d "references/standards/conventions" ]]; then
        SOURCE="references/standards/conventions"
    fi
fi

if [[ -z "$SOURCE" || ! -d "$SOURCE" ]]; then
    echo "ERROR: conventions not found. Pass --source DIR." >&2
    exit 1
fi

# Inert where the project IS the convention source.
if [[ "$(cd "$SOURCE" && pwd)" == "$(cd "$(dirname "$SOURCE")" 2>/dev/null && pwd)/conventions" \
   && -f "PURPOSE.md" && -d "references/standards/conventions" && "$SOURCE" == "references/standards/conventions" ]]; then
    echo "This project is the convention source; nothing to vendor."
    exit 0
fi

if [[ -t 1 ]]; then
    GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'; BLUE=$'\033[0;34m'; RESET=$'\033[0m'
else
    GREEN=""; YELLOW=""; BLUE=""; RESET=""
fi

# Version of the TOOLCHAIN that supplied the conventions, not of the project
# receiving them. Reading the receiving project's project.yaml recorded the
# wrong version, or "unknown" where the project has none.
SOURCE_ROOT="$(cd "$SOURCE/../../.." 2>/dev/null && pwd)"
VERSION="unknown"
for candidate in "${CLAUDE_PLUGIN_ROOT:-}/project.yaml" "$SOURCE_ROOT/project.yaml"; do
    [[ -f "$candidate" ]] || continue
    v="$(grep -A5 '^livespec:' "$candidate" 2>/dev/null | grep -m1 'version:' \
        | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
    if [[ -n "$v" ]]; then VERSION="$v"; break; fi
done

# Body = everything after the closing --- of frontmatter. Hashing the body only
# keeps the hash verifiable after provenance keys are stamped into frontmatter.
body_hash() {
    awk 'BEGIN{n=0} /^---$/{n++; if(n<=2) next} n>=2{print}' "$1" | sha256sum | cut -d" " -f1
}

stamp() {
    local src="$1" dst="$2" hash="$3" from="$4"
    # `extends` is dropped from the vendored copy: it points at a metaspec that
    # exists in the toolchain and not in the receiving project, so carrying it
    # over would plant a broken cross-reference in every project that vendors.
    # The metaspec template is implied by `type` in any case.
    awk -v from="$from" -v ver="$VERSION" -v hash="$hash" '
        BEGIN{n=0; skip=0}
        /^---$/{
            n++
            if(n==2){
                print "vendored-from: " from
                print "source-version: " ver
                print "source-hash: sha256:" hash
            }
            skip=0
            print; next
        }
        n==1 && /^extends:/ {skip=1; next}
        n==1 && skip==1 && /^[[:space:]]+-[[:space:]]/ {next}
        n==1 {skip=0}
        {print}
    ' "$src" > "$dst"
}

mkdir -p "$TARGET"

VENDORED=0; UNCHANGED=0; EDITED=0; UPSTREAM=0; DIVERGED=0

for src in "$SOURCE"/*.spec.md; do
    [[ -e "$src" ]] || continue
    name="$(basename "$src")"
    dst="$TARGET/$name"
    logical="references/standards/conventions/$name"
    up_hash="$(body_hash "$src")"

    if [[ ! -f "$dst" ]]; then
        if $CHECK; then
            echo "${BLUE}ABSENT${RESET}      $name"
        else
            stamp "$src" "$dst" "$up_hash" "$logical"
            echo "${GREEN}VENDORED${RESET}    $name"
        fi
        VENDORED=$((VENDORED+1)); continue
    fi

    recorded="$(grep -m1 '^source-hash:' "$dst" | sed 's/^source-hash:[[:space:]]*sha256://' | tr -d ' ')"
    local_hash="$(body_hash "$dst")"

    local_changed=false; up_changed=false
    [[ "$local_hash" != "$recorded" ]] && local_changed=true
    [[ "$up_hash"    != "$recorded" ]] && up_changed=true

    if   ! $local_changed && ! $up_changed; then
        echo "${GREEN}UNCHANGED${RESET}   $name"; UNCHANGED=$((UNCHANGED+1))
    elif $local_changed && ! $up_changed; then
        echo "${YELLOW}LOCAL-EDIT${RESET}  $name (left alone)"; EDITED=$((EDITED+1))
    elif ! $local_changed && $up_changed; then
        if $CHECK; then
            echo "${YELLOW}UPSTREAM${RESET}    $name (update available)"
        else
            stamp "$src" "$dst" "$up_hash" "$logical"
            echo "${GREEN}UPDATED${RESET}     $name"
        fi
        UPSTREAM=$((UPSTREAM+1))
    else
        echo "${YELLOW}DIVERGED${RESET}    $name (local edits and upstream change; resolve by hand)"
        DIVERGED=$((DIVERGED+1))
    fi
done

echo ""
echo "Source: $SOURCE  ->  Target: $TARGET"
echo "  vendored/absent: $VENDORED   unchanged: $UNCHANGED   local-edit: $EDITED   upstream: $UPSTREAM   diverged: $DIVERGED"
if (( DIVERGED > 0 || EDITED > 0 )); then
    echo ""
    echo "Locally edited and diverged files are never overwritten. Resolve them deliberately."
fi
exit 0
