---
type: contract
category: interfaces
fidelity: full-detail
criticality: IMPORTANT
failure_mode: Without correct plugin manifest, Claude Code cannot install or configure the LSP plugin
governed-by: []
satisfies:
  - specs/features/lsp/claude-code-plugin.spec.md
supports: []
---

# Claude Code Plugin Manifest

## Requirements

### Plugin Identity

- [!] Plugin manifest declares identity and metadata
  - `name`: `livespec-lsp`
  - `version`: Semantic version matching language server
  - `description`: Brief description of plugin purpose
  - `author`: LiveSpec maintainers
  - `license`: MIT (matching LiveSpec license)

### LSP Configuration

- [!] Plugin manifest configures language server connection
  - `lspServers` object with language server definition
  - `command`: Path or name of language server binary
  - `args`: Command-line arguments (typically `["--stdio"]`)
  - `extensionToLanguage`: Maps `.spec.md` to `livespec` language ID

### File Associations

- [!] Plugin activates for LiveSpec specification files
  - Pattern: `*.spec.md`
  - Language ID: `livespec`
  - Scope: Entire workspace (not just open files)

## Validation

- [ ] Plugin validates successfully with `claude plugin validate`
- [ ] Plugin installs via `claude plugin add livespec-lsp`
- [ ] Language server starts when `.spec.md` file opened
- [ ] Plugin uninstalls cleanly

## Manifest Structure

```json
{
  "name": "livespec-lsp",
  "version": "1.0.0",
  "description": "Language server for LiveSpec MSL specifications",
  "author": "LiveSpec",
  "license": "MIT",
  "lspServers": {
    "livespec": {
      "command": "livespec-lsp",
      "args": ["--stdio"],
      "extensionToLanguage": {
        ".spec.md": "livespec"
      },
      "settings": {
        "livespec.validation.enabled": true,
        "livespec.diagnostics.severity": "hint"
      }
    }
  }
}
```

## Distribution Options

**Option A: npm package**
```bash
npm install -g livespec-lsp
claude plugin add livespec-lsp
```

**Option B: Standalone binary**
```bash
# Download from releases
curl -L https://github.com/livespec/lsp/releases/latest/download/livespec-lsp-linux-x64 -o ~/.local/bin/livespec-lsp
chmod +x ~/.local/bin/livespec-lsp
claude plugin add livespec-lsp
```

**Option C: Bundled with plugin**
- Plugin includes pre-built binaries for common platforms
- Auto-extracts on first activation
- No separate installation required
