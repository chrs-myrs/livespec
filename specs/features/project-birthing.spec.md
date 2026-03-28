---
type: behavior
category: features
fidelity: behavioral
criticality: IMPORTANT
failure_mode: No structured path for incubating and extracting child projects
governed-by: []
satisfies: []
guided-by: []
---

# Project Birthing

Parent livespec projects can incubate child projects in an `offspring/` folder and birth them into standalone repositories when ready.

## Requirements

- [!] Parent project may contain an `offspring/` directory at project root
  - Each sub-directory is a distinct project being incubated
  - Each offspring has full LiveSpec init structure (PURPOSE.md + specs/ hierarchy)

- [!] Offspring incubation creates a full LiveSpec project scaffold
  - Same structure as `/livespec:init` produces
  - Specs drafted in offspring before birth, not after

- [!] Birth operation extracts offspring to a standalone git repository
  - Copies all offspring files to user-specified destination
  - Initialises git repo at destination with initial commit
  - Optionally removes offspring entry from parent project
  - Reports next steps (run /livespec:audit context to generate AGENTS.md)

## Validation

- [ ] `offspring/` created at project root when first offspring incubated
- [ ] Each offspring contains PURPOSE.md and specs/ hierarchy
- [ ] Birth copies files to destination and runs git init
- [ ] Birth produces a working LiveSpec project at destination
