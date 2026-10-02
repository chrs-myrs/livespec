#!/usr/bin/env bash
# remediate-references.sh — Repair stale references an upgrade surfaces
#
# Usage: bash scripts/remediate-references.sh [--check]
# Exit 0: applied, or --check reported
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/remediate-references.spec.md

set -uo pipefail

CHECK=false
case "${1:-}" in
    --check) CHECK=true ;;
    "") ;;
    *) echo "Usage: $0 [--check]" >&2; exit 2 ;;
esac

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 2

if [[ -t 1 ]]; then
    GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'; BLUE=$'\033[0;34m'; RESET=$'\033[0m'
else
    GREEN=""; YELLOW=""; BLUE=""; RESET=""
fi

# Retired command -> current equivalent. Matches the migration table in
# references/guides/upgrade-to-v5.md.
# name=target pairs; indexed, since the bash macOS ships has no associative arrays.
RENAME=(
    "evolve=audit"
    "feature=design feature"
    "debug=design debug"
    "refine=design refine"
    "validate=audit validate"
    "rebuild-context=audit context"
    "session-review=learn"
    "health-report=audit health"
    "complete-session=learn"
    "measure-session=learn"
    "next-steps=go"
    "refine-workspace=design workspace"
    "suggest-improvements=audit"
)

# Retired names with no current equivalent: reported, never guessed.
NO_EQUIVALENT="build verify run-spike analyze-failure"

# Historical records, not instructions.
SKIP_RE='(^|/)(CHANGELOG\.md|registries/|var/|worktrees/|\.git/|\.archive/)'
GUIDE_RE='references/guides/'

files() {
    git ls-files '*.md' 2>/dev/null | grep -Ev "$SKIP_RE" | grep -v "$GUIDE_RE"
}

APPLIED=0; WOULD=0
UNREM_NAMES=(); UNREM_FILES=()

for pair in "${RENAME[@]}"; do
    name="${pair%%=*}"; target="${pair#*=}"
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        grep -q -F "/livespec:${name}" "$f" 2>/dev/null || continue
        n=$(grep -c -F "/livespec:${name}" "$f")
        if $CHECK; then
            echo "${BLUE}WOULD${RESET}  $f: /livespec:${name} -> /livespec:${target} (${n})"
            WOULD=$((WOULD+n))
        else
            # Longest names first is unnecessary here: each is matched whole via
            # the trailing boundary, so a prefix like `refine` cannot eat
            # `refine-workspace`.
            perl -pi -e "s{/livespec:\Q${name}\E(?![a-z-])}{/livespec:${target}}g" "$f"
            echo "${GREEN}FIXED${RESET}  $f: /livespec:${name} -> /livespec:${target} (${n})"
            APPLIED=$((APPLIED+n))
        fi
    done < <(files)
done

for name in $NO_EQUIVALENT; do
    hits=""
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        if grep -q -F "/livespec:${name}" "$f" 2>/dev/null; then
            hits+="$f "
        fi
    done < <(files)
    if [[ -n "$hits" ]]; then
        UNREM_NAMES+=("/livespec:${name}"); UNREM_FILES+=("$hits")
    fi
done

# Repoint convention references at the project's vendored copies.
VENDOR_DIR="specs/workspace/standards"
CONV=0
if [[ -d "$VENDOR_DIR" ]]; then
    for vendored in "$VENDOR_DIR"/*.spec.md; do
        [[ -e "$vendored" ]] || continue
        base="$(basename "$vendored")"
        from="references/standards/conventions/${base}"
        while IFS= read -r f; do
            [[ -z "$f" ]] && continue
            [[ "$f" == "$VENDOR_DIR"/* ]] && continue
            grep -q -F "$from" "$f" 2>/dev/null || continue
            if $CHECK; then
                echo "${BLUE}WOULD${RESET}  $f: $from -> $VENDOR_DIR/$base"
            else
                perl -pi -e "s{\Q${from}\E}{${VENDOR_DIR}/${base}}g" "$f"
                echo "${GREEN}FIXED${RESET}  $f: convention repointed to vendored copy"
            fi
            CONV=$((CONV+1))
        done < <(files)
    done
fi

# Drop metaspec references from governed-by: the format they name is implied by
# `type`. Older versions planted pre-schema copies under references/templates/
# and *.metaspec.md names the toolchain has since retired, so existence is
# irrelevant. Writes the rewritten file to $2 and prints the entries dropped.
METASPEC_RE='metaspecs/|references/templates/|[.]metaspec[.]md'
drop_metaspecs() {
    awk -v re="$METASPEC_RE" -v out="$2" '
        function flush() {
            if (dropped_here > 0 && kept == 0) print "governed-by: []" > out
            else { print hdr > out; printf "%s", buf > out }
            ing = 0
        }
        BEGIN { n = 0; ing = 0; total = 0 }
        /^---$/ { n++; if (ing) flush(); print > out; next }
        n == 1 && /^governed-by:[[:space:]]*$/ {
            ing = 1; hdr = $0; buf = ""; kept = 0; dropped_here = 0; next
        }
        n == 1 && /^governed-by:/ && $0 ~ re { print "governed-by: []" > out; total++; next }
        n == 1 && ing && /^[[:space:]]+-[[:space:]]/ {
            if ($0 ~ re) { dropped_here++; total++ } else { buf = buf $0 "\n"; kept++ }
            next
        }
        n == 1 && ing { flush() }
        { print > out }
        END { print total }
    ' "$1"
}

META=0
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
while IFS= read -r f; do
    [[ -z "$f" || "$f" != *.spec.md || "$f" == "$VENDOR_DIR"/* ]] && continue
    n="$(drop_metaspecs "$f" "$tmp")"
    (( n > 0 )) || continue
    if $CHECK; then
        echo "${BLUE}WOULD${RESET}  $f: drop ${n} metaspec reference(s) from governed-by"
    else
        cat "$tmp" > "$f"
        echo "${GREEN}FIXED${RESET}  $f: dropped ${n} metaspec reference(s) from governed-by"
    fi
    META=$((META+n))
done < <(files)

echo ""
if $CHECK; then
    echo "Would rewrite: $WOULD command reference(s), $CONV convention reference(s), $META metaspec reference(s)"
else
    echo "Rewrote: $APPLIED command reference(s), $CONV convention reference(s), $META metaspec reference(s)"
fi

if (( ${#UNREM_NAMES[@]} > 0 )); then
    echo ""
    echo "${YELLOW}No current equivalent — resolve by hand:${RESET}"
    for i in "${!UNREM_NAMES[@]}"; do
        echo "  ${UNREM_NAMES[i]}"
        for f in ${UNREM_FILES[i]}; do echo "      $f"; done
    done
fi
exit 0
