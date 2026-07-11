---
name: setup-skills
description: Configure this project for engineering skills. Sets up the task tracker, domain doc layout and testing stance. Run once per project before first use of the other skills.
disable-model-invocation: true
---

# Setup Skills

Scaffold the per-project configuration the engineering skills assume:

- **Task tracker**: where tasks live (GitHub or local markdown)
- **Domain docs**: where `CONTEXT.md` and ADRs live and the rules for reading them
- **Testing stance**: whether skills should write tests here (asked only when the project has none)

This is a prompt-driven skill, not a deterministic script. Explore, present what you find, confirm with the user, then write.

## Process

### 1. Explore

Look at the current project to understand its starting state. Read whatever exists; don't assume:

- Version control: is there a `.git` directory? If so, does `git remote -v` point at GitHub? Which repo? The project may not use git at all (e.g. TFVC); that's fine and nothing else here depends on it.
- `CLAUDE.md` and `AGENTS.md` at the project root: does either exist? Is there already an `## Agent skills` section in either?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the project root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/`: does this skill's prior output already exist?
- `.scratchpad/`: sign that a local markdown task tracker is already in use
- Multi-context signals: multiple deployable apps/services in one tree, whatever the ecosystem (e.g. a `pnpm-workspace.yaml` or `workspaces` field, a `.sln` referencing many projects, a populated `packages/*` or `apps/*` with its own `src/`). Their absence means single-context, which is almost every project.
- Test signals: test directories or files (`tests/`, `__tests__/`, `*.test.*`, `*.spec.*`), a runner config or a test script in the ecosystem's manifest. Their absence triggers Section C.

### 2. Present findings and ask

Summarise what's present and what's missing. Then complete the sections in order, one section, one answer, then the next. Lead each section with the recommended answer so the user can accept it in a word.

**Section A: task tracker.** If a git remote points at GitHub, propose GitHub. Otherwise (including non-git projects), propose local markdown.

- **GitHub**: tasks live in the repo's GitHub Issues (uses the `gh` CLI)
- **Local markdown**: tasks live as files under `.scratchpad/<feature-slug>/` in this project (good for solo projects, non-git projects or projects without a remote). If the project uses git, ask whether `.scratchpad/` should be committed (recommended, it's the tracker of record) or gitignored, then add or remove the `.gitignore` entry to match and record the choice in the template's committed flag.

**Section B: domain docs.** Default to single-context, one `CONTEXT.md` plus `docs/adr/` at the project root. This fits almost every project; write it without asking.

Offer multi-context, a root `CONTEXT-MAP.md` pointing to per-context `CONTEXT.md` files, only when exploration found multi-context signals. Then confirm which layout they want.

**Section C: testing stance.** Skip this section when exploration found test signals; an existing suite speaks for itself. When it found none, ask whether skills should write tests in this project. Absence is ambiguous (deliberately test-free vs not yet started), so the recorded answer is what disambiguates it for every future skill. The answer becomes a `### Testing` line in the `## Agent skills` block; no separate docs file.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to whichever of `CLAUDE.md` / `AGENTS.md` is being edited (see step 4 for selection rules)
- The contents of `docs/agents/task-tracker.md` and `docs/agents/domain.md`

Let them edit before writing.

### 4. Write

Pick the file to edit:

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, ask the user which one to create; don't pick for them.

Never create one when the other already exists. If an `## Agent skills` block already exists in the chosen file, update its contents in place rather than appending a duplicate. Don't touch the surrounding sections.

The block:

```markdown
## Agent skills

### Task tracker

[one-line summary of where tasks are tracked]. See `docs/agents/task-tracker.md`.

### Domain docs

[one-line summary of layout, "single-context" or "multi-context"]. See `docs/agents/domain.md`.

### Testing

[one-line stance, e.g. "verified manually, keep it test-free" or "tests are welcome but none exist yet"]
```

Include the `### Testing` sub-block only when Section C ran; a project with an existing suite needs no stance recorded.

Then write the docs files using the seed templates in this skill folder as a starting point:

- [task-tracker-github.md](./task-tracker-github.md): GitHub task tracker
- [task-tracker-local.md](./task-tracker-local.md): local markdown task tracker
- [domain.md](./domain.md): domain doc consumer rules and layout

### 5. Done

Tell the user the setup is complete and that they can edit `docs/agents/*.md` directly later. Re-running this skill is only necessary to switch task trackers or restart from scratch.
