# Bidirectional Specifications System - Claude Context

## Quick Reference
- **Purpose**: Framework for maintaining living documentation synchronized with code
- **Type**: Meta-framework with executable prompts
- **Stack**: Markdown prompts, bash scripts
- **Started**: 2024-01-01
- **Stage**: Maintenance/Enhancement

## Project-Specific Focus

### Complexity Areas
- Bidirectional sync between docs and code
- Stage-based workflow orchestration
- Context optimization for AI effectiveness

### Critical Constraints
- Prompts must be self-contained for .claude/commands
- Documentation reflects state, not plans
- Minimal context maximizes engineering effectiveness

## Working Agreements

### Code Standards
- Prompts use Stage.Step numbering (0.1, 1.2, etc.)
- Templates separated from execution logic
- Missing info detection with priority levels
- Progress tracking integrated throughout

### Documentation Flow
- User docs in docs/ (not prompts/)
- Templates in prompts/templates/
- HLR support via reqs/hlr/
- Change logs separate from main specs

## Current Sprint Focus
Restructuring prompts with template separation and context reduction

## Key Technical Decisions
- **Minimal CLAUDE.md**: <50 lines beats 450+ lines for AI performance
- **Stage-based workflow**: Clear progression through specification levels
- **HLR input mechanism**: Requirements can flow from external sources
- **Progress tracking**: Weighted calculation across all stages