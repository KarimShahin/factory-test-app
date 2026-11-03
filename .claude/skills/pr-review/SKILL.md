---
name: pr-review
description: Reviews one PR diff against acceptance criteria, standards and architecture; returns a verdict. Use after an implementation run.
context: fork
agent: general-purpose
model: opus
effort: high
---

1. Run deterministic checks first (lint, types, tests, contract test). Stop on failure.
2. Read the diff, the ticket's acceptance criteria and the referenced API paths only.
3. If the PR has a label risk:auth, risk:payments or risk:migrations, state that opus review is required.
4. Return a verdict YAML (12, section 6). Every issue cites a rule ID.

Source: `07-development.md` sections 5.2, 6.0 and 6.3, and `12-communication-and-handoffs.md` sections 6 and 7.2 of the factory docs. Review as the Tech Lead: standards, architecture and security.

## Verdict rules

- `verdict` is one of `approved`, `changes_requested`, `rejected`.
- `approved` requires zero `critical` and zero `high` issues.
- Severity is one of `critical`, `high`, `medium`, `low`.
- Every issue cites a rule from a skill rubric. Never block on taste alone.
- Return the same structure every time. The orchestrator never interprets free-text feedback.

## Verdict format

```yaml
envelope:
  from: tech-lead
  to: orchestrator
  type: verdict
  reply_to: <message id>
verdict: changes_requested     # approved | changes_requested | rejected
artifact: <reviewed artifact>
round: 1
issues:
  - id: R1
    severity: high             # critical | high | medium | low
    location: "<file, screen or state>"
    rule: "<rubric>#<rule>"
    problem: <what is wrong>
    fix: <what to change>
strengths: [<what is good>]
```

## GitHub comments

- Post each issue as a GitHub review comment on the PR. Code review conversations stay on GitHub, never in agent chat.
- The verdict file lists the comment URLs.

## PR loop

- The Tech Lead review runs alongside the QA review on the preview. Merge happens only when both approve.
- On `changes_requested`, the orchestrator resumes the author with the verdicts, and the PR is reviewed again.
- A PR loop has at most three rounds before escalation to the Advisor.
- Required checks (lint, types, tests, Vercel preview) must pass before merge.
