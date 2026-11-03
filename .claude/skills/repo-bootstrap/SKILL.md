---
name: repo-bootstrap
description: Set up a new project's GitHub repository, with the repo layout, branch rulesets, pull request template, CODEOWNERS, Jira linking and security features. Use when asked to bootstrap a repo, configure branch protection or set up GitHub for a new project.
model: sonnet
effort: medium
---

Source: `06-setup-foundation.md` sections 4.1 to 4.6 and 6.2 of the factory docs.

## Critical rules

1. Creating a repository and changing its settings are account changes: confirm the target organization and repository name with the owner before the first command.
2. Never print, log or commit a secret value; refer to variables by name.
3. Do not perform the human prerequisites (section 4.1): GitHub organization, Vercel team, tokens, third-party sandbox accounts. If one is missing, stop and tell the owner which one.
4. Rulesets must have no bypass, including admins. Only the owner merges into `production`.
5. Every infrastructure change goes through a PR reviewed by the Tech Lead.
6. Write only to `.github/`, `vercel.json`, `docker-compose.yml`, `infra/`, `scripts/` and the setup handoff files.

## Human prerequisites (check, do not do)

1. A GitHub organization exists, with the Vercel GitHub app and the GitHub for Jira app installed.
2. A Vercel team exists, on a plan that fits (Rolling Releases need Pro or Enterprise).
3. A GitHub token for the GitHub MCP server exists, and the Vercel MCP server is added with OAuth.
4. Third-party sandbox accounts (payments, email, SMS) exist and their keys are in Vercel environment variables.

## Steps

1. Create the repository from the layout in phase 05 of the factory docs.
2. Create rulesets on `main` and `production` with `gh api`:
   - pull request required, with **zero required approvals** (every agent acts as the owner's GitHub user, and GitHub does not let authors approve their own PRs);
   - required status checks: CI, plus a `factory/review` commit status posted by the reviewer run;
   - linear history, no force push, no deletion;
   - no bypass, including admins.
3. Add `.github/pull_request_template.md`: the per-ticket handoff, defined in `12-communication-and-handoffs.md` section 7.4.
4. Add `CODEOWNERS` mapping folders to owner roles.
5. Set up Jira linking: the PR title starts with the Jira key.
6. Turn on security features: Dependabot, secret scanning, code scanning (for example CodeQL).
7. Optional: install the Claude Code GitHub Action so humans can mention `@claude` on issues and PRs.

## Related setup (separate skills)

These steps of section 4 belong to sibling skills; hand off to them instead of repeating them here.

- 4.3 CI pipeline (lint, types, test with coverage, build, in GitHub Actions): `ci-pipeline`.
- 4.4 Vercel (project link, root directory, production branch `production`, environments, domains, skew protection, rolling release): `vercel-project-setup` and `env-matrix`.
- 4.5 Local development (docker-compose for Postgres and Redis, migrations tool, seed script, one `pnpm dev` command): `local-dev-setup`.
- 4.6 Skeletons (web, API, API client generated from `docs/api/openapi.yaml`): `skeleton-web`, `skeleton-api`, `api-client-gen`.
- 4.6 Project `CLAUDE.md`: short rules for all coding agents (commands, structure, conventions), under 200 lines; long material goes into skills.

## Output

Report which of steps 1 to 7 are done and anything left for the owner.
