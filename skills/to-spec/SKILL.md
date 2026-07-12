---
name: to-spec
description: Turn the current conversation into a spec and publish it to the project's task tracker. No interview, just synthesis of what you've already discussed.
disable-model-invocation: true
---

# To spec

This skill takes the current conversation context and codebase understanding and produces a spec. Do NOT interview the user, just synthesise what you already know. Synthesise only what was discussed or follows directly from it; if a section of the template has no material, write "Not discussed" rather than inventing content.

The task tracker conventions live in `docs/agents/task-tracker.md`. Run `/setup-skills` if that file doesn't exist.

## Process

1. Explore the project to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary throughout the spec and respect any ADRs in the area you're touching (see `docs/agents/domain.md`).

2. Sketch out the seams at which you're going to test the feature. Existing seams should be preferred to new ones. Use the highest seam possible. If new seams are needed, propose them at the highest point you can. The fewer seams across the codebase, the better; the ideal number is one.

   Check with the user that these seams match their expectations. This is the only question this skill asks.

   Whether the project uses tests comes from the `### Testing` stance in the Agent skills block (if the stance is missing, re-run `/setup-skills`). When the project doesn't use tests, skip this step; the spec's Verification section covers checking the change instead.

3. Give the spec a short feature title, write it using the template below, then publish it to the task tracker. The tracker conventions derive the task title or feature slug from the title.

4. End by offering the onward paths: `/to-tasks` to break the spec into tasks when the work is bigger than one session, or `/implement` straight from the spec when it's small. `/tdd` is not an entry point; `/implement` invokes it at the agreed seams.

<spec-template>

## Problem statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User stories

A LONG, numbered list of user stories. Each user story should be in the format of:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>

1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending

</user-story-example>

This list of user stories should be extremely extensive and cover all aspects of the feature.

## Implementation decisions

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it within the relevant decision and note briefly that it came from a prototype. Trim to the decision-rich parts, not a working demo, just the important bits.

## Testing decisions

A list of testing decisions that were made. Include:

- The seams agreed in step 2; `/tdd` treats seams recorded here as confirmed and doesn't re-ask
- A description of what makes a good test (only test external behaviour, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

In a project that doesn't use tests, title this section **Verification** instead and record how the change will be checked by hand: the flows to exercise and what correct looks like.

## Out of scope

A description of the things that are out of scope for this spec.

## Further notes

Any further notes about the feature.

</spec-template>
