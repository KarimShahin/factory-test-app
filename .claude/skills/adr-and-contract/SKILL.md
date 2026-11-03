---
name: adr-and-contract
description: Writes an Architecture Decision Record or the OpenAPI 3.1 API contract for a product. Use when a technical decision needs recording, a stack choice needs an ADR, or the API contract must be written before any code.
model: opus
effort: high
---

Source: `05-architecture.md` sections 4, 6.1, 6.2, 7, 8 and 10, and `07-development.md` section 4.1 of the factory docs. Run as the Tech Lead.

## Critical rules

- Prefer boring, proven technology. Every non-default choice needs an ADR.
- Write the API contract before any implementation starts, so FE and BE can work in parallel.
- Map every NFR from `.factory/handoffs/02-product.yaml` to a design element.
- Write only to `docs/adr/`, `docs/architecture/`, `docs/api/`, `CLAUDE.md` and `.factory/handoffs/05-*`.
- Use the Explore agent for codebase searches to keep your context small.

## Inputs

- `.factory/handoffs/02-product.yaml` (NFRs, flows, business rules).
- `.factory/handoffs/03-plan.yaml` (spikes, critical path).
- The stories and the ERD (`docs/architecture/erd.md`) for the contract.

## Write an ADR

1. Write one ADR for every stack choice and every non-default decision. Stack choices cover frontend, backend, database, cache, queue, file storage and search.
2. Use exactly these parts: context, options, decision, consequences.
3. Save it as `docs/adr/NNNN-<slug>.md`, for example `docs/adr/0001-modular-monolith.md`.
4. Architecture style defaults to a modular monolith. Choose microservices only with a written reason (team size, independent scaling, regulatory isolation).
5. Record the Vercel topology decisions in `docs/adr/` because they shape the code. For background jobs, record the limits (duration, memory) in the ADR.
6. Run the spikes from phase 03 and record each result in an ADR.
7. If an NFR cannot be met with the chosen stack, write an ADR with options. If the change affects cost or scope, return a question instead of deciding.
8. If a platform limit is found (for example function duration), move the work to a background job or worker and update the ADR.
9. If the Advisor and you disagree twice, stop. A human decides, with both positions summarized.

## Write the API contract

1. Write OpenAPI 3.1 for REST (or a GraphQL schema) at `docs/api/openapi.yaml`, from the stories and the ERD.
2. Include an error model and pagination.
3. Cover every story that needs data.
4. Make sure the contract lints clean.
5. Treat the contract as the source of truth: the backend must match it exactly, and a contract test fails the build on any mismatch.

## Exit checks

- [ ] An ADR exists for every stack choice and every non-default decision.
- [ ] The OpenAPI contract lints clean and covers every story that needs data.
- [ ] The Advisor verdict is approved.
