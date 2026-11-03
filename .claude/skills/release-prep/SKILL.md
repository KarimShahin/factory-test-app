---
name: release-prep
description: Prepare a release for go-live. Use when writing the UAT script and release notes, closing the Jira fix version, or running the go-live checklist with evidence per item before the human go-live approval.
---

Source: `09-release-preparation.md` sections 4, 6.2 and 4.1 of the factory docs. This covers the PM agent's part of phase 09. QA and DevOps own their checklist items; you collect their evidence.

## Critical rules

- You never approve go-live, sign off UAT or enter payment provider live keys. These are human-only. Record them only when the owner reports them, with name and time.
- A checklist item is done only when it has an evidence path. No evidence, no tick.
- If a production variable is missing, block go-live and ask the human to add it. Agents verify variable names, never values.
- If stakeholders are unavailable for UAT, wait. Go-live cannot be approved by an agent.
- Write only to `docs/release/<version>/`, `docs/planning/` and `.factory/handoffs/09-*`.

## Inputs

- `.factory/handoffs/08-qa-<rc>.yaml` with `signoff: approved`
- `.factory/handoffs/03-plan.yaml` (fix version and milestone)
- `.factory/handoffs/06-setup.yaml` (Vercel project, domains, environments)

## Steps

1. UAT script. Write `docs/release/<version>/uat-script.md`: scenario-based, from the stories. The owner runs it with the client on staging and records pass or fail per scenario in `uat-results.md`. The QA agent reproduces any reported issue.
2. A UAT scope gap that is not a bug becomes a new story for the next release. The release continues if the business case is not affected.
3. Release notes. Build them from the Jira fix version and merged PR titles. Write two versions: `release-notes-users.md` and `release-notes-team.md`.
4. Jira release. Set the fix version and release date, and confirm every ticket in it is Done.
5. Go-live checklist. Run the checklist below and record the evidence path per item in `go-live-checklist.md`.
6. When every item is green, report to the orchestrator for the Business Consultant review, then the human go-live approval.

## Go-live checklist

| Item | Owner | Check |
|------|-------|-------|
| Domain and SSL | DevOps | Production domain verified on Vercel; certificate active |
| Production env variables | DevOps + human | Every variable in the env matrix exists for Production (names verified by agent, values entered by a human) |
| Payment provider live keys | Human only | Switched in Vercel Production env; agent never sees values |
| Database backups | DevOps | Automatic backups on; restore tested once |
| Restore point | DevOps | Snapshot taken just before release |
| Rate limits and firewall | DevOps | Rules for auth and booking endpoints |
| Skew Protection | DevOps | On |
| Release method | DevOps | Atomic promotion by the owner or the dashboard (default); rolling release stages only for high-traffic clients |
| Cron jobs | DevOps | Declared and pointing at production-safe handlers |
| Analytics | PM | Events visible from staging in the analytics tool |
| Error tracking | QA | Test error from staging appears with release tag |
| Status page / support contact | PM | Published |
| Legal pages | PM | Live on staging |
| Release notes | PM | Approved |
| Rollback plan | DevOps | Written, steps tested on staging |
| QA sign-off | QA | Present in 08 handoff |
| UAT sign-off | Human | Recorded |

## Handoff

Write `.factory/handoffs/09-release.yaml` with the paths of the release notes, checklist and UAT results, and the `approvals` block (uat and go_live, each with recorded_by and time). The go_live field stays empty until the human approves.
