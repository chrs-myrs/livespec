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
TARGET="specs/standards"

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

# Version of the toolchain doing the vendoring
VERSION="$(grep -A5 '^livespec:' project.yaml 2>/dev/null | grep -m1 'version:' \
          | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || echo unknown)"

# Body = everything after the closing --- of frontmatter. Hashing the body only
# keeps the hash verifiable after provenance keys are stamped into frontmatter.
body_hash() {
    awk 'BEGIN{n=0} /^---$/{n++; if(n<=2) next} n>=2{print}' "$1" | sha256sum | cut -d" " -f1
}

stamp() {
    local src="$1" dst="$2" hash="$3" from="$4"
    awk -v from="$from" -v ver="$VERSION" -v hash="$hash" '
        BEGIN{n=0}
        /^---$/{
            n++
            if(n==2){
                print "vendored-from: " from
                print "source-version: " ver
                print "source-hash: sha256:" hash
            }
            print; next
        }
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
