---
criticality: IMPORTANT
failure_mode: Without Context7 integration, AI agents using Context7 MCP cannot access LiveSpec documentation effectively
governed-by:
  - .livespec/standard/metaspecs/contract.spec.md
supports:
  - specs/strategy/ai-discoverability.spec.md
---

# Context7 Discovery Interface Contract

## Requirements

### Repository Registration

- [!] LiveSpec registered with Context7 for documentation discovery
  - Repository indexed at context7.com
  - Documentation accessible via MCP query-docs tool
  - Library ID resolvable via resolve-library-id tool

### Documentation Quality

- [!] Indexed content optimized for Context7 consumption
  - Clear markdown structure (headers, lists, code blocks)
  - Comprehensive coverage of methodology concepts
  - Code examples where applicable
  - Searchable terminology

### Benchmark Coverage

- [!] Context7 benchmark questions answered by indexed content
  - Core concepts discoverable (phases, layers, MSL)
  - Workflow guidance accessible
  - Validation patterns documented
  - Benchmark score tracked and improved

## Validation

- [ ] Repository appears in Context7 search results
- [ ] resolve-library-id returns valid library ID for "livespec"
- [ ] query-docs returns relevant content for core concepts
- [ ] Benchmark score meets quality threshold (target: 70%+)
