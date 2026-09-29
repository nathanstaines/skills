---
name: prototype
description: Build a throwaway prototype to answer a design question. Use when exploring a logic or state model, comparing UI directions or working a scout prototype task.
argument-hint: "A design question or a scout prototype task"
---

# Prototype

A prototype is **throwaway code that answers a question**. Its deliverable is evidence and a human verdict, not production code.

## 1. Name the question

Read the surrounding code and any supplied task. State what the prototype must prove or disprove before writing code, including the cases or alternatives the user needs to judge. Use the project's glossary vocabulary for labels and state descriptions, following `docs/agents/domain.md` when present.

When working through `/scout`, use its selected decision task. Scout owns eligibility checks, claiming, resolution and map updates; this skill supplies the prototype and verdict. If invoked directly with a scout task, have the user run `/scout` with that task first rather than bypassing its lifecycle.

Standalone use needs no tracker setup. If the user supplies another tracker reference, read `docs/agents/task-tracker.md`; run `/setup-skills` if those conventions are missing.

## 2. Pick the shape

Read only the guide for the question being answered:

- **Does this logic or state model feel right?** Read [LOGIC.md](./LOGIC.md). Build a self-contained HTML demo with free-play controls and guided scenarios.
- **What should this look like?** Read [UI.md](./UI.md). Build structurally different UI variants on one route with a browser switcher.

If the question is ambiguous, ask before building. If both shapes are needed, agree which uncertainty to tackle first rather than building both at once.

## 3. Build the evidence

Follow the selected guide under these constraints:

- **Clearly disposable.** Locate files near the module or page being explored and name them as prototypes. Follow existing routing conventions.
- **Trivial to run.** A logic demo opens by double-clicking one file. A UI prototype uses one project task-runner command; report that command and the URL.
- **Isolated state.** Use in-memory state and stub mutations. If persistence is the question, use a clearly named scratch database or local file, never production data or credentials.
- **Cheap verification.** Skip automated tests and production hardening for disposable code. Manually exercise every scenario or variant, check state visibility and confirm the run instructions work. If you cannot run it, state what remains unverified.
- **One question.** Keep abstractions and polish to what makes the evidence understandable. Surface the relevant state after actions or variant switches.

## 4. Get the human verdict

Hand over the file or URL, the run instructions and the question to judge. Invite the user to try the awkward cases or compare variants. Iterate on their feedback until they can say what the evidence establishes.

Building can happen independently; validation requires the user's response. Without that response, report **awaiting feedback** and leave the decision unresolved. An inconclusive response calls for a sharper question or another experiment, not an invented verdict.

## 5. Capture and stop

Capture the question, the user's verdict and reasoning, remaining limitations and a pointer to the runnable artefact. Keep observations separate from recommendations.

- **Under scout:** return the answer and artefact pointer to scout for recording on the decision task. Scout handles closing the task and updating the map.
- **Other tracked work:** record them on the supplied task per the tracker conventions.
- **Standalone:** include them in the handover. Ask before creating a separate durable decision record.

Retain the prototype as evidence. A local path is local evidence, not a shareable archive; say so when handing it over. Offer a throwaway branch or another project-appropriate durable location when useful, but only commit, check in or push when explicitly asked. Preserve unrelated work and never switch branches or delete prototype files merely to tidy up.

Stop at the verdict. Production promotion needs a separate explicit request and the project's normal specification, implementation and testing workflow. Prototype code is evidence to learn from, not code already approved to ship.
