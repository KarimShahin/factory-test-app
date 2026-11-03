#!/bin/bash
# .claude/hooks/path-guard.sh <agent> <allowed-prefix>...
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
REL="${FILE#"$CLAUDE_PROJECT_DIR"/}"
shift
for prefix in "$@"; do
  [[ "$REL" == "$prefix"* ]] && exit 0
done
echo "Blocked: $REL is outside this agent's write scope ($*)" >&2
exit 2
