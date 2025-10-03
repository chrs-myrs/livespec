# Prompt Renaming Plan

This document outlines the renaming of prompts to follow the new stage-based numbering system.

## Renaming Map

### Stage 0: Project Setup
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `setup-project-claude-md.md` | `0.1-setup-project.md` | Initialize project with CLAUDE.md |
| `0-assess-complexity.md` | `0.2-assess-complexity.md` | Assess project complexity |

### Stage 1: Discovery & Purpose  
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `1-write-purpose.md` | `1.1-write-purpose.md` | Document system purpose |
| `run-discovery-spike.md` | `1.2-run-purpose-spike.md` | Explore purpose-level unknowns |

### Stage 2: Strategy
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `2-write-strategy.md` | `2.1-write-strategy.md` | Document technical strategies |
| `run-discovery-spike.md` | `2.2-run-strategy-spike.md` | Explore strategy-level unknowns |

### Stage 3: Design
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `3-write-design.md` | `3.1-write-design.md` | Document system design |
| `run-discovery-spike.md` | `3.2-run-design-spike.md` | Explore design-level unknowns |
| `reality-checkpoint.md` | `3.3-design-checkpoint.md` | Validate design feasibility |

### Stage 4: Components
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `4-write-components.md` | `4.1-write-components.md` | Document component specs |
| `pre-implementation-validation.md` | `4.2-validate-components.md` | Validate before implementation |

### Stage 5: Implementation
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `5-write-implementation.md` | `5.1-write-implementation.md` | Document implementation specs |
| `NEW` | `5.2-validate-implementation.md` | Validate implementation specs |
| `implement-from-specs.md` | `5.3-implement-from-specs.md` | Build from specifications |
| `reality-checkpoint.md` | `5.4-implementation-checkpoint.md` | Validate implementation |

### Stage 6: Maintenance
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `update-specs-with-code.md` | `6.1-update-specs.md` | Update specs from code changes |
| `align-specs-to-code.md` | `6.2-check-alignment.md` | Check spec-code alignment |
| `capture-learnings.md` | `6.3-capture-learnings.md` | Document lessons learned |

### Utility Prompts (No Stage)
| Current Name | New Name | Purpose |
|--------------|----------|---------|
| `extract-specs-from-code.md` | `extract-specs-from-code.md` | Mode 4 reverse engineering |
| `auto-build.md` | `auto-build.md` | Rapid prototyping |
| `analyze-process-failure.md` | `analyze-process-failure.md` | Post-mortem analysis |
| `run-discovery-spike.md` | `run-discovery-spike.md` | Generic spike template |
| `reality-checkpoint.md` | `reality-checkpoint.md` | Generic checkpoint template |

## Implementation Notes

1. **Spike Prompts**: We'll create stage-specific spike prompts (1.2, 2.2, 3.2) that inherit from the generic `run-discovery-spike.md` but add stage-specific guidance.

2. **Checkpoint Prompts**: Similarly, we'll create specific checkpoint prompts (3.3, 5.3) that inherit from the generic `reality-checkpoint.md`.

3. **Backward Compatibility**: Keep the generic templates for flexibility when users want to run spikes or checkpoints outside the standard flow.

4. **Progress Integration**: Each renamed prompt will be updated to include progress report update instructions.

## File System Commands

Here are the commands to perform the renaming:

```bash
# Stage 0
mv setup-project-claude-md.md 0.1-setup-project.md
mv 0-assess-complexity.md 0.2-assess-complexity.md

# Stage 1
mv 1-write-purpose.md 1.1-write-purpose.md
cp run-discovery-spike.md 1.2-run-purpose-spike.md

# Stage 2
mv 2-write-strategy.md 2.1-write-strategy.md
cp run-discovery-spike.md 2.2-run-strategy-spike.md

# Stage 3
mv 3-write-design.md 3.1-write-design.md
cp run-discovery-spike.md 3.2-run-design-spike.md
cp reality-checkpoint.md 3.3-design-checkpoint.md

# Stage 4
mv 4-write-components.md 4.1-write-components.md
mv pre-implementation-validation.md 4.2-validate-components.md

# Stage 5
mv 5-write-implementation.md 5.1-write-implementation.md
# 5.2-validate-implementation.md is created from new template
mv implement-from-specs.md 5.3-implement-from-specs.md
cp reality-checkpoint.md 5.4-implementation-checkpoint.md

# Stage 6
mv update-specs-with-code.md 6.1-update-specs.md
mv align-specs-to-code.md 6.2-check-alignment.md
mv capture-learnings.md 6.3-capture-learnings.md
```

## Benefits of New Structure

1. **Clear Progression**: Stage.Step numbering shows exact workflow
2. **Logical Grouping**: Related activities are in the same stage
3. **Flexibility**: Can still jump to any prompt as needed
4. **Progress Tracking**: Each prompt updates central progress report
5. **Better Discoverability**: Numbered prompts are easier to find and understand

## Next Steps

1. Execute the renaming commands
2. Update each prompt with progress report integration
3. Create stage-specific versions of spike and checkpoint prompts
4. Update all documentation to reflect new structure
5. Test the complete workflow with an example project