# CLAUDE.md Migration Guide: From Verbose to Minimal

## Quick Decision Guide

**Should I migrate?**
- Is your CLAUDE.md over 200 lines? → **Yes**
- Full of {PLACEHOLDERS}? → **Yes**
- Mostly generic content? → **Yes**
- Hard to maintain? → **Yes**
- Team ignores it? → **Definitely Yes**

## Migration Process

### Step 1: Extract Essential Information (10 minutes)

From your current CLAUDE.md, extract only:

1. **Project name and core purpose**
2. **Actual technology choices** (not placeholders)
3. **Real constraints** that affected development
4. **Specific rules** your team actually follows
5. **Current focus** or sprint goals

### Step 2: Create Minimal Version

Use this template:

```markdown
# [Your Project] - Claude Context

## Quick Reference
- **Purpose**: [One sentence - what does it do?]
- **Type**: [Actual type, not placeholder]
- **Stack**: [Real tech stack in use]
- **Started**: [Actual date]
- **Stage**: [Current stage from progress report]

## Project-Specific Focus

### Complexity Areas
- [Your actual biggest challenge]
- [Second challenge if significant]

### Critical Constraints
- [Real constraints you face]
- [Compliance/security if applicable]

## Working Agreements

### Code Standards
- [Rules your team actually follows]
- [Patterns you've established]

### Documentation Flow
- [How you actually use the reqs/ structure]
- [Any modifications to standard flow]

## Current Sprint Focus
[What you're actually working on now]

## Key Technical Decisions
- **[Decision]**: [Why you made it]
- **[Decision]**: [Brief rationale]
```

### Step 3: Archive Verbose Version

```bash
# Don't delete - archive for reference
mv CLAUDE.md CLAUDE.md.verbose-archive
# Create new minimal version
```

### Step 4: Validate with Team

Ask your team:
1. "Is anything critical missing?"
2. "Is everything here actually true?"
3. "Will we maintain this?"

## Real Migration Examples

### Example 1: E-Commerce Platform

**Before** (475 lines):
```markdown
# {PROJECT_NAME} - Claude Development Context
...
**Project Type**: {PROJECT_TYPE}
**Technology Stack**: {TECH_STACK}
...
[Hundreds of lines of generic rules and placeholders]
```

**After** (42 lines):
```markdown
# ShopFlow - Claude Context

## Quick Reference
- **Purpose**: Multi-tenant e-commerce platform with subscription billing
- **Type**: Next.js app with GraphQL API  
- **Stack**: TypeScript, PostgreSQL, Stripe, Vercel
- **Started**: 2023-11-01
- **Stage**: Maintenance (Stage 6)

## Project-Specific Focus

### Complexity Areas
- Multi-tenant data isolation
- Stripe subscription state sync
- Real-time inventory updates

### Critical Constraints
- PCI DSS compliance required
- EU/UK data residency laws
- 99.9% uptime SLA

## Working Agreements

### Code Standards
- Feature flags for all new features
- No direct Stripe API calls (use our wrapper)
- Tenant context required for all DB queries

### Documentation Flow
- Payment flows documented in reqs/3-design/payment-flow/
- Tenant isolation strategy in reqs/2-strategy/multi-tenant.md

## Current Sprint Focus
Implementing subscription plan upgrades/downgrades

## Key Technical Decisions
- **PostgreSQL RLS**: For tenant isolation
- **Stripe Checkout**: Simpler than custom flow
- **Vercel**: Auto-scaling for Black Friday
```

### Example 2: Internal CLI Tool

**Before** (380 lines with TDD rules, deployment strategies, etc.)

**After** (28 lines):
```markdown
# DevOps Automator - Claude Context

## Quick Reference
- **Purpose**: CLI tool for automating AWS deployments
- **Type**: Go CLI with Cobra
- **Stack**: Go 1.21, AWS SDK v2
- **Started**: 2024-01-05
- **Stage**: Components (Stage 4)

## Project-Specific Focus

### Complexity Areas
- Multi-account AWS deployments
- Rollback state management

### Critical Constraints
- Must work in air-gapped environments
- Cannot store AWS credentials

## Working Agreements

### Code Standards
- All AWS calls must be mockable
- Configs in YAML only (customer requirement)
- Extensive --dry-run support

## Current Sprint Focus
Adding ECS deployment support per reqs/4-components/ecs-deployer.md
```

## Common Patterns to Remove

### 1. Generic Best Practices
❌ "Follow clean code principles"
❌ "Write tests for all code"
❌ "Use meaningful variable names"
✅ "Use domain terms from glossary.md"

### 2. Framework Boilerplate
❌ "Follow React best practices"
❌ "Use hooks appropriately"
✅ "Custom hooks go in hooks/ with tests"

### 3. Obvious Workflows
❌ "Commit code to git"
❌ "Review PRs before merging"
✅ "PRs need security review for auth changes"

### 4. Tool Instructions
❌ "Use npm to install packages"
❌ "Run tests before committing"
✅ "Run integration tests locally (takes 5 min)"

## Maintaining the Minimal Version

### Weekly Check (2 minutes)
1. Is "Current Sprint Focus" still current?
2. Any new "Key Decisions" to add?
3. Anything that can be removed?

### Monthly Review (10 minutes)
1. Are "Complexity Areas" still accurate?
2. Have constraints changed?
3. Are working agreements being followed?
4. Still under 100 lines?

### Quarterly Prune (20 minutes)
1. Remove outdated decisions
2. Consolidate similar rules
3. Archive if growing too large
4. Check with team on usefulness

## Growth Strategy

Only add sections when truly needed:

```bash
# When adding AI components
claude-code "Add AI-specific rules to CLAUDE.md for our LLM integration"

# When team grows beyond 5
claude-code "Add team conventions section to CLAUDE.md"

# When compliance requirements expand
claude-code "Add compliance section to CLAUDE.md for SOC2"
```

## Success Metrics

You'll know migration succeeded when:
1. **CLAUDE.md is under 100 lines**
2. **No placeholders remain**
3. **Every line is project-specific**
4. **Team actually reads it**
5. **It gets updated regularly**
6. **Claude's responses are more focused**

## FAQs

**Q: What if we need some of the verbose content later?**
A: Add it when you need it, not before. Your archived version has everything.

**Q: How do we handle multiple environments?**
A: Add a brief "Environments" section only if they have different rules.

**Q: Should we document our API here?**
A: No. API docs belong in reqs/5-implementation/. CLAUDE.md is for context.

**Q: What about coding standards?**
A: Only document project-specific standards. Assume Claude knows language basics.

## The One Rule

> If you're unsure whether to include something, leave it out. You can always add it later when it proves necessary.