#!/usr/bin/env bash
set -euo pipefail

# LiveSpec v5 Upgrade Script
# Migrates legacy installations (submodule/copy/symlink) and retired spec folder
# layouts to the v5 plugin architecture.
# Usage: upgrade-to-v5.sh [--detect-only] [--dry-run] [--map specs/<folder>=<target>]...
#   --detect-only  Report current state, make no changes
#   --dry-run      Show what would change without changing it
#   --map          Confirm where a folder needing a decision goes (repeatable)
#
# Specifies: specs/features/automation.spec.md

DRY_RUN=false
DETECT_ONLY=false
CHANGES_MADE=0
MAPS=""        # "folder|target" lines confirmed with --map

usage() {
  echo "Usage: upgrade-to-v5.sh [--detect-only] [--dry-run] [--map specs/<folder>=<target>]..."
  echo "  --detect-only  Report current state, make no changes"
  echo "  --dry-run      Show what would change without changing it"
  echo "  --map          Confirm where a folder needing a decision goes, e.g."
  echo "                 --map specs/meta=specs/workspace (repeatable)"
}

add_map() {
  local from="${1%%=*}" to="${1#*=}"
  from="${from%/}"; to="${to%/}"
  if [[ "$1" != *=* || "$from" != specs/* || "$from" == specs/*/* || -z "$to" \
        || "$to" == /* || "$to" == *..* || "$to" == "$from" ]]; then
    echo "ERROR: --map wants specs/<folder>=<repository path>, got '$1'" >&2
    exit 2
  fi
  MAPS+="${from#specs/}|$to"$'\n'
}

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=true ;;
    --detect-only) DETECT_ONLY=true ;;
    --map) [ $# -ge 2 ] || { usage >&2; exit 2; }; add_map "$2"; shift ;;
    --map=*) add_map "${1#--map=}" ;;
    --help|-h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
  shift
done

# The migration table: retired folder | target | kind | why.
#   auto     documented mapping, moved without asking
#   propose  a judgement: moved only once confirmed with --map
# Targets are repository paths; "-" means there is no folder to move it into.
TABLE='1-requirements|specs/foundation|auto|documented; strategic/ and functional/ are flattened
2-strategy|specs/strategy|auto|documented
3-behaviors|specs/features|auto|documented; contracts/ goes to specs/interfaces
3-contracts|specs/interfaces|auto|the pre-v5 contracts folder
4-contracts|specs/interfaces|auto|a pre-v5 template named 3-contracts/ this way in error
procedures|specs/interfaces/procedures|propose|process contracts live under interfaces
meta|specs/workspace|propose|it describes how the workspace works
reports|var/audit-reports|propose|reports are generated; delete instead if they can be regenerated
metaspecs|specs/workspace/standards|propose|delete copies of LiveSpec metaspecs; keep project-authored templates
4-validation|specs/features/validation|propose|validation behaviour; move any reports out of specs/
4-baseline|specs/features|propose|a brownfield baseline; keep its extraction markers
learnings|-|propose|accepted learnings become registry entries; raw notes can go, git keeps them'
CURRENT=" workspace foundation strategy features interfaces artifacts "

table_row() { printf '%s\n' "$TABLE" | awk -F'|' -v d="$1" '$1 == d { print; exit }'; }
map_for() { printf '%s' "$MAPS" | awk -F'|' -v d="$1" '$1 == d { t = $2 } END { print t }'; }

# --- Detection ---

echo "=== LiveSpec Installation Detection ==="

HAS_SUBMODULE=false
HAS_LEGACY_LIVESPEC=false
LEGACY_LIVESPEC_TYPE=""
HAS_VERSION_FILE=false
HAS_PLUGIN=false
HAS_PROJECT=false

if [ -d ".livespec-repo" ]; then
  echo "FOUND: .livespec-repo/ (legacy submodule)"
  HAS_SUBMODULE=true
fi

if [ -L ".livespec" ]; then
  echo "FOUND: .livespec (symlink)"
  HAS_LEGACY_LIVESPEC=true
  LEGACY_LIVESPEC_TYPE="symlink"
elif [ -d ".livespec" ]; then
  echo "FOUND: .livespec/ (copy directory)"
  HAS_LEGACY_LIVESPEC=true
  LEGACY_LIVESPEC_TYPE="directory"
elif [ -f ".livespec" ]; then
  echo "FOUND: .livespec (file)"
  HAS_LEGACY_LIVESPEC=true
  LEGACY_LIVESPEC_TYPE="file"
fi

# The git index records a retired install even where the working tree does not:
# a fresh clone leaves a submodule uninitialised, and a symlink may dangle.
if git rev-parse --git-dir >/dev/null 2>&1; then
  while read -r mode _ _ path; do
    if [ "$mode" = 160000 ] && [ "$path" = .livespec-repo ] && ! $HAS_SUBMODULE; then
      echo "FOUND: .livespec-repo (submodule recorded in the git index)"
      HAS_SUBMODULE=true
    elif [ "$mode" = 120000 ] && [ "$path" = .livespec ] && ! $HAS_LEGACY_LIVESPEC; then
      echo "FOUND: .livespec (symlink recorded in the git index)"
      HAS_LEGACY_LIVESPEC=true
      LEGACY_LIVESPEC_TYPE="symlink"
    fi
  done < <(git ls-files -s -- .livespec .livespec-repo 2>/dev/null || true)
  if ! $HAS_SUBMODULE && [ -f .gitmodules ] \
     && git config -f .gitmodules --get-regexp '^submodule\..*\.path$' 2>/dev/null | grep -q ' \.livespec-repo$'; then
    echo "FOUND: .livespec-repo (submodule declared in .gitmodules)"
    HAS_SUBMODULE=true
  fi
fi

if [ -f ".livespec-version" ]; then
  echo "FOUND: .livespec-version (legacy version file)"
  HAS_VERSION_FILE=true
fi

# Spec folder layout, classified against the table.
#   FOLDERS lines: folder|target|kind|why, kind one of auto, confirmed, decide, unknown
FOLDERS=""
HAS_CURRENT=false
HAS_RETIRED=false
NEEDS_DECISION=false
if [ -d specs ]; then
  for d in specs/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    case "$CURRENT" in *" $name "*) HAS_CURRENT=true; continue ;; esac
    row="$(table_row "$name")"
    mapped="$(map_for "$name")"
    if [ -n "$mapped" ]; then
      FOLDERS+="$name|$mapped|confirmed|confirmed with --map"$'\n'
      HAS_RETIRED=true
    elif [ -n "$row" ] && [ "$(cut -d'|' -f3 <<< "$row")" = auto ]; then
      FOLDERS+="$name|$(cut -d'|' -f2 <<< "$row")|auto|$(cut -d'|' -f4 <<< "$row")"$'\n'
      HAS_RETIRED=true
    elif [ -n "$row" ]; then
      FOLDERS+="$name|$(cut -d'|' -f2 <<< "$row")|decide|$(cut -d'|' -f4 <<< "$row")"$'\n'
      HAS_RETIRED=true; NEEDS_DECISION=true
    elif [[ "$name" == [0-9]-* ]]; then
      FOLDERS+="$name|-|decide|a retired numbered folder with no known mapping"$'\n'
      HAS_RETIRED=true; NEEDS_DECISION=true
    else
      FOLDERS+="$name|-|unknown|not a LiveSpec folder"$'\n'
    fi
  done
fi

LAYOUT="absent"
if $HAS_RETIRED && $HAS_CURRENT; then LAYOUT="retired+mixed"
elif $HAS_RETIRED; then LAYOUT="retired"
elif $HAS_CURRENT; then LAYOUT="current"
fi
echo "LAYOUT: $LAYOUT"

while IFS='|' read -r name target kind why; do
  [ -n "$name" ] || continue
  case "$kind" in
    auto|confirmed) echo "  MOVE      specs/$name/ -> $target/ ($why)" ;;
    decide)
      if [ "$target" = "-" ]; then
        echo "  DECIDE    specs/$name/: $why; choose a target with --map specs/$name=<path>"
      else
        echo "  DECIDE    specs/$name/ -> proposed $target/ ($why); confirm with --map specs/$name=$target"
      fi ;;
    unknown) echo "  UNKNOWN   specs/$name/ ($why; left in place)" ;;
  esac
done <<< "$FOLDERS"

# Context tree layout: flat, plus ctxt/domains/. Earlier generations wrote
# phases/ and utils/. A rebuild does not remove them, and no marker reliably
# identifies generated files across generations, so nothing here is moved.
CTXT_RETIRED=""
CTXT_OTHER=""
if [ -d ctxt ]; then
  for d in ctxt/*/; do
    [ -d "$d" ] || continue
    name="$(basename "$d")"
    case "$name" in
      domains) ;;
      phases|utils) CTXT_RETIRED+="$name " ;;
      *) CTXT_OTHER+="$name " ;;
    esac
  done
  if [ -n "$CTXT_RETIRED" ]; then echo "CONTEXT: retired layout"; else echo "CONTEXT: flat"; fi
  for name in $CTXT_RETIRED; do
    echo "  RETIRED   ctxt/$name/ (earlier generation; a rebuild does not remove it)"
  done
  for name in $CTXT_OTHER; do
    echo "  CHECK     ctxt/$name/ (not in the standard layout; keep it only if your context-architecture spec defines it)"
  done
fi

if [ -d ".claude-plugin" ] || [ -d "$HOME/.claude/plugins/marketplaces/livespec" ] || ls -d "$HOME/.claude/plugins/cache/"*"/livespec" >/dev/null 2>&1; then
  echo "FOUND: v5 plugin installed"
  HAS_PLUGIN=true
fi

# A LiveSpec PROJECT is identified by its own artifacts, independently of whether
# the plugin happens to be installed on this machine. Project work must not depend
# on the plugin, so plugin absence must never read as "not a LiveSpec project".
if { [ -f "PURPOSE.md" ] && [ -d "specs/workspace" ]; } || [ -f "project.yaml" ]; then
  echo "FOUND: LiveSpec project structure"
  HAS_PROJECT=true
fi

# Every version signal the project carries. project.yaml records the version the
# project has accepted (DEC-009); the others should agree with it.
yaml_version() {
  grep -A5 '^livespec:' "$1" 2>/dev/null | grep -m1 'version:' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || true
}
ACCEPTED="$(yaml_version project.yaml)"
if [ -n "$ACCEPTED" ]; then
  echo "VERSION: accepted $ACCEPTED (project.yaml)"
else
  echo "VERSION: none accepted (project.yaml has no livespec.version)"
fi
report_version() {   # report_version <label> <version> <file>
  echo "VERSION: $1 $2 ($3)"
  if [ -n "$ACCEPTED" ] && [ "$2" != "$ACCEPTED" ]; then
    echo "  DIFFERS   $3 is $2, accepted is $ACCEPTED"
  fi
}
VENDORED_COUNT=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  v="$(grep -m1 -E '^(# )?source-version: ' "$f" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || true)"
  if [ -n "$v" ]; then
    VENDORED_COUNT=$((VENDORED_COUNT + 1))
    if [ -n "$ACCEPTED" ] && [ "$v" != "$ACCEPTED" ]; then
      echo "  DIFFERS   $f was vendored from $v, accepted is $ACCEPTED"
    fi
  fi
done < <( { grep -l '^# source-version: ' scripts/*.sh 2>/dev/null
            grep -rl '^source-version: ' specs/workspace/standards 2>/dev/null; } | LC_ALL=C sort || true)
if [ "$VENDORED_COUNT" -gt 0 ]; then echo "VERSION: vendored files $VENDORED_COUNT"; fi
for doc in AGENTS.md CLAUDE.md; do
  v="$(grep -oE 'LiveSpec v[0-9]+\.[0-9]+\.[0-9]+' "$doc" 2>/dev/null | tail -1 | sed 's/LiveSpec v//' || true)"
  if [ -n "$v" ]; then report_version "context generated by" "$v" "$doc"; break; fi
done
if $HAS_VERSION_FILE; then
  v="$(grep -oE '[0-9]+\.[0-9]+\.[0-9]+' .livespec-version | head -1 || true)"
  if [ -n "$v" ]; then report_version "legacy" "$v" ".livespec-version"; fi
fi

# Summarise state
if ! $HAS_SUBMODULE && ! $HAS_LEGACY_LIVESPEC && ! $HAS_VERSION_FILE && ! $HAS_RETIRED \
   && [ -z "$CTXT_RETIRED" ]; then
  if $HAS_PROJECT; then
    echo ""
    echo "STATUS: Already on v5. Nothing to migrate."
    exit 0
  elif $HAS_PLUGIN; then
    echo ""
    echo "STATUS: Plugin installed, but no LiveSpec project structure here."
    echo "        Use /livespec:init to set up this project."
    exit 0
  else
    echo ""
    echo "STATUS: No LiveSpec installation detected. Use /livespec:init to set up."
    exit 0
  fi
fi

echo ""
echo "=== Migration Plan ==="

if $HAS_LEGACY_LIVESPEC; then
  echo "  REMOVE: .livespec ($LEGACY_LIVESPEC_TYPE)"
fi
if $HAS_SUBMODULE; then
  echo "  REMOVE: .livespec-repo/ (git submodule)"
fi
if $HAS_VERSION_FILE; then
  echo "  REMOVE: .livespec-version"
fi
while IFS='|' read -r name target kind _; do
  case "$kind" in
    auto|confirmed) echo "  MIGRATE: specs/$name/ -> $target/" ;;
    decide) echo "  NEEDS DECISION: specs/$name/ (not moved until confirmed with --map)" ;;
  esac
done <<< "$FOLDERS"
for name in $CTXT_RETIRED; do
  echo "  NEEDS DECISION: ctxt/$name/ (never moved; delete it yourself once /livespec:audit context has written the flat files)"
done

if $DETECT_ONLY; then
  exit 0
fi

if $DRY_RUN; then
  echo ""
  echo "(dry run - no changes made)"
  exit 0
fi

# --- Remove Legacy .livespec ---

if $HAS_LEGACY_LIVESPEC; then
  echo ""
  echo "Removing .livespec ($LEGACY_LIVESPEC_TYPE)..."
  case "$LEGACY_LIVESPEC_TYPE" in
    symlink|file) rm -f .livespec ;;
    directory) rm -rf .livespec ;;
  esac
  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))
fi

# --- Remove Legacy Submodule ---

if $HAS_SUBMODULE; then
  echo ""
  echo "Removing .livespec-repo/ submodule..."
  git submodule deinit -f .livespec-repo 2>/dev/null || true
  git rm -f .livespec-repo 2>/dev/null || git rm --cached .livespec-repo 2>/dev/null || true
  rm -rf .git/modules/.livespec-repo 2>/dev/null || true
  if [ -f .gitmodules ]; then
    # The section is named for the submodule, which need not match its path.
    while read -r key _; do
      section="${key%.path}"
      git config -f .gitmodules --remove-section "$section" 2>/dev/null || true
    done < <(git config -f .gitmodules --get-regexp '^submodule\..*\.path$' 2>/dev/null \
             | awk '$2 == ".livespec-repo"' || true)
    git add .gitmodules 2>/dev/null || true
  fi
  # Clean up directory if still present
  rm -rf .livespec-repo 2>/dev/null || true
  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))
fi

# --- Remove Legacy Version File ---

if $HAS_VERSION_FILE; then
  echo ""
  echo "Removing .livespec-version..."
  rm -f .livespec-version
  echo "  Done."
  CHANGES_MADE=$((CHANGES_MADE + 1))
fi

# --- Migrate Spec Folders ---

CONFLICTS=""
MOVED=""       # folders that moved, for reference rewriting and verification

# move_tree <from> <to> [flatten]: move every file under <from> to the same path
# under <to>, never overwriting. With flatten, the first directory level below
# <from> is dropped. A file whose destination exists stays put and is reported.
move_tree() {
  local from="$1" to="$2" flatten="${3:-}" f rel dest
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    rel="${f#"$from"/}"
    if [ -n "$flatten" ] && [[ "$rel" == */* ]]; then rel="${rel#*/}"; fi
    dest="$to/$rel"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
      CONFLICTS+="  $f (would overwrite $dest)"$'\n'
      continue
    fi
    mkdir -p "$(dirname "$dest")"
    mv "$f" "$dest"
  done < <(find "$from" \( -type f -o -type l \) 2>/dev/null | LC_ALL=C sort)
  find "$from" -depth -type d -empty -exec rmdir {} \; 2>/dev/null || true
}

if grep -qE '\|(auto|confirmed)\|' <<< "$FOLDERS"; then
  echo ""
  echo "Migrating specs/ folders..."
  mkdir -p specs/workspace specs/foundation specs/strategy specs/features specs/interfaces
  while IFS='|' read -r name target kind _; do
    case "$kind" in auto|confirmed) ;; *) continue ;; esac
    if [ "$kind" = auto ] && [ "$name" = 1-requirements ]; then
      move_tree "specs/$name" "$target" flatten
    elif [ "$kind" = auto ] && [ "$name" = 3-behaviors ]; then
      if [ -d specs/3-behaviors/contracts ]; then move_tree specs/3-behaviors/contracts specs/interfaces; fi
      move_tree "specs/$name" "$target"
    else
      move_tree "specs/$name" "$target"
    fi
    echo "  Moved: specs/$name/ -> $target/"
    MOVED+="$name|$target|$kind"$'\n'
  done <<< "$FOLDERS"
  CHANGES_MADE=$((CHANGES_MADE + 1))

  # Rewrite references to every folder that moved, most specific first.
  SEDS=()
  while IFS='|' read -r name target kind; do
    [ -n "$name" ] || continue
    if [ "$kind" = auto ] && [ "$name" = 1-requirements ]; then
      SEDS+=(-e 's|specs/1-requirements/\([A-Za-z0-9_-]*/\)\{0,1\}|specs/foundation/|g')
    elif [ "$kind" = auto ] && [ "$name" = 3-behaviors ]; then
      SEDS+=(-e 's|specs/3-behaviors/contracts/|specs/interfaces/|g' -e 's|specs/3-behaviors/|specs/features/|g')
    else
      SEDS+=(-e "s|specs/$name/|$target/|g")
    fi
  done <<< "$MOVED"

  echo ""
  echo "Updating cross-references in specs..."
  UPDATED=0
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    sed "${SEDS[@]}" "$f" > "$f.livespec-tmp"
    if cmp -s "$f" "$f.livespec-tmp"; then
      rm -f "$f.livespec-tmp"
    else
      cat "$f.livespec-tmp" > "$f"; rm -f "$f.livespec-tmp"
      echo "  Updated: $f"; UPDATED=$((UPDATED + 1))
    fi
  done < <(grep -rlE 'specs/[A-Za-z0-9_-]+/' specs 2>/dev/null | LC_ALL=C sort || true)
  [ "$UPDATED" -gt 0 ] || echo "  No stale references found."
fi

# --- Summary ---

echo ""
echo "=== Migration Complete ==="
echo "Changes made: $CHANGES_MADE"

# Verify
echo ""
echo "=== Verification ==="
PASS=true
if [ -d ".livespec-repo" ]; then echo "FAIL: .livespec-repo/ still exists"; PASS=false; else echo "PASS: No submodule"; fi
if [ -e ".livespec" ] || [ -L ".livespec" ]; then echo "FAIL: .livespec still exists"; PASS=false; else echo "PASS: No legacy .livespec"; fi
if [ -f ".livespec-version" ]; then echo "FAIL: .livespec-version still exists"; PASS=false; else echo "PASS: No version file"; fi

if [ -n "$CONFLICTS" ]; then
  echo "FAIL: Files left in place because their destination already exists:"
  printf '%s' "$CONFLICTS"
  echo "      Compare each pair, keep one, then re-run."
  PASS=false
fi
while IFS='|' read -r name target kind; do
  [ -n "$name" ] || continue
  if [ -d "specs/$name" ]; then echo "FAIL: specs/$name/ still holds files"; PASS=false; fi
  if grep -rlF "specs/$name/" specs >/dev/null 2>&1; then
    echo "WARN: References to specs/$name/ remain in:"
    grep -rlF "specs/$name/" specs | sed 's/^/  /'
  fi
done <<< "$MOVED"
if [ -z "$MOVED" ] && ! $NEEDS_DECISION; then echo "PASS: No retired spec folders"; fi
while IFS='|' read -r name target kind _; do
  if [ "$kind" = decide ]; then
    [ "$target" = "-" ] && target="<path>"
    echo "DECIDE: specs/$name/ was not moved; confirm a target with --map specs/$name=$target"
    PASS=false
  fi
done <<< "$FOLDERS"
for name in $CTXT_RETIRED; do
  echo "DECIDE: ctxt/$name/ is a retired context layout; regenerate with /livespec:audit context, then delete it"
  PASS=false
done

if $PASS; then
  echo ""
  echo "All checks passed. Ready to commit."
  exit 0
else
  echo ""
  echo "Some checks failed. Review manually."
  exit 1
fi
