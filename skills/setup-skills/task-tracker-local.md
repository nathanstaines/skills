# Task tracker: local markdown

Tasks and specs for this project live as markdown files in `.scratchpad/`.

## Conventions

- One feature per directory: `.scratchpad/<feature-slug>/`
- **Committed to version control: yes.** _(Set to `no` if this project gitignores `.scratchpad/`; setup asks when git is in use.)_
- The spec is `.scratchpad/<feature-slug>/spec.md`
- Tasks are one file per task at `.scratchpad/<feature-slug>/tasks/<NN>-<slug>.md`, numbered from `01`, never a single combined file
- State is recorded in YAML frontmatter at the top of each file, per the Status section below
- Comments and conversation history append to the bottom of the file under a `## Comments` heading

## Status

Every task and every spec opens with a YAML frontmatter block. It is the only place state lives; a status written into the prose body is drift, not a second opinion.

A task:

```yaml
---
status: open
blocked_by: ["01", "03"]
updated: 2026-07-29
---
```

- `status` is one of `open`, `in-progress`, `blocked` or `done`
- `blocked_by` lists the task numbers that gate this one, `[]` when nothing does. Quote them: they're zero-padded identifiers, and a bare `01` is parsed as a number, losing the padding that matches the filename. It's a list rather than prose so the frontier can be computed rather than reasoned out: a task is on the frontier when its status is `open` and every task it names is `done`.
- `updated` is the date of the last status change, `YYYY-MM-DD`. It's what separates a live `in-progress` task from one orphaned by a session that died.

A spec:

```yaml
---
status: draft
updated: 2026-07-29
---
```

- `status` is one of `draft`, `ready`, `in-progress`, `done` or `parked`. `draft` is what `/to-spec` writes on publish; `ready` means a path has been chosen but no work has started.

Specs carry no count or checklist. A spec small enough to implement without tasks is one session's work, so a single state is the honest granularity; anything finer is what `/to-tasks` is for.

Changing a status is a write to two fields: set `status` to the new value and `updated` to today. A transition that moves `status` but leaves `updated` stale is what makes the staleness check meaningless, so the two move together or not at all.

### Which status counts

A feature can hold two status signals, and exactly one of them is ever read:

- **`tasks/` exists and is non-empty**: the tasks are the source of truth. Feature progress is the count of `done` over total, and the spec's own `status` is ignored, never displayed and never trusted. This is what stops a stale `status: draft` sitting above nine finished tasks.
- **No `tasks/`**: the spec's frontmatter is the source of truth. Show its status, no count.

Derive the feature's state when you read it. Don't maintain a summary or index file; an index that has to be kept in step drifts the first time a task closes without one.

## When a skill says "publish to the task tracker"

Create a new file under `.scratchpad/<feature-slug>/`, deriving the slug from the feature title (kebab-case) and creating the directory if needed. Open it with the frontmatter block for its kind, with `updated` set to today.

## When a skill says "fetch the relevant task"

Read the file at the referenced path. The user will normally pass the path, or the feature plus task number (task numbers restart at `01` per feature, so a bare number is only unambiguous within one feature).
