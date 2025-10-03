---
spec: specs/prompts/2a-implement-from-specs.spec.md
---

# 2a: Implement from Specifications

**Phase**: BUILD
**Purpose**: Implement the system according to design specifications
**Prerequisites**: Phase 1 complete (architecture, behaviors, contracts defined)

## Task

Implement the system by following the specifications in order of criticality.

## Implementation Approach

### 1. Load Context

Read all relevant specifications:
- `specs/workspace/` - HOW to build (patterns, workflows)
- `specs/behaviors/` - WHAT to build (observable behaviors)
- `specs/contracts/` - WHAT interfaces to implement
- `specs/constraints.md` - WHAT boundaries to respect

### 2. Prioritise by Criticality

Implement in this order:
1. **CRITICAL behaviors** - System fails without these
2. **CRITICAL contracts** - Integration breaks without these
3. **IMPORTANT behaviors** - Quality degrades without these
4. **IMPORTANT contracts** - Nice to have but not essential

### 3. Follow Workspace Patterns

Respect all workspace specifications:
- Code patterns from `specs/workspace/patterns.md`
- Development workflows from `specs/workspace/workflows.md`
- Quality standards from `specs/workspace/constitution.md`

### 4. Implement Behaviors, Not Implementation

**Focus on observable outcomes:**
- ✅ "System authenticates users" → Implement authentication
- ❌ "Use JWT tokens" → Don't assume implementation unless specified

**Keep flexibility:**
- Specs define WHAT, you choose HOW
- Make reasonable implementation choices
- Document significant decisions

### 5. Validate Against Contracts

If contracts exist:
- Implement APIs matching OpenAPI specs exactly
- Validate data against JSON Schemas
- Ensure events match AsyncAPI contracts
- Use contract testing tools (Pact, oasdiff)

## Guidelines

**Start with critical path:**
- What must work for system to function?
- Implement end-to-end for one behavior first
- Validate before moving to next behavior

**Write tests alongside code:**
- Each behavior should have tests
- Tests validate specification requirements
- Tests serve as living documentation

**Stay minimal:**
- Don't add features not in specs
- Don't implement "nice to haves"
- Don't over-engineer

**Document decisions:**
- If you make significant implementation choices, document why
- If specs are ambiguous, flag for clarification
- If constraints conflict, escalate

## Exit Criteria

- [ ] All CRITICAL behaviors implemented
- [ ] All CRITICAL contracts implemented
- [ ] Implementation follows workspace patterns
- [ ] All constraints satisfied
- [ ] Tests validate behaviors
- [ ] No features added beyond specifications

## Next Step

Once implementation is complete, proceed to `2b-create-tests.md`
