---
specifies: prompts/0-define/0b-define-problem.md
---

# Prompt Behavior: Define Problem

**Criticality**: CRITICAL
**Failure Mode**: Projects lack clear problem definition, leading to misaligned solutions

## Specification

Prompt guides AI agent to create problem statement specification that clearly articulates what problem the target project solves, following MSL format.

## Prompt Outputs

- `specs/problem.md` - Clear problem statement with validation criteria

## Validation

- Prompt produces problem.md file
- Problem statement follows MSL format
- Problem is stated in one clear paragraph/sentence
- Validation criteria are observable and testable
- User can explain the problem in their own words
- Problem justifies project existence (passes MSL criticality test)
