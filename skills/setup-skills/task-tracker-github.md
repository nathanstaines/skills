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

## When a skill says "publish to the task tracker"

Create a GitHub issue.

## When a skill says "fetch the relevant task"

Run `gh issue view <number> --comments`.
