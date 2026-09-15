#!/usr/bin/env bash
# setup-hooks.sh — Install LiveSpec validation as a pre-commit hook
#
# Usage: bash scripts/setup-hooks.sh [--check] [--force]
# Exit 0: installed, already current, or --check reported state
# Exit 1: an unrelated pre-commit hook exists (use --force), or not a git repo
# Exit 2: usage error
#
# Specifies: specs/artifacts/validators/setup-hooks.spec.md

set -uo pipefail

CHECK=false
FORCE=false
for arg in "$@"; do
    case "$arg" in
        --check) CHECK=true ;;
        --force) FORCE=true ;;
        *) echo "Usage: $0 [--check] [--force]" >&2; exit 2 ;;
    esac
done

GIT_DIR="$(git rev-parse --git-dir 2>/dev/null)" || {
    echo "ERROR: not a git repository" >&2; exit 1; }

HOOK="$GIT_DIR/hooks/pre-commit"
MARKER="# LiveSpec validation hook"

if $CHECK; then
    if [[ -f "$HOOK" ]] && grep -qF "$MARKER" "$HOOK"; then
        echo "INSTALLED: $HOOK"
    elif [[ -f "$HOOK" ]]; then
        echo "FOREIGN: $HOOK exists and was not installed by LiveSpec"
    else
        echo "ABSENT: no pre-commit hook"
    fi
    exit 0
fi

LOCAL="$GIT_DIR/hooks/pre-commit.local"
PRESERVED=false

# An existing foreign hook is preserved and chained, never discarded. Credential
# scanners installed via init.templateDir must keep running.
if [[ -f "$HOOK" ]] && ! grep -qF "$MARKER" "$HOOK"; then
    if [[ -f "$LOCAL" ]] && ! $FORCE; then
        echo "ERROR: both $HOOK and $LOCAL exist and neither was installed by LiveSpec." >&2
        echo "       Resolve by hand, or re-run with --force to keep $LOCAL and drop the other." >&2
        exit 1
    fi
    if [[ ! -f "$LOCAL" ]]; then
        mv "$HOOK" "$LOCAL"
        PRESERVED=true
    fi
fi

mkdir -p "$(dirname "$HOOK")"

cat > "$HOOK" <<'HOOKEOF'
#!/usr/bin/env bash
# LiveSpec validation hook
# Installed by scripts/setup-hooks.sh. Re-run that script to update.
#
# Resolves validators from the project first, then the plugin. When neither is
# available it skips rather than blocking: a contributor without LiveSpec
# installed must still be able to commit.

set -uo pipefail
cd "$(git rev-parse --show-toplevel)" || exit 0

resolve() {
    local name="$1"
    if [[ -f "scripts/$name" ]]; then
        echo "scripts/$name"
    elif [[ -n "${CLAUDE_PLUGIN_ROOT:-}" && -f "${CLAUDE_PLUGIN_ROOT}/scripts/$name" ]]; then
        echo "${CLAUDE_PLUGIN_ROOT}/scripts/$name"
    fi
}

FAILED=0
RAN=0

# Chain to a hook that predated LiveSpec (credential scanners, project hooks).
LOCAL_HOOK="$(git rev-parse --git-dir)/hooks/pre-commit.local"
if [[ -x "$LOCAL_HOOK" ]]; then
    if ! "$LOCAL_HOOK"; then
        echo "✗ pre-commit.local failed - commit blocked"
        exit 1
    fi
fi

for v in validate-frontmatter.sh validate-crossrefs.sh validate-constraints.sh; do
    path="$(resolve "$v")"
    [[ -z "$path" ]] && continue
    RAN=$((RAN+1))
    if ! bash "$path"; then
        echo ""
        echo "✗ $v failed - commit blocked"
        FAILED=1
    fi
done

if (( RAN == 0 )); then
    echo "LiveSpec: no validators resolved, skipping validation."
    exit 0
fi

if (( FAILED == 1 )); then
    echo ""
    echo "Fix the reported errors and try again."
    exit 1
fi

echo "✓ LiveSpec validation passed"
exit 0
HOOKEOF

chmod +x "$HOOK"

echo "Installed: $HOOK"
if $PRESERVED; then
    echo "Preserved:  $LOCAL (existing hook, still runs first)"
fi
echo "The hook will run whichever of these it can resolve, from scripts/ or \${CLAUDE_PLUGIN_ROOT}/scripts/:"
echo "  validate-frontmatter.sh"
echo "  validate-crossrefs.sh"
echo "  validate-constraints.sh"
echo ""
echo "It skips rather than blocking when none resolve."
exit 0
