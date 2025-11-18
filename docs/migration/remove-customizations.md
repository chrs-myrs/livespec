# Migrating from customizations.yaml Pattern

**Last updated:** 2025-01-18
**Affects:** Users who previously customized framework prompts using `customizations.yaml`

## Summary

LiveSpec v4.0+ removes framework customization tracking (`customizations.yaml`) in favor of **immutable framework** approach. Framework prompts are now read-only references - projects customize via `specs/workspace/` instead.

## Why This Changed

**Old approach (customizations.yaml):**
- Tracked which framework files users modified
- Complex merge logic on upgrade
- Merge conflicts, drift risk
- Confusion about source of truth

**New approach (immutable framework):**
- Framework is read-only git submodule
- No modification, no tracking needed
- Upgrade via `git submodule update` (trivial)
- Project customization via `specs/workspace/` (separate)

**Philosophy:** LiveSpec is a framework for **creating** custom agentic projects, not for modifying the framework itself.

## Migration Steps

### Step 1: Audit Your Customizations

If you have `.livespec/customizations.yaml`:

```bash
# Review what you modified
cat .livespec/customizations.yaml

# Understand WHY you modified each file
# Ask: "Was this really a framework change, or a project-specific workflow?"
```

### Step 2: Determine If Actually Needed

**90% of "framework customizations" are actually project-specific workflows:**

| What You Customized | Where It Belongs |
|---------------------|------------------|
| Custom phases/steps | specs/workspace/workflows.spec.md |
| Custom patterns | specs/workspace/patterns.spec.md |
| Custom principles | specs/workspace/constitution.spec.md |
| Project-specific prompts | prompts/generated/custom/ |
| Domain-specific templates | Your own templates/ directory |

### Step 3: Move to specs/workspace/

**For custom process changes:**

```bash
# Add to specs/workspace/workflows.spec.md
# Example:
## Requirements
- [!] Project follows custom Phase 2 workflow with security review gate
  - Security review must pass before merge
  - ... etc
```

**For custom patterns:**

```bash
# Add to specs/workspace/patterns.spec.md
# Example:
## Requirements
- [!] All specs include security impact assessment
  - ... etc
```

**For custom principles:**

```bash
# Add to specs/workspace/constitution.spec.md
# Example:
- **Security First** (Principle #1 - essential):
  - All changes reviewed for security impact
  - ... etc
```

### Step 4: True Framework Changes?

**Very rare case - you actually need to change the methodology itself:**

```bash
# Fork LiveSpec
gh repo fork chrs-myrs/livespec yourname/livespec

# In your project, point submodule to your fork
rm -rf .livespec .livespec-repo
git submodule add https://github.com/yourname/livespec .livespec-repo
ln -s .livespec-repo/dist .livespec
```

**When to fork:**
- You fundamentally disagree with MSL format
- You need different phase structure
- You're creating a domain-specific variant

**When NOT to fork (use specs/workspace/ instead):**
- Custom coding conventions → patterns.spec.md
- Additional workflow steps → workflows.spec.md
- Project-specific principles → constitution.spec.md

### Step 5: Clean Up

```bash
# Delete customizations.yaml
rm .livespec/customizations.yaml

# Migrate to sparse submodule
rm -rf .livespec/
bash scripts/install-livespec.sh

# Verify installation
ls -l .livespec  # Should show symlink
git -C .livespec-repo describe --tags  # Shows version
```

### Step 6: Update Upgrade Workflow

**Old upgrade workflow:**
```bash
# Complex multi-phase merge
claude-code "Use .livespec/prompts/utils/upgrade-methodology.md"
# (30+ minutes, merge conflicts, complex)
```

**New upgrade workflow:**
```bash
# Simple submodule update
git submodule update --remote .livespec-repo
git add .livespec-repo
git commit -m "Update LiveSpec framework to v4.0.0"
# (2 minutes, no conflicts, simple)
```

## FAQ

**Q: I customized prompts to add my company branding - where does that go?**

A: Create `prompts/generated/custom/` with your branded versions. Reference your company values in `specs/workspace/constitution.spec.md`.

**Q: I added extra validation steps to Phase 3 - is that a framework change?**

A: No. Add to `specs/workspace/workflows.spec.md`:
```markdown
## Requirements
- [!] Phase 3 (VERIFY) includes additional compliance validation
  - SOC2 compliance check
  - GDPR privacy review
  - ... etc
```

**Q: I need different phase names (we call it BUILD/TEST/SHIP) - do I fork?**

A: Probably not. The phase names in `.livespec/` are just references. Document your terminology mapping in `specs/workspace/patterns.spec.md`:
```markdown
## Phase Terminology

**Our naming:**
- BUILD = LiveSpec Phase 2
- TEST = LiveSpec Phase 3
- SHIP = (custom - not in LiveSpec)
```

**Q: What if I genuinely disagree with MSL Minimalism principle?**

A: That's a framework change. Fork is appropriate. But consider whether you're solving the right problem - MSL Minimalism prevents bloat, violating it may indicate design issue.

## Benefits After Migration

✅ **Trivial upgrades** - `git submodule update` instead of merge workflow
✅ **No tracking overhead** - Framework is what it is
✅ **Clear source of truth** - Git submodule points to canonical
✅ **Separation of concerns** - Framework vs project customization
✅ **Simplicity** - No customizations.yaml infrastructure

## Getting Help

- **Documentation:** See `specs/workspace/distribution.spec.md` for immutable framework pattern
- **Examples:** LiveSpec dogfoods this approach (we don't customize our own framework)
- **Questions:** GitHub Discussions or Issues

---

*This migration guide reflects LiveSpec v4.0+ immutable framework approach*
