# Common LiveSpec Pitfalls: Real-World Examples

**Purpose**: Prevent recurring mistakes through honest failure analysis and pattern recognition.

**Based on**: Real implementation experiences documented through dist/templates/reports/implementation-report.md.template

---

## Introduction

LiveSpec's spec-first approach is **counterintuitive** for both AI assistants and human developers. We have strong instincts to jump to implementation, pattern-match from previous work, and avoid "overhead" documentation.

This guide catalogs actual failures from real LiveSpec projects, analyzing **why** we skip steps and **what** actually happens when we do.

**Key insight**: These aren't random mistakes - they're systematic cognitive biases that require **structural enforcement**, not just documentation.

---

## Pitfall 1: Skipping Requirements (Overconfidence Bias)

### Real Example: Slack MCP Channel Operations

**What happened**:
- User requested "add bug investigation and user interview flows"
- AI assistant immediately started planning implementation details
- Jumped to technical architecture without requirements analysis
- **User intervention required**: "you are skipping the livespec process"

**What the assistant thought**:
> "This is straightforward - DMs to channels, URL parsing, thread continuation. I understand the problem."

**What was actually missing**:
- User/channel discovery tools (user had to point this out)
- Auto-resolution of usernames to IDs
- Graceful degradation for missing OAuth scopes
- Distinction between blocking vs non-blocking operations

**Root cause**: Overconfidence bias - assuming problem is simpler than it is

**Prevention**:
- ✅ **Use Phase 0 (DEFINE)**: Always start with .livespec/0-define/ prompts
- ✅ **Create PURPOSE.md**: Forces articulation of WHY before WHAT
- ✅ **List all requirements**: FR-* numbering makes gaps visible
- ✅ **User review checkpoint**: Requirements review catches missed dependencies

**Recovery**:
If you catch yourself planning implementation before requirements:
1. STOP - Don't continue with implementation
2. Back up to Phase 0/1 (DEFINE/DESIGN)
3. Create requirements specs (specs/1-requirements/)
4. User review before proceeding
5. Resume with proper phase sequence

---

## Pitfall 2: Efficiency Instinct (False Speed)

### Real Example: "Writing Specs Feels Like Overhead"

**What the assistant thought**:
> "Writing specs feels like overhead. I can deliver faster by coding directly."

**What actually happened**:
- User had to stop and redirect to proper process
- Would have implemented incomplete solution (missing discovery tools)
- Rework would have been **more expensive** than upfront specs
- Manual testing revealed missing features (expected_format parameter)

**Cost comparison**:

**Without specs**:
```
User request → Implementation (1 hour)
→ User review: "Missing discovery tools, threading unclear, no UX docs"
→ Rework (2 hours)
→ Still incomplete (no tests, no domain models)
= 3+ hours, still gaps
```

**With specs (LiveSpec process)**:
```
User request → Requirements (15 min)
→ Behaviors (30 min)
→ Contracts (30 min)
→ User review: "Looks complete, proceed"
→ Implementation (1 hour)
→ Tests (30 min)
= 2.5 hours, complete and tested
```

**Prevention**:
- ✅ **Measure total time**: Include rework, not just initial coding
- ✅ **Value user review checkpoints**: Catch issues before implementation
- ✅ **Spec-first is path of least resistance**: Use TodoWrite to enforce sequence

**Recovery**:
If you realize you've coded without specs:
1. Don't delete code - keep as reference
2. Extract specs from implementation (.livespec/4-evolve/4b-extract-specs.md)
3. Mark extracted specs as "LOW CONFIDENCE"
4. User review of extracted specs
5. Refactor implementation to match validated specs

---

## Pitfall 3: Pattern Matching Without Context

### Real Example: "I've Built MCP Tools Before"

**What the assistant thought**:
> "I've implemented similar MCP tools before. I know the patterns."

**What was missed**:
- **Slack's threading model** differs from other messaging systems
- **Channel vs DM semantics** have different reply patterns
- **TMP-specific use cases** (bug investigation, user interviews) have unique requirements
- **Business context** matters for prioritization

**Root cause**: Pattern matching is useful but insufficient - each domain has unique constraints

**Prevention**:
- ✅ **Document domain models**: Use .livespec/standard/metaspecs/domain-model.spec.md
- ✅ **Explicit threading models**: Slack threads ≠ Discord threads ≠ email threads
- ✅ **Business context in requirements**: specs/1-requirements/ captures WHY
- ✅ **Domain-specific behaviors**: specs/3-behaviors/ defines THIS system's rules

**Recovery**:
If you discover domain-specific gaps after implementation:
1. Create domain model spec (e.g., threading-model.spec.md)
2. Document invariants, rules, edge cases
3. Review implementation against domain model
4. Add tests for domain-specific edge cases
5. Update contracts to reflect domain constraints

---

## Pitfall 4: Ambiguity Aversion (Fear of Questions)

### Real Example: Not Asking for Clarification

**What the assistant thought**:
> "If I start asking requirements questions, it will slow things down and annoy the user."

**What actually happened**:
- User explicitly mentioned two flows but didn't specify all dependencies
- Discovery tools were **implicit prerequisites** (user assumed obvious)
- User was **happy to clarify** when asked directly
- Asking upfront saved rework time

**Prevention**:
- ✅ **Use AskUserQuestion tool**: Explicit clarification is welcomed
- ✅ **List assumptions**: "I'm assuming X, Y, Z - correct?"
- ✅ **Requirements review checkpoint**: User validates before implementation
- ✅ **Better to ask than rework**: 2 minutes of questions saves hours of rework

**When to ask**:
- Multiple valid interpretations of requirement
- Technical approach choice affects user experience
- Business priority unclear
- Domain knowledge gaps

**When to proceed**:
- Single obvious interpretation
- Conventional patterns apply
- Low-risk decision
- Easy to change later

---

## Pitfall 5: TDD Completely Skipped

### Real Example: Slack MCP Implementation

**What was done**: Specs → Implementation → Manual testing via MCP calls

**What should have been done**: Specs → Automated tests (RED) → Implementation (GREEN) → Refactor

**Impact**:
- ❌ Zero automated test coverage
- ❌ No regression protection
- ❌ Manual testing doesn't prove correctness, only "seems to work"
- ❌ Can't refactor safely
- ❌ No CI/CD validation possible

**Why this happened**:
> "TDD wasn't explicitly in the LiveSpec phase names. Assumed 'testing' meant validation, not test-first development."

**Prevention (Post-3.3.0)**:
- ✅ **Phase 2 renamed**: "BUILD" → "BUILD (TDD)"
- ✅ **Mandatory by default**: TDD required, escape hatch for trivial scripts
- ✅ **Prompts reordered**: 2b-create-tests.md BEFORE 2a-implement-from-specs.md
- ✅ **Escape hatch scoring**: ≥8/10 points required to skip TDD

**Escape hatch criteria** (from dist/guides/tdd.md):
```
✓ Trivial script (no logic/conditionals/loops) [2 points]
✓ Throw-away/experimental code [2 points]
✓ Simple config/data file [2 points]
✓ Generated boilerplate [2 points]
✓ One-time migration script [2 points]

Total ≥8 points → May skip TDD with justification
Total <8 points → TDD required
```

**Recovery**:
If you realize you skipped TDD after implementation:
1. Don't defend the skip - acknowledge the gap
2. Write tests now (better late than never)
3. Use behavior specs to guide test creation
4. Red-Green-Refactor: Make tests fail, then pass, then refactor
5. Document test coverage gaps in implementation report

---

## Pitfall 6: UX Flows Never Documented

### Real Example: Bug Investigation Flow

**What was done**: Jumped from user request to tool contracts

**What should have been done**: Document complete user journeys as specifications before defining tools

**Missing documentation**:
- **Bug Investigation Flow**: Step-by-step UX from copying URL to posting findings
- **User Interview Flow**: Multi-turn conversation patterns, timeout handling, thread continuation
- User mental models for each flow
- Expected interaction patterns
- Error recovery journeys

**Impact**:
- ❌ Tools exist but usage patterns unclear
- ❌ No documentation for Claude or human users on how to use these flows
- ❌ Can't validate if implementation matches intended UX

**Prevention (Post-3.3.0)**:
- ✅ **Phase 1a added**: .livespec/1-design/1a-document-ux-flows.md
- ✅ **Before architecture**: UX flows defined before tool contracts
- ✅ **Mermaid diagrams**: Visual flow documentation required
- ✅ **Metaspec available**: .livespec/standard/metaspecs/research/ux-flow.metaspec.md

**When to create UX flows**:
- ✅ User-facing features with multiple interaction paths
- ✅ Complex state transitions
- ✅ Error recovery patterns need documentation
- ✅ Multi-step workflows
- ✅ Async operations with user feedback

**When to skip UX flows**:
- ❌ Pure backend processing (no user interaction)
- ❌ Single-step operations
- ❌ Library/utility functions
- ❌ Data transformations

**Recovery**:
If you discover missing UX flows after implementation:
1. Use .livespec/1-design/1a-document-ux-flows.md retroactively
2. Create Mermaid flowcharts for each user journey
3. Validate flows against implementation
4. Update tools to match documented UX (if gaps found)
5. Add UX flow specs to specs/3-behaviors/ux-flows/

---

## Pitfall 7: Incomplete Feature Implementation

### Real Example: `expected_format` Parameter

**What was claimed**: Tools with `expected_format` parameter for structured responses

**What actually exists**: Parameter defined in contract but **no implementation**

**Missing features**:
- ❌ Multiple choice response validation/parsing
- ❌ Yes/no response validation/formatting
- ❌ Number response validation/parsing
- ❌ Structured response format enforcement
- ❌ Response parsing logic
- ❌ User-friendly format hints in Slack messages

**Impact**:
- Parameter exists but does nothing (API lie)
- Users will expect behavior that doesn't exist
- **Contract doesn't match implementation**

**Root cause**: Contract completeness validation didn't exist (fixed in 3.3.0)

**Prevention (Post-3.3.0)**:
- ✅ **Contract completeness validation**: scripts/check-contract-completeness.sh
- ✅ **Required behavior links**: Every contract parameter must reference behavior spec
- ✅ **Pre-commit hook**: Automatic validation before commit
- ✅ **CI/CD integration**: tests/structure/test_full_validation.sh includes completeness check

**Pattern**:
```markdown
# Contract: specs/3-contracts/mcp-tools/slack-tools.spec.md

**Parameters**:
- `expected_format` (optional): Expected response format
  - Behavior: specs/3-behaviors/response-validation.spec.md#format-validation
```

**Recovery**:
If you discover parameters without behavior specs:
1. Run scripts/check-contract-completeness.sh to identify all gaps
2. For each parameter, create or link to behavior spec
3. Implement missing behavior (if parameter claims functionality)
4. OR remove parameter (if not actually needed)
5. Never ship contracts with non-functional parameters

---

## Pitfall 8: Domain Model Ambiguity

### Real Example: Slack Threading Model

**What was assumed**: "thread_ts model was clear enough"

**Actual ambiguity**:
- **Channel vs DM threading**: How does thread_ts work differently in each context?
- **Reply semantics**: What does "reply to message" mean in channel vs DM?
- **Correlation in channels**: Multiple users can reply - how do we know which reply belongs to our request?
- **Thread creation**: When does Claude start new thread vs continue existing?
- **Parent message handling**: Is parent message included in thread retrieval?

**Impact**:
- ❌ Implementation made assumptions not validated in specs
- ❌ Edge cases undefined (e.g., multiple simultaneous DMs to same user)
- ❌ Behavior under concurrent access undefined

**Prevention (Post-3.3.0)**:
- ✅ **Domain model metaspec**: .livespec/standard/metaspecs/domain-model.spec.md
- ✅ **Explicit core concepts**: Threading, correlation, state machines get their own specs
- ✅ **Invariants documented**: Rules that MUST hold in all cases
- ✅ **Interaction patterns**: How concepts relate to each other

**When to create domain model specs**:
- Complex core concepts (not obvious from code)
- State machines with transitions
- Correlation/matching logic
- Business rules with edge cases
- Concepts referenced across multiple behaviors

**Example domain model structure**:
```markdown
# Slack Threading Model (Domain Model)

## Core Concepts
- [!] thread_ts: Parent message timestamp (NOT separate thread ID)
- [!] Channels: thread_ts identifies parent, replies visible to all
- [!] DMs: thread_ts creates logical grouping, 1:1 conversation

## Invariants
- [!] In channels: thread_ts ALWAYS identifies parent message timestamp
- [!] Parent message IS included when retrieving thread
- [!] thread_ts is the parent message's timestamp, not a separate ID

## Interaction Patterns
### Creating Threads (Channels)
- First message: thread_ts = null (creates parent)
- Replies: thread_ts = parent's timestamp

### DM Threading
- First DM: No thread_ts needed (1:1 conversation)
- Subsequent DMs: Same conversation continues
- Use thread_ts for logical grouping only
```

**Recovery**:
If you discover domain model ambiguity:
1. Create domain model spec in specs/3-behaviors/domain-models/
2. Document invariants (rules that MUST hold)
3. Document interaction patterns
4. Link from behavior specs to domain model
5. Add tests for domain-specific edge cases

---

## Pitfall 9: Wrong Folder for Working Documents

### Real Example: Implementation Report Placement

**What was done**: Put implementation report in `specs/workspace/`

**What should have happened**: Working documents go in `var/`

**Why this matters**:
- `specs/` is for **specifications** (requirements, behaviors, contracts)
- `var/` is for **transient working files** (reports, analysis, scratch work)
- Violates separation of concerns

**Correct locations**:
```
specs/workspace/           # HOW you work (constitution, patterns, workflows)
specs/1-requirements/      # WHY you're building (strategic outcomes, constraints)
specs/2-strategy/          # HOW you'll build (architecture, design decisions)
specs/3-behaviors/         # WHAT system does (observable outcomes)
specs/3-contracts/         # Interfaces (API/data contracts)

var/                       # Working files (reports, analysis)
generated/                 # Build outputs (dist/, compiled code)
.archive/                  # Old versions (if needed)
```

**Prevention**:
- ✅ **Read specs/workspace/taxonomy.spec.md FIRST**: Before creating any files
- ✅ **Portability test**: "Could I use this spec in ANY project?" → YES = workspace/
- ✅ **Specs boundary**: No user data in specs/, no research materials, no generated artifacts
- ✅ **Working files**: Reports, analysis, scratch → var/

**Recovery**:
If you put files in wrong location:
1. Move file to correct location
2. Update any references/links
3. Gitignore var/ and generated/ (if not already)
4. Review taxonomy.spec.md to internalize boundaries

---

## Pattern Recognition: When You're About to Skip Steps

**Warning signs that you're falling into a pitfall**:

1. **Thought: "This is straightforward, I can skip requirements"**
   - → Pitfall 1 (Overconfidence bias)
   - Action: Use .livespec/0-define/0c-define-problem.md

2. **Thought: "Writing specs will slow me down"**
   - → Pitfall 2 (False speed)
   - Action: Remember total time includes rework

3. **Thought: "I've done this before, I know the patterns"**
   - → Pitfall 3 (Pattern matching)
   - Action: Document domain models first

4. **Thought: "I don't want to annoy user with questions"**
   - → Pitfall 4 (Ambiguity aversion)
   - Action: Use AskUserQuestion tool

5. **Thought: "I'll write tests later/after implementation"**
   - → Pitfall 5 (TDD skipped)
   - Action: Use .livespec/2-build/2b-create-tests.md FIRST

6. **Thought: "The user request is clear enough"**
   - → Pitfall 6 (UX flows missing)
   - Action: Use .livespec/1-design/1a-document-ux-flows.md

7. **Thought: "I can add that parameter to the API"**
   - → Pitfall 7 (Incomplete features)
   - Action: Link parameter to behavior spec

8. **Thought: "The threading model is obvious"**
   - → Pitfall 8 (Domain ambiguity)
   - Action: Create domain model spec

9. **Thought: "I'll just put this report in specs/"**
   - → Pitfall 9 (Wrong folder)
   - Action: Check taxonomy.spec.md

---

## Structural Enforcement (Why Documentation Alone Fails)

**Key insight**: These pitfalls persist even when documented because they're **cognitive biases**, not knowledge gaps.

**LiveSpec 3.3.0 structural changes**:

1. **TodoWrite Gate** (Layer 1):
   - Creating permanent file → Add "Create spec" todo FIRST
   - Forces conscious decision to create spec

2. **Validation Check** (Layer 2):
   - scripts/check-requires-spec.sh runs before file operations
   - Blocks file creation if spec missing

3. **Plan Mode** (Layer 3):
   - New permanent files require plan presentation
   - Plan must show spec creation step
   - User approval before proceeding

4. **Pre-commit Hook** (Layer 4):
   - Automatic validation before every commit
   - Catches skipped specs, broken links, MSL violations
   - Blocks commit if validation fails

5. **Phase Naming** (Phase 2):
   - Renamed to "BUILD (TDD)" to make TDD explicit
   - Prompts reordered (tests before implementation)
   - Escape hatch with scoring system (≥8/10 to skip)

6. **Contract Completeness**:
   - scripts/check-contract-completeness.sh validates parameters
   - Every contract parameter must link to behavior spec
   - Integrated into validation suite

**Goal**: Make correct approach **path of least resistance**

---

## Using This Guide

**When to read this**:
- Starting new LiveSpec project
- Caught yourself skipping a phase
- Implementation review revealed gaps
- Teaching LiveSpec to others

**When to update this**:
- New pitfall discovered in real project
- New prevention strategy proves effective
- Structural enforcement changes
- Implementation reports reveal patterns

**Template for adding pitfalls**:
```markdown
## Pitfall X: [Name]

### Real Example: [Project/Context]

**What happened**: [Chronological narrative]

**What was thought**: [Quote or paraphrase of reasoning]

**What was missed**: [Bullet list of gaps]

**Root cause**: [Why this happens]

**Prevention**:
- ✅ [Specific action 1]
- ✅ [Specific action 2]

**Recovery**:
[Step-by-step recovery process]
```

---

## Further Reading

- **dist/templates/reports/implementation-report.md.template** - Full report template with cognitive bias sections
- **dist/prompts/4-evolve/4f-document-implementation.md** - Prompt for creating honest implementation reports
- **specs/workspace/constitution.spec.md** - Core principles including spec-first enforcement
- **dist/guides/tdd.md** - TDD guide with mandatory-by-default approach
- **.livespec/standard/metaspecs/domain-model.spec.md** - Template for domain model specs

---

**Remember**: Pitfalls aren't failures - they're learning opportunities. Document them honestly, recognize patterns, build structural prevention.
