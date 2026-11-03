---
name: client-brief
description: Write the client brief, the two-page business plan a client approves before work starts. Use when a client owns the business idea and you need goals, users, scope, constraints, success measures, timeline and budget range from the idea file.
---

Source: `01-discovery-business.md` sections 1, 4, 5, 7, 8, 9 and 10 of the factory docs. This is the "Client brief" depth of phase 01, the default for client work. For your own products, or a paid add-on, the full business case (all of section 4 of that doc) is needed instead.

## Critical rules

- Never invent a number, price, date, market fact or quote. Every market number, price or competitor fact cites a URL and the date read. Anything without a source is labelled "assumption" with a confidence of low, medium or high.
- Personas that are not backed by real interviews are labelled "hypothesis". Never present synthetic personas as research.
- Internal notes and raw research stay out of the client brief.
- You never record the client's approval. The owner presents the brief to the client in person and records the decision. Silence from the client is never approval.
- Feedback that adds scope becomes a change request with effort and cost impact, not a silent edit. The owner decides before the brief is revised.
- Write only inside `docs/business/` and `.factory/handoffs/01-business.yaml`.

## Input

Read `.factory/inputs/idea.md` first. It holds the problem as the human sees it, the target users, the country or market, known constraints (budget, deadline, team) and any existing material. For an existing product, also read the supplied analytics exports, support tickets and revenue figures, and the previous cycle's `11-cycle-<n>.yaml`. In a delta increment, write only what changed.

## Steps

1. Define the problem: who has it, how often it occurs, what it costs them, what they use today.
2. Draft the brief, about two pages, with these sections:
   - Goals
   - Users
   - Scope (the MVP scope summary)
   - Constraints
   - Success measures: one north-star metric and three to five KPIs, each with a target and a measurement method
   - Timeline
   - Budget range
   - Risks, each with a mitigation
3. Check each claim has a source or an assumption label. If not, research it or label it, then re-check.
4. Save to `docs/business/business-plan-client.md`.
5. Hand over for the owner's review. Do not send it to the client.
6. After the owner has presented it, apply only the changes the client requested and the owner confirmed. Increment the revision.

## Handoff

When the owner reports the decision, write `.factory/handoffs/01-business.yaml` with the `client_approval` block:

- `status`: pending, changes_requested, approved or rejected
- `artifact`: `docs/business/business-plan-client.md`
- `revision`, `client` (name), `method`, `recorded_by`, `recorded_at`
- `record`: path of the approval record under `.factory/handoffs/approvals/`

Finish with a handoff_ready envelope that lists file paths only. When a human decision is needed, stop and return a question envelope.

## When something is missing

- No reliable market data for the country: use bottom-up sizing only, mark confidence low, raise a question for the human.
- Human interviews not done: use hypothesis personas and list "validate personas" as the first MVP hypothesis.
- Client requests changes that add scope: record a change request with effort and cost impact.
- Client does not respond: flag the schedule risk. Never treat it as approval.
