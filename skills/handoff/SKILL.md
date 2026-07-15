---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

# Handoff

Write a handoff document summarising the current conversation so a fresh agent can continue the work. Save it to the temporary directory of the user's OS, not the current workspace. Name the file after the project or topic so the path is easy to guess and the next handoff for the same work replaces it.

Include a "suggested skills" section in the document, which suggests skills the next session should use.

Do not duplicate content already captured in other artefacts (specs, plans, ADRs, tasks, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords or personally identifiable information.

If the user passed arguments, treat them as a description of what the next session will focus on and tailor the document accordingly.

End by giving the user the file path and nothing else.
