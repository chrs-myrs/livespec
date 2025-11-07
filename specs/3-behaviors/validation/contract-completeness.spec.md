---
governed-by:
  - specs/workspace/constitution.spec.md
  - dist/standard/metaspecs/behavior.spec.md
criticality: IMPORTANT
failure_mode: Without completeness validation, contract parameters are defined without corresponding behavior specs, leading to incomplete implementations
---

# Contract Completeness Validation

## Requirements
- [!] System validates that every parameter in contract specifications has a corresponding behavior specification reference.
  - Scans all files in `specs/3-contracts/` recursively
  - For each contract parameter defined, checks for behavior spec reference
  - Reports parameters without behavior linkage
  - Exit code 0 if complete, 1 if incomplete
  - Clear error messages showing which parameters lack specs
  - Validation runs in CI/CD (part of test suite)
  - Can be run manually via `scripts/check-contract-completeness.sh`

## Contract Structure Patterns
- [!] Validation recognizes standard contract parameter patterns.
  - **Tool/Function Parameters**: Parameters in function signatures or tool schemas
  - **API Endpoints**: Request/response parameters in REST/GraphQL specs
  - **Data Schemas**: Fields in data structure definitions
  - **Configuration**: Config parameters that affect behavior

## Validation Rules
- [!] Each parameter must reference behavior spec that documents its purpose and validation.
  - Parameter documented in contract: `specs/3-contracts/api/endpoint.spec.md`
  - Behavior spec referenced: `specs/3-behaviors/feature.spec.md`
  - Reference can be in frontmatter (`implements:` or `satisfies:`) or inline comment
  - Parameter without reference → validation fails
  - Optional parameters still need behavior specs (optionality is a behavior)

## Example Valid Contract

```markdown
---
# specs/3-contracts/mcp-tools/slack-tools.spec.md
satisfies:
  - specs/3-behaviors/slack-messaging.spec.md
---

# Slack MCP Tools Contract

## slack_post_message

**Parameters**:
- `channel` (required): Slack channel ID
  - Behavior: specs/3-behaviors/slack-messaging.spec.md#channel-resolution
- `text` (required): Message text
  - Behavior: specs/3-behaviors/slack-messaging.spec.md#message-formatting
- `thread_ts` (optional): Thread timestamp for replies
  - Behavior: specs/3-behaviors/slack-threading.spec.md#thread-replies
- `expected_format` (optional): Expected response format (multiple_choice, yes_no, number)
  - Behavior: specs/3-behaviors/response-validation.spec.md#format-validation
```

**Validation passes**: All 4 parameters reference behavior specs.

## Example Incomplete Contract

```markdown
# Slack MCP Tools Contract

## slack_post_message

**Parameters**:
- `channel` (required): Slack channel ID
- `text` (required): Message text
- `thread_ts` (optional): Thread timestamp for replies
- `expected_format` (optional): Expected response format
```

**Validation fails**: No behavior spec references. Reports:
```
ERROR: Contract parameter without behavior spec:
  File: specs/3-contracts/mcp-tools/slack-tools.spec.md
  Tool: slack_post_message
  Parameter: channel - Missing behavior reference
  Parameter: text - Missing behavior reference
  Parameter: thread_ts - Missing behavior reference
  Parameter: expected_format - Missing behavior reference
```

## Error Messages
- [!] Validation provides actionable error messages.
  - File path where issue found
  - Parameter name lacking reference
  - Suggested fix (add behavior reference)
  - Count of issues found
  - Example of valid reference format

## Integration Points
- [!] Validation integrates with existing LiveSpec validation suite.
  - Called by `tests/structure/test_full_validation.sh`
  - Blocks pre-commit if completeness fails (optional via hook)
  - Can be run standalone: `scripts/check-contract-completeness.sh [path]`
  - Supports path filtering (validate specific contract or directory)

## Validation
- Script exists at `scripts/check-contract-completeness.sh`
- Script has execute permission (chmod +x)
- Exit code 0 when all contracts complete
- Exit code 1 when incomplete contracts found
- Error messages show file, parameter, and missing reference
- Script integrated into `tests/structure/test_full_validation.sh`
- Can validate specific file or directory
- Reports summary (X contracts checked, Y parameters, Z missing references)
