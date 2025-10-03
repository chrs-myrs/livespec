# Inventory Management System - Claude Context

## Quick Reference
- **Purpose**: Multi-warehouse inventory tracking to reduce stockouts and excess inventory
- **Type**: Web application with REST API
- **Stack**: Node.js, PostgreSQL, Redis, React
- **Started**: 2024-01-01
- **Stage**: Implementation (Stage 5)

## Project-Specific Focus

### Complexity Areas
- Real-time sync across 3 warehouses with spotty WiFi
- SOX compliance audit trail requirements
- Integration with existing order system we can't modify

### Critical Constraints
- $200K budget cap
- Must use existing PostgreSQL
- Cannot modify order system
- 99.9% uptime requirement during business hours

## Working Agreements

### Code Standards
- All inventory changes through EventStore pattern
- Immutable audit log for every transaction
- Offline-first approach for warehouse operations
- Feature flags for all new functionality

### Documentation Flow
- Specs live in `reqs/` folder
- HLR requirements in `reqs/hlr/`
- Progress tracked in `reqs/progress-report.md`
- Open questions actively tracked per stage

## Current Sprint Focus
Implementing offline-capable Inventory Service with event sourcing for SOX compliance

## Key Technical Decisions
- **PostgreSQL + Redis**: Postgres for persistence, Redis for real-time cache
- **Event Sourcing**: For immutable audit trail (SOX requirement)
- **REST over GraphQL**: Simpler for warehouse staff tools
- **Microservices**: Inventory, Warehouse, and Reporting services
- **Kubernetes**: For scaling and high availability