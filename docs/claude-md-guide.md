# CLAUDE.md Complete Guide

This guide consolidates all information about creating and maintaining effective CLAUDE.md files for optimal AI engineering performance.

## Table of Contents

1. [The Problem with Verbose Context](#the-problem-with-verbose-context)
2. [The Minimal Approach](#the-minimal-approach)
3. [Creating Your CLAUDE.md](#creating-your-claudemd)
4. [Migration from Verbose](#migration-from-verbose)
5. [Maintenance Strategy](#maintenance-strategy)
6. [Examples](#examples)
7. [FAQ](#faq)

## The Problem with Verbose Context

Traditional CLAUDE.md files often exceed 450 lines with 47+ placeholders, creating significant problems:

### Cognitive Overload
- **Token Usage**: 3000 tokens for parsing vs 200 for minimal (93% reduction)
- **Relevance**: Only ~20% of verbose content is project-specific
- **Performance**: Model wastes capacity filtering irrelevant boilerplate
- **Effectiveness**: Important constraints get buried in noise

### Maintenance Burden
- Teams ignore verbose documents
- Updates take 30+ minutes vs 5 minutes for minimal
- Placeholders remain unfilled
- Generic content becomes outdated

### Engineering Impact
```
Engineer: "Implement user authentication"
Claude: *Parses 450 lines of context*
Claude: *Filters through 47 placeholders*
Claude: *May miss the one line about "OAuth only, no passwords"*
```

## The Minimal Approach

### Core Principles

1. **Every line must earn its place** - No generic content
2. **Project-specific only** - What makes THIS project unique
3. **Living document** - Grows organically with need
4. **Under 50 lines** - Maximum initial size
5. **No placeholders** - Only actual decisions and constraints

### Benefits

- **Better Engineering**: More focused, effective responses
- **Easier Maintenance**: Teams actually keep it updated
- **Faster Onboarding**: New developers understand quickly
- **Reduced Errors**: Clear, specific rules prevent mistakes
- **Scalable**: Grows only as needed

## Creating Your CLAUDE.md

### The Minimal Template

```markdown
# [Project Name] - Claude Context

## Quick Reference
- **Purpose**: [One sentence description]
- **Type**: [web app/API/CLI tool/library]
- **Stack**: [Primary language/framework]
- **Started**: [Date]
- **Stage**: [Current stage from progress report]

## Project-Specific Focus

### Complexity Areas
- [Highest complexity/risk area]
- [Second area if significant]

### Critical Constraints
- [Any compliance/security requirements]
- [Performance requirements if critical]
- [Deployment constraints if unusual]

## Working Agreements

### Code Standards
- [Only project-specific patterns]
- [Not generic best practices]

### Documentation Flow
- Specs live in `reqs/` folder
- HLR inputs go in `reqs/hlr/`
- Progress tracked in `reqs/progress-report.md`
- [Any project-specific documentation rules]

## Current Sprint Focus
[What's being worked on now - updated each sprint]

## Key Technical Decisions
[Only list as they're made, with brief rationale]
```

### What to Include

✅ **DO Include**:
- Actual technology choices (not placeholders)
- Real constraints affecting development
- Specific patterns your team follows
- Current work focus
- Key decisions with rationale

❌ **DON'T Include**:
- Generic best practices
- Framework boilerplate
- Obvious workflows
- Tool instructions
- Future possibilities

## Migration from Verbose

### Quick Decision Guide

Migrate if your CLAUDE.md:
- Is over 200 lines → **Yes**
- Full of {PLACEHOLDERS} → **Yes**
- Mostly generic content → **Yes**
- Hard to maintain → **Yes**
- Team ignores it → **Definitely Yes**

### Migration Process

#### Step 1: Extract Essential Information (10 minutes)

From your current CLAUDE.md, extract only:
1. Project name and core purpose
2. Actual technology choices (not placeholders)
3. Real constraints that affected development
4. Specific rules your team actually follows
5. Current focus or sprint goals

#### Step 2: Create Minimal Version

Use the template above and fill with extracted information.

#### Step 3: Archive Verbose Version

```bash
# Don't delete - archive for reference
mv CLAUDE.md CLAUDE.md.verbose-archive
```

#### Step 4: Validate with Team

Ask: "Is anything critical missing?" If yes, add it. If no, you're done.

### Common Patterns to Remove

#### Generic Best Practices
❌ "Follow clean code principles"
❌ "Write tests for all code"
✅ "Use domain terms from glossary.md"

#### Framework Boilerplate
❌ "Follow React best practices"
❌ "Use hooks appropriately"
✅ "Custom hooks go in hooks/ with tests"

#### Obvious Workflows
❌ "Commit code to git"
❌ "Review PRs before merging"
✅ "PRs need security review for auth changes"

## Maintenance Strategy

### Weekly Check (2 minutes)
1. Is "Current Sprint Focus" still current?
2. Any new "Key Decisions" to add?
3. Anything that can be removed?

### Monthly Review (10 minutes)
1. Are "Complexity Areas" still accurate?
2. Have constraints changed?
3. Are working agreements being followed?
4. Still under 100 lines?

### Growth Strategy

Only add sections when truly needed:

```bash
# When adding AI components
claude-code "Add AI-specific rules to CLAUDE.md for our LLM integration"

# When team grows beyond 5
claude-code "Add team conventions section to CLAUDE.md"

# When compliance requirements expand
claude-code "Add compliance section to CLAUDE.md for SOC2"
```

### The One Rule

> If you're unsure whether to include something, leave it out. You can always add it later when it proves necessary.

## Examples

### Example 1: Simple API

```markdown
# Weather API - Claude Context

## Quick Reference
- **Purpose**: RESTful API for weather data aggregation
- **Type**: FastAPI microservice
- **Stack**: Python 3.11, PostgreSQL
- **Started**: 2024-01-20
- **Stage**: Design (Stage 3)

## Project-Specific Focus

### Complexity Areas
- Multiple weather provider integrations
- Rate limiting across providers

### Critical Constraints
- Must handle provider outages gracefully
- 99.9% uptime requirement

## Working Agreements

### Code Standards
- All provider integrations use adapter pattern
- Pydantic for all API models
- UTC timestamps only

### Documentation Flow
- Standard reqs/ structure
- Provider specs in reqs/4-components/providers/

## Current Sprint Focus
Implementing OpenWeatherMap adapter
```

### Example 2: E-Commerce Platform

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

### Example 3: CLI Tool

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

## FAQ

**Q: Won't we lose important information?**
A: No. Generic information adds noise, not value. Project-specific info is preserved.

**Q: What about complex projects?**
A: They need clarity even more. Complexity requires focus, not verbosity.

**Q: How do we ensure completeness?**
A: Grow organically. Add sections when needed, not preemptively.

**Q: What if we need some of the verbose content later?**
A: Add it when you need it, not before. Your archived version has everything.

**Q: Should we document our API here?**
A: No. API docs belong in reqs/5-implementation/. CLAUDE.md is for context.

**Q: What about coding standards?**
A: Only document project-specific standards. Assume Claude knows language basics.

## Key Insight

> **For Claude Opus 4.0+, less context with higher relevance produces superior engineering outcomes compared to comprehensive context with low relevance.**

This is especially true for:
- Complex problem solving
- Code generation
- Architecture decisions
- Debugging assistance

## Success Metrics

You'll know your CLAUDE.md is effective when:
1. **Under 100 lines** and every line matters
2. **No placeholders** remain
3. **Team reads it** when onboarding
4. **Gets updated** with actual changes
5. **Claude's responses** are more focused and accurate

---

*"The ability to simplify means to eliminate the unnecessary so that the necessary may speak."* - Hans Hofmann