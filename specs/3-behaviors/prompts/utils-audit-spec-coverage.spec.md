---
criticality: IMPORTANT
failure_mode: Without coverage audit, permanent files lack specifications and implementation proceeds without clear requirements
specifies: dist/prompts/utils/audit-spec-coverage.md
implements: specs/3-behaviors/slash-command-generation.spec.md
governed-by:
  - .livespec/standard/metaspecs/prompt.spec.md
  - specs/workspace/patterns.spec.md
---

# Prompt Behavior: Audit Spec Coverage

## Requirements
- [!] Prompt audits project to verify all permanent files have corresponding specifications
  - Uses `scripts/check-requires-spec.sh` to identify files requiring specs
  - Categorizes missing specs (individual behavior, related group, false positive)
  - Calculates coverage percentage (files with specs / total permanent files × 100%)
  - Assigns status (🟢 95-100%, 🟡 80-94%, 🔴 <80% coverage)
  - Identifies systematic gaps (entire directories, old files, generated files misclassified)
  - Provides spec templates for missing files (frontmatter, requirements structure)
  - Tracks coverage trends (compared to previous audit)
  - Recommends process improvements (pre-commit validation, CI/CD integration)
  - Distinguishes permanent vs ephemeral files (var/, generated/, .archive/ exempt)
  - Suggests shared specs for related files (configs, utilities)

## Validation
- Prompt correctly identifies all permanent files requiring specs
- Coverage calculation accurate (excludes ephemeral directories)
- Categorization logical (individual vs group vs false positive)
- Status assignments correct (🟢🟡🔴 based on coverage thresholds)
- Templates provided include proper MSL format (frontmatter, requirements, validation)
- False positives correctly identified (ephemeral files misclassified as permanent)
- Recommendations actionable (specific files, suggested spec paths)
- Trend tracking compares against previous audits if available
