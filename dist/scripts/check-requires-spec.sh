#!/bin/bash
# LiveSpec Spec Requirement Checker
# Usage: ./scripts/check-requires-spec.sh path/to/file.ext
# Returns: 0 if spec exists or not needed, 1 if spec required but missing

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check usage
if [ -z "$1" ]; then
    echo "Usage: $0 <filepath>"
    echo ""
    echo "Checks if a file requires a specification and whether one exists."
    echo ""
    echo "Returns:"
    echo "  0 - Spec exists or not required"
    echo "  1 - Spec required but missing"
    exit 1
fi

filepath="$1"
filename=$(basename "$filepath")
name_without_ext="${filename%.*}"

# Exceptions - files that don't need specs
if [[ "$filepath" =~ ^(var|generated|\.archive|\.git|node_modules|\.cache|build|dist)/ ]]; then
    echo -e "${GREEN}✓ No spec needed: $filepath (temporary/generated)${NC}"
    exit 0
fi

# Exception - .livespec is read-only framework (NEVER create specs for it, NEVER write to it)
if [[ "$filepath" =~ ^\.livespec/ ]] || [[ "$filepath" =~ ^\.livespec-repo/ ]]; then
    echo -e "${RED}✗ NEVER write to .livespec/ directory${NC}"
    echo ""
    echo -e "${YELLOW}.livespec/ is a read-only methodology framework reference.${NC}"
    echo ""
    echo -e "${BLUE}Customize your project instead:${NC}"
    echo -e "  • Process rules → specs/workspace/ (constitution, patterns, workflows)"
    echo -e "  • Project prompts → prompts/generated/ (project-specific prompts)"
    echo -e "  • Agent context → AGENTS.md (regenerated from workspace specs)"
    echo ""
    exit 1
fi

# Exception - workspace specs ARE specs (no meta-spec needed)
if [[ "$filepath" =~ ^specs/workspace/ ]]; then
    echo -e "${GREEN}✓ No spec needed: $filepath (workspace spec = self-defining)${NC}"
    exit 0
fi

# Exception - files that are pure data/logs
if [[ "$filename" =~ \.(log|lock|cache)$ ]]; then
    echo -e "${GREEN}✓ No spec needed: $filepath (data/log file)${NC}"
    exit 0
fi

# Check if file is mentioned in any spec
if grep -r -l "$filename" specs/ >/dev/null 2>&1; then
    spec_files=$(grep -r -l "$filename" specs/ 2>/dev/null)
    echo -e "${GREEN}✓ Spec coverage found: $filepath${NC}"
    echo -e "${BLUE}  Referenced in:${NC}"
    echo "$spec_files" | while read -r spec; do
        echo -e "${BLUE}    - $spec${NC}"
    done
    exit 0
fi

# Check if there's a .spec.md file colocated with this file
colocated_spec="${filepath%.*}.spec.md"
if [ -f "$colocated_spec" ]; then
    echo -e "${GREEN}✓ Colocated spec found: $colocated_spec${NC}"
    exit 0
fi

# Spec required but missing
echo -e "${RED}✗ Spec required for: $filepath${NC}"
echo ""
echo -e "${YELLOW}This is a permanent file (committed to git) and requires specification.${NC}"
echo ""
echo -e "${BLUE}Suggested spec locations:${NC}"
echo -e "  1. Colocated: ${filepath%.*}.spec.md"
echo -e "  2. Behaviors: specs/3-behaviors/${name_without_ext}.spec.md"
echo -e "  3. Contracts: specs/3-contracts/${name_without_ext}.spec.md"
echo -e "  4. Add to existing spec covering this behavior"
echo ""
echo -e "${BLUE}To create spec:${NC}"
echo -e "  Use: .livespec/1-design/1b-define-behaviors.md"
echo ""
exit 1
