# Task tracker: local markdown

Tasks and specs for this project live as markdown files in `.scratchpad/`.

## Conventions

- One feature per directory: `.scratchpad/<feature-slug>/`
- **Committed to version control: yes.** _(Set to `no` if this project gitignores `.scratchpad/`; setup asks when git is in use.)_
- The spec is `.scratchpad/<feature-slug>/spec.md`
- Tasks are one file per task at `.scratchpad/<feature-slug>/tasks/<NN>-<slug>.md`, numbered from `01`, never a single combined file
- State is recorded as a `Status:` line near the top of each task file (`open`, `in-progress` or `closed`)
- Comments and conversation history append to the bottom of the file under a `## Comments` heading

## When a skill says "publish to the task tracker"

Create a new file under `.scratchpad/<feature-slug>/`, deriving the slug from the feature title (kebab-case) and creating the directory if needed.

## When a skill says "fetch the relevant task"

Read the file at the referenced path. The user will normally pass the path, or the feature plus task number (task numbers restart at `01` per feature, so a bare number is only unambiguous within one feature).
