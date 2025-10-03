# LiveSpec Templates

These templates provide starting points for workspace specifications in your project.

## Usage

### Workspace Templates

Copy the workspace templates to your project's specs/workspace/ folder:

```bash
cp prompts/templates/workspace/*.template specs/workspace/
```

Then customize each template:

1. **Replace placeholders**: Change `[PROJECT_NAME]` to your actual project name
2. **Fill in specifics**: Replace example content with your project's actual principles, patterns, and workflows
3. **Remove `.template` extension**: Rename files to `.spec.md`

Example:
```bash
mv specs/workspace/constitution.spec.md.template specs/workspace/constitution.spec.md
```

### What Each Template Provides

- **constitution.spec.md.template** - Governance principles for your project
- **patterns.spec.md.template** - Coding and specification patterns
- **workflows.spec.md.template** - Development workflows and processes

## MSL Format

All templates follow MSL (Minimal Specification Language) format:
- **Criticality**: CRITICAL or IMPORTANT
- **Failure Mode**: What breaks without this
- **Specification**: What is required
- **Validation**: How to verify compliance

Keep specifications minimal - only include what's truly necessary.
