---
type: contract
category: interfaces
fidelity: full-detail
criticality: CRITICAL
failure_mode: Without a defined server interface, implementations will be inconsistent and plugin integration will fail
governed-by: []
supports:
  - specs/features/lsp/claude-code-plugin.spec.md
  - specs/features/lsp/diagnostics.spec.md
  - specs/features/lsp/navigation.spec.md
  - specs/features/lsp/completions.spec.md
---

# LiveSpec Language Server Interface

## Requirements

### Server Initialization

- [!] Language server implements LSP 3.17 initialization protocol
  - Accepts `initialize` request with workspace root
  - Returns capabilities declaration
  - Indexes all `.spec.md` files on startup
  - Watches for file changes in workspace

### Supported LSP Methods

- [!] Server implements core LSP methods for spec intelligence
  - `textDocument/publishDiagnostics` - Push diagnostics to client
  - `textDocument/definition` - Go to definition for references
  - `textDocument/references` - Find all references to current spec
  - `textDocument/documentSymbol` - Document outline
  - `workspace/symbol` - Workspace-wide spec search
  - `textDocument/completion` - Context-aware completions
  - `textDocument/didOpen` - Track open documents
  - `textDocument/didChange` - Handle incremental updates
  - `textDocument/didClose` - Clean up document state

### Capabilities Declaration

- [!] Server declares supported capabilities on initialization
  ```json
  {
    "capabilities": {
      "textDocumentSync": 2,
      "completionProvider": {
        "triggerCharacters": [":", "/", "-"]
      },
      "definitionProvider": true,
      "referencesProvider": true,
      "documentSymbolProvider": true,
      "workspaceSymbolProvider": true,
      "diagnosticProvider": {
        "interFileDependencies": true,
        "workspaceDiagnostics": true
      }
    }
  }
  ```

### Transport

- [!] Server communicates via stdio transport
  - Reads JSON-RPC messages from stdin
  - Writes JSON-RPC messages to stdout
  - Logs to stderr (not mixed with protocol)
  - Supports Content-Length header framing

## Validation

- [ ] Server responds to initialize within 1 second
- [ ] Server indexes 100 specs in < 2 seconds
- [ ] Diagnostics published within 500ms of change
- [ ] Server handles malformed requests gracefully
- [ ] Server shuts down cleanly on exit notification

## Implementation Options

| Language | Library | Notes |
|----------|---------|-------|
| TypeScript | `vscode-languageserver` | Best docs, Claude Code native |
| Rust | `tower-lsp` | Fast, single binary distribution |
| Go | `go-lsp` | Good for CLI integration |

## Claude Code Plugin Configuration

```json
{
  "livespec": {
    "command": "livespec-lsp",
    "args": ["--stdio"],
    "extensionToLanguage": {
      ".spec.md": "livespec"
    }
  }
}
```
