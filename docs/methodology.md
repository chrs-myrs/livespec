# LiveSpec Methodology

## Core Philosophy

LiveSpec is built on three principles:

1. **Specifications and code drift apart** - This is inevitable without active synchronization
2. **AI agents need structure** - Good organization makes AI dramatically more effective
3. **Less is more** - Minimal specs are more maintainable than comprehensive ones

## What LiveSpec Is

LiveSpec is **information architecture**:

- A folder structure that separates workspace (HOW) from product (WHAT)
- A specification format (MSL) that keeps requirements minimal
- A set of prompts that guide AI agents through development phases
- A methodology for keeping specs and code synchronized

## What LiveSpec Is NOT

LiveSpec is not:

- ❌ A framework or library
- ❌ An AI coding assistant
- ❌ A build tool or automation system
- ❌ Custom software requiring installation
- ❌ Proprietary formats or lock-in

**It's just folders, markdown files, and a methodology.**

## The Workspace/Product Distinction

This is LiveSpec's core architectural decision.

### Workspace (How We Build)

`specs/workspace/` contains specifications for your development process:

- **constitution.md**: Development principles and governance
- **patterns.md**: Code patterns, naming conventions, standards
- **workflows.md**: How to add features, fix bugs, review changes

**Characteristics:**
- Relatively stable (doesn't change often)
- Applies to all development work
- Forms persistent context for AI agents
- Answers "How should we work?"

**Example:**
```markdown
# specs/workspace/patterns.spec.md

## Test Naming

**Specification**: Test functions use descriptive names starting with `test_`

**Validation**: All test files follow `test_*.py` pattern and functions start with `test_`
```

### Product (What We Build)

`specs/` root and type folders contain specifications for the system itself:

- **problem.md**: What problem does this solve?
- **constraints.md**: What boundaries must be respected?
- **behaviors/**: What does the system do?
- **contracts/**: What are the interfaces?

**Characteristics:**
- Changes with requirements
- Specific to features and capabilities
- Forms dynamic context (load what's relevant)
- Answers "What should we build?"

**Example:**
```markdown
# specs/behaviors/user-authentication.spec.md

**Criticality**: CRITICAL
**Failure Mode**: System unsecured without authentication

## Specification
System authenticates users via email and password before allowing access to protected resources.
```

### Why This Matters

AI agents perform better with this separation:

1. **Workspace specs** provide consistent behavioral rules
2. **Product specs** provide focused task context
3. Combined context is smaller and more relevant
4. Workspace rules don't pollute product requirements

## The Five Phases

LiveSpec guides development through five phases, not as rigid waterfall but as clear progression.

### Phase 0: DEFINE (Why & What)

**Purpose**: Establish problem space and development approach

**Outputs:**
- `specs/problem.md` - What are we solving?
- `specs/constraints.md` - What boundaries exist?
- `specs/workspace/*` - How will we work?

**When**: Start of project or major pivot

**Key Principle**: Don't start building without knowing why

### Phase 1: DESIGN (How)

**Purpose**: Design the solution architecture

**Outputs:**
- `specs/architecture.md` (or similar) - System structure
- `specs/behaviors/*` - Observable behaviors
- `specs/contracts/*` - API/data contracts

**When**: After problem is clear, before implementation

**Key Principle**: Specify WHAT, not HOW

### Phase 2: BUILD (Do)

**Purpose**: Implement the solution

**Outputs:**
- Working code following specs
- Tests validating behaviors
- Documentation as needed

**When**: After design is approved

**Key Principle**: Build to specs, not beyond them

### Phase 3: VERIFY (Check)

**Purpose**: Validate solution meets requirements

**Outputs:**
- Test results
- Validation reports
- Acceptance decisions

**When**: After implementation complete

**Key Principle**: Verify against specs, not assumptions

### Phase 4: EVOLVE (Sync)

**Purpose**: Keep specs and code synchronized

**Outputs:**
- Updated specifications
- Extracted new specs
- Evolution logs

**When**: Continuous after initial delivery

**Key Principle**: Specs are living documents

## The Evolution Cycle

Phase 4 (EVOLVE) is special - it's continuous:

```
Code Changes → Detect Drift → Classify Changes → Update Specs → Verify Sync
     ↑                                                               ↓
     └───────────────────────────────────────────────────────────────┘
```

### Drift Detection

**When code and specs diverge:**

1. **Detect drift** (4a-detect-drift.md)
   - What changed in code?
   - What changed in specs?
   - Are they still aligned?

2. **Classify changes** (use 70-80-10 pattern)
   - 70-80%: Auto-accept (refactoring, no spec change)
   - 10-20%: Review needed (behavior changes)
   - 5-10%: Manual resolution (conflicts)

3. **Extract/update specs** (4b-extract-specs.md)
   - New features → Extract new specs
   - Modified behaviors → Update existing specs
   - Removed features → Archive specs

4. **Verify synchronization** (4c-sync-complete.md)
   - All changes addressed?
   - Tests still passing?
   - Specs match reality?

### Continuous Synchronization

Run EVOLVE prompts:
- **Weekly**: Regular drift checks
- **After features**: Immediate spec extraction
- **Before releases**: Full synchronization verification
- **Quarterly**: MSL minimalism audits

## Working with AI Agents

### Claude Code

```bash
# Direct prompt execution
claude-code "Use .livespec/0-define/0a-setup-workspace.md"

# With context
claude-code "Using specs/behaviors/authentication.spec.md as reference, implement the login endpoint"
```

### Cursor

```
1. Open prompt file
2. Select content (Cmd+A)
3. Use Composer (Cmd+K)
4. Paste and execute
```

### GitHub Copilot

```python
# In your code file
# Following .livespec/2-build/2a-implement-from-specs.md
# Implement user authentication per specs/behaviors/authentication.spec.md
```

### Any Agent

All prompts are plain markdown - copy/paste into your AI agent.

## The MSL Advantage

### Traditional Requirements

```
User Management Module

The system shall provide a comprehensive user management interface
that allows administrators to create, read, update, and delete user
accounts. The interface should be intuitive and follow modern UX
best practices...

(continues for 5 pages)
```

### MSL Requirements

```markdown
# User Management

**Criticality**: CRITICAL
**Failure Mode**: Admins cannot manage user accounts

## Specification
Admins can create, view, update, and delete user accounts via management interface.

## Validation
- Admins can perform CRUD operations on users
- Non-admins cannot access management interface
- Changes persist correctly
```

### The Difference

- **70% smaller** - Less to read and maintain
- **Clear criticality** - Know what matters
- **Testable** - Every validation is a test
- **No bloat** - Only essential information
- **AI-friendly** - Fits in context windows

## Progressive Refinement

LiveSpec specifications should REDUCE over time, not grow.

### Initial Spec (v1)

```markdown
# API Rate Limiting

**Criticality**: IMPORTANT
**Failure Mode**: API abuse possible without rate limiting

## Specification
API limits requests to 100 per minute per user with 429 response for exceeded limits.
Limits reset every minute. Headers include remaining requests and reset time.

## Validation
- 100 requests succeed within minute
- 101st request returns 429
- Limits reset after minute
- Response headers show limit info
```

### Refined Spec (v2 - after learning)

```markdown
# API Rate Limiting

**Criticality**: IMPORTANT
**Failure Mode**: API abuse possible without rate limiting

## Specification
API limits requests per user with 429 response when exceeded.

## Validation
- Requests within limit succeed
- Requests exceeding limit return 429
```

**What changed:**
- ❌ Removed "100 per minute" (implementation detail)
- ❌ Removed "headers include..." (how, not what)
- ✅ Kept core behavior (limiting works)
- ✅ Kept validation (observable outcomes)

**Result**: Spec is more flexible, equally complete.

## Spec Granularity

### When to Create a Specification

Create one specification per:

- **Independently testable behavior** - Can be validated without other specs
- **Single failure mode** - One clear way the system breaks without it
- **Deployment boundary** - Feature that can be released independently
- **External contract** - Interface with another system or component

**Example:**
```
✅ specs/behaviors/user-login.spec.md
✅ specs/behaviors/password-reset.spec.md
✅ specs/contracts/payment-api.spec.md
```

Not:
```
❌ specs/behaviors/authentication.spec.md (too broad - covers multiple features)
❌ specs/behaviors/login-button-styling.spec.md (too granular - implementation detail)
```

### When to Split Specifications

Split a specification when:

1. **Length exceeds ~200 lines** - Becoming hard to maintain
2. **Multiple distinct failure modes** - "System breaks without A AND without B"
3. **Different update frequencies** - Part changes often, part is stable
4. **Mixed criticality levels** - Some parts CRITICAL, others IMPORTANT
5. **Separate testing needed** - Different validation approaches required

**Example: Before Split**
```markdown
# User Management (300 lines, 5 failure modes)

**Criticality**: CRITICAL + IMPORTANT mixed
**Failure Mode**: Multiple distinct failures

## Specification
Covers authentication, profile management, permissions, and password policies...
```

**After Split:**
```markdown
# specs/behaviors/user-authentication.spec.md (CRITICAL)
# specs/behaviors/user-profiles.spec.md (IMPORTANT)
# specs/behaviors/user-permissions.spec.md (CRITICAL)
# specs/behaviors/password-policy.spec.md (IMPORTANT)
```

### When to Merge Specifications

Merge specifications when:

1. **Always change together** - Can't update one without the other
2. **Share single failure mode** - Same thing breaks without both
3. **Total size < 100 lines** - Small enough to maintain as one
4. **Single validation suite** - Tested together
5. **Same criticality level** - Both CRITICAL or both IMPORTANT

**Example: Before Merge**
```markdown
# specs/behaviors/login-form.spec.md (45 lines)
# specs/behaviors/login-validation.spec.md (35 lines)
# specs/behaviors/login-session.spec.md (40 lines)
```

All three always change together, tested together, same criticality.

**After Merge:**
```markdown
# specs/behaviors/user-authentication.spec.md (120 lines)
Covers form, validation, and session in one cohesive spec.
```

### Scoping Examples from LiveSpec

LiveSpec itself demonstrates good scoping:

**Workspace Specs (Process):**
- `specs/workspace/constitution.spec.md` - Development principles
- `specs/workspace/patterns.spec.md` - Code and spec patterns
- `specs/workspace/workflows.spec.md` - Development workflows

**Why separate?** Different concerns, different update frequencies.

**Prompt Specs (Product):**
- `specs/behaviors/prompts/0a-setup-workspace.spec.md` - One prompt's behavior
- `specs/behaviors/prompts/0b-define-problem.spec.md` - Another prompt's behavior

**Why separate?** Each prompt is independently testable, different failure modes.

**Core Behavior Specs:**
- `specs/behaviors/msl-format.spec.md` - MSL format rules
- `specs/behaviors/folder-structure.spec.md` - Folder organization
- `specs/behaviors/five-phases.spec.md` - Phase progression

**Why separate?** Different aspects of methodology, tested differently.

### The Goldilocks Principle

**Too Granular:**
```
❌ specs/behaviors/login-button-color.spec.md
❌ specs/behaviors/password-field-placeholder.spec.md
❌ specs/behaviors/login-error-animation.spec.md
```

**Too Broad:**
```
❌ specs/behaviors/entire-application.spec.md
❌ specs/behaviors/all-user-features.spec.md
❌ specs/behaviors/frontend.spec.md
```

**Just Right:**
```
✅ specs/behaviors/user-authentication.spec.md
✅ specs/behaviors/user-profile-management.spec.md
✅ specs/behaviors/user-permissions.spec.md
```

### Decision Process

When creating or reviewing a spec, ask:

1. **Single purpose?** - Does it specify ONE behavior or feature?
2. **Clear boundaries?** - Can you define what's in and out of scope?
3. **Independently testable?** - Can you validate without other specs?
4. **Right size?** - Between 30-200 lines typically
5. **Appropriate criticality?** - All content matches the criticality level

If answers are unclear, spec scope is probably wrong.

### Refactoring Specs

Like code, specifications benefit from refactoring:

**Signs spec needs splitting:**
- "This spec AND that spec" in failure mode
- File getting hard to navigate (>250 lines)
- Different parts updated by different people
- Validation section has 15+ bullets

**Signs specs need merging:**
- Always updated together in git history
- Total combined size <100 lines
- Same validation approach
- Duplicated content between them

Run periodic "spec audits" during Phase 4 (EVOLVE) to identify refactoring opportunities.

## Anti-Patterns

### ❌ Over-Specification

**Bad:**
```markdown
# Database Schema

**Specification**:
Users table has columns: id (UUID primary key), email (varchar 255 unique),
password_hash (varchar 255), created_at (timestamp), updated_at (timestamp).
Uses PostgreSQL 14 with btree indexes on email...
```

**Why Bad**: This is implementation detail, not requirement.

**Better:**
```markdown
# User Data Storage

**Specification**:
System persists user accounts with email and secure password storage.
```

### ❌ Nice-to-Haves

**Bad:**
```markdown
# Dashboard

**Criticality**: IMPORTANT
**Specification**:
Dashboard should show graphs, be colorful, have animations, and feel modern.
```

**Why Bad**: Subjective, not testable, not critical.

**Better:**
```markdown
# Dashboard

**Criticality**: CRITICAL
**Failure Mode**: Users cannot view account data

**Specification**:
Dashboard displays user's transaction history and current balance.
```

### ❌ Implementation Disguised as Requirements

**Bad:**
```markdown
# Frontend

**Specification**:
Use React with TypeScript, Redux for state, styled-components for styling.
```

**Why Bad**: This belongs in workspace/patterns.md if anywhere.

**Better:**
```markdown
# specs/workspace/patterns.spec.md

## Frontend Stack

**Specification**: Frontend uses React with TypeScript

**Validation**: All frontend code is .tsx files
```

## When to Use LiveSpec

### Good Fits

✅ **AI-assisted development** - You work with Claude, Copilot, Cursor
✅ **Living documentation** - Specs must stay current
✅ **New projects** - Clean start with good structure
✅ **Existing projects** - Need to document what exists
✅ **Team projects** - Need clear specifications
✅ **Any language/platform** - Pure information architecture

### Might Not Fit

⚠️ **Solo hobby projects** - Might be overkill
⚠️ **Throwaway prototypes** - No need for specs
⚠️ **Fully specified systems** - Already have comprehensive docs
⚠️ **No AI usage** - Benefits less clear without AI agents

## Success Metrics

You'll know LiveSpec is working when:

- ✅ AI agents consistently understand what to build
- ✅ Specifications are 70% smaller than before
- ✅ Spec drift detected and resolved regularly
- ✅ New team members understand project quickly
- ✅ No outdated documentation exists
- ✅ Specifications are maintained, not abandoned

## Getting Started

1. **Read [Quickstart](quickstart.md)** - 5-minute setup
2. **Read [MSL Guide](msl-guide.md)** - Learn minimal specs
3. **Use Phase 0 prompts** - Setup your first project
4. **Follow the five phases** - Let prompts guide you
5. **Embrace minimalism** - Delete everything non-essential

---

**LiveSpec is not about perfect specifications. It's about specifications good enough to keep code and documentation synchronized without becoming a maintenance burden.**
