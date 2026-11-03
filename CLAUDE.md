# Project rules

Rules for every coding agent in this repository. Keep this file under 200 lines; long material belongs in skills.

## Commands

- `pnpm install --frozen-lockfile` installs dependencies.
- `pnpm lint`, `pnpm typecheck`, `pnpm test` and `pnpm build` must pass before a PR opens. CI runs the same four.
- `pnpm --filter web dev` starts the web app.

## Structure

- `apps/web/` is the Next.js app; `/health` is the health page.
- `packages/ui/tokens/tokens.json` holds the design tokens.
- `docs/adr/` holds architecture decision records; `docs/api/openapi.yaml` is the API contract and the source of truth.
- `.factory/` holds factory state, schemas and handoffs. Do not edit `.claude/` or `.factory/schemas/` by hand; the factory sync PR overwrites them.

## Conventions

- Branch names: `feat/<JIRA-KEY>-<slug>`. Commits use Conventional Commits. PR titles: `<JIRA-KEY>: <summary>`.
- Never push to `main` or `production`, and never run production commands.
- Never write secrets, tokens or `.env*` files; refer to environment variables by name.
- Use design tokens and existing components; do not hard-code colors or spacing.
