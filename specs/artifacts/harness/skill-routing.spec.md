---
type: prompt
category: artifacts
fidelity: behavioral
criticality: IMPORTANT
failure_mode: Agents working on LiveSpec answer methodology requests from memory or the published repository instead of the installed skills, and a fresh clone loses the routing because its hook is wired only in an untracked settings file
governed-by: []
satisfies:
  - specs/workspace/workspace-agent.spec.md
specifies:
  - .claude/hooks/skill-evaluator.sh
  - .claude/settings.json
  - .claude/rules/plugin-skill-routing.md
---

# Skill Routing

Points requests in this repository at the LiveSpec skill that handles them. A
standing rule tells the agent; a prompt hook reminds it per request.

## Requirements

- [!] A request naming a LiveSpec intent is pointed at the plugin skill for it
  - Specs and design → `/livespec:design`; health, validation and context → `/livespec:audit`; setup → `/livespec:init`; session completion → `/livespec:learn`; upgrade and migration → `/livespec:upgrade`
  - The hook suggests and never blocks: every prompt goes through, including when the hook itself fails
  - A prompt that already invokes a `/livespec:` skill gets no suggestion

- [!] The hook runs in every clone
  - Wired in the tracked `.claude/settings.json`; `settings.local.json` is not committed, so wiring there reaches no one else

- [!] The rule and the hook route the same intents to the same skills
  - Every trigger the rule lists is one the hook matches, to the same skill
  - The rule also says LiveSpec is not looked up on the web here: a lookup finds the published repository, which lags this working tree

## Validation

- In a fresh clone, a prompt asking to refine a spec produces a suggestion naming `/livespec:design`
- A prompt beginning `/livespec:audit` produces no suggestion
- A prompt with no trigger produces no output and exit 0, as does a hook run with `jq` absent
- Each trigger the rule lists, given to the hook alone, produces a suggestion naming the skill the rule pairs it with
