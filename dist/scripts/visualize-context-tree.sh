#!/bin/bash
# LiveSpec Context Tree Visualizer
# Shows link-based dependency tree of agent context files
# Spec: specs/3-behaviors/utils/context-tree-visualizer.spec.md

set -e

# Colors
RESET='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
GRAY='\033[0;90m'

# Configuration
ROOT_AGENTS="${AGENTS_MD:-AGENTS.md}"
MAX_DEPTH="${MAX_DEPTH:-4}"
SHOW_SIZES="${SHOW_SIZES:-true}"
SHOW_DUPLICATES="${SHOW_DUPLICATES:-true}"

# Track visited files to detect duplicates
declare -A VISITED_FILES
declare -A FILE_SIZES
TOTAL_SIZE=0

# Usage
usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Visualizes the link-based context tree showing actual document references.

OPTIONS:
  -r, --root FILE       Root AGENTS.md file (default: AGENTS.md)
  -d, --depth N         Maximum depth to traverse (default: 4)
  -s, --no-sizes        Hide file sizes
  -u, --no-duplicates   Hide duplicate indicators
  -h, --help            Show this help

EXAMPLES:
  # Basic usage
  ./scripts/visualize-context-tree.sh

  # Custom root file
  ./scripts/visualize-context-tree.sh -r dist/AGENTS.md

  # Limit depth
  ./scripts/visualize-context-tree.sh -d 2

OUTPUT:
  - Blue: ctxt/* files
  - Green: specs/* files
  - Yellow: .livespec/* prompts
  - Red: Missing files
  - (DUP): File already referenced elsewhere

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--root)
            ROOT_AGENTS="$2"
            shift 2
            ;;
        -d|--depth)
            MAX_DEPTH="$2"
            shift 2
            ;;
        -s|--no-sizes)
            SHOW_SIZES=false
            shift
            ;;
        -u|--no-duplicates)
            SHOW_DUPLICATES=false
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Get file size in KB
get_size() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local bytes=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
        echo $((bytes / 1024))
    else
        echo 0
    fi
}

# Get color for file type
get_color() {
    local file="$1"
    case "$file" in
        ctxt/*) echo "$BLUE" ;;
        specs/*) echo "$GREEN" ;;
        .livespec/*) echo "$YELLOW" ;;
        *) echo "$RESET" ;;
    esac
}

# Extract markdown links from file
extract_links() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        return
    fi

    # Extract markdown links: [text](path)
    grep -oP '(?<=\]\()[^)]+(?=\))' "$file" 2>/dev/null || true

    # Extract "Load ctxt/..." patterns (from When to Load Sub-Agents section)
    grep -oP '(?<=Load )(ctxt/[^*]+\.md)(?=\*\*)' "$file" 2>/dev/null || true

    # Extract backtick-wrapped paths
    grep -oP '`(\.livespec/[^`]+\.md)`' "$file" 2>/dev/null | tr -d '`' || true
    grep -oP '`(specs/[^`]+\.spec\.md)`' "$file" 2>/dev/null | tr -d '`' || true

    # Extract "See Reference Library: file.md" patterns
    grep -oP '(?<=See Reference Library: )`[^`]+`' "$file" 2>/dev/null | tr -d '`' || true
    grep -oP '(?<=See: )`[^`]+`' "$file" 2>/dev/null | tr -d '`' || true
    grep -oP '(?<=Fetch when: )`[^`]+`' "$file" 2>/dev/null | tr -d '`' || true
}

# Clean and normalize path
normalize_path() {
    local path="$1"
    # Remove leading ./ or /
    path="${path#./}"
    path="${path#/}"
    echo "$path"
}

# Check if file was already visited
is_duplicate() {
    local file="$1"
    [[ -n "${VISITED_FILES[$file]}" ]]
}

# Mark file as visited
mark_visited() {
    local file="$1"
    VISITED_FILES["$file"]=1
}

# Print tree node
print_node() {
    local prefix="$1"
    local file="$2"
    local is_last="$3"
    local depth="$4"

    # Tree characters
    local connector="├── "
    local continue_prefix="│   "
    if [[ "$is_last" == "true" ]]; then
        connector="└── "
        continue_prefix="    "
    fi

    # Check if duplicate
    local dup_marker=""
    local is_dup=false
    if is_duplicate "$file"; then
        is_dup=true
        if [[ "$SHOW_DUPLICATES" == "true" ]]; then
            dup_marker=" ${GRAY}(DUP)${RESET}"
        fi
    else
        mark_visited "$file"
    fi

    # Get file info
    local color=$(get_color "$file")
    local size=""
    if [[ "$SHOW_SIZES" == "true" ]]; then
        local kb=$(get_size "$file")
        if [[ $kb -gt 0 ]]; then
            size=" ${GRAY}(${kb}KB)${RESET}"
            FILE_SIZES["$file"]=$kb
            TOTAL_SIZE=$((TOTAL_SIZE + kb))
        fi
    fi

    # Check if file exists
    local exists_marker=""
    if [[ ! -f "$file" ]]; then
        color="$RED"
        exists_marker=" ${RED}[MISSING]${RESET}"
    fi

    # Print the node
    echo -e "${prefix}${connector}${color}${file}${RESET}${size}${dup_marker}${exists_marker}"

    # If duplicate or max depth, don't recurse
    if [[ "$is_dup" == "true" ]] || [[ $depth -ge $MAX_DEPTH ]]; then
        return
    fi

    # Extract links from this file and recurse
    if [[ -f "$file" ]]; then
        local links=($(extract_links "$file" | sort -u))
        local num_links=${#links[@]}

        for i in "${!links[@]}"; do
            local link="${links[$i]}"
            link=$(normalize_path "$link")

            # Skip empty, external links, or anchors
            [[ -z "$link" ]] && continue
            [[ "$link" =~ ^http ]] && continue
            [[ "$link" =~ ^# ]] && continue

            local is_last_link=false
            [[ $((i + 1)) -eq $num_links ]] && is_last_link=true

            print_node "${prefix}${continue_prefix}" "$link" "$is_last_link" $((depth + 1))
        done
    fi
}

# Main execution
main() {
    echo -e "${BLUE}Context Tree: Link-Based Dependencies${RESET}"
    echo -e "${GRAY}Root: $ROOT_AGENTS${RESET}"
    echo ""

    # Check root exists
    if [[ ! -f "$ROOT_AGENTS" ]]; then
        echo -e "${RED}Error: Root file not found: $ROOT_AGENTS${RESET}"
        exit 1
    fi

    # Start from root
    print_node "" "$ROOT_AGENTS" "false" 0

    # Summary
    if [[ "$SHOW_SIZES" == "true" ]]; then
        echo ""
        echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
        echo -e "${GRAY}Total context size: ${TOTAL_SIZE}KB${RESET}"

        if [[ $TOTAL_SIZE -gt 100 ]]; then
            echo -e "${RED}⚠ Warning: Total size exceeds 100KB budget${RESET}"
        else
            echo -e "${GREEN}✓ Within 100KB budget${RESET}"
        fi
    fi

    # Duplicate summary
    if [[ "$SHOW_DUPLICATES" == "true" ]]; then
        local dup_count=0
        for file in "${!VISITED_FILES[@]}"; do
            # Count how many times each file appears in tree
            # (This is simplified - could be enhanced to track actual count)
            :
        done
    fi
}

main
