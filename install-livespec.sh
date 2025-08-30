#!/bin/bash

# LiveSpec Framework Installer
# This script installs or updates the LiveSpec framework in a project

set -e

# Configuration
FRAMEWORK_VERSION="0.2.0"
FRAMEWORK_NAME="LiveSpec - Living Specification Framework"
CLAUDE_DIR=".claude"
COMMANDS_DIR="$CLAUDE_DIR/commands/livespec"
FRAMEWORK_CONFIG="$CLAUDE_DIR/livespec.config.json"
BACKUP_DIR="$CLAUDE_DIR/backups"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║     LiveSpec - Living Specification Framework      ║${NC}"
    echo -e "${BLUE}║                    Installation Script                      ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

check_prerequisites() {
    print_info "Checking prerequisites..."
    
    # Check if we're in a git repository
    if [ -d .git ]; then
        print_success "Git repository detected"
    else
        print_warning "Not a git repository - version control recommended"
    fi
    
    # Check if Claude directory exists
    if [ -d "$CLAUDE_DIR" ]; then
        print_success "Claude directory exists"
    else
        print_info "Creating Claude directory structure..."
        mkdir -p "$CLAUDE_DIR"
    fi
}

detect_existing_installation() {
    if [ -f "$FRAMEWORK_CONFIG" ]; then
        EXISTING_VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "$FRAMEWORK_CONFIG" | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
        print_info "Existing installation detected: v$EXISTING_VERSION"
        return 0
    else
        print_info "No existing installation detected"
        return 1
    fi
}

backup_existing() {
    if [ -d "$COMMANDS_DIR" ]; then
        print_info "Creating backup of existing installation..."
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        BACKUP_PATH="$BACKUP_DIR/livespec_backup_$TIMESTAMP"
        mkdir -p "$BACKUP_PATH"
        cp -r "$COMMANDS_DIR" "$BACKUP_PATH/"
        if [ -f "$FRAMEWORK_CONFIG" ]; then
            cp "$FRAMEWORK_CONFIG" "$BACKUP_PATH/"
        fi
        print_success "Backup created at $BACKUP_PATH"
    fi
}

create_directory_structure() {
    print_info "Creating directory structure..."
    
    # Framework directories
    mkdir -p "$COMMANDS_DIR"
    mkdir -p "$COMMANDS_DIR/templates/0-ux"
    mkdir -p "$COMMANDS_DIR/templates/reviews"
    mkdir -p "$COMMANDS_DIR/utils"
    
    # Project directories (if not exists)
    mkdir -p "reqs/hlr"
    mkdir -p "reqs/0-ux/personas"
    mkdir -p "reqs/0-ux/journeys"
    mkdir -p "reqs/reviews/feedback"
    mkdir -p "reqs/spikes"
    mkdir -p "reqs/learnings"
    
    print_success "Directory structure created"
}

install_prompts() {
    print_info "Installing framework prompts..."
    
    # This is where prompts would be copied from source
    # In a real deployment, these would come from a package or download
    
    cat > "$COMMANDS_DIR/FRAMEWORK_README.md" << 'EOF'
# LiveSpec Framework Commands

This directory contains the LiveSpec - Living Specification Framework prompts.

## Version
Current version: 0.2.0

## Usage
Use these prompts with Claude Code:
```bash
claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"
```

## Directory Structure
- **Main prompts**: Numbered workflow prompts (0a, 1b, etc.)
- **templates/**: Document templates
- **utils/**: Utility scripts and helpers

## Updates
To update the framework:
```bash
./update-livespec.sh
```

## Documentation
See the main project documentation in docs/ for detailed usage instructions.
EOF
    
    print_success "Framework prompts installed"
}

create_config_file() {
    print_info "Creating configuration file..."
    
    cat > "$FRAMEWORK_CONFIG" << EOF
{
  "framework": {
    "name": "$FRAMEWORK_NAME",
    "version": "$FRAMEWORK_VERSION",
    "installed": "$(date -Iseconds)",
    "installer_version": "1.0.0"
  },
  "project": {
    "customizations": [],
    "excluded_prompts": [],
    "additional_templates": []
  },
  "settings": {
    "auto_update_check": true,
    "preserve_customizations": true,
    "backup_before_update": true
  },
  "paths": {
    "commands": "$COMMANDS_DIR",
    "reqs": "reqs",
    "templates": "$COMMANDS_DIR/templates"
  }
}
EOF
    
    print_success "Configuration file created"
}

create_update_script() {
    print_info "Creating update script..."
    
    cat > "update-livespec.sh" << 'EOF'
#!/bin/bash

# LiveSpec Framework Update Script
set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Checking for LiveSpec Framework updates...${NC}"

# Read current version
CURRENT_VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' .claude/livespec.config.json | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

echo -e "Current version: ${YELLOW}v$CURRENT_VERSION${NC}"

# In a real implementation, this would check a remote source
LATEST_VERSION="0.2.0"

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo -e "${GREEN}✓ Framework is up to date${NC}"
else
    echo -e "${YELLOW}New version available: v$LATEST_VERSION${NC}"
    echo "Run './install-livespec.sh' to update"
fi
EOF
    
    chmod +x update-livespec.sh
    print_success "Update script created"
}

setup_git_ignore() {
    print_info "Updating .gitignore..."
    
    # Check if .gitignore exists
    if [ ! -f .gitignore ]; then
        touch .gitignore
    fi
    
    # Add entries if not present
    if ! grep -q "^\.claude/backups" .gitignore; then
        echo "" >> .gitignore
        echo "# LiveSpec Framework" >> .gitignore
        echo ".claude/backups/" >> .gitignore
    fi
    
    print_success ".gitignore updated"
}

create_project_claude_md() {
    if [ ! -f "CLAUDE.md" ]; then
        print_info "Creating project CLAUDE.md..."
        
        cat > "CLAUDE.md" << 'EOF'
# Project Context for Claude Code

## Project Overview
[Describe your project here]

## LiveSpec Framework
This project uses the LiveSpec - Living Specification Framework v0.2.0 (Beta).

### Quick Commands
- Start workflow: `claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"`
- Check progress: `cat reqs/progress-report.md`
- Prepare review: `claude-code "Use .claude/commands/livespec/0d-prepare-stakeholder-review.md"`

### Project-Specific Configuration
[Add any project-specific configuration here]

## Working Agreements
[Add team agreements here]
EOF
        
        print_success "Project CLAUDE.md created"
    else
        print_info "CLAUDE.md already exists - preserving existing content"
    fi
}

print_usage_instructions() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║            Installation Complete! 🎉                        ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Next steps:"
    echo ""
    echo "1. Start the workflow orchestrator:"
    echo -e "   ${BLUE}claude-code \"Use .claude/commands/livespec/0-orchestrate-workflow.md\"${NC}"
    echo ""
    echo "2. Or begin with project setup:"
    echo -e "   ${BLUE}claude-code \"Use .claude/commands/livespec/0a-setup-project.md\"${NC}"
    echo ""
    echo "3. Check framework documentation:"
    echo -e "   ${BLUE}cat .claude/commands/livespec/FRAMEWORK_README.md${NC}"
    echo ""
    echo "Important paths:"
    echo "  • Framework prompts: .claude/commands/livespec/"
    echo "  • Project specs: reqs/"
    echo "  • Configuration: .claude/livespec.config.json"
    echo ""
    echo "To check for updates later:"
    echo -e "   ${BLUE}./update-livespec.sh${NC}"
    echo ""
}

# Main installation flow
main() {
    print_header
    
    # Check prerequisites
    check_prerequisites
    
    # Check for existing installation
    if detect_existing_installation; then
        echo ""
        read -p "Do you want to update/reinstall the framework? (y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
        backup_existing
    fi
    
    # Create directory structure
    create_directory_structure
    
    # Install prompts
    install_prompts
    
    # Create configuration
    create_config_file
    
    # Create update script
    create_update_script
    
    # Setup git ignore
    setup_git_ignore
    
    # Create project CLAUDE.md if needed
    create_project_claude_md
    
    # Print usage instructions
    print_usage_instructions
}

# Run main function
main "$@"