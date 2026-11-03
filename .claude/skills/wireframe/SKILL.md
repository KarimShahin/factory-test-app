---
name: wireframe
description: Draw low-fidelity wireframes for the stories of the next sprint, one layout per screen, before any high-fidelity work. Use when the user says wireframe this story, sketch the screens, or lay out the sprint screens. Stops at the Design Lead check and the client wireframe approval.
model: sonnet
effort: medium
---

Source: `04-ux-ui-design.md` sections 4.2, 5, 6.1, 6.2 and 7, and `12-communication-and-handoffs.md` section 13.

## Critical rules

- Design only the stories listed in the delegation envelope.
- Use existing tokens and components first. Propose a new component only with a reason.
- If a story's acceptance criteria are unclear, return a question to the orchestrator. The PM clarifies the story. Do not guess.
- Write only to `docs/design/`, `packages/ui/tokens/` and `.factory/handoffs/04-*`.
- Do not start high-fidelity work. It waits for the client's approval of the wireframes. Use the `hifi-screen` skill only after that approval.
- Never record or change an approval record. Only the owner records client decisions.

## Steps

1. Read the stories assigned to sprint N+1 from the delegation envelope. Read `.factory/handoffs/02-product.yaml` for flows, personas and NFRs, including `rtl`, and `.factory/handoffs/03-plan.yaml` for which stories belong to the sprint.
2. Read the design surface recorded in the phase handoff (`surface`: `claude-design`, `figma` or `code-first`) and draw on that surface. For a new surface choice, the options are in section 6.1 of the source doc.
3. Draw one low-fidelity wireframe per screen, reusing existing components from the design system.
4. Save the wireframes under `docs/design/sprints/sprint-<NN>/wireframes/`.
5. Mark any new component you propose, with its reason, so the Design Lead and Tech Lead can judge it.
6. Report handoff-ready to the orchestrator. The Design Lead then runs the heuristic usability check (Nielsen heuristics).
7. If the Design Lead returns changes, revise the wireframes and report again.

## After the Design Lead approves

- The owner reviews the wireframes, presents them to the client in person and records the decision. Prepare the package with the `approval-pack` skill.
- If the client requests changes, revise only the items the orchestrator passes to you. Return to step 3 for those screens.
- High-fidelity work starts only when the wireframe approval is recorded as approved.

## Output

Wireframes in `docs/design/sprints/sprint-<NN>/wireframes/`, one per screen, covering every story in scope.
