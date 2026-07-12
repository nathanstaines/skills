---
name: implement
description: Implement a piece of work described by a spec or set of tasks.
disable-model-invocation: true
---

Implement the work described by the user in the spec or tasks.

The task tracker conventions live in `docs/agents/task-tracker.md`. Run `/setup-skills` if that file doesn't exist. When the work comes from the tracker, fetch the referenced task per those conventions and check its blocking edges; if a blocker is still open, stop and tell the user. When the task points at a parent spec, or a `spec.md` sits beside it in the feature directory, read it before starting so the implementation decisions and agreed seams carry over. Mark the task in-progress where the tracker records status.

Use the project's domain glossary vocabulary and respect any ADRs in the area you're touching (see `docs/agents/domain.md`).

Whether the project uses tests comes from the `### Testing` stance in the Agent skills block. When it does, use `/tdd` at pre-agreed seams; run single test files regularly and the full suite once at the end. When it doesn't, verify the change by hand, per the spec's Verification section when one exists.

When the project has a typechecker, run it regularly.

Once done, review the full set of changes with `/code-review` before handing the work back. Close the task per the tracker conventions, only when every acceptance criterion is met and with any deviation from the task description noted. Implement only the referenced task: when it's done, stop rather than pulling the next frontier task into the same session.

Only record the work in version control (commit, check in, push) when explicitly asked. Applying requested changes never implies recording them, even if that was discussed beforehand.
