---
name: e2e-playwright
description: Write Playwright end-to-end tests for a story with smoke and regression tags, page objects and an axe accessibility check, and wire them to run against the Vercel preview. Use when asked for E2E tests, Playwright tests or preview smoke tests.
model: sonnet
effort: medium
---

Source: `08-quality-assurance.md` sections 4 (item 4 and 10), 6.2 and 6.4 of the factory docs.

## Critical rules

1. Test only against Vercel preview or staging URLs. Never against the production domain, except smoke tests in phase 10.
2. Never print or commit a secret value; refer to `VERCEL_AUTOMATION_BYPASS_SECRET` by name.
3. Check Vercel's current documentation on protection bypass for automation before relying on the variable name in the workflow below.

## Steps

1. Read the story and its acceptance criteria (Given/When/Then).
2. Write one Playwright test per story, using page objects.
3. Tag each test `@smoke` or `@regression`.
   - `@smoke` runs in GitHub Actions on every successful preview deployment.
   - The full `@regression` suite runs nightly and on every release candidate.
4. Add an axe-core check to the E2E test for key flows. The exit gate is no critical axe violations on key flows.
5. Make the test read its target from the `BASE_URL` environment variable.
6. Make sure the workflow below exists at `.github/workflows/e2e-preview.yml`; create or update it through a PR.
7. Run the tests against the preview URL and report the result.

## Workflow (section 6.4)

```yaml
# .github/workflows/e2e-preview.yml
name: e2e-preview
on:
  deployment_status:
jobs:
  e2e:
    if: github.event.deployment_status.state == 'success'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v4
      - uses: actions/setup-node@v4
        with: { node-version: 22, cache: pnpm }
      - run: pnpm install --frozen-lockfile
      - run: pnpm exec playwright install --with-deps
      - run: pnpm exec playwright test --grep @smoke
        env:
          BASE_URL: ${{ github.event.deployment_status.environment_url }}
          # preview protection bypass secret, if previews are protected
          VERCEL_AUTOMATION_BYPASS_SECRET: ${{ secrets.VERCEL_AUTOMATION_BYPASS_SECRET }}
```

## Output

The test files added, their tags, the axe result, and the run result against the preview URL.
