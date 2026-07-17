#!/usr/bin/env bash
# Human-in-the-loop reproduction loop.
# Copy this file, edit the steps below, and run it.
# The agent runs the script; the user follows prompts in their terminal.
#
# Usage:
#   bash hitl-loop.template.sh
#
# Three helpers:
#   step "<instruction>"           → show instruction, wait for Enter
#   capture VAR "<question>"       → show question, read one line into VAR
#   capture_multi VAR "<question>" → show question, read until a lone '.' into VAR
#
# Use capture_multi for anything the user pastes (stack traces, log dumps).
# A single-line capture would leave the rest of the paste in stdin, where the
# next prompt would silently eat it.
#
# At the end, captured values are printed for the agent to parse: single-line
# values as KEY=VALUE, multi-line values as a KEY<<CAPTURE_EOF ... CAPTURE_EOF
# block. Pick a different delimiter if the captured text could contain that one.

set -euo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p "    [Enter when done] " _
}

capture() {
  local var="$1" question="$2" answer
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  printf -v "$var" '%s' "$answer"
}

capture_multi() {
  local var="$1" question="$2" line answer=''
  printf '\n>>> %s\n' "$question"
  printf '    [paste, then a lone . on its own line]\n'
  while IFS= read -r line; do
    [[ "$line" == '.' ]] && break
    answer+="$line"$'\n'
  done
  printf -v "$var" '%s' "${answer%$'\n'}"
}

emit() {
  local var="$1" value="${!1}"
  if [[ "$value" == *$'\n'* ]]; then
    printf '%s<<CAPTURE_EOF\n%s\nCAPTURE_EOF\n' "$var" "$value"
  else
    printf '%s=%s\n' "$var" "$value"
  fi
}

# --- edit below ---------------------------------------------------------

step "Open the app at http://localhost:3000 and sign in."

capture ERRORED "Click the 'Export' button. Did it throw an error? (y/n)"

capture_multi ERROR_MSG "Paste the error message (or 'none'):"

printf '\n--- Captured ---\n'
emit ERRORED
emit ERROR_MSG

# --- edit above ---------------------------------------------------------
