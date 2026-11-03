#!/bin/bash
# report-event.sh <project-slug> <dashboard-host>
# Posts the hook input to the dashboard. Never blocks the session and prints nothing,
# because SessionStart output would be added to Claude's context.
INPUT="$(cat)"
AUTH=()
[ -n "${FACTORY_HOOK_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer $FACTORY_HOOK_TOKEN")
curl -s -m 5 -X POST "https://$2/api/hooks/claude" \
  -H "Content-Type: application/json" -H "X-Factory-Project: $1" "${AUTH[@]}" \
  --data "$INPUT" >/dev/null 2>&1 || true
exit 0
