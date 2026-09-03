---
name: implement
description: Implement a piece of work described by a spec or set of tasks.
disable-model-invocation: true
---

Implement the work described by the user in the spec or tasks.

The task tracker conventions live in `docs/agents/task-tracker.md`. Run `/setup-skills` if that file doesn't exist.

## Steps

1. **Fetch the work.** From the tracker, fetch the referenced task per the conventions and check its blocking edges. An open blocker ends the session: say so, and offer an unblocked task instead while no work has started. The blocked task gets its own session later. Read the parent spec, or a `spec.md` sitting beside the task in the feature directory, before starting so the implementation decisions and agreed seams carry over.
2. **Mark it in-progress** per the tracker conventions, replacing `ready` when the work is a taskless spec. Already in-progress means a session probably died mid-flight: say when it was last touched, then ask whether to continue from where it stands or reset it to its unstarted state and start clean. Picking one up blind is how half-finished work gets built on twice.
3. **Build it.** Use the project's domain glossary vocabulary and respect any ADRs in the area you're touching (see `docs/agents/domain.md`). The `### Testing` stance in the Agent skills block decides how: where tests are welcome, use `/tdd` at pre-agreed seams, running single test files regularly and the full suite once at the end; where the project is test-free, verify by hand, per the spec's Verification section when one exists. Run the typechecker regularly when the project has one.
4. **Tick each acceptance criterion as you meet it** rather than all of them at the end, so a session that doesn't finish still leaves an accurate picture of how far it got.
5. **Close the task** per the tracker conventions, clearing its in-progress status as part of closing it, only when every acceptance criterion is met and ticked and with any deviation from the task description noted. Then stop, and say the changes are unreviewed.

Reviewing is the user's call from a fresh session, `/code-review` against the state you started from; leave it for them to invoke and do nothing further until they ask.

Implement only the referenced task: when it's done, stop rather than pulling the next frontier task into the same session. A fresh session can run `/progress` to pick the next frontier task up.

Only record the work in version control (commit, check in, push) when explicitly asked. Applying requested changes never implies recording them, even if that was discussed beforehand.
