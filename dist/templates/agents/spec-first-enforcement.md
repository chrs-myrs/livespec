## ⚠️ CRITICAL: Spec-First Protocol (Structural Enforcement)

### Before Creating ANY Permanent File

**Four-layer enforcement for 90%+ compliance:**

#### Layer 1: TodoWrite Gate (MUST USE)

When user requests new permanent file:

1. **Add todo FIRST** (before any file operations):
   ```
   TodoWrite: "Create spec for [filename]" (status: pending)
   ```

2. **Only after spec created** → Mark todo complete

#### Layer 2: Run Validation Check

```bash
scripts/check-requires-spec.sh path/to/file
```

**Exit code 0** = Spec exists or not needed
**Exit code 1** = Spec required but missing → STOP and create spec

#### Layer 3: Mandatory Plan Mode (New Files)

Creating new permanent files requires presenting plan with:
- [ ] TodoWrite item added showing spec creation
- [ ] Spec creation step (specific path: `specs/3-behaviors/[name].spec.md`)
- [ ] Validation check passed

**Plan optional for:** Editing existing files, working in var/generated/.archive/

#### Layer 4: What is "Permanent"?

**Simple test:** "Is this committed to git?"

**YES (requires spec):**
- Code (`src/`, `lib/`, `scripts/`)
- Tests (`tests/`, `__tests__/`)
- Config (`.gitignore`, `tsconfig.json`, `package.json`, lock files)
- Documentation (`README`, guides)
- Agents (`.claude/agents/*/instructions.md`)
- Slash commands (`.claude/commands/`)

**NO (no spec needed):**
- `var/`, `generated/`, `.archive/`
- Build outputs (`dist/`, `build/`)
- Logs, caches

**Exception:** `specs/workspace/*.spec.md` ARE specs (no meta-spec needed)

### Flexible Spec Organization

Multiple related files can share one spec (agent decides based on coherence):
- `specs/3-behaviors/documentation.spec.md` → All README/GUIDE files
- `specs/3-behaviors/project-config.spec.md` → Config files like .gitignore
- `specs/3-behaviors/automation.spec.md` → Related maintenance scripts

**Test:** "Do these files serve the same observable purpose?"
- YES → One spec covers them
- NO → Separate specs

### No Exceptions

❌ "This is obvious" → Still permanent → Needs spec
❌ "Lock files are auto-generated" → Covered by project-config.spec.md
❌ "Just infrastructure" → If permanent, needs spec
❌ "Everyone knows what [X] is" → Your requirements may differ → Needs spec

### Why This Works

**Path of least resistance:**
1. User requests file → Agent adds todo "Create spec" (Layer 1)
2. Agent runs validation check (Layer 2)
3. Agent presents plan showing spec creation (Layer 3)
4. User approves → Agent creates spec → Marks todo complete
5. Pre-commit validates automatically (Layer 4 - safety net)

**Occasional bypass:** TodoWrite skipped → Plan mode catches → Pre-commit catches
**Target:** 90%+ prevented before commit, 10% caught by validation
