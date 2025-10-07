---
derives_from:
  - specs/requirements.spec.md (Voluntary Adoption)
  - specs/workspace/constitution.spec.md (Dogfooding principle)
constrained_by:
  - specs/constraints.spec.md (Testable Behaviors, No Framework Lock-in)
  - .livespec/standard/metaspecs/strategy.spec.md
criticality: CRITICAL
failure_mode: Without dogfooding validation, LiveSpec could prescribe methodology that doesn't work in practice, undermining credibility and voluntary adoption
---

# Dogfooding Strategy

## Requirements
- [!] LiveSpec validates its methodology by using itself to document and develop itself, creating self-referential proof that the framework works in practice through .livespec/ symlink to dist/, comprehensive specs/ structure, tests/ validation suite, and continuous drift detection applied to own codebase.
  - .livespec/ symlink points to dist/ (LiveSpec uses distributed methodology on itself)
  - specs/ follows standard folder structure (workspace/, behaviors/, strategy/, contracts/)
  - Every deliverable has defining spec in specs/ (complete circularity)
  - Every spec constrained by metaspec in dist/standard/metaspecs/
  - tests/ validate LiveSpec follows its own rules
  - Drift detection applied to LiveSpec repository (Phase 4 on ourselves)
  - Changes to methodology trigger spec updates (living documentation)
  - Repository demonstrates bidirectional sync (specs ↔ deliverables)
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
- MSL format scales (30+ specs maintained easily)
- Phase approach viable (we develop through phases)
- Drift detection effective (we detect our own drift)
- AI agents can assist (we use Claude Code on ourselves)
- Voluntary adoption possible (we maintain specs willingly)

## .livespec/ Symlink Design

**Implementation:**
```bash
# In LiveSpec repository root
.livespec -> dist/
```

**Rationale:**
- LiveSpec uses EXACT methodology we distribute (no special case)
- Symlink not copy ensures we use latest dist/ version
- Tests run against .livespec/ prove dist/ works
- If .livespec/ prompts break for us, they break for users
- Forces us to keep dist/ actually usable

**What this enables:**
- Develop new prompt using own methodology
- Test prompt immediately via .livespec/
- Validate prompt works before distributing
- Use utils/ on ourselves (next-steps.md, upgrade-methodology.md)
- AI agents reference .livespec/ same as user projects

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
Deliverables (prompts, templates, framework, docs)
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
- Use prompts/4-evolve/4a-detect-drift.md on LiveSpec repository
- Compare dist/ deliverables vs specs/ definitions
- Compare specs/ vs actual repository structure
- Check for unspec'd deliverables (new files without defining specs)
- Check for obsolete specs (defining deleted deliverables)

**What we detect:**
- Prompt added without defining spec → drift
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
prompts/utils/upgrade-methodology.md added
But: No specs/behaviors/prompts/utils-upgrade.spec.md

# Resolution
Create specs/behaviors/prompts/utils-upgrade.spec.md
Define what upgrade prompt should do
Verify prompt implements spec
Commit both together
```

**Connection to validation:**
- Drift detection IS Phase 4 applied to ourselves
- Proves Phase 4 methodology works in practice
- Tests catch drift automatically (CI/CD integration)

## Bidirectional Sync Demonstration

**Spec → Deliverable (design-first):**
1. Create behavior spec (e.g., specs/behaviors/prompts/utils-upgrade.spec.md)
2. Define requirements, triggers, outputs, validation criteria
3. Implement prompt (prompts/utils/upgrade-methodology.md)
4. Reference spec in prompt frontmatter (spec: ...)
5. Validate prompt satisfies spec

**Deliverable → Spec (extract-first):**
1. Create prompt (rapid prototyping, exploration)
2. Use 4b-extract-specs.md to document what it does
3. Create behavior spec from implemented functionality
4. Add spec reference to prompt frontmatter
5. Validate alignment

**Both ways work:**
- New features often spec-first (intentional design)
- Experiments often deliverable-first (discovery)
- Both converge to synchronized state
- Demonstrates flexibility users will need

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

- .livespec/ symlink exists and points to dist/
- specs/ follows standard folder structure (workspace/, behaviors/, strategy/)
- Every deliverable in dist/ has defining spec in specs/
- Every spec has constrained_by pointing to metaspec
- tests/ directory validates LiveSpec follows own rules
- Drift detection applied to LiveSpec repository
- Repository demonstrates bidirectional sync (examples of both directions)
- Test suite passes (proves dogfooding successful)
- No special-case methodology for developing LiveSpec (same as users)
