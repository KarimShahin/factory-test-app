#!/bin/bash
# Validates every handoff changed since the last commit, in any increment or the baseline.
# Schema per file: .factory/schemas/<phase>.<kind>.schema.json (kind = full | delta).
cd "$CLAUDE_PROJECT_DIR" || exit 0
CHANGED=$(git status --porcelain -- .factory/increments .factory/baseline | awk '{print $NF}' | grep '\.yaml$')
FAIL=0
for f in $CHANGED; do
  PHASE=$(yq '.phase' "$f")
  KIND=$(yq '.kind // "full"' "$f")
  SCHEMA=".factory/schemas/${PHASE}.${KIND}.schema.json"
  [ -f "$SCHEMA" ] || continue
  if ! npx --yes ajv-cli validate -s "$SCHEMA" -d "$f" --spec=draft2020 >/dev/null 2>&1; then
    echo "Handoff $f failed $SCHEMA" >&2
    FAIL=1
  fi
done
[ "$FAIL" -eq 1 ] && yq -i '.last_validation = "failed"' .factory/state.yaml
exit 0   # record the failure for the orchestrator; do not block the agent from stopping
