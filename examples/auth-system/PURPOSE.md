# Auth System Example

## Why This Exists

This example demonstrates how to specify **cross-cutting concerns** using LiveSpec's three-layer architecture. Authentication and authorization are the most common cross-cutting concerns in software systems - they touch nearly every component but don't fit neatly into feature-based organization.

## What Success Looks Like

1. **Clear organization**: Security specifications organized by abstraction level (requirements → strategy → behaviors → contracts)
2. **Full traceability**: Every behavior links to requirements it satisfies and strategy it follows
3. **Cascade analysis**: When security requirements change, affected behaviors are easily identified
4. **Reusable pattern**: This organization applies to any cross-cutting concern (logging, error handling, caching, etc.)
