---
name: implement-ticket
description: Implement one Jira ticket end to end with the ticket loop, from reading the ticket to an opened pull request. Use when asked to implement, build or work on a ticket, story or task in a single cloud run.
model: sonnet
effort: medium
---

Source: `07-development.md` sections 5.1 and 6.0 of the factory docs. Folder rules, backend and frontend rules, branch, commit and PR naming and failure reactions live in `dev-conventions`; follow them and do not restate them here.

## Critical rules

1. One cloud run handles one ticket. Sessions are not reused between events, so keep everything that needs shared context inside this session.
2. Check the dashboard's `paused` flag first; stop if it is paused.
3. Open the PR only when the self-review is clean and the review passes.
4. Never create Jira issues.

## Ticket loop (section 5.1)

1. Read the ticket and the files it references.
2. Write failing tests from the acceptance criteria.
3. Implement.
4. Run tests, lint and types. On failure, return to step 3.
5. Refactor.
6. Self-review your own diff. On issues, return to step 3.
7. Open the PR.

## One run per ticket (section 6.0)

1. Check the `paused` flag; stop if paused.
2. Spawn the named author subagent (`fe-agent` or `be-agent`) with the Agent tool, so its frontmatter (tools, hooks, isolation) applies. Reading the agent file as text applies none of it.
3. Run deterministic checks first: lint, types, tests, contract test.
4. Spawn a reviewer subagent (sonnet by default; opus for auth, payments and migrations). Resume the author with `SendMessage` for revisions, in the same session.
5. Open the PR only when the review passes, then post the `factory/review` commit status.
6. Write continuity to `.factory/handoffs/tickets/<KEY>.yaml` (status, branch, last verdict, open questions), so a later run can continue without the earlier session.

E2E smoke tests run in GitHub Actions on the Vercel preview (see `e2e-playwright`). There is no second LLM review on every push.

## Output

The PR link, the ticket handoff file path, and the last review verdict.
