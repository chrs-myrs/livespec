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
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# The version of the toolchain running the sweep, from its own project.yaml.
CURRENT_PLUGIN_VERSION="$(grep -A5 '^livespec:' "${SCRIPT_DIR}/../project.yaml" 2>/dev/null \
  | grep -m1 'version:' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || true)"
CURRENT_PLUGIN_VERSION="${CURRENT_PLUGIN_VERSION:-unknown}"

usage() {
  echo "Usage: sweep-projects.sh [--json] [--root <path>] [--stale-days <N>]"
  echo "  --json            Output JSON array instead of markdown"
  echo "  --root <path>     Root directory to scan (default: ~/projects)"
  echo "  --stale-days <N>  Days without spec commit to flag as stale (default: 60)"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --json) OUTPUT_JSON=true ;;
    --root)
      [[ $# -ge 2 ]] || { usage >&2; exit 2; }
      PROJECTS_ROOT="${2%/}"; shift ;;
    --stale-days)
      [[ $# -ge 2 && "$2" =~ ^[0-9]+$ ]] || { usage >&2; exit 2; }
      STALE_DAYS="$2"; shift ;;
    --help|-h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
  shift
done

# --- Helpers ---

# Check if path is under excluded directory
is_excluded() {
  local path="$1"
  local rel="${path#"${PROJECTS_ROOT}/"}"
  local first_segment="${rel%%/*}"
  [[ "$first_segment" == "$EXCLUDE_DIR" ]]
}

# Check version lag signal (0=ok, 1=warning, 2=critical). Detection comes from
# the upgrade script, so the sweep and the upgrade agree on what needs migrating.
score_version_lag() {
  local project_dir="$1" detect accepted
  detect="$(cd "$project_dir" && bash "${SCRIPT_DIR}/upgrade-to-v5.sh" --detect-only 2>/dev/null || true)"

  # A retired install or spec layout needs migration whatever the version says
  if grep -qE '^FOUND: \.livespec|^LAYOUT: retired' <<< "$detect"; then
    echo 2; return
  fi

  accepted="$(sed -n 's/^VERSION: accepted \([0-9.]*\) .*/\1/p' <<< "$detect")"
  if [[ -z "$accepted" ]]; then
    # Has specs but records no accepted version
    if [[ -d "${project_dir}/specs" ]]; then echo 1; else echo 0; fi
    return
  fi
  if [[ "$CURRENT_PLUGIN_VERSION" == unknown || "$accepted" == "$CURRENT_PLUGIN_VERSION" ]]; then
    echo 0; return
  fi
  # Older major version = critical, older minor = warning
  if [[ "${accepted%%.*}" != "${CURRENT_PLUGIN_VERSION%%.*}" ]]; then
    echo 2; return
  fi
  echo 1
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

# One pass over every spec in the project: "files structure-violations incomplete".
#   structure: no frontmatter or criticality, and no Requirements section
#   incomplete: no failure_mode, and a Requirements section with no [!] marker
spec_stats() {
  local project_dir="$1"
  if [[ ! -d "${project_dir}/specs" ]]; then echo "0 0 0"; return; fi
  find "${project_dir}/specs" -name "*.spec.md" -type f 2>/dev/null | LC_ALL=C sort | awk '
    {
      file = $0; first = 1; fm = crit = req = fail = mark = 0
      while ((getline line < file) > 0) {
        if (first) { fm = (line ~ /^---/); first = 0 }
        if (line ~ /^criticality:/) crit = 1
        if (line ~ /^## Requirements/) req = 1
        if (line ~ /failure_mode:/) fail = 1
        if (line ~ /^- \[!\]/) mark = 1
      }
      close(file)
      n++
      if (!fm || !crit) sv++
      if (!req) sv++
      if (!fail) inc++
      if (req && !mark) inc++
    }
    END { print n + 0, sv + 0, inc + 0 }'
}

# Check structure violations signal (0=ok, 1=warning, 2=critical)
score_structure_violations() {
  local total violations
  read -r total violations _ <<< "$1"
  if (( total == 0 )); then echo 0; return; fi
  local violation_rate=$(( violations * 100 / (total * 2) ))
  if (( violation_rate >= 50 )); then echo 2; return; fi
  if (( violation_rate >= 20 )); then echo 1; return; fi
  echo 0
}

# Check incomplete/unlinked specs signal (0=ok, 1=warning, 2=critical)
score_incomplete_specs() {
  local total incomplete
  read -r total _ incomplete <<< "$1"
  if (( total == 0 )); then echo 0; return; fi
  local incomplete_rate=$(( incomplete * 100 / (total * 2 + 1) ))
  if (( incomplete_rate >= 50 )); then echo 2; return; fi
  if (( incomplete_rate >= 25 )); then echo 1; return; fi
  echo 0
}

# Build comma-separated list of triggered signal names
get_signals_list() {
  local v_lag="$1" v_missing="$2" v_stale="$3" v_struct="$4" v_incomplete="$5"
  local found=()
  (( v_lag > 0 ))        && found+=("version-lag(${v_lag})")
  (( v_missing > 0 ))    && found+=("missing-files(${v_missing})")
  (( v_stale > 0 ))      && found+=("stale-specs(${v_stale})")
  (( v_struct > 0 ))     && found+=("structure(${v_struct})")
  (( v_incomplete > 0 )) && found+=("incomplete(${v_incomplete})")
  # An empty array is unbound under set -u in the bash macOS ships (3.2)
  if (( ${#found[@]} )); then echo "${found[*]}" | tr ' ' ','; else echo ""; fi
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
  [[ -e "${project_dir}/.livespec" || -L "${project_dir}/.livespec" ]] && has_signal=true
  [[ -e "${project_dir}/.livespec-repo" ]] && has_signal=true
  [[ -f "${project_dir}/AGENTS.md" ]] && has_signal=true
  [[ -f "${project_dir}/PURPOSE.md" ]] && has_signal=true
  [[ -f "${project_dir}/project.yaml" ]] && has_signal=true
  $has_signal || continue

  project_name="$(basename "$project_dir")"

  # Score each signal
  v_lag=$(score_version_lag "$project_dir")
  v_missing=$(score_missing_files "$project_dir")
  v_stale=$(score_stale_specs "$project_dir")
  stats=$(spec_stats "$project_dir")
  v_struct=$(score_structure_violations "$stats")
  v_incomplete=$(score_incomplete_specs "$stats")

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

# Sort by score descending, then name
sorted_results=()
if (( ${#results[@]} > 0 )); then
  while IFS= read -r entry; do sorted_results+=("$entry"); done \
    < <(printf '%s\n' "${results[@]}" | LC_ALL=C sort -t'|' -k1,1rn -k2,2)
fi

json_str() {
  local s="$1"
  s="${s//\\/\\\\}"; s="${s//\"/\\\"}"
  s="${s//$'\t'/\\t}"; s="${s//$'\n'/\\n}"; s="${s//$'\r'/\\r}"
  printf '"%s"' "$s"
}

# --- Output ---

if $OUTPUT_JSON; then
  echo "["
  first=true
  for entry in "${sorted_results[@]}"; do
    IFS='|' read -r score name path status signals <<< "$entry"
    $first || echo ","
    first=false
    printf '  {"score":%s,"name":%s,"path":%s,"status":%s,"signals":%s}' \
      "$score" "$(json_str "$name")" "$(json_str "$path")" "$(json_str "$status")" "$(json_str "$signals")"
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
