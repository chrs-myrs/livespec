## ⚠️ WARNING: No "Plumbing" Exception

**ALL behavior changes require specifications.** There is no exception for "simple" or "infrastructure" work.

### Red Flags (Mental Categorization Errors)

These phrases indicate you may be skipping necessary specification:
- ❌ "Just wiring up [X]"
- ❌ "Just infrastructure"
- ❌ "Obviously simple"
- ❌ "This is just plumbing"
- ❌ "Everyone knows what [X] is"

### The Test

Ask yourself: **"If this breaks, does something stop working?"**

- **YES** → It's a feature → Needs specification → Needs tests (if TDD)
- **NO** → It's truly implementation detail → May not need spec

### Real Example

LiveSpec's own MCP resource serving was categorized as "just wiring up resources" and implemented without specs. This violated the project's TDD methodology despite having full documentation. The agent had to create a detailed violation report.

**Lesson**: Familiarity creates false confidence. When in doubt, create a spec.
