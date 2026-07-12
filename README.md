# Skills

A set of agent skills used for engineering.

## Skills

- **[setup-skills](./skills/setup-skills/SKILL.md)**: configure a project for the engineering skills (task tracker, domain doc layout and testing stance). Run once per project before first use of the others.
- **[grill](./skills/grill/SKILL.md)**: a relentless interview to sharpen a plan or design. Runs a `/grilling` session.
- **[grilling](./skills/grilling/SKILL.md)**: the interview itself, one question at a time until no open decisions remain.
- **[to-spec](./skills/to-spec/SKILL.md)**: turn the current conversation into a spec and publish it to the project's task tracker.
- **[to-tasks](./skills/to-tasks/SKILL.md)**: break a plan, spec or conversation into tracer-bullet tasks with blocking edges, published to the task tracker.
- **[domain-modelling](./skills/domain-modelling/SKILL.md)**: build and sharpen the project's domain model as you design, maintaining `CONTEXT.md` and offering ADRs sparingly.
- **[tdd](./skills/tdd/SKILL.md)**: the red → green loop with tests at pre-agreed seams, one vertical slice at a time.

A typical flow: `/grill` a plan, `/to-spec` the conversation, `/to-tasks` the spec, then work the frontier, with `/domain-modelling` keeping the glossary and ADRs sharp throughout.

## Installation

1. Run the skills.sh installer:

```bash
npx skills@latest add nathanstaines/skills
```

2. Pick the skills you want.

## Credits

These skills are opinionated adaptations of [Matt Pocock's skills](https://github.com/mattpocock/skills).
