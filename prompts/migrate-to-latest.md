# Migrate Project to Latest Structure

You are tasked with migrating an existing project from an older version of the bidirectional specifications structure to the latest version. This involves analyzing the current structure, creating a migration plan, executing the migration, and identifying any gaps that need to be filled.

## Your Mindset

You are:
- **A migration specialist** - Understanding both old and new structures
- **A gap analyzer** - Identifying what's missing in the current documentation
- **A preservationist** - Maintaining valuable existing content
- **A modernizer** - Upgrading to latest best practices

## Migration Process Overview

1. **Analyze** current structure and version
2. **Plan** migration steps and gap filling
3. **Execute** migration with careful preservation
4. **Identify** remaining gaps and next actions
5. **Update** progress tracking to latest format

## Step 1: Structure Analysis

### Detect Current Version

Look for version indicators:

```bash
# Check for old prompt naming
ls prompts/ | grep -E "^[0-9]-"  # Old: 1-write-purpose.md
ls prompts/ | grep -E "^[0-9][a-z]-"  # New: 1a-write-purpose.md

# Check for structure elements
[ -d "reqs/0-ux" ] && echo "Has UX directory"
[ -d "reqs/hlr" ] && echo "Has HLR support"
[ -f "reqs/progress-report.md" ] && echo "Has progress tracking"
[ -d "reqs/reviews" ] && echo "Has review structure"

# Check CLAUDE.md for features
grep -q "Workflow Orchestration" CLAUDE.md && echo "Has orchestration"
grep -q "number-letter system" CLAUDE.md && echo "Has new numbering"
```

### Version Detection Rules

**Version 1.0 (Original)**:
- Prompts named: `1-write-*.md`, `2-write-*.md`
- No UX-specific directories
- No review workflow
- Basic progress tracking

**Version 1.5 (HLR Support)**:
- Has `reqs/hlr/` directory
- Progress report exists
- Some validation prompts

**Version 2.0 (Current)**:
- Number-letter naming: `0a-*.md`, `1b-*.md`
- UX integration: `reqs/0-ux/`
- Review workflow: `reqs/reviews/`
- Orchestration support
- Enhanced progress tracking

## Step 2: Create Migration Plan

Based on the analysis, create `reqs/migration-plan.md`:

```markdown
# Migration Plan to Latest Structure v2.0

**Current Version Detected**: [version]
**Migration Date**: [date]
**Estimated Effort**: [hours/days]

## Pre-Migration Checklist

- [ ] Backup current structure
- [ ] Identify custom modifications
- [ ] Note any project-specific patterns
- [ ] Check for uncommitted changes

## Migration Steps

### 1. Structural Updates

#### Directory Structure
- [ ] Create missing directories:
  - [ ] `reqs/0-ux/` (if missing)
  - [ ] `reqs/0-ux/personas/`
  - [ ] `reqs/0-ux/journeys/`
  - [ ] `reqs/reviews/`
  - [ ] `reqs/reviews/feedback/`
  - [ ] `prompts/templates/reviews/`

#### File Migrations
- [ ] Rename prompts to number-letter system:
  - [ ] `1-write-purpose.md` → `1a-write-purpose.md`
  - [ ] `2-write-strategy.md` → `2a-write-strategy.md`
  - [ ] [List all renamings needed]

### 2. Content Updates

#### New Documents to Create
- [ ] UX Discovery (if user-facing system):
  - [ ] User personas
  - [ ] User journeys
  - [ ] Information architecture
- [ ] User success metrics (from purpose)
- [ ] UX strategy (from technical strategy)
- [ ] Interaction designs
- [ ] Behavior specifications
- [ ] UI specifications

#### Existing Documents to Enhance
- [ ] Add review status markers
- [ ] Add changelog sections
- [ ] Update progress tracking format
- [ ] Add missing sections per latest templates

### 3. Process Updates

#### CLAUDE.md Updates
- [ ] Add workflow orchestration section
- [ ] Add prompt numbering convention
- [ ] Update to latest format (<100 lines)

#### Progress Report Migration
- [ ] Convert to enhanced format with review tracking
- [ ] Add review dashboard
- [ ] Add stakeholder engagement metrics
- [ ] Update activity log format

### 4. Gap Analysis

#### Documentation Gaps
[Will be filled during migration]

#### Process Gaps
[Will be identified during migration]

## Risk Mitigation

- **Data Loss**: Full backup before migration
- **Breaking Changes**: Preserve custom content
- **Integration Issues**: Test after each major step
- **Team Disruption**: Communicate changes clearly

## Success Criteria

- [ ] All files migrated to new structure
- [ ] No content lost during migration
- [ ] New features accessible
- [ ] Team can use orchestrator
- [ ] Review workflow functional
```

## Step 3: Execute Migration

### 3.1 Backup Current State

```bash
# Create backup
cp -r reqs/ reqs-backup-$(date +%Y%m%d)/
cp -r prompts/ prompts-backup-$(date +%Y%m%d)/
cp CLAUDE.md CLAUDE.md.backup
```

### 3.2 Create New Directory Structure

```bash
# Create missing directories
mkdir -p reqs/0-ux/personas
mkdir -p reqs/0-ux/journeys  
mkdir -p reqs/reviews/feedback
mkdir -p prompts/templates/reviews
```

### 3.3 Migrate Prompts

For each old prompt, create new version:

```bash
# Example migrations
mv prompts/1-write-purpose.md prompts/1a-write-purpose.md
mv prompts/2-write-strategy.md prompts/2a-write-strategy.md
# ... continue for all prompts
```

### 3.4 Migrate Document Content

For each existing document, check against latest templates and add missing sections:

#### Purpose Document Enhancement
If `reqs/1-purpose/purpose.md` exists, ensure it has:
- Clear success metrics section
- Stakeholder identification
- Review status markers
- Changelog reference

#### Strategy Document Enhancement
For each strategy document, ensure:
- Decision rationale documented
- Alternatives considered section
- Risk assessment included
- Review markers added

### 3.5 Create Missing UX Documents

If this is a user-facing system and UX documents don't exist:

```markdown
# Create placeholder personas
reqs/0-ux/personas/primary-persona.md:
"# Primary User Persona

[PLACEHOLDER - Needs Discovery]

This persona needs to be developed through user research.

## Recommended Discovery Actions
1. Interview 5-10 current/potential users
2. Analyze support tickets for user pain points
3. Review any existing user feedback
4. Conduct user observation sessions
"
```

### 3.6 Update Progress Tracking

Convert existing progress report to enhanced format:
- Add review tracking sections
- Add stakeholder metrics
- Update status indicators
- Add workflow state section

## Step 4: Gap Analysis Report

Create `reqs/migration-gaps.md`:

```markdown
# Migration Gap Analysis

**Migration Date**: [date]
**Gaps Identified**: [count]
**Priority Actions**: [count]

## Documentation Gaps

### High Priority (Blocking)
1. **Missing UX Discovery**
   - Impact: Cannot validate user needs
   - Action: Run `0c-discover-ux-requirements.md`
   - Effort: 2-3 days

2. **No User Success Metrics**
   - Impact: Purpose lacks measurable outcomes
   - Action: Run `1b-define-user-success.md`
   - Effort: 1 day

### Medium Priority (Important)
1. **Incomplete Test Strategy**
   - Impact: TDD approach unclear
   - Action: Update component specs with test plans
   - Effort: 1 day per component

### Low Priority (Nice to Have)
1. **Missing Spike Reports**
   - Impact: Decision rationale undocumented
   - Action: Recreate from team knowledge
   - Effort: Optional

## Process Gaps

### Review Workflow
- [ ] No stakeholder list defined
- [ ] Review timeline not established
- [ ] Approval criteria unclear

**Action**: Define review process with team

### Progress Tracking  
- [ ] Historical progress lost
- [ ] Metrics baseline needed
- [ ] Activity log incomplete

**Action**: Establish new baseline

## Content Quality Issues

### Documents Needing Major Updates
1. [Document]: [What's missing/wrong]
2. [Document]: [What's missing/wrong]

### Documents Needing Minor Updates
1. [Document]: [Small fixes needed]
2. [Document]: [Small fixes needed]

## Recommended Immediate Actions

1. **Run UX Discovery** (if user-facing):
   ```
   claude-code "Use prompts/0c-discover-ux-requirements.md"
   ```

2. **Update Purpose with Success Metrics**:
   ```
   claude-code "Use prompts/1b-define-user-success.md"
   ```

3. **Run Orchestrator for Guidance**:
   ```
   claude-code "Use prompts/0-orchestrate-workflow.md"
   ```

## Migration Verification Checklist

- [ ] All prompts follow number-letter naming
- [ ] Review workflow is accessible
- [ ] Progress tracking works
- [ ] Orchestrator provides correct guidance
- [ ] No broken references
- [ ] Team understands new features
```

## Step 5: Update CLAUDE.md

Ensure CLAUDE.md is updated to latest format:
- Under 100 lines
- Includes workflow orchestration
- Documents numbering convention
- Mentions review gates

## Step 6: Final Migration Report

Create `reqs/migration-complete.md`:

```markdown
# Migration Complete Report

**Status**: ✅ Complete with Gaps Identified
**Date Completed**: [date]
**Next Review**: [date + 1 week]

## What Was Migrated

### Structure ✅
- [X] Directory structure updated
- [X] Prompts renamed to number-letter system
- [X] Review directories created
- [X] Templates organized

### Content 🔄
- [X] Existing documents preserved
- [X] Missing sections identified
- [ ] All gaps filled (in progress)
- [X] Review markers added

### Process ✅
- [X] CLAUDE.md updated
- [X] Progress tracking enhanced
- [X] Orchestrator ready to use
- [X] Review workflow available

## How to Proceed

1. **Address High Priority Gaps**:
   See `reqs/migration-gaps.md` for prioritized list

2. **Start Using Orchestrator**:
   ```
   claude-code "Use prompts/0-orchestrate-workflow.md"
   ```

3. **Brief Your Team**:
   - New numbering system
   - Review gates at each stage
   - Orchestrator for guidance
   - Enhanced progress tracking

## Rollback Plan

If issues arise:
1. Backups available in `*-backup-[date]/`
2. Can selectively restore files
3. Contact: [migration support]

## Lessons Learned

[Document any project-specific findings that could help others]
```

## Special Handling

### For Very Old Projects (pre-v1.0)

If project predates the framework:
1. Run `extract-specs-from-code.md` first
2. Create initial structure
3. Then run migration

### For Partially Adopted Projects

If only some parts were used:
1. Identify which stages were completed
2. Focus migration on active areas
3. Mark unused stages appropriately

### For Modified Frameworks

If project customized the framework:
1. Preserve customizations in separate directory
2. Document divergences
3. Merge custom features carefully

## Output Summary

After running this migration prompt, you will have:

1. **Migration Plan** - Detailed steps to follow
2. **Backup** - Complete backup of current state  
3. **Updated Structure** - Latest directory organization
4. **Migrated Files** - All files renamed/moved appropriately
5. **Gap Analysis** - Clear list of what's missing
6. **Next Actions** - Specific commands to run
7. **Migration Report** - Summary of what was done

End with:
```
Migration complete! 

Gaps identified: [count]
Next recommended action:
claude-code "Use prompts/0-orchestrate-workflow.md"

See reqs/migration-gaps.md for specific gap-filling actions.
```