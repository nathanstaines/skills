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

## Blocking edges

GitHub's native issue dependencies are the canonical representation. Add an edge with `gh api --method POST repos/<owner>/<repo>/issues/<blocked>/dependencies/blocked_by -F issue_id=<blocker-db-id>`, where `<blocker-db-id>` is the blocker's numeric database id (`gh api repos/<owner>/<repo>/issues/<n> --jq .id`, not the `#number` or `node_id`). Where dependencies aren't available, fall back to a `Blocked by: #<n>, #<n>` line at the top of the task body. A task is unblocked when every blocker is closed.

## When a skill says "publish to the task tracker"

Create a GitHub issue. Specs are issues too, titled `Spec: <feature title>` so they're distinguishable from tasks in the shared number space.

## When a skill says "fetch the relevant task"

Run `gh issue view <number> --comments`.
