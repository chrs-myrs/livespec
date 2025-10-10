# AI-Driven Commits Guide (Optional)

Guidelines for AI agents to create intelligent, atomic commits autonomously during development.

## Philosophy

AI agents should commit complete logical units as they progress, not everything at the end. Each commit represents one coherent purpose, creating clean git history that tells the story of development.

**Core beliefs:**
- Commit by intent (one coherent purpose)
- Atomic changes (independently revertible)
- Development narrative (git history tells evolution story)
- Safety through frequency (more commits reduce risk)

## The 5 Commit Readiness Questions

AI must ask before committing:

### 1. Logical Completeness
**"Have I finished a complete, testable unit of work?"**
- YES → Consider committing
- NO → Continue development

### 2. Atomic Change
**"Is this the smallest meaningful change that adds value?"**
- YES → Good commit candidate
- NO → Break down further or continue

### 3. Independence
**"Could someone understand this change without the next one?"**
- YES → Commit is self-contained
- NO → Expand scope or wait

### 4. Reversibility
**"Could this commit be safely reverted without breaking other work?"**
- YES → Safe to commit
- NO → Include dependencies or wait

### 5. Validation
**"Does this change pass all current tests and quality checks?"**
- YES → Ready to commit
- NO → Fix issues first

## Commit Types (Conventional Commits)

### Standard Types
- **feat**: New functionality implemented
- **fix**: Bug correction or issue resolution
- **refactor**: Code restructuring without behavior change
- **test**: Test addition, modification, or improvement
- **docs**: Documentation updates or additions

### AI Development Types
- **impl**: Core implementation of specified feature
- **scaffold**: Initial structure and boilerplate creation
- **validate**: Input validation and error handling added
- **integrate**: Integration between components or systems
- **checkpoint**: Safe point before experimental changes

## Commit Message Format

```
<type>[optional scope]: <description>

[optional body explaining why]
```

### Good Examples
```bash
feat(auth): implement password strength validation
impl(parser): add CSV parsing with error handling
validate(api): add input sanitization for user endpoints
integrate(db): connect user service to authentication
checkpoint: working auth before session management
refactor(utils): extract common validation functions
```

### Poor Examples (Avoid)
```bash
update code          # Too vague
fix bug              # Not specific
implement everything # Too broad
partial implementation  # Incomplete
```

## Safety Commits

Create checkpoint commits **before**:
- Complex refactoring (major restructuring)
- Experimental approach (uncertain implementation)
- Breaking changes (affecting existing interfaces)
- Large deletions (removing significant code)

**Example:**
```bash
git commit -m "checkpoint: working auth before refactoring session management"
# Now safe to experiment - can revert to this point
```

## Integration with Spec-First

Commits reference MSL requirements when applicable:

```bash
impl(auth): implement REQ-003 password validation
test(auth): add tests for REQ-003 password rules
```

This maintains traceability from commits → specs → requirements.

## Development Flow Example

```bash
# 1. Create structure
git commit -m "scaffold(auth): create authentication module structure"

# 2. Implement core
git commit -m "impl(auth): add password validation and login logic"

# 3. Add validation
git commit -m "validate(auth): add input validation and error handling"

# 4. Create tests
git commit -m "test(auth): add comprehensive authentication tests"

# 5. Integrate
git commit -m "integrate(auth): connect authentication to user service"

# 6. Document
git commit -m "docs(auth): document authentication API endpoints"
```

## When NOT to Commit

**Don't commit:**
- Incomplete implementations (failing tests)
- Code with obvious TODOs or FIXMEs
- Temporary or debug code
- Large, multi-purpose changes
- Changes without meaningful messages

## Success Indicators

- Each commit represents complete, logical change
- Commit history tells clear development story
- Easy to identify when specific features implemented
- Simple to revert problematic changes without side effects
- Average 3-7 commits per feature (appropriate granularity)

---

*Adapted from SpellForge AI-Driven Commits policy for LiveSpec distribution. This is an OPTIONAL practice - use judgment based on project needs.*
