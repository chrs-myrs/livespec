# MSL: Markdown Specification Language

LiveSpec uses [MSL (Markdown Specification Language)](https://github.com/chrs-myrs/msl-specification) for all specifications.

## What is MSL?

MSL is a lightweight specification format based on markdown with:
- **Title** (`# Heading`)
- **Requirements section** (`## Requirements`)
- **YAML frontmatter** for metadata
- **Requirement markers** (`[!]`, `[?]`, `[x]`, `[ ]`)
- **Optional sections** (`## Summary`, `## Notes`)

For the complete MSL specification, see: https://github.com/chrs-myrs/msl-specification

## LiveSpec Conventions

LiveSpec extends MSL with two custom frontmatter fields:

### criticality: CRITICAL | IMPORTANT

Indicates requirement priority:
- **CRITICAL**: System fails without this (literally breaks)
- **IMPORTANT**: System works but quality degrades significantly

### failure_mode: [description]

Concrete description of what breaks if requirement not met.

## Example

```markdown
---
criticality: CRITICAL
failure_mode: Users cannot access system without authentication
---

# User Authentication

## Requirements
- [!] System authenticates users via email and password before allowing access to protected resources.
  - Valid credentials allow login
  - Invalid credentials rejected
  - Session persists after authentication
  - Protected resources require authentication
```

## Additional Resources

- [MSL Specification](https://github.com/chrs-myrs/msl-specification) - Full format specification
- [LiveSpec Conventions](livespec-conventions.md) - LiveSpec-specific patterns
- [Quickstart Guide](quickstart.md) - Getting started with LiveSpec
