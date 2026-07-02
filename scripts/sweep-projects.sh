#!/usr/bin/env bash
# LiveSpec Project Sweep - Discovery & Fingerprinting
# Scans ~/projects/ for LiveSpec-adjacent projects and scores them by maintenance need.
# Usage: sweep-projects.sh [--json] [--root <path>] [--stale-days <N>]
# Output: Markdown priority table (default) or JSON array (--json)

set -uo pipefail

# --- Configuration ---
PROJECTS_ROOT="${HOME}/projects"
EXCLUDE_DIR="tmp"
STALE_DAYS=60
OUTPUT_JSON=false
CURRENT_PLUGIN_VERSION="5.1.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for arg in "$@"; do
  case "$arg" in
    --json) OUTPUT_JSON=true ;;
    --root) shift; PROJECTS_ROOT="$1" ;;
    --stale-days) shift; STALE_DAYS="$1" ;;
    --help|-h)
      echo "Usage: sweep-projects.sh [--json] [--root <path>] [--stale-days <N>]"
      echo "  --json            Output JSON array instead of markdown"
      echo "  --root <path>     Root directory to scan (default: ~/projects)"
      echo "  --stale-days <N>  Days without spec commit to flag as stale (default: 60)"
      exit 0
      ;;
  esac
done

# --- Helpers ---

# Check if path is under excluded directory
is_excluded() {
  local path="$1"
  local rel="${path#"${PROJECTS_ROOT}/"}"
  local first_segment="${rel%%/*}"
  [[ "$first_segment" == "$EXCLUDE_DIR" ]]
}

# Check version lag signal (0=ok, 1=warning, 2=critical)
score_version_lag() {
  local project_dir="$1"
  local version_file="${project_dir}/.livespec-version"
  local plugin_manifest="${project_dir}/.claude-plugin/plugin.json"

  # Check for .livespec-version file
  if [[ -f "$version_file" ]]; then
    local project_version
    project_version=$(cat "$version_file" | tr -d '[:space:]')
    if [[ "$project_version" == "$CURRENT_PLUGIN_VERSION" ]]; then
      echo 0; return
    fi
    # Older major version = critical, older minor = warning
    local proj_major proj_minor
    proj_major=$(echo "$project_version" | cut -d. -f1)
    local curr_major
    curr_major=$(echo "$CURRENT_PLUGIN_VERSION" | cut -d. -f1)
    if [[ "$proj_major" != "$curr_major" ]]; then
      echo 2; return
    fi
    echo 1; return
  fi

  # Check for legacy .livespec/ directory (pre-plugin)
  if [[ -d "${project_dir}/.livespec" ]]; then
    echo 2; return  # Legacy installation, critical lag
  fi

  # No version tracking at all
  if [[ -d "${project_dir}/specs" ]]; then
    echo 1; return  # Has specs but no version tracking
  fi

  echo 0
}

# Check missing required files signal (0=ok, 1=warning, 2=critical)
score_missing_files() {
  local project_dir="$1"
  local missing_critical=0
  local missing_warning=0

  # Critical: AGENTS.md
  [[ ! -f "${project_dir}/AGENTS.md" ]] && ((missing_critical++))

  # Critical: PURPOSE.md
  [[ ! -f "${project_dir}/PURPOSE.md" ]] && ((missing_critical++))

  # Warning: specs/workspace/ directory
  [[ ! -d "${project_dir}/specs/workspace" ]] && ((missing_warning++))

  # Warning: specs/foundation/ directory
  [[ ! -d "${project_dir}/specs/foundation" ]] && ((missing_warning++))

  if (( missing_critical >= 1 )); then
    echo 2; return
  fi
  if (( missing_warning >= 2 )); then
    echo 1; return
  fi
  echo 0
}

# Check stale specs signal (0=ok, 1=warning, 2=critical)
score_stale_specs() {
  local project_dir="$1"

  # Only meaningful if it's a git repo
  if [[ ! -d "${project_dir}/.git" ]]; then
    echo 0; return
  fi

  # Check if there's any spec activity in last STALE_DAYS days
  local spec_count=0
  spec_count=$(cd "$project_dir" && timeout 3 git log \
    --oneline --since="${STALE_DAYS} days ago" \
    -- "specs/" "*.spec.md" 2>/dev/null | wc -l) || spec_count=0
  spec_count=$(( 10#${spec_count//[[:space:]]/} + 0 ))

  # Check if project has been active (any commits) in same period
  local activity_count=0
  activity_count=$(cd "$project_dir" && timeout 3 git log \
    --oneline --since="${STALE_DAYS} days ago" 2>/dev/null | wc -l) || activity_count=0
  activity_count=$(( 10#${activity_count//[[:space:]]/} + 0 ))

  # Active project with zero spec commits = warning/critical
  if (( activity_count > 5 && spec_count == 0 )); then
    echo 2; return
  fi
  if (( activity_count > 2 && spec_count == 0 )); then
    echo 1; return
  fi

  echo 0
}

# Check structure violations signal (0=ok, 1=warning, 2=critical)
score_structure_violations() {
  local project_dir="$1"
  local violations=0

  # Check if specs exist at all
  if [[ ! -d "${project_dir}/specs" ]]; then
    echo 0; return  # Not a specs project - not a violation
  fi

  # Sample up to 10 spec files for format compliance
  local spec_files
  mapfile -t spec_files < <(find "${project_dir}/specs" -name "*.spec.md" 2>/dev/null | head -10)

  if (( ${#spec_files[@]} == 0 )); then
    echo 0; return
  fi

  for spec in "${spec_files[@]}"; do
    local has_frontmatter=false
    local has_criticality=false
    local has_requirements=false

    # Check for YAML frontmatter
    if head -1 "$spec" 2>/dev/null | grep -q "^---"; then
      has_frontmatter=true
    fi

    # Check for criticality field
    if grep -q "^criticality:" "$spec" 2>/dev/null; then
      has_criticality=true
    fi

    # Check for Requirements section
    if grep -q "^## Requirements" "$spec" 2>/dev/null; then
      has_requirements=true
    fi

    if ! $has_frontmatter || ! $has_criticality; then
      ((violations++))
    fi
    if ! $has_requirements; then
      ((violations++))
    fi
  done

  local total_files=${#spec_files[@]}
  local violation_rate=$(( violations * 100 / (total_files * 2) ))

  if (( violation_rate >= 50 )); then
    echo 2; return
  fi
  if (( violation_rate >= 20 )); then
    echo 1; return
  fi
  echo 0
}

# Check incomplete/unlinked specs signal (0=ok, 1=warning, 2=critical)
score_incomplete_specs() {
  local project_dir="$1"
  local incomplete=0

  if [[ ! -d "${project_dir}/specs" ]]; then
    echo 0; return
  fi

  local spec_files
  mapfile -t spec_files < <(find "${project_dir}/specs" -name "*.spec.md" 2>/dev/null | head -10)

  if (( ${#spec_files[@]} == 0 )); then
    echo 0; return
  fi

  for spec in "${spec_files[@]}"; do
    # Check for failure_mode
    if ! grep -q "failure_mode:" "$spec" 2>/dev/null; then
      ((incomplete++))
    fi
    # Check for [!] requirement markers
    if grep -q "^## Requirements" "$spec" 2>/dev/null && ! grep -q "^\- \[!\]" "$spec" 2>/dev/null; then
      ((incomplete++))
    fi
  done

  local total_files=${#spec_files[@]}
  local incomplete_rate=$(( incomplete * 100 / (total_files * 2 + 1) ))

  if (( incomplete_rate >= 50 )); then
    echo 2; return
  fi
  if (( incomplete_rate >= 25 )); then
    echo 1; return
  fi
  echo 0
}

# Build comma-separated list of triggered signal names
get_signals_list() {
  local v_lag="$1" v_missing="$2" v_stale="$3" v_struct="$4" v_incomplete="$5"
  local signals=()
  (( v_lag > 0 ))        && signals+=("version-lag(${v_lag})")
  (( v_missing > 0 ))    && signals+=("missing-files(${v_missing})")
  (( v_stale > 0 ))      && signals+=("stale-specs(${v_stale})")
  (( v_struct > 0 ))     && signals+=("structure(${v_struct})")
  (( v_incomplete > 0 )) && signals+=("incomplete(${v_incomplete})")
  echo "${signals[*]}" | tr ' ' ','
}

# --- Discovery ---

# Collect all candidate project directories (depth 1 under root)
declare -a projects=()
while IFS= read -r -d '' dir; do
  is_excluded "$dir" && continue
  projects+=("$dir")
done < <(find "$PROJECTS_ROOT" -mindepth 1 -maxdepth 1 -type d -print0 2>/dev/null)

# --- Fingerprinting ---

declare -a results=()

for project_dir in "${projects[@]}"; do
  # Must have at least one LiveSpec signal to qualify
  has_signal=false
  [[ -d "${project_dir}/specs"    ]] && has_signal=true
  [[ -d "${project_dir}/.livespec" ]] && has_signal=true
  [[ -f "${project_dir}/AGENTS.md" ]] && has_signal=true
  [[ -f "${project_dir}/PURPOSE.md" ]] && has_signal=true
  $has_signal || continue

  project_name="$(basename "$project_dir")"

  # Score each signal
  v_lag=$(score_version_lag "$project_dir")
  v_missing=$(score_missing_files "$project_dir")
  v_stale=$(score_stale_specs "$project_dir")
  v_struct=$(score_structure_violations "$project_dir")
  v_incomplete=$(score_incomplete_specs "$project_dir")

  total=$(( v_lag + v_missing + v_stale + v_struct + v_incomplete ))
  signals=$(get_signals_list "$v_lag" "$v_missing" "$v_stale" "$v_struct" "$v_incomplete")

  # Status label
  if (( total == 0 )); then
    status="HEALTHY"
  elif (( total <= 3 )); then
    status="WARNING"
  else
    status="CRITICAL"
  fi

  results+=("${total}|${project_name}|${project_dir}|${status}|${signals}")
done

# Sort by score descending
mapfile -t sorted_results < <(printf '%s\n' "${results[@]}" | sort -t'|' -k1 -rn)

# --- Output ---

if $OUTPUT_JSON; then
  echo "["
  first=true
  for entry in "${sorted_results[@]}"; do
    IFS='|' read -r score name path status signals <<< "$entry"
    $first || echo ","
    first=false
    printf '  {"score":%s,"name":"%s","path":"%s","status":"%s","signals":"%s"}' \
      "$score" "$name" "$path" "$status" "$signals"
  done
  echo ""
  echo "]"
else
  # Markdown table output
  echo "# LiveSpec Sweep — Project Discovery"
  echo ""
  echo "**Scanned:** \`${PROJECTS_ROOT}\` (excluding \`${EXCLUDE_DIR}/\`)"
  echo "**Date:** $(date +%Y-%m-%d)"
  echo "**Plugin version:** ${CURRENT_PLUGIN_VERSION}"
  echo ""

  # Separate by status
  critical=()
  warning=()
  healthy=()
  for entry in "${sorted_results[@]}"; do
    IFS='|' read -r score name path status signals <<< "$entry"
    case "$status" in
      CRITICAL) critical+=("$entry") ;;
      WARNING)  warning+=("$entry") ;;
      *)        healthy+=("$entry") ;;
    esac
  done

  total_projects=${#sorted_results[@]}
  echo "**Projects found:** ${total_projects} (${#critical[@]} critical, ${#warning[@]} warning, ${#healthy[@]} healthy)"
  echo ""

  if (( ${#critical[@]} > 0 || ${#warning[@]} > 0 )); then
    echo "## Projects Needing Maintenance"
    echo ""
    echo "| Score | Status   | Project          | Signals |"
    echo "|-------|----------|------------------|---------|"
    for entry in "${critical[@]}" "${warning[@]}"; do
      IFS='|' read -r score name path status signals <<< "$entry"
      [[ -z "$signals" ]] && signals="—"
      printf "| %-5s | %-8s | %-16s | %s |\n" "$score/10" "$status" "$name" "$signals"
    done
    echo ""
  fi

  if (( ${#healthy[@]} > 0 )); then
    echo "## Healthy Projects"
    echo ""
    echo "| Project | Path |"
    echo "|---------|------|"
    for entry in "${healthy[@]}"; do
      IFS='|' read -r score name path status signals <<< "$entry"
      printf "| %-20s | %s |\n" "$name" "$path"
    done
    echo ""
  fi

  if (( total_projects == 0 )); then
    echo "_No LiveSpec-adjacent projects found under \`${PROJECTS_ROOT}\`._"
  fi
fi
