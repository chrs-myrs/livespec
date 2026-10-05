#!/usr/bin/env bash
# validate-context.sh — Is the generated agent context current with the specs it came from?
#
# Usage: bash scripts/validate-context.sh [--strict] [--json]
#        bash scripts/validate-context.sh --stamp
#        bash scripts/validate-context.sh --changed
#   --strict   promote stale and unstamped warnings to errors
#   --json     machine-readable output (specs/interfaces/formats/validator-output.spec.md)
#   --stamp    write the source stamp into the agent doc and every ctxt/ file
#   --changed  list the sources changed since the stamp was written, or "unknown"
# Exit 0: current, or only warnings
# Exit 1: a stale or unstamped file under --strict
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/validate-context.spec.md
#
# The stamp is a hash of the sources, not a timestamp: timestamps and
# modification times differ on every clone, a hash of what git commits does not.

set -uo pipefail

usage() {
    echo "Usage: $0 [--strict] [--json] | --stamp | --changed" >&2
    exit 2
}

MODE=check
STRICT=false
JSON=false
for arg in "$@"; do
    case "$arg" in
        --strict)  STRICT=true ;;
        --json)    JSON=true ;;
        --stamp)   MODE=stamp ;;
        --changed) MODE=changed ;;
        *)         usage ;;
    esac
done
[[ "$MODE" != check ]] && { $JSON || $STRICT; } && usage

TOP="$(git rev-parse --show-toplevel 2>/dev/null || pwd -P)"
IN_GIT=false
git rev-parse --git-dir >/dev/null 2>&1 && IN_GIT=true
cd "$TOP" || exit 2

if $JSON; then
    VO_HELPER="$(dirname "${BASH_SOURCE[0]}")/validator-output.sh"
    [[ -f "$VO_HELPER" ]] || { echo "ERROR: --json needs $VO_HELPER" >&2; exit 2; }
    # shellcheck source=validator-output.sh
    source "$VO_HELPER"
    vo_init validate-context
fi

# sha256sum is absent from macOS before 15.2; shasum ships with every release.
sha256() { if command -v sha256sum >/dev/null; then sha256sum; else shasum -a 256; fi; }

STAMP_RE='^<!-- livespec-context-sources: sha256:[0-9a-f]+ n=[0-9]+ -->$'

# The agent doc project.yaml names, followed if it is a symlink so one file is
# stamped once.
DOC="$(grep -A12 '^agent:' project.yaml 2>/dev/null | grep -m1 'doc_format:' \
    | sed -e 's/.*doc_format:[[:space:]]*//' -e 's/[[:space:]#].*//')"
DOC="${DOC:-AGENTS.md}"
if [[ -L "$DOC" ]]; then
    link="$(readlink "$DOC")"
    [[ "$link" != /* && -f "$link" ]] && DOC="$link"
fi

TARGETS=""
[[ -f "$DOC" && ! -L "$DOC" ]] && TARGETS+="$DOC"$'\n'
# Generated context is flat plus ctxt/domains/. Any other subfolder is a retired
# layout or hand-written context; stamping it would make it read as current.
[[ -d ctxt ]] && TARGETS+="$( { find ctxt -maxdepth 1 -name '*.md' -type f
                                [[ -d ctxt/domains ]] && find ctxt/domains -name '*.md' -type f; } \
                              | LC_ALL=C sort)"$'\n'
TARGETS="$(grep -v '^$' <<< "$TARGETS" || true)"

# The sources: PURPOSE.md, every spec in the categories the Spec -> Generated
# File Map covers, and the spec-first template the agent doc inlines. Only files
# git would commit count.
SOURCE_SPECS=(PURPOSE.md 'specs/workspace/*.spec.md' 'specs/foundation/*.spec.md'
              'specs/features/*.spec.md' 'specs/artifacts/*.spec.md'
              templates/agents/spec-first-enforcement.md)
if $IN_GIT; then
    SOURCES="$(git ls-files --cached --others --exclude-standard -- "${SOURCE_SPECS[@]}" | LC_ALL=C sort -u)"
else
    SOURCES="$( { [[ -f PURPOSE.md ]] && echo PURPOSE.md
                  find specs/workspace specs/foundation specs/features specs/artifacts -name '*.spec.md' -type f 2>/dev/null
                  [[ -f templates/agents/spec-first-enforcement.md ]] && echo templates/agents/spec-first-enforcement.md
                } | LC_ALL=C sort -u)"
fi
EXISTING=""
while IFS= read -r f; do [[ -n "$f" && -f "$f" ]] && EXISTING+="$f"$'\n'; done <<< "$SOURCES"
COUNT="$(grep -c . <<< "$EXISTING" || true)"
HASH="$(
    while IFS= read -r f; do
        [[ -n "$f" ]] || continue
        printf '%s\0' "$f"; tr -d '\r' < "$f"; printf '\0'
    done <<< "$EXISTING" | sha256 | cut -d' ' -f1
)"
STAMP="<!-- livespec-context-sources: sha256:$HASH n=$COUNT -->"

recorded() { grep -E "$STAMP_RE" "$1" 2>/dev/null | tail -1 | sed -E 's/.*sha256:([0-9a-f]+).*/\1/'; }

# --- --stamp ---
if [[ "$MODE" == stamp ]]; then
    if [[ -z "$TARGETS" ]]; then
        echo "No generated agent context ($DOC, ctxt/) to stamp."
        exit 0
    fi
    while IFS= read -r t; do
        locked=false
        if [[ ! -w "$t" ]]; then chmod u+w "$t" && locked=true; fi
        tmp="$(mktemp)" || exit 2
        # Drop earlier stamps and the blank lines before them, then append one.
        awk -v re="$STAMP_RE" '
            $0 ~ re { next }
            { lines[++n] = $0 }
            END {
                while (n > 0 && lines[n] ~ /^[[:space:]]*$/) n--
                for (i = 1; i <= n; i++) print lines[i]
            }' "$t" > "$tmp"
        printf '\n%s\n' "$STAMP" >> "$tmp"
        cat "$tmp" > "$t"
        rm -f "$tmp"
        $locked && chmod u-w "$t"
        echo "  STAMPED  $t"
    done <<< "$TARGETS"
    echo "Sources: $COUNT files, sha256:$HASH"
    exit 0
fi

# --- --changed ---
if [[ "$MODE" == changed ]]; then
    first="$(head -1 <<< "$TARGETS")"
    rec=""
    [[ -n "$first" ]] && rec="$(recorded "$first")"
    commit=""
    if $IN_GIT && [[ -n "$rec" ]]; then
        commit="$(git log -1 --format=%H -S"sha256:$rec" -- "$first" 2>/dev/null || true)"
    fi
    if [[ -z "$commit" ]]; then
        echo "unknown"
        exit 0
    fi
    { git diff --name-only "$commit" -- "${SOURCE_SPECS[@]}"
      git ls-files --others --exclude-standard -- "${SOURCE_SPECS[@]}"; } | LC_ALL=C sort -u
    exit 0
fi

# --- check ---
echo "Validating context currency..."
echo ""
if [[ -z "$TARGETS" ]]; then
    echo "No generated agent context ($DOC, ctxt/); nothing to check."
    exit 0
fi

SEV=warning; $STRICT && SEV=error
FINDINGS=0
while IFS= read -r t; do
    rec="$(recorded "$t")"
    if [[ -z "$rec" ]]; then
        echo "  unstamped  $t"
        FINDINGS=$((FINDINGS + 1))
        $JSON && vo_finding "$SEV" unstamped "$t" "" "carries no source stamp; regenerate with /livespec:audit context"
    elif [[ "$rec" != "$HASH" ]]; then
        echo "  stale      $t"
        FINDINGS=$((FINDINGS + 1))
        $JSON && vo_finding "$SEV" stale "$t" "" "its sources have changed since it was generated; regenerate with /livespec:audit context"
    else
        echo "  current    $t"
    fi
done <<< "$TARGETS"

echo ""
echo "Sources: $COUNT files, sha256:$HASH"
if (( FINDINGS > 0 )) && $STRICT; then
    echo ""
    echo "FAILED: $FINDINGS generated file(s) stale or unstamped"
    exit 1
fi
echo ""
if (( FINDINGS > 0 )); then
    echo "PASSED with $FINDINGS warning(s): regenerate with /livespec:audit context (--strict to fail)"
else
    echo "PASSED: generated context is current"
fi
exit 0
