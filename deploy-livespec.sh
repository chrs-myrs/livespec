#!/bin/bash

# LiveSpec Framework Deployment Script
# This script packages and deploys the framework to a target project

set -e

# Configuration
FRAMEWORK_VERSION="1.0.0"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_PROJECT="$1"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     LiveSpec Framework Deployment Tool                          ║${NC}"
    echo -e "${BLUE}║     Version: $FRAMEWORK_VERSION                                          ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

usage() {
    echo "Usage: $0 <target-project-path>"
    echo ""
    echo "Deploys the LiveSpec framework to a target project."
    echo ""
    echo "Examples:"
    echo "  $0 /path/to/my/project"
    echo "  $0 ~/projects/my-app"
    echo ""
    exit 1
}

validate_source() {
    print_info "Validating source framework..."
    
    if [ ! -d "$SOURCE_DIR/prompts" ]; then
        print_error "Source prompts directory not found!"
        exit 1
    fi
    
    # Count prompts
    PROMPT_COUNT=$(find "$SOURCE_DIR/prompts" -name "*.md" -type f | wc -l)
    print_success "Found $PROMPT_COUNT prompts to deploy"
}

validate_target() {
    print_info "Validating target project..."
    
    if [ ! -d "$TARGET_PROJECT" ]; then
        print_error "Target project directory does not exist: $TARGET_PROJECT"
        exit 1
    fi
    
    cd "$TARGET_PROJECT"
    
    # Check if it's a git repo (recommended but not required)
    if [ -d .git ]; then
        print_success "Target is a git repository"
    else
        print_info "Target is not a git repository (version control recommended)"
    fi
}

create_target_structure() {
    print_info "Creating target directory structure..."
    
    # Create Claude command structure
    mkdir -p .claude/commands/livespec
    mkdir -p .claude/backups
    
    # Create project structure
    mkdir -p reqs/{hlr,0-ux/personas,0-ux/journeys,reviews/feedback}
    mkdir -p reqs/{0-complexity,1-purpose,2-strategy,3-design,4-components,5-implementation}
    mkdir -p reqs/{spikes,learnings}
    
    print_success "Directory structure created"
}

deploy_prompts() {
    print_info "Deploying prompts..."
    
    # Copy all prompts
    cp -r "$SOURCE_DIR/prompts/"* .claude/commands/livespec/
    
    # Create a manifest of deployed files
    find .claude/commands/livespec -type f -name "*.md" | sort > .claude/commands/livespec/MANIFEST.txt
    
    local count=$(wc -l < .claude/commands/livespec/MANIFEST.txt)
    print_success "Deployed $count prompt files"
}

create_framework_config() {
    print_info "Creating framework configuration..."
    
    cat > .claude/livespec.config.json << EOF
{
  "framework": {
    "name": "LiveSpec - Living Specification Framework",
    "version": "$FRAMEWORK_VERSION",
    "deployed": "$(date -Iseconds)",
    "source": "$SOURCE_DIR"
  },
  "project": {
    "path": "$(pwd)",
    "customizations": [],
    "excluded_prompts": []
  },
  "commands": {
    "start": "claude-code 'Use .claude/commands/livespec/0-orchestrate-workflow.md'",
    "setup": "claude-code 'Use .claude/commands/livespec/0a-setup-project.md'",
    "migrate": "claude-code 'Use .claude/commands/livespec/migrate-to-latest.md'"
  },
  "paths": {
    "prompts": ".claude/commands/livespec",
    "templates": ".claude/commands/livespec/templates",
    "reqs": "reqs",
    "reviews": "reqs/reviews"
  }
}
EOF
    
    print_success "Configuration created"
}

create_helper_scripts() {
    print_info "Creating helper scripts..."
    
    # Create start script
    cat > livespec-start.sh << 'EOF'
#!/bin/bash
# Quick start for LiveSpec workflow
echo "Starting LiveSpec Workflow Orchestrator..."
claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
EOF
    chmod +x livespec-start.sh
    
    # Create status script
    cat > livespec-status.sh << 'EOF'
#!/bin/bash
# Check LiveSpec project status
echo "LiveSpec Project Status"
echo "==================="
echo ""

if [ -f reqs/progress-report.md ]; then
    echo "Progress Report:"
    grep -E "^\*\*Overall Progress\*\*:|^\*\*Current Stage\*\*:" reqs/progress-report.md || echo "No progress data found"
else
    echo "No progress report found. Run workflow orchestrator to begin."
fi

echo ""
echo "Framework Version:"
grep '"version"' .claude/livespec.config.json | head -1

echo ""
echo "Project Structure:"
find reqs -type f -name "*.md" 2>/dev/null | wc -l | xargs echo "Documentation files:"
EOF
    chmod +x livespec-status.sh
    
    print_success "Helper scripts created"
}

update_gitignore() {
    print_info "Updating .gitignore..."
    
    if [ ! -f .gitignore ]; then
        touch .gitignore
    fi
    
    # Add LiveSpec-specific ignores if not present
    if ! grep -q "^# LiveSpec Framework" .gitignore; then
        cat >> .gitignore << 'EOF'

# LiveSpec Framework
.claude/backups/
.claude/commands/livespec/MANIFEST.txt
*.backup
EOF
    fi
    
    print_success ".gitignore updated"
}

create_readme_section() {
    print_info "Creating README section..."
    
    cat > LiveSpec-README.md << 'EOF'
# LiveSpec Framework Integration

This project uses the Living Specification (LiveSpec) Framework for documentation management.

## Quick Start

1. **Start the workflow orchestrator:**
   ```bash
   ./livespec-start.sh
   # or
   claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
   ```

2. **Check project status:**
   ```bash
   ./livespec-status.sh
   ```

3. **View progress:**
   ```bash
   cat reqs/progress-report.md
   ```

## Key Commands

| Command | Purpose |
|---------|---------|
| `0-orchestrate-workflow` | Analyzes state and guides next steps |
| `0a-setup-project` | Initial project setup |
| `0c-discover-ux-requirements` | UX discovery (user-facing systems) |
| `1a-write-purpose` | Document system purpose |
| `0d-prepare-stakeholder-review` | Prepare review packages |

## Project Structure

```
.claude/
  commands/livespec/    # Framework prompts
  livespec.config.json  # Configuration
reqs/
  0-ux/            # UX documentation
  1-purpose/       # System purpose
  2-strategy/      # Technical strategy
  3-design/        # System design
  4-components/    # Component specs
  5-implementation/# Implementation details
  reviews/         # Stakeholder reviews
```

## Documentation Workflow

1. Work through stages 0-5 sequentially
2. Stakeholder reviews at key gates
3. Continuous synchronization with code
4. Regular alignment checks

## For More Information

See the framework documentation in `.claude/commands/livespec/docs/`
EOF
    
    print_success "README section created (see LiveSpec-README.md)"
}

print_completion() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║          LiveSpec Framework Deployed Successfully! 🚀           ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Deployment Summary:"
    echo "  • Target: $TARGET_PROJECT"
    echo "  • Version: $FRAMEWORK_VERSION"
    echo "  • Prompts: .claude/commands/livespec/"
    echo "  • Config: .claude/livespec.config.json"
    echo ""
    echo "Quick Start Commands:"
    echo ""
    echo "  1. Start workflow orchestrator:"
    echo -e "     ${BLUE}cd $TARGET_PROJECT${NC}"
    echo -e "     ${BLUE}./livespec-start.sh${NC}"
    echo ""
    echo "  2. Check status:"
    echo -e "     ${BLUE}./livespec-status.sh${NC}"
    echo ""
    echo "  3. Or use Claude directly:"
    echo -e "     ${BLUE}claude-code \"Use .claude/commands/livespec/0-orchestrate-workflow.md\"${NC}"
    echo ""
    echo "Helper scripts created:"
    echo "  • livespec-start.sh - Start workflow"
    echo "  • livespec-status.sh - Check status"
    echo "  • LiveSpec-README.md - Documentation"
    echo ""
}

# Main execution
main() {
    print_header
    
    # Check arguments
    if [ $# -eq 0 ]; then
        usage
    fi
    
    # Validate environment
    validate_source
    validate_target
    
    # Deploy framework
    create_target_structure
    deploy_prompts
    create_framework_config
    create_helper_scripts
    update_gitignore
    create_readme_section
    
    # Complete
    print_completion
}

# Run main
main "$@"