#!/bin/bash
# Blocks writes and edits to .env* files, and content that contains a literal secret.
# Patterns are well-known public token formats; the matched text is never printed.
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty')

case "$(basename "$FILE")" in
  .env*)
    echo "Blocked: $FILE is an environment file. Secrets never go through agents." >&2
    exit 2
    ;;
esac

SECRET_PATTERNS=(
  '-----BEGIN [A-Z ]*PRIVATE KEY-----'
  'AKIA[0-9A-Z]{16}'
  'gh[pousr]_[A-Za-z0-9]{36,}'
  'github_pat_[A-Za-z0-9_]{22,}'
  'sk-ant-[A-Za-z0-9_-]{20,}'
  'xox[baprs]-[A-Za-z0-9-]{10,}'
)
for pattern in "${SECRET_PATTERNS[@]}"; do
  if printf '%s' "$CONTENT" | grep -Eq -- "$pattern"; then
    echo "Blocked: the content for $FILE looks like it contains a secret. Use an environment variable name instead." >&2
    exit 2
  fi
done
exit 0
