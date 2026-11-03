---
name: jira-sync
description: Create or update Jira stories and sub-tasks from approved story files, with links, labels, story points and fix versions. Use only after the plan is approved, to push the backlog into Jira without creating duplicates.
argument-hint: project key
model: haiku
effort: low
---

Source: skill `jira-backlog-sync` in `03-planning.md` section 6.2 of the factory docs.

## Critical rules

- Run only after the plan is approved (Tech Lead verdict: approved). If you cannot confirm that, stop and ask the owner.
- Only the PM agent creates Jira issues. Skip any story that does not meet the Definition of Ready in `docs/planning/definition-of-ready.md` and list it in the failures.
- Never create a duplicate. Always search before you create.
- If duplicates already exist in Jira: stop creating, list the duplicates, and ask the human before any delete.
- Use the Jira tools of the Atlassian server available to you: `mcp__atlassian_personal__*` or `mcp__claude_ai_Atlassian_MCP__*`.
- The project key is the argument given to this skill. If none is given, ask for it. Do not guess.

## Steps

For each story in `docs/planning/sprints.md`:

1. Search with `searchJiraIssuesUsingJql`: `project = <project key> AND summary ~ "<story id>"`. If found, update it with `editJiraIssue`. Do not create it again.
2. Otherwise create it with `createJiraIssue`: type Story, parent = the epic key, summary, and description (the user story and its acceptance criteria in Jira markup), labels, story points, fix version. Take the story text from the story files in `docs/product/stories/`.
3. Create sub-tasks per role listed in the story (design, fe, be, qa).
4. Create dependency links with `createIssueLink` ("blocks").
5. Append `<story id>: <jira key>` to `docs/planning/jira-map.md`.

Labels in use: `fe`, `be`, `design`, `qa`, `devops`, `spike`.

## Return

The number created, the number updated, and the list of failures.
