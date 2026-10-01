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

TOP="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "ERROR: not a git repository" >&2; exit 1; }
cd "$TOP" || exit 1
GIT_DIR="$(git rev-parse --git-dir)"

HOOK="$GIT_DIR/hooks/pre-commit"
MARKER="# LiveSpec validation hook"

# The validators the hook runs, then the scripts generated project context
# instructs (the inlined spec-first template names both of the latter), then
# the helper their --json output needs.
HOOKED=(validate-frontmatter.sh validate-crossrefs.sh validate-constraints.sh)
VENDOR=("${HOOKED[@]}" check-requires-spec.sh validate-purpose.sh validator-output.sh)

# Vendored from beside this script. CLAUDE_PLUGIN_ROOT is not set in a shell or
# an agent's shell tool, so a hook relying on it skips every commit.
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
INERT=false
[[ "$SOURCE_DIR" == "$(pwd -P)/scripts" ]] && INERT=true

VERSION="unknown"
if [[ -f "$SOURCE_DIR/../project.yaml" ]]; then
    v="$(grep -A5 '^livespec:' "$SOURCE_DIR/../project.yaml" | grep -m1 'version:' \
        | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
    [[ -n "$v" ]] && VERSION="$v"
fi

# Provenance lives in a comment block after the shebang. The hash excludes
# those lines, so it stays verifiable after stamping.
PROV_RE='^# (vendored-from|source-version|source-hash): '
# sha256sum is absent from macOS before 15.2; shasum ships with every release.
sha256() { if command -v sha256sum >/dev/null; then sha256sum; else shasum -a 256; fi; }
script_hash() { grep -vE "$PROV_RE" "$1" | sha256 | cut -d" " -f1; }

stamp_script() {
    local src="$1" dst="$2" hash="$3" name="$4"
    awk -v from="scripts/$name" -v ver="$VERSION" -v hash="$hash" '
        NR==1 {
            print
            print "# vendored-from: " from
            print "# source-version: " ver
            print "# source-hash: sha256:" hash
            next
        }
        {print}
    ' "$src" > "$dst"
    chmod +x "$dst"
}

# Same four states as convention vendoring. Only absent and
# upstream-changed-but-unedited scripts are written.
vendor_scripts() {
    local write="$1" name src dst up recorded local_h
    if $INERT; then
        echo "This project is the toolchain source; nothing to vendor."
        return
    fi
    $write && mkdir -p scripts
    for name in "${VENDOR[@]}"; do
        src="$SOURCE_DIR/$name"; dst="scripts/$name"
        [[ -f "$src" ]] || continue
        up="$(script_hash "$src")"
        if [[ ! -f "$dst" ]]; then
            if $write; then stamp_script "$src" "$dst" "$up" "$name"; echo "  VENDORED    $dst"
            else echo "  ABSENT      $dst"; fi
            continue
        fi
        recorded="$(grep -m1 '^# source-hash:' "$dst" | sed 's/^# source-hash:[[:space:]]*sha256://')"
        if [[ -z "$recorded" ]]; then
            echo "  PROJECT     $dst (no provenance: the project's own, left alone)"
            continue
        fi
        local_h="$(script_hash "$dst")"
        if   [[ "$local_h" == "$recorded" && "$up" == "$recorded" ]]; then
            echo "  UNCHANGED   $dst"
        elif [[ "$local_h" != "$recorded" && "$up" == "$recorded" ]]; then
            echo "  LOCAL-EDIT  $dst (left alone)"
        elif [[ "$local_h" == "$recorded" ]]; then
            if $write; then stamp_script "$src" "$dst" "$up" "$name"; echo "  UPDATED     $dst"
            else echo "  UPSTREAM    $dst (update available)"; fi
        else
            echo "  DIVERGED    $dst (local edits and upstream change; resolve by hand)"
        fi
    done
}

# Where each hooked validator resolves at commit time.
report_resolution() {
    local v in_project=0
    for v in "${HOOKED[@]}"; do
        if [[ -f "scripts/$v" ]]; then
            echo "  project     scripts/$v"; in_project=$((in_project+1))
        elif [[ -n "${CLAUDE_PLUGIN_ROOT:-}" && -f "${CLAUDE_PLUGIN_ROOT}/scripts/$v" ]]; then
            echo "  plugin      $v (only while CLAUDE_PLUGIN_ROOT is set)"
        else
            echo "  UNRESOLVED  $v"
        fi
    done
    if (( in_project == 0 )); then
        echo ""
        echo "WARNING: no hooked validator is in the project's scripts/. CLAUDE_PLUGIN_ROOT"
        echo "         is normally unset at commit time, so the hook will skip every commit."
    fi
}

if $CHECK; then
    if [[ -f "$HOOK" ]] && grep -qF "$MARKER" "$HOOK"; then
        echo "INSTALLED: $HOOK"
    elif [[ -f "$HOOK" ]]; then
        echo "FOREIGN: $HOOK exists and was not installed by LiveSpec"
    else
        echo "ABSENT: no pre-commit hook"
    fi
    echo "Vendored scripts:"
    vendor_scripts false
    echo "Hooked validators resolve from:"
    report_resolution
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

# Only the specs being committed. Blocking on historical drift elsewhere in the
# tree trains contributors to bypass the hook; /livespec:audit validate reports it.
STAGED=()
while IFS= read -r -d '' f; do
    [[ -f "$f" ]] && STAGED+=("$f")
done < <(git diff --cached --name-only -z --diff-filter=ACMR -- '*.spec.md')

for v in validate-frontmatter.sh validate-crossrefs.sh; do
    path="$(resolve "$v")"
    [[ -z "$path" ]] && continue
    RAN=$((RAN+1))
    (( ${#STAGED[@]} )) || continue
    if ! bash "$path" "${STAGED[@]}"; then
        echo ""
        echo "✗ $v failed - commit blocked"
        FAILED=1
    fi
done

# Constraints are whole-tree by nature, so advisory: reported, never blocking.
path="$(resolve validate-constraints.sh)"
if [[ -n "$path" ]]; then
    RAN=$((RAN+1))
    if ! out="$(bash "$path" 2>&1)"; then
        echo "! validate-constraints.sh: $(grep -m1 -oE '[0-9]+ constraint violation\(s\)' <<< "$out") (advisory, not blocking; run it for detail)"
    fi
fi

if (( RAN == 0 )); then
    echo "LiveSpec: no validators resolved, skipping validation."
    exit 0
fi

(( ${#STAGED[@]} )) || echo "LiveSpec: no staged specs, spec validation skipped."

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
echo "Vendored scripts (source $VERSION):"
vendor_scripts true
echo "Hooked validators resolve from:"
report_resolution
echo ""
echo "The hook skips rather than blocking when none resolve."
exit 0
