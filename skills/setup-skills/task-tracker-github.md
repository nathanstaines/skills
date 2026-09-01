# Task tracker: GitHub

Tasks and specs for this project live as GitHub issues. Use the `gh` CLI for all operations.

## Conventions

- **Create a task**: `gh issue create --title "..." --body "..."`. Use a heredoc for multi-line bodies.
- **Read a task**: `gh issue view <number> --comments`
- **List tasks**: `gh issue list --state open --json number,title,body,labels,comments` with appropriate `--label` and `--state` filters
- **Comment on a task**: `gh issue comment <number> --body "..."`
- **Apply / remove labels**: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **Close**: `gh issue close <number> --comment "..."`

Infer the repo from `git remote -v`. `gh` does this automatically when run inside a clone.

## Status

State lives in GitHub's native fields where they carry it, labels where they don't. Every issue has a native `updatedAt`, so there's no manual `updated` field to maintain; a status written into an issue body is drift, not a second opinion.

A task:

- an open issue with no status label is `open`
- the `in-progress` label means in progress
- the `blocked` label, or any blocker still open, means blocked
- a closed issue is `done`

A spec (an issue titled `Spec: <feature title>`):

- open with no label is `draft`, which is what publishing writes
- the `ready` label means a path has been chosen but no work has started
- the `parked` label means parked
- a closed issue is `done`

Create a label the first time it's needed: `gh label create in-progress`, and likewise `blocked`, `ready`, `parked`. Move a spec from draft to ready with `gh issue edit <n> --add-label ready`.

### Which status counts

A feature can hold two status signals, and exactly one of them is ever read:

- **Tasks referencing the spec exist**: the tasks are the truth. Feature progress is the count of closed over total, and the spec's own labels are ignored, never displayed and never trusted. This is what stops a stale `ready` label sitting above finished tasks.
- **No tasks**: the spec issue's own state is the truth.

The same rule decides which status *moves* when work runs. With tasks, the task's labels and state are what change and the spec issue is left alone entirely. With none, the spec issue itself moves: the `in-progress` label on start, closed on completion.

Derive the feature's state when you read it. Don't maintain a summary or index issue; an index that has to be kept in step drifts the first time a task closes without one.

## Blocking edges

GitHub's native issue dependencies are the canonical representation. Add an edge with `gh api --method POST repos/<owner>/<repo>/issues/<blocked>/dependencies/blocked_by -F issue_id=<blocker-db-id>`, where `<blocker-db-id>` is the blocker's numeric database id (`gh api repos/<owner>/<repo>/issues/<n> --jq .id`, not the `#number` or `node_id`). Where dependencies aren't available, fall back to a `Blocked by: #<n>, #<n>` line at the top of the task body. A task is unblocked when every blocker is closed.

## When a skill says "publish to the task tracker"

Create a GitHub issue. Specs are issues too, titled `Spec: <feature title>` so they're distinguishable from tasks in the shared number space.

## When a skill says "fetch the relevant task"

Run `gh issue view <number> --comments`.

## Scouting operations

`/scout` charts a map of decision tasks as issues:

- The map is an issue titled `Scout: <feature title>`, sharing the number space with tasks and specs
- Decision tasks are issues titled `Decision: <the question>`, distinguishable from implementation tasks by that prefix, tied to the map through GitHub's native sub-issues (`gh api --method POST repos/<owner>/<repo>/issues/<map>/sub_issues -F sub_issue_id=<task-db-id>`, taking the task's numeric database id from `gh api repos/<owner>/<repo>/issues/<n> --jq .id`). Where sub-issues aren't available, fall back to a `Map: #<n>` line at the top of the task body
- Blocking uses the same native dependencies as implementation tasks, so the frontier renders in GitHub's own UI

State:

- an open map issue is being scouted; closing it means the destination is reached
- an open decision task with no status label is `open`; the `in-progress` label **is** the claim, set before any work so a second session skips it; a closed one is resolved
- each carries one type label, `scout:research`, `scout:prototype`, `scout:grill` or `scout:chore`. Create each the first time it's needed
- one that turned out to sit past the destination is closed with the `out-of-scope` label, which keeps it off the frontier and distinguishes it from one that was resolved
- the frontier is the open, unlabelled decision tasks whose blockers are all closed: `gh issue list --state open --json number,title,labels`, filtered to the map's sub-issues

The resolution is posted as a comment before the issue is closed, and anything produced while resolving it is linked from that comment rather than pasted into it.
