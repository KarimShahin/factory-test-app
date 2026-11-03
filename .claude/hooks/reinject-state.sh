#!/bin/bash
# Prints the factory state after compaction so the orchestrator does not lose its place.
echo "Factory state after compaction:"
cat "$CLAUDE_PROJECT_DIR/.factory/state.yaml"
echo "Rules: read 12-communication-and-handoffs.md section 4 before sending any envelope."
