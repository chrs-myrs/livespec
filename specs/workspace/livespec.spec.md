---
applies_to:
  - all_ai_agents
  - livespec_integration
derives_from:
  - specs/workspace/constitution.spec.md
  - specs/workspace/workflows.spec.md
supports:
  - all_development_activities
---

# LiveSpec Agent Integration

**Criticality**: CRITICAL
**Failure Mode**: Agents work against LiveSpec methodology instead of with it, requiring constant user correction and defeating voluntary adoption

## Specification

AI agents must proactively guide users through LiveSpec methodology using cached AGENTS.md context, enforcing MSL minimalism and suggesting appropriate phases without requiring slash commands or manual prompt discovery.

**Agent behaviors:**

**1. Context Loading**
- Cache AGENTS.md at session start
- Reference workspace specs when making methodology decisions
- Understand dependency graph (PURPOSE → requirements → strategy → behaviors)

**2. Proactive Phase Guidance**
- Detect project state (no specs = Phase 0, specs exist = check drift)
- Suggest next phase: "Ready to move to Phase 2 implementation?"
- Explain why a phase is needed when suggesting it

**3. MSL Enforcement**
- Guide users to minimal specifications (challenge over-specification)
- Apply MSL template when creating .spec.md files
- Verify four sections: Criticality, Failure Mode, Specification, Validation
- Check frontmatter dependencies declared

**4. Prompt Awareness**
- Know which prompts exist without fetching
- Suggest relevant prompt: "Should I use .livespec/1-design/1b-define-behaviors.md?"
- Fetch full prompt only when user approves or implementation starts

**5. Drift Prevention**
- Suggest Phase 4a drift detection before implementing features
- Update behavior specs alongside code changes
- Maintain frontmatter traceability when specs change

**6. Workspace Adherence**
- Follow constitution.spec.md principles (trust implementers, MSL minimalism)
- Apply patterns.spec.md conventions (naming, folder structure)
- Execute workflows.spec.md processes (spec before code, validate changes)

**7. Decision Support**
- Use decision tree to recommend phase/prompt
- Reference constraints.spec.md when evaluating approaches
- Check requirements.spec.md satisfaction when completing features

**8. No CLI Required**
- Never require user to install LiveSpec tooling
- Never require slash commands or special syntax
- Work through natural conversation referencing cached methodology

## Validation

- Agent suggests appropriate phase without user prompting
- Agent creates MSL-compliant specs without template reminder
- Agent checks for drift before implementing features
- Agent maintains frontmatter dependencies automatically
- Agent explains "why this phase" when suggesting actions
- Users report agent "just knows what to do" with LiveSpec projects
