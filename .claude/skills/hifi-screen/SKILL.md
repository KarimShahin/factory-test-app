---
name: hifi-screen
description: Design a high-fidelity screen with all its states, responsive and RTL variants, for a story whose wireframes the client has approved. Use when the user says design the real screens, make the hi-fi, or build the screen states. Not for wireframes or handoff packaging.
model: sonnet
effort: high
---

Source: `04-ux-ui-design.md` sections 4.2, 5, 6.2, 8, 9 and 10, and `12-communication-and-handoffs.md` section 13.3.

## Critical rules

- Start only when the client's approval of the wireframes for these stories is recorded as approved. If it is not, stop and tell the orchestrator. Never treat lateness or silence as approval.
- Design only the stories listed in the delegation envelope.
- Use existing tokens and components first. Propose a new component only with a reason. A new component late in the sprint goes to the Design Lead, the Tech Lead confirms feasibility, and the PM adds the front-end ticket.
- Every screen has default, loading, empty, error and success states. Add permission-denied where relevant.
- Every screen has LTR and RTL variants when `02-product.yaml` says `rtl: true`.
- Contrast must meet WCAG 2.2 AA.
- Write only to `docs/design/`, `packages/ui/tokens/` and `.factory/handoffs/04-*`.
- If acceptance criteria are unclear, return a question to the orchestrator. If feedback asks for new screens or features, do not design them; the PM records a change request.

## Steps

1. Read the approved wireframes in `docs/design/sprints/sprint-<NN>/wireframes/` and the stories' acceptance criteria.
2. Read the tokens in `packages/ui/tokens/tokens.json` and the component specs in `docs/design/system/`. Use their values, not new ones.
3. Design each screen at high fidelity on the surface recorded in the phase handoff, with all required states.
4. Add responsive variants for the breakpoints in scope (the handoff schema lists `mobile` and `desktop`).
5. Add the RTL variant when `rtl: true`, using the `rtl-variant` skill and the RTL rules from the design system.
6. For a flow with more than three steps, build an interactive prototype.
7. Run the accessibility check per screen, using the `a11y-audit` skill (contrast, focus order, labels, targets).
8. Save screens under `docs/design/sprints/sprint-<NN>/screens/` as exported images or links.
9. Record for each screen what the handoff schema needs: `id`, `stories`, `link`, `states`, `breakpoints`, `rtl`, `components`, `new_components`, `notes`.
10. Report handoff-ready to the orchestrator. The Design Lead and the PM review (the PM checks acceptance criteria coverage).

## After review

- If the Design Lead or PM returns changes, revise the affected screens and report again.
- On approval, the owner presents the UI/UX to the client in person and records the decision. Prepare the package with the `approval-pack` skill.
- If the client requests changes, revise only the items the orchestrator passes to you.
- The approved revision is frozen. Any later change needs a new revision and a new approval.

## Done when

- Every story in sprint N+1 has screens.
- Every screen lists all five states, plus responsive and RTL variants where required.
- The accessibility check passes.
