# Skills

A set of agent skills used for engineering.

## Installation

1. Run the skills.sh installer:

```bash
npx skills@latest add nathanstaines/skills
```

2. Pick the skills you want.

## Skills

- **[setup-skills](./skills/setup-skills/SKILL.md)**: configure a project for the engineering skills (task tracker, domain doc layout and testing stance). Run once per project before first use of the others.
- **[code-review](./skills/code-review/SKILL.md)**: review the changes since a fixed point along two axes, standards (does the code follow the project's conventions?) and spec (does it do what was asked?), reported side by side.
- **[codebase-design](./skills/codebase-design/SKILL.md)**: the deep-module vocabulary (module, interface, depth, seam, adapter) and the principles for designing with it, imperative or declarative.
- **[diagnosing-bugs](./skills/diagnosing-bugs/SKILL.md)**: a six-phase diagnosis loop for hard bugs and performance regressions, built around a tight feedback loop rather than an assumed test suite.
- **[domain-modelling](./skills/domain-modelling/SKILL.md)**: build and sharpen the project's domain model as you design, maintaining `CONTEXT.md` and offering ADRs sparingly.
- **[grill](./skills/grill/SKILL.md)**: a relentless interview to sharpen a plan or design. Runs a `/grilling` session.
- **[grill-with-docs](./skills/grill-with-docs/SKILL.md)**: the same interview, capturing glossary terms and ADRs as they resolve.
- **[grilling](./skills/grilling/SKILL.md)**: the interview itself, one question at a time until no open decisions remain.
- **[handoff](./skills/handoff/SKILL.md)**: compact the current conversation into a handoff document in the OS temp dir for a fresh session to pick up.
- **[implement](./skills/implement/SKILL.md)**: work a task or spec end to end, test-first where the project's testing stance allows.
- **[improve-codebase-architecture](./skills/improve-codebase-architecture/SKILL.md)**: scan the codebase for deepening opportunities, present them as a visual HTML report, then grill through the chosen candidate.
- **[tdd](./skills/tdd/SKILL.md)**: the red → green loop with tests at pre-agreed seams, one vertical slice at a time.
- **[to-spec](./skills/to-spec/SKILL.md)**: turn the current conversation into a spec and publish it to the project's task tracker.
- **[to-tasks](./skills/to-tasks/SKILL.md)**: break a plan, spec or conversation into tracer-bullet tasks with blocking edges, published to the task tracker.

## A typical flow

- `/grill` or `/grill-with-docs` a plan.
- `/to-spec` the conversation.
- `/to-tasks` the spec.
- `/implement` the frontier one task at a time.
- `/code-review` the changes.

Refactoring work enters the same flow via `/improve-codebase-architecture`: pick a deepening candidate from its report and continue from the grilling step.

## Credits

These skills are opinionated adaptations of [Matt Pocock's skills](https://github.com/mattpocock/skills).
