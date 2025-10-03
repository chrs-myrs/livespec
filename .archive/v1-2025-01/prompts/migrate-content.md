# Migrate Project Content to Latest LiveSpec Structure

You are tasked with migrating project CONTENT from an older documentation structure to the latest LiveSpec framework v2.0. This assumes the framework prompts have already been deployed via `deploy-framework.sh`. Your focus is on migrating, organizing, and enhancing the project's specification documents.

## Your Mindset

You are:
- **A content curator** - Organizing existing documentation properly
- **A gap identifier** - Finding missing documentation areas  
- **A quality enhancer** - Adding missing sections and metadata
- **A progress tracker** - Updating tracking to latest formats

## Prerequisites

This prompt assumes:
- Framework already deployed to `.claude/commands/livespec/`
- Project has existing documentation to migrate
- You're focusing on content, not framework files

## Migration Process

### Step 1: Analyze Current Documentation

Scan for existing documentation:

```bash
# Find all documentation
find . -name "*.md" -not -path "./.claude/*" -not -path "./.git/*" | head -50

# Check common locations
ls -la reqs/ 2>/dev/null || echo "No reqs directory"
ls -la docs/ 2>/dev/null || echo "No docs directory"  
ls -la specifications/ 2>/dev/null || echo "No specifications directory"

# Look for purpose/strategy/design docs
find . -name "*purpose*" -o -name "*strategy*" -o -name "*design*" -o -name "*component*" | grep -v ".git"
```

### Step 2: Document Classification

Classify found documents into LiveSpec categories:

| Document Type | Target Location | Indicators |
|--------------|-----------------|------------|
| Purpose | `reqs/1-purpose/` | Business value, why, goals |
| Strategy | `reqs/2-strategy/` | Technical decisions, approach |
| Design | `reqs/3-design/` | Architecture, structure, flow |
| Components | `reqs/4-components/` | Component specs, interfaces |
| Implementation | `reqs/5-implementation/` | How-to, APIs, deployment |
| UX/User | `reqs/0-ux/` | Personas, journeys, UI |
| Reviews | `reqs/reviews/` | Feedback, approvals |
| Spikes | `reqs/spikes/` | Research, experiments |

### Step 3: Create Migration Map

Generate `reqs/content-migration-map.md`:

```markdown
# Content Migration Map

## Documents Found
Total documents: [count]
Relevant specifications: [count]

## Migration Mapping

### Purpose Documents
| Current Location | Document | Target Location | Status |
|-----------------|----------|-----------------|--------|
| docs/purpose.md | System Purpose | reqs/1-purpose/purpose.md | Pending |

### Strategy Documents
[Similar table]

### Design Documents
[Similar table]

### Component Specifications
[Similar table]

### Unclassified Documents
| Document | Type Guess | Recommendation |
|----------|------------|----------------|
| README.md | Overview | Keep in place |

## Documents to Create (Gaps)
- [ ] User personas (none found)
- [ ] User journeys (none found)
- [ ] UX strategy (none found)
- [ ] Test strategy (partial)
```

### Step 4: Execute Content Migration

#### 4.1 Create Target Structure
```bash
mkdir -p reqs/{0-ux/personas,0-ux/journeys}
mkdir -p reqs/{1-purpose,2-strategy,3-design,4-components,5-implementation}
mkdir -p reqs/{reviews/feedback,spikes,learnings}
```

#### 4.2 Migrate Documents

For each document to migrate:

1. **Copy to new location**:
   ```bash
   cp [source] [target]
   ```

2. **Enhance with required sections**:
   - Add review status markers
   - Add changelog section
   - Add missing metadata
   - Update formatting

Example enhancement for purpose document:
```markdown
# System Purpose

<!-- Review Status: [PENDING REVIEW] -->
<!-- Last Updated: [date] -->
<!-- Version: 2.0 -->

[Original content]

## Success Metrics
[Add if missing]

## Stakeholders
[Add if missing]

## Review History
- [Date]: Migrated to LiveSpec v2.0 structure

---
*Changelog: See purpose-changelog.md*
```

#### 4.3 Create Placeholder Documents for Gaps

For missing critical documents, create placeholders:

```markdown
# [Document Title]

**Status**: PLACEHOLDER - Needs Development
**Priority**: [High/Medium/Low]
**Created**: [Date] during migration

## Why This Is Needed
[Explain why this document should exist]

## Recommended Actions
1. [Specific step to create this]
2. [Another step]

## Questions to Answer
- [Question 1]
- [Question 2]

## References
- [Any related documents]
```

### Step 5: Update Progress Tracking

Convert or create progress report with enhanced format:

1. If old progress report exists, migrate it
2. If not, create new one from current state
3. Include review tracking sections
4. Add workflow state information

### Step 6: Create Migration Report

Generate `reqs/content-migration-report.md`:

```markdown
# Content Migration Report

**Migration Date**: [date]
**From Structure**: [detected version/structure]
**To Structure**: LiveSpec v2.0

## Migration Summary

### Documents Migrated
- Purpose documents: [count]
- Strategy documents: [count]
- Design documents: [count]
- Component specs: [count]
- Implementation docs: [count]
- Other: [count]

### Documents Created
- Placeholders: [count]
- New sections: [count]

### Enhancements Applied
- [ ] Review markers added
- [ ] Changelogs created
- [ ] Metadata updated
- [ ] Formatting standardized

## Quality Assessment

### Coverage Gaps (Priority Order)
1. **Critical**: [What's missing that blocks progress]
2. **Important**: [What should be added soon]
3. **Nice to Have**: [What would improve quality]

### Content Quality Issues
- Documents needing major updates: [list]
- Documents needing minor updates: [list]
- Well-structured documents: [list]

## Recommended Next Actions

### Immediate (This Week)
1. Fill critical gaps:
   ```
   claude-code "Use .claude/commands/livespec/[prompt]"
   ```

2. Review migrated content:
   ```
   claude-code "Use .claude/commands/livespec/0d-prepare-stakeholder-review.md"
   ```

### Short Term (Next Sprint)
1. [Action with specific prompt]
2. [Another action]

### Long Term (Backlog)
1. [Enhancement idea]
2. [Another enhancement]

## Verification Checklist

- [ ] All found documents migrated or consciously excluded
- [ ] Directory structure follows LiveSpec standard
- [ ] Progress tracking updated
- [ ] Review workflow ready to use
- [ ] No documents lost in migration
- [ ] Backup of original structure retained

## Notes for Team

[Any specific notes about your project's migration]
```

## Special Cases

### No Existing Documentation
If starting from scratch:
1. Skip migration, note as "greenfield"
2. Focus on gap analysis
3. Recommend starting with orchestrator

### Partial Documentation
If only some stages documented:
1. Migrate what exists
2. Create detailed gap analysis
3. Prioritize missing stages

### Non-Standard Structure
If using custom organization:
1. Map carefully to LiveSpec stages
2. Preserve custom value in notes
3. Consider gradual transition

## Output Summary

After running this migration:
1. **Content Migration Map** - Shows what goes where
2. **Migrated Documents** - In correct LiveSpec locations
3. **Enhanced Documents** - With required sections
4. **Gap Placeholders** - For missing documents
5. **Migration Report** - Complete summary
6. **Updated Progress** - Latest tracking format

End with:
```
Content migration complete!

Documents migrated: [count]
Gaps identified: [count] 
Next recommended action:

claude-code "Use .claude/commands/livespec/0-orchestrate-workflow.md"

This will analyze the migrated structure and guide you through filling gaps.
```