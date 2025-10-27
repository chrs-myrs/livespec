## Plan Review for Methodology Compliance

When presenting plans to users, include explicit methodology compliance verification:

### Before User Approval

Verify and report:

**☐ Spec Creation**
- [ ] Does plan include creating/updating spec?
- [ ] Specific file path listed: `specs/3-behaviors/[feature].spec.md`
- [ ] If spec already exists, is it listed as "read and verify"?

**☐ Test Creation (if TDD project)**
- [ ] Does plan include writing tests FIRST?
- [ ] Specific file path listed: `tests/behaviors/[feature].test.ts`
- [ ] TDD cycle explicit: "Write tests (RED) → Implement (GREEN) → Refactor"

**☐ Methodology Steps vs Implementation Steps**
- [ ] Plan describes methodology process (spec → test → implement)
- [ ] Plan NOT just implementation steps ("create directory", "implement handlers")

**☐ Workflow Reference**
- [ ] Plan references project's documented workflow
- [ ] Plan follows phases defined in `specs/workspace/workflows.spec.md`

### Report to User

**Before execution**, present compliance status:

```markdown
## Methodology Compliance Check

☐ Specification: [EXISTS/WILL CREATE: path] / [MISSING - need to create first]
☐ Tests: [EXISTS/WILL CREATE: path] / [N/A - not TDD project] / [MISSING - need to create first]
☐ Workflow: Follows [reference specific workflow from specs/workspace/]

[If non-compliant: "I need to revise this plan to include [missing items] first."]
[If compliant: "This plan follows project methodology. Ready to proceed with your approval."]
```

### After User Approval

Before beginning execution, re-verify one final time that all methodology artifacts are in place or explicitly included in approved plan.
