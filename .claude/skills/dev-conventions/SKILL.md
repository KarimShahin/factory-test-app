---
name: dev-conventions
description: House conventions for the dev agent when implementing one Jira ticket, frontend or backend. Preloaded into the dev agent; covers the ticket loop, backend and frontend rules, branch, commit and PR naming, and failure reactions.
user-invocable: false
---

Source: `07-development.md` sections 4, 5.1, 6.1 and 10 of the factory docs.

## Ticket loop

1. Read the ticket and the files it references.
2. Write failing tests from the acceptance criteria.
3. Implement.
4. Run tests, lint and types; return to step 3 on failure.
5. Refactor.
6. Self-review your own diff; return to step 3 on issues.
7. Open the PR only when the self-review is clean.

## Backend tickets

1. Models and migrations are backward-compatible: expand first, contract in a later release.
2. Endpoints match `docs/api/openapi.yaml` exactly. The contract test fails the build on any mismatch.
3. Add validation, permissions and business rules.
4. Add background jobs where the ticket needs them.
5. Run integrations in sandbox mode only.
6. Write unit and integration tests.
7. If the contract is wrong, stop and return a question; the Tech Lead updates it through a PR.

## Frontend tickets

1. Build with design-system components; add a new component only when the design handoff lists it.
2. Wire pages and routing.
3. Fetch data through the generated API client; until the backend endpoint is merged, use mock handlers generated from the OpenAPI file.
4. Make client validation mirror server validation.
5. Build loading, empty, error and success states exactly as designed.
6. Add i18n strings and RTL layout.
7. Add the analytics events from the analytics plan.
8. Meet accessibility (labels, focus order, keyboard use) and the performance budget.
9. Write unit and component tests.

## Contract-first work

- Frontend and backend work on the same story at the same time and test against the same OpenAPI file.
- The agent whose code differs from `openapi.yaml` fixes it.

## Git, PR and Jira

- Branch: `feat/<JIRA-KEY>-<slug>`.
- Commits use Conventional Commits.
- PR title: `<JIRA-KEY>: <summary>`; fill the PR template.
- Jira: move To Do to In Progress when you start, and In Progress to In Review when the PR opens. Never create Jira issues.
- Unfinished work merges behind a feature flag; record the flag name in the ticket and the handoff.

## Failure reactions

- Design is missing a state: return a question and wait; the Designer adds it.
- A test is flaky: mark it, ask the PM to open a bug, never disable it silently.
- After 3 PR review rounds without approval, the orchestrator escalates to the Advisor.

## Parallel work

- Each dev run uses its own git worktree.
- Do not touch a module another running ticket owns.
