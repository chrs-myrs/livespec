---
type: strategy
category: strategy
fidelity: decisions-only
criticality: CRITICAL
failure_mode: Without dogfooding validation, LiveSpec could prescribe methodology that doesn't work in practice, undermining credibility and voluntary adoption
governed-by:
  - specs/foundation/constraints.spec.md (Testable Behaviors, No Framework Lock-in)
derives-from:
  - specs/foundation/outcomes.spec.md (Voluntary Adoption)
  - specs/workspace/constitution.spec.md (Dogfooding principle)
---

# Dogfooding Strategy

## Requirements
- [!] LiveSpec validates its methodology by using itself to document and develop itself, creating self-referential proof that the framework works in practice through the plugin's own skills/ and specs/ structure, tests/ validation suite, and continuous health checks applied to own codebase.
  - LiveSpec is installed as a Claude Code plugin (`/plugin install livespec@livespec`) and used on itself (no separate copy mechanism)
  - specs/ follows standard folder structure (workspace/, foundation/, strategy/, features/, interfaces/)
  - Every deliverable has defining spec in specs/ (complete circularity)
  - Every spec constrained by metaspec in references/standards/metaspecs/
  - tests/ validate LiveSpec follows its own rules
  - Drift/health detection applied to LiveSpec repository (`/livespec:audit` on ourselves)
  - Changes to methodology trigger spec updates (living documentation)
  - Repository demonstrates specification-driven regeneration (specs → deliverables)
  - Dogfooding proves methodology works before recommending to others

## Rationale

**Why dogfooding?**
- **Credibility**: Can't recommend what we don't use ourselves
- **Validation**: Catches methodology flaws early (if it doesn't work for us, won't work for users)
- **Living proof**: Repository IS the proof LiveSpec works
- **Continuous improvement**: We feel the pain points users will feel
- **Self-consistency**: Framework documented using framework (circularity)

**What we prove:**
- Folder structure works (we use it)
- MSL format scales (50+ specs maintained easily)
- Phase approach viable (we develop through phases)
- Drift detection effective (we detect our own drift)
- AI agents can assist (we use Claude Code on ourselves)
- Voluntary adoption possible (we maintain specs willingly)

## Plugin Self-Use Design

**Implementation:**
- LiveSpec repository is itself the plugin source; skills under `skills/<name>/SKILL.md` are used directly on this repository, the same way a consumer project would invoke them after `/plugin install livespec@livespec`

**Rationale:**
- LiveSpec uses EXACT methodology we distribute (no special case)
- Working directly against the plugin source ensures we always use the latest skill behavior
- If a skill breaks for us, it breaks for users
- Forces us to keep skills/ actually usable

**What this enables:**
- Develop a new skill using own methodology
- Test skill immediately by invoking it in this repository
- Validate skill works before releasing
- Use utility skills on ourselves (`/livespec:learn`, `/livespec:upgrade`)
- AI agents use the installed plugin skills same as user projects

**Alternative considered:**
- Separate methodology for developing LiveSpec
- **Rejected**: Defeats dogfooding purpose, creates dual-track complexity

## Circularity Achievement

**Complete chain:**
```
MSL Spec (external)
  ↓ (extends)
base.spec.md (adds criticality, failure_mode)
  ↓ (constrains)
Metaspecs (7: behavior, workspace, strategy, requirements, constraints, contract, base)
  ↓ (constrain)
Project Specs (30+: behaviors/, workspace/, strategy/, requirements.spec.md, constraints.spec.md)
  ↓ (define)
Deliverables (skills, agents, commands, templates, docs)
  ↓ (dogfoods back into)
LiveSpec methodology (used to create specs)
```

**Validation:**
- Every deliverable has spec: 36 deliverables, 36 defining specs ✓
- Every spec has constrained_by: 30+ specs, all point to metaspecs ✓
- Metaspecs constrained by base.spec.md ✓
- base.spec.md derives from MSL specification ✓
- Complete circle: MSL → base → metaspecs → specs → deliverables → dogfooding

**What circularity proves:**
- Framework is self-describing (no external dependencies to understand it)
- Methodology is complete (can document itself using itself)
- No hidden assumptions (everything explicit in specs)
- Self-consistency (follows own rules)

## Validation Through Testing

**Test suite structure:**
```
tests/
├── prompts/
│   ├── test_folder_structure.sh     # Validates folder-structure convention
│   ├── test_msl_format.sh           # Validates MSL format compliance
│   ├── test_prompt_behaviors.sh     # Validates prompt ↔ spec alignment
│   └── test_spec_naming.sh          # Validates naming convention
├── structure/
│   ├── test_full_validation.sh      # Validates circularity (constrained_by completeness)
│   └── test_traceability.sh         # Validates derives_from chains
└── run-all-tests.sh                 # Executes all tests
```

**What tests validate:**
1. **Structure compliance**: LiveSpec follows its own folder-structure.spec.md
2. **MSL compliance**: All specs follow MSL format (title, frontmatter, Requirements)
3. **Traceability**: derives_from and constrained_by chains complete
4. **Circularity**: Every spec constrained, every deliverable specified
5. **Naming**: File names follow naming.spec.md convention
6. **Alignment**: Prompts implement their defining specs

**Philosophy:**
- Tests validate OBSERVABLE behaviors (file structure, format, naming)
- Tests don't validate IMPLEMENTATION (how specs written, content quality)
- Tests prove we follow our own rules (dogfooding verification)
- Test failures indicate drift (methodology ≠ practice)

**Connection to validation.spec.md:**
- Detailed testing strategy in specs/strategy/validation.spec.md
- This spec (dogfooding) explains WHY we test ourselves
- validation.spec.md explains HOW we test

## Drift Detection on Ourselves

**Continuous monitoring:**
- Use `/livespec:audit health` on LiveSpec repository
- Compare skills/agents/commands deliverables vs specs/ definitions
- Compare specs/ vs actual repository structure
- Check for unspec'd deliverables (new files without defining specs)
- Check for obsolete specs (defining deleted deliverables)

**What we detect:**
- Skill/command/agent added without defining spec → drift
- Spec updated but deliverable unchanged → drift
- Folder structure changed but folder-structure.spec.md not updated → drift
- New metaspec but base.spec.md not updated → drift

**Resolution process:**
1. Detect drift (automated checks or manual review)
2. Determine cause:
   - Deliverable changed? Update spec (extract new requirements)
   - Spec changed? Update deliverable (implement new design)
   - Both changed? Reconcile and align
3. Create/update spec
4. Validate alignment restored
5. Commit synchronized changes

**Example:**
```
# Drift detected
skills/upgrade/SKILL.md + commands/upgrade.md added
But: specs/artifacts/commands/generation.spec.md not updated with the new entry

# Resolution
Add skills/upgrade to the Command Mapping table in
specs/artifacts/commands/generation.spec.md
Verify the command routes correctly to the skill
Commit both together
```

**Connection to validation:**
- Drift detection IS `/livespec:audit` applied to ourselves
- Proves the audit methodology works in practice
- Tests catch drift automatically (CI/CD integration)

## Regeneration Workflow Demonstration

**Spec → Deliverable (design-first, primary path):**
1. Define the skill's behavior spec (feature-level, e.g. under specs/features/)
2. Define requirements, triggers, outputs, validation criteria
3. Generate/implement the skill (skills/upgrade/SKILL.md) + its command router (commands/upgrade.md)
4. Add the mapping to specs/artifacts/commands/generation.spec.md's Command Mapping table
5. Validate the skill satisfies its behavior spec

**Deliverable → Spec (discovery leveling):**
1. Create deliverable (rapid prototyping, exploration)
2. Use `/livespec:audit extract` to extract essential knowledge
3. Level up discoveries to appropriate spec layer
4. Add spec reference to deliverable frontmatter
5. Deliverable becomes regenerable from spec

**Both paths converge:**
- New features often spec-first (intentional design)
- Experiments often deliverable-first (discovery)
- Discoveries level up to specs, deliverables become regenerable
- Demonstrates flexible workflow users need

## Benefits of Dogfooding

**For LiveSpec development:**
- Early detection of methodology problems
- Forces minimal specs (we feel maintenance burden)
- Validates AI agent effectiveness (we use Claude Code)
- Proves voluntary adoption possible (no enforcement on ourselves)
- Continuous improvement loop (pain → fix → improve)

**For users:**
- Trust: "They use it themselves"
- Proof: Repository is working example
- Templates: Can copy our patterns
- Confidence: If it works for complex project (itself), works for theirs
- Learning: Can read our specs to understand methodology

**For methodology evolution:**
- Dogfooding reveals what works (keep)
- Dogfooding reveals what doesn't (fix or remove)
- Self-consistency prevents feature creep (would we spec this?)
- Validates before distributing (never ship untested approach)

## Validation

- LiveSpec is installed and used as a Claude Code plugin on its own repository
- specs/ follows standard folder structure (workspace/, behaviors/, strategy/)
- Every deliverable (skill, agent, command) has defining spec in specs/
- Every spec has constrained_by pointing to metaspec
- tests/ directory validates LiveSpec follows own rules
- Drift detection applied to LiveSpec repository
- Repository demonstrates specification-driven regeneration (both spec-first and discovery paths)
- Test suite passes (proves dogfooding successful)
- No special-case methodology for developing LiveSpec (same as users)
