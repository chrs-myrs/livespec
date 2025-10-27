---
generated: 2025-10-10T14:30:00Z
generated_by: prompts/utils/generate-self-improvement.md
sources:
  - PURPOSE.md
  - specs/1-requirements/strategic/outcomes.spec.md
  - specs/1-requirements/strategic/constraints.spec.md
  - specs/strategy/architecture.spec.md
  - specs/workspace/constitution.spec.md
  - specs/workspace/patterns.spec.md
  - specs/workspace/workflows.spec.md
implements: specs/behaviors/prompts/utils-self-improve.spec.md
---

# Self-Improvement Analysis

<ultrathink>
I need to analyze LiveSpec for systematic improvements.

**Project Purpose:** Prevent specification-code drift by keeping specs synchronized with reality. Enable AI agents with structured context without documentation becoming a maintenance burden.

**Success Criteria:**
1. Specifications remain synchronized with reality throughout evolution
2. AI agents have structured context for effective assistance
3. Documentation stays current without becoming a maintenance burden
4. Works equally well for new projects and existing systems
5. Teams adopt and maintain specifications voluntarily
6. Applies across software development, governance, operations, and planning

**Core Principles (Priority Order):**
1. **Specs Before Implementation** - Every deliverable requires spec first (even "obvious" ones)
2. **MSL Minimalism** - Specs justify existence through 4-question decision framework
3. **Dogfooding** - LiveSpec uses its own methodology
4. **Simplicity Over Features** - No custom tooling required
5. **Living Documentation** - Specs evolve continuously with code
6. **Governance Framework Awareness** - Specialized for methodology documentation

**Key Constraints:**
- Agent Agnostic (works across Claude, Copilot, Cursor)
- Manual Adoption (file operations only, no install scripts)
- MSL Minimalism (4-section format, CRITICAL/IMPORTANT only)
- No Framework Lock-in (standard markdown, standard folders)
- Testable Behaviors (every spec has validation criteria)

**Domain**: This is a **governance/methodology framework** - specs about methodology itself. Analysis should focus on:
- Methodology completeness (all 5 phases covered)
- Dogfooding compliance (are we using our own methodology?)
- AI discoverability (can agents find and use prompts effectively?)
- Specification clarity (do prompts have clear behavior specs?)
- MSL adherence (are specs truly minimal?)
</ultrathink>

## Execution

### Phase 1: Context Validation

Reading project specifications to understand current state...

**Project Context:**
```bash
cat PURPOSE.md
cat specs/1-requirements/strategic/outcomes.spec.md
cat specs/1-requirements/strategic/constraints.spec.md
cat specs/strategy/architecture.spec.md
cat specs/workspace/constitution.spec.md
cat specs/workspace/patterns.spec.md
cat specs/workspace/workflows.spec.md
```

**Purpose:** Prevent spec-code drift, enable AI assistance, maintain living documentation

**Success Criteria:**
1. Bidirectional synchronization (spec→code and code→spec)
2. AI agent support (structured context)
3. Universal applicability (greenfield and brownfield)
4. Minimal maintenance (MSL compliance)
5. Voluntary adoption (reduces cognitive load)

**Core Principles:**
1. Spec-First Always (AI guides this)
2. MSL Minimalism (4-question framework)
3. Dogfooding (use own methodology)

**Critical Constraints:**
- Agent agnostic
- Manual adoption
- MSL minimalism
- No lock-in
- Testable behaviors

### Phase 2: Methodology Health Assessment

Analyzing LiveSpec's methodology completeness and self-application...

#### 2.1 Specification Completeness

**Check spec coverage:**
```bash
# Verify all required specs exist
ls -la specs/workspace/*.spec.md
ls -la specs/1-requirements/strategic/*.spec.md
ls -la specs/strategy/*.spec.md
find specs/behaviors/ -name "*.spec.md" | wc -l
find prompts/ -name "*.md" | wc -l
```

**Analysis questions:**
- Do all prompts in `prompts/` have corresponding specs in `specs/behaviors/prompts/`?
- Do all specs have validation criteria defined?
- Are failure modes documented for each spec?
- Do frontmatter dependencies exist and resolve correctly?
- Are there any deliverables (scripts, configs, templates) without specs?

#### 2.2 Dogfooding Compliance

**Validate self-application:**
```bash
# Check that LiveSpec uses its own methodology
ls -la .livespec
cat .livespec-version 2>/dev/null || echo "Version tracking not initialized"
find specs/behaviors/prompts/ -name "*.spec.md" | head -5
git log --oneline --all --grep="spec" | head -10
```

**Questions:**
- Is `.livespec/` symlink properly pointing to `prompts/`?
- Does git history show specs created before implementations?
- Are we following our own spec-first principle?
- Do we use Phase 4 (EVOLVE) to detect our own drift?
- Are workspace specs actually guiding our development?

#### 2.3 AI Discoverability

**Assess agent effectiveness:**
```bash
# Check AI agent configuration
cat AGENTS.md | head -50
cat llms.txt 2>/dev/null || echo "llms.txt not found"
ls -la specs/workspace/workspace-agent.spec.md 2>/dev/null || echo "Agent spec not found"
```

**Questions:**
- Is AGENTS.md comprehensive enough for AI agents to work autonomously?
- Does Context7 integration work (llms.txt properly configured)?
- Can agents discover prompts without human intervention?
- Do prompt specs clearly define expected behaviors?
- Are dependency links (implements:, governed-by:) traceable?

#### 2.4 MSL Adherence

**Validate minimalism:**
```bash
# Check spec sizes and format
for spec in specs/**/*.spec.md; do
  lines=$(wc -l < "$spec")
  if [ $lines -gt 100 ]; then
    echo "⚠️  $spec: $lines lines (consider splitting)"
  fi
done

# Check for over-specification
grep -r "NICE\|USEFUL" specs/ || echo "✓ No low-priority requirements found"
```

**Questions:**
- Are specs truly minimal (CRITICAL/IMPORTANT only)?
- Do specs specify WHAT not HOW?
- Can any requirements be removed without system failure?
- Are we trusting implementers appropriately?
- Do verbose specs need MSL audit?

#### 2.5 Process Adherence

**Validate workflow compliance:**
```bash
cat specs/workspace/workflows.spec.md
git log --oneline --all | head -20
```

**Check:**
- Is spec-first principle followed consistently?
- Are specs updated when prompts change?
- Do all changes go through proper phase workflow?
- Is drift detected and resolved regularly?
- Are validation criteria actually used?

### Phase 3: Gap Analysis

Identifying areas needing attention...

#### 3.1 Specification Gaps

**Missing or incomplete specs:**
- Which prompts lack behavior specifications?
- Which utilities lack documented behaviors?
- Which templates lack specifications?
- Which scripts/configs lack specs (violating spec-first)?

**Command to identify:**
```bash
# Find prompts without matching specs
for prompt in prompts/**/*.md; do
  base=$(basename "$prompt" .md)
  spec="specs/behaviors/prompts/${base}.spec.md"
  if [ ! -f "$spec" ]; then
    echo "Missing spec: $spec (for $prompt)"
  fi
done
```

#### 3.2 Quality Gaps

**Improvement opportunities:**
- Which specs are too verbose (>100 lines)?
- Which specs lack clear validation criteria?
- Which specs have vague failure modes?
- Which specs violate MSL minimalism (specifying HOW not WHAT)?
- Which specs have broken frontmatter dependencies?

#### 3.3 Purpose Alignment Gaps

**Achievement of success criteria:**

1. **Bidirectional Synchronization** - How well achieved?
   - ✓ Phase 1-2 (spec→code) exists
   - ✓ Phase 4a-4b (code→spec) exists
   - ? How often is Phase 4 actually run?
   - ? Are extractions validated (Phase 4e)?

2. **AI Agent Support** - How effective?
   - ✓ AGENTS.md exists
   - ✓ Context7 integration exists
   - ? Is AGENTS.md comprehensive enough?
   - ? Do agents follow spec-first principle?
   - ? Can agents navigate dependencies?

3. **Universal Applicability** - Both greenfield and brownfield?
   - ✓ Phase 0 for new projects
   - ✓ Phase 4b for existing codebases
   - ? How well tested on brownfield projects?
   - ? Are extraction workflows complete?

4. **Minimal Maintenance** - Are specs staying lean?
   - ✓ MSL format enforced
   - ? Are periodic MSL audits happening?
   - ? Are specs growing over time?
   - ? Is spec debt accumulating?

5. **Voluntary Adoption** - Do teams want to use this?
   - ? What friction points exist?
   - ? Where does adoption fail?
   - ? What cognitive load remains?
   - ? Are AI agents reducing burden effectively?

### Phase 4: Improvement Recommendations

**High Priority** (Critical to success criteria):

1. **Complete Spec Coverage for All Prompts**
   - **Impact**: Ensures spec-first principle actually enforced, enables validation
   - **Implementation**:
     1. Audit `prompts/` directory for prompts without specs
     2. Create missing specs in `specs/behaviors/prompts/`
     3. Add frontmatter dependencies (implements:, governed-by:)
     4. Define validation criteria for each
   - **Estimate**: 2-4 hours (depends on number of missing specs)
   - **Success**: Every prompt has matching spec with validation criteria

2. **Validate Dogfooding Compliance**
   - **Impact**: Builds credibility, discovers methodology gaps through real usage
   - **Implementation**:
     1. Check git history: Are specs created before implementations?
     2. Review recent changes: Did we follow our own workflows?
     3. Document any violations and root causes
     4. Add enforcement mechanisms (pre-commit hooks, PR templates)
   - **Estimate**: 1-2 hours
   - **Success**: Git history shows consistent spec-first pattern

3. **Strengthen AI Agent Guidance**
   - **Impact**: Ensures AI agents actually enforce spec-first principle
   - **Implementation**:
     1. Review AGENTS.md for spec-first emphasis
     2. Add explicit agent behaviors to `specs/workspace/workspace-agent.spec.md`
     3. Create examples of agent-guided spec-first workflow
     4. Test with actual agents (Claude, Copilot)
   - **Estimate**: 2-3 hours
   - **Success**: AI agents consistently check for specs before implementation

**Medium Priority** (Enhanced quality):

4. **MSL Audit for Verbose Specs**
   - **Impact**: Improves maintainability, demonstrates minimalism principle
   - **Implementation**:
     1. Identify specs >100 lines
     2. Apply 4-question MSL framework to each requirement
     3. Remove non-CRITICAL/IMPORTANT items
     4. Split complex specs into focused specs
   - **Estimate**: 3-4 hours
   - **Success**: All specs <100 lines, clear justification for each requirement

5. **Dependency Traceability Validation**
   - **Impact**: Enables impact analysis, improves navigation
   - **Implementation**:
     1. Validate all frontmatter dependencies resolve correctly
     2. Add missing dependencies (derives-from, governed-by, satisfies)
     3. Create dependency visualization (optional)
     4. Document dependency conventions in patterns.spec.md
   - **Estimate**: 2-3 hours
   - **Success**: All dependency links resolve, no broken references

6. **Extraction Workflow Validation**
   - **Impact**: Proves brownfield adoption works
   - **Implementation**:
     1. Run Phase 4b (extract-specs.md) on LiveSpec itself
     2. Validate low-confidence extractions (Phase 4e)
     3. Document learnings from self-extraction
     4. Improve extraction prompts based on experience
   - **Estimate**: 3-4 hours
   - **Success**: LiveSpec can extract and validate its own specs

**Low Priority** (Proactive enhancements):

7. **Create Self-Assessment Test Suite**
   - **Impact**: Enables continuous validation of methodology health
   - **Implementation**:
     1. Create automated tests for common gaps
     2. Check: Every prompt has spec, every spec has validation, etc.
     3. Run as part of CI/CD
     4. Add to Phase 4 (EVOLVE) workflow
   - **Estimate**: 4-6 hours
   - **Success**: Automated health checks catch violations

8. **Document Adoption Friction Points**
   - **Impact**: Improves voluntary adoption (success criterion #5)
   - **Implementation**:
     1. Collect feedback from actual users
     2. Identify common failure modes
     3. Create troubleshooting guide
     4. Improve prompts to address friction
   - **Estimate**: Ongoing
   - **Success**: Reduced support requests, higher completion rates

### Phase 5: Implementation Roadmap

**Immediate** (This week):
1. Complete spec coverage audit (Recommendation #1)
2. Validate dogfooding compliance (Recommendation #2)
3. Strengthen AI agent spec-first guidance (Recommendation #3)

**Short-term** (Next sprint):
1. MSL audit for verbose specs (Recommendation #4)
2. Dependency traceability validation (Recommendation #5)
3. Run extraction workflow on LiveSpec itself (Recommendation #6)

**Medium-term** (Next month):
1. Create self-assessment test suite (Recommendation #7)
2. Document adoption friction points (Recommendation #8)

## Analysis Summary

**Project Strengths:**
- Clear architecture with 5 phases
- Strong principles (spec-first, MSL minimalism, dogfooding)
- Agent-agnostic design
- Bidirectional workflow (spec→code and code→spec)

**Priority Focus Areas:**
1. **Spec-first enforcement**: Ensure every deliverable has spec (even LiveSpec's own)
2. **Dogfooding validation**: Prove we use our own methodology
3. **AI agent guidance**: Make agents enforce spec-first principle
4. **MSL adherence**: Keep specs truly minimal

**Success Metrics:**
- Every prompt has behavior spec with validation criteria
- Git history shows specs before implementations
- AI agents check for specs before implementing
- All specs <100 lines, CRITICAL/IMPORTANT only
- Brownfield extraction workflow proven on LiveSpec itself

**Next Analysis:**
- Run this prompt **monthly** or after significant changes
- Before major releases to ensure methodology integrity
- After adopting LiveSpec on new projects (learn from experience)
- When onboarding new contributors to validate clarity

**Key Questions for Next Analysis:**
1. Did we create any implementations without specs?
2. Did we follow Phase 4 (EVOLVE) to keep specs synchronized?
3. Are AI agents successfully enforcing spec-first principle?
4. Have specs grown beyond MSL minimalism?
5. What adoption friction did users encounter?
