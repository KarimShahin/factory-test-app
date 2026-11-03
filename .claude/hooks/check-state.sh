#!/bin/bash
# Tells the orchestrator at startup whether the project has been assessed.
# Lean roster: there is no project-assessor or drift-check, so a missing state file
# means the human confirms the entry phase.
if [ ! -f "$CLAUDE_PROJECT_DIR/.factory/state.yaml" ]; then
  echo "No .factory/state.yaml: this project has not been assessed. Ask the human to confirm the entry phase."
else
  echo "Factory state found. Read .factory/state.yaml before continuing."
fi
