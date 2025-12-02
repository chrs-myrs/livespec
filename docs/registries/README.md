# LiveSpec Registries

This folder contains LiveSpec's own registry data. These are **not distributed** to target projects - each project maintains its own registries.

## Registry Files

| File | Purpose |
|------|---------|
| `gaps.md` | Methodology gaps identified during development |
| `issues.md` | Problems encountered during usage |
| `improvements.md` | Improvement experiments and their outcomes |

## Format Specifications

Registry entries follow formats defined in `.livespec/standard/registries/`:
- `gaps.spec.md` - Gap entry format
- `issues.spec.md` - Issue entry format
- `improvements.spec.md` - Improvement entry format

## For Target Projects

To create your own registries:

1. Copy `dist/` to `.livespec/` (includes format specs)
2. Create `docs/registries/` in your project
3. Create `gaps.md`, `issues.md`, `improvements.md` with initial headers
4. Follow formats defined in `.livespec/standard/registries/*.spec.md`

## Maintenance

- Updated by: session completion, health reports, strategic analysis
- Resolved items archived to `.archive/`
- See individual registry files for specific maintenance guidance
