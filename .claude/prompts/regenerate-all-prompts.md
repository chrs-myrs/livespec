# Regenerate All LiveSpec Prompts

**Purpose:** Regenerate all 16 LiveSpec prompt files from their specifications using the Prompt Generator agent.

**Context:** Each prompt file in `dist/prompts/` has a corresponding specification in `specs/behaviors/prompts/`. This meta-prompt guides systematic regeneration of all prompts to ensure they implement what their specs require.

## Prerequisites

- All 16 spec files exist in `specs/behaviors/prompts/`
- Prompt Generator agent available (@prompt-generator)
- Understanding of optimal prompt positioning (instruction before context)

## Regeneration Process

### Phase 0: DEFINE (3 prompts)

**0a-setup-workspace.md**
```
@prompt-generator

Create prompt file: dist/prompts/0-define/0a-setup-workspace.md

From spec: specs/behaviors/prompts/0a-setup-workspace.spec.md

This prompt guides AI agents to initialize LiveSpec workspace structure.

Requirements:
- Step-by-step workspace initialization
- Create PURPOSE.md with guided questions
- Create 3 workspace specs (constitution, patterns, workflows)
- Template content for each spec
- Validation checklist
- Common mistakes section
- Next steps guidance

Front-load: Clear purpose and setup sequence before providing templates
Success criteria: User has complete workspace structure ready for spec development
```

**0b-define-problem.md**
```
@prompt-generator

Create prompt file: dist/prompts/0-define/0b-define-problem.md

From spec: specs/behaviors/prompts/0b-define-problem.spec.md

This prompt guides problem articulation and requirements specification.

Requirements:
- Problem discovery questions
- Current state vs desired state framework
- Root cause analysis (Five Whys)
- Scope boundary definition
- Creates specs/requirements.spec.md
- Validation checklist

Front-load: Purpose and discovery questions before templates
Success criteria: Clear problem statement with measurable requirements
```

**0c-identify-constraints.md**
```
@prompt-generator

Create prompt file: dist/prompts/0-define/0c-identify-constraints.md

From spec: specs/behaviors/prompts/0c-identify-constraints.spec.md

This prompt identifies non-negotiable boundaries.

Requirements:
- Constraint categories (technical, business, resource, user/market)
- Discovery questions per category
- Validation process (challenge assumptions)
- Creates specs/constraints.spec.md
- Impact documentation

Front-load: Purpose and constraint categories before discovery process
Success criteria: All hard constraints documented with rationale
```

### Phase 1: DESIGN (3 prompts)

**1a-design-architecture.md**
```
@prompt-generator

Create prompt file: dist/prompts/1-design/1a-design-architecture.md

From spec: specs/behaviors/prompts/1a-design-architecture.spec.md

This prompt guides architecture design within constraints.

Requirements:
- Reads specs/requirements.spec.md and specs/constraints.spec.md first
- Architecture decision framework (options, trade-offs)
- Component identification
- Creates specs/strategy/architecture.spec.md
- Decision rationale documentation

Front-load: Required reading and decision framework before process
Success criteria: Architecture documented with decisions and rationale
```

**1b-define-behaviors.md**
```
@prompt-generator

Create prompt file: dist/prompts/1-design/1b-define-behaviors.md

From spec: specs/behaviors/prompts/1b-define-behaviors.spec.md

This prompt defines observable system behaviors.

Requirements:
- Behavior identification from requirements
- Observable outcome focus (not implementation)
- Creates specs/behaviors/*.spec.md
- MSL format with testable criteria
- One spec per behavior

Front-load: Purpose and observable outcomes concept before process
Success criteria: Each behavior has specification with validation criteria
```

**1c-create-contracts.md**
```
@prompt-generator

Create prompt file: dist/prompts/1-design/1c-create-contracts.md

From spec: specs/behaviors/prompts/1c-create-contracts.spec.md

This prompt defines interfaces and contracts.

Requirements:
- Contract types (API, data, process)
- Interface definition format
- Creates specs/contracts/*.spec.md or .yaml
- Request/response specifications
- Error handling requirements

Front-load: Contract types and purpose before templates
Success criteria: All interfaces formally specified
```

### Phase 2: BUILD (2 prompts)

**2a-implement-from-specs.md**
```
@prompt-generator

Create prompt file: dist/prompts/2-build/2a-implement-from-specs.md

From spec: specs/behaviors/prompts/2a-implement-from-specs.spec.md

This prompt guides spec-driven implementation.

Requirements:
- Read specifications completely first
- Implementation planning from specs
- Verification against spec requirements
- Code organization guidance
- ⚠️ PRE-FLIGHT CHECK: Spec must exist

Front-load: Pre-flight check and spec reading before implementation guidance
Success criteria: Implementation satisfies all spec requirements
```

**2b-create-tests.md**
```
@prompt-generator

Create prompt file: dist/prompts/2-build/2b-create-tests.md

From spec: specs/behaviors/prompts/2b-create-tests.spec.md

This prompt creates tests from behavior specs.

Requirements:
- Extract testable criteria from specs
- Test organization matching specs
- Validation coverage for all behaviors
- Test naming conventions
- Edge case identification

Front-load: Purpose and test extraction approach before templates
Success criteria: All spec validation criteria have tests
```

### Phase 3: VERIFY (2 prompts)

**3a-run-validation.md**
```
@prompt-generator

Create prompt file: dist/prompts/3-verify/3a-run-validation.md

From spec: specs/behaviors/prompts/3a-run-validation.spec.md

This prompt validates implementation against specs.

Requirements:
- Systematic validation process
- Checklist from spec validation sections
- Gap identification
- Validation report generation
- Pass/fail criteria

Front-load: Validation approach before checklist generation
Success criteria: All behaviors validated, gaps identified
```

**3b-acceptance-review.md**
```
@prompt-generator

Create prompt file: dist/prompts/3-verify/3b-acceptance-review.md

From spec: specs/behaviors/prompts/3b-acceptance-review.spec.md

This prompt guides stakeholder acceptance review.

Requirements:
- Review preparation (demo, docs, metrics)
- Acceptance criteria from requirements.spec.md
- Stakeholder feedback collection
- Gap resolution planning
- Sign-off documentation

Front-load: Review purpose and preparation steps before templates
Success criteria: Stakeholders approve or provide clear feedback
```

### Phase 4: EVOLVE (5 prompts)

**4a-detect-drift.md**
```
@prompt-generator

Create prompt file: dist/prompts/4-evolve/4a-detect-drift.md

From spec: specs/behaviors/prompts/4a-detect-drift.spec.md

This prompt detects spec-code drift.

Requirements:
- Systematic drift detection per spec
- Compare spec requirements vs implementation
- Identify: spec drift, code drift, missing behaviors
- Generate drift report
- Prioritize drift resolution

Front-load: Drift types and detection approach before process
Success criteria: All drift identified with resolution priorities
```

**4b-extract-specs.md**
```
@prompt-generator

Create prompt file: dist/prompts/4-evolve/4b-extract-specs.md

From spec: specs/behaviors/prompts/4b-extract-specs.spec.md

This prompt extracts specifications from existing code.

Requirements:
- Code analysis for behaviors/contracts
- Confidence rating (HIGH/MEDIUM/LOW)
- Extracted spec template with metadata
- Requires validation flag for low confidence
- Extraction notes documenting uncertainty

Front-load: Extraction purpose and confidence rating before process
Success criteria: All behaviors extracted with appropriate confidence levels
```

**4c-sync-complete.md**
```
@prompt-generator

Create prompt file: dist/prompts/4-evolve/4c-sync-complete.md

From spec: specs/behaviors/prompts/4c-sync-complete.spec.md

This prompt confirms spec-code synchronization.

Requirements:
- Final verification checklist
- All specs reviewed
- All drift resolved
- All tests pass
- Sync confirmation documentation

Front-load: Sync criteria before verification process
Success criteria: Confirmed synchronization documented
```

**4d-regenerate-agents.md**
```
@prompt-generator

Create prompt file: dist/prompts/4-evolve/4d-regenerate-agents.md

From spec: specs/behaviors/prompts/4d-regenerate-agents.spec.md

This prompt regenerates AGENTS.md configuration.

Requirements:
- Reads PURPOSE.md and specs/workspace/
- Generates dist/AGENTS.md with methodology guidance
- Includes quick start, decision tree, folder structure
- Phase guide with key prompts
- Common anti-patterns

Front-load: Purpose and source materials before generation logic
Success criteria: AGENTS.md accurately reflects current methodology
```

**4e-validate-extractions.md**
```
@prompt-generator

Create prompt file: dist/prompts/4-evolve/4e-validate-extractions.md

From spec: specs/behaviors/prompts/4e-validate-extractions.spec.md

This prompt validates low-confidence extracted specs.

Requirements:
- Find specs with requires_validation: true
- Validation questions per spec
- Evidence gathering (tests, docs, stakeholders)
- Promote to standard spec or mark for rework
- Update confidence ratings

Front-load: Validation purpose and criteria before process
Success criteria: All low-confidence specs validated or flagged for rework
```

### Utils (1 prompt)

**upgrade-methodology.md**
```
@prompt-generator

Create prompt file: dist/prompts/utils/upgrade-methodology.md

From spec: specs/behaviors/prompts/upgrade-methodology.spec.md

This prompt upgrades LiveSpec methodology with proof-of-work enforcement.

Requirements:
- ⚠️ PRE-FLIGHT CHECKS (cannot skip)
  - Clone LiveSpec repo (show output)
  - Create backup (show ls proof)
  - Run self-validation (show results)
- PHASE GATE enforcement between stages
- Customizations.yaml reading for merge strategy
- Progressive merge (safe auto, interactive review)
- PROOF REQUIRED for each phase
- Rollback instructions

Front-load: Pre-flight checks and proof requirements before process
Success criteria: Upgrade complete with proof-of-work for all phases
```

## Execution Instructions

For each prompt above:

1. **Invoke Prompt Generator:**
   ```
   @prompt-generator [paste the prompt request above]
   ```

2. **Review Generated Prompt:**
   - Check spec coverage (all requirements addressed)
   - Verify optimal positioning (instruction before context)
   - Confirm enforcement patterns (⚠️ markers, PROOF REQUIRED)
   - Validate success criteria explicit

3. **Write to File:**
   - Save to specified path in dist/prompts/
   - Include YAML frontmatter with spec reference
   - Maintain phase organization

4. **Validate Bidirectional Link:**
   - Prompt references spec in frontmatter
   - Spec should reference prompt (update if missing)

## Batch Execution Alternative

Instead of 16 separate invocations, you can generate all in sequence:

```
For each of the 16 prompts listed above:
1. Read the specification at specs/behaviors/prompts/[name].spec.md
2. Generate the prompt following the requirements
3. Save to dist/prompts/[phase]/[name].md
4. Continue to next prompt

Generate all 16 prompts from their specifications.
```

## Validation Checklist

After regeneration:

- [ ] All 16 prompt files regenerated
- [ ] Each prompt has YAML frontmatter with spec reference
- [ ] Optimal positioning used (instruction before context)
- [ ] Enforcement patterns preserved (⚠️, PROOF REQUIRED, PHASE GATE)
- [ ] Success criteria explicit in each prompt
- [ ] Common mistakes sections included
- [ ] Next steps guidance provided
- [ ] Templates follow MSL format

## Success Criteria

Regeneration complete when:

- All 16 prompts regenerated from specs
- Each prompt implements what its spec requires
- Bidirectional links established (prompt ↔ spec)
- Enforcement patterns maintained
- Optimal prompt positioning used throughout

---

**Meta-note:** This is a meta-prompt (prompt to generate prompts). It demonstrates LiveSpec's self-referential nature - even the methodology for regenerating prompts is itself specified and prompted.
