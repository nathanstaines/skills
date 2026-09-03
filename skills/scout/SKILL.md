---
name: scout
description: Chart a large, foggy piece of work as a map of decision tasks on the project's task tracker, then resolve them one at a time until the way to a spec is clear.
argument-hint: "A loose idea, or the map to work through"
disable-model-invocation: true
---

A loose idea has arrived, too big for one session and wrapped in fog: the way from here to the **destination** isn't visible yet. Scouting is about finding that way, not charging at the destination. This skill charts the way as a **shared map** in the project's task tracker, then works its **decision tasks** (questions whose resolution is a decision, not slices of a build to execute) one at a time until the route is clear.

The destination is usually a spec worth handing to `/to-spec`. It may instead be a decision to lock before planning starts or a change made in place like a data migration. Naming it is the first act of charting, and it fixes the scope for everything that follows.

The task tracker conventions live in `docs/agents/task-tracker.md`, and scouting's operations are its **Scouting operations** section. Run `/setup-skills` if either is missing.

## Plan, don't do

Scouting produces decisions, not deliverables. The map is done when the way is clear, with nothing consequential left to decide before someone goes and builds the thing. The pull to just do the work is usually the signal you've reached the edge of the map and it's time to hand off.

**Decisions belong upstream in proportion to their blast radius**, and that's what sizes the map. A decision carries blast radius when it constrains several future tasks, sets a project-wide convention, is expensive to reverse or changes what the product promises. Those are the decision tasks. The contract for one piece of work is `/to-spec`'s: its interfaces, its state transitions, the seam it crosses. What is local and reversible is `/implement`'s: filenames, helper names, module layout inside an agreed architecture, configuration syntax. A question you can't attach that kind of consequence to belongs downstream, not on the map.

## Refer by name

Every map and decision task has a **name**: its title. In everything the user reads, refer to it by that name, never by a bare id, number, slug or path. A wall of `#42, #43, #44` is illegible where names read at a glance. The identifier doesn't vanish, it rides inside the name as a link.

## The map

The map is a single artefact in the task tracker, the canonical record of this effort, with its decision tasks hanging off it. Both are tracker-specific: read **Scouting operations** for how this project expresses the map, its tasks, blocking and the frontier query.

The map is an **index**, not a store. It lists the decisions made and points at the decision tasks holding their detail, so a decision lives in exactly one place and the map only gists it and links.

### The map body

The whole map at low resolution, loaded once per session. Open tasks are not listed: they're found by the frontier query.

```markdown
## Destination

<what reaching the end of this map looks like: the spec, decision or change this effort is finding its way to. One or two lines; every session orients to it before choosing a task.>

## Notes

<domain; skills every session should consult; standing preferences for this effort>

## Decisions so far

<!-- the index: one line per resolved task, enough to judge relevance, then follow the link for the detail -->

- [<resolved task title>](link): <one-line gist of the answer>

## Not yet specified

<!-- in-scope fog too dim to write as a task yet; graduates as the frontier advances -->

## Out of scope

<!-- work ruled beyond the destination; closed, never graduates -->
```

### Decision tasks

A decision task's body is the question, sized to one agent session:

```markdown
## Question

<the decision or investigation this task resolves>
```

Each one carries its type, one of `research`, `prototype`, `grill` or `chore`. A session **claims** a task before any work, so a second session skips it. A task is **unblocked** when every task blocking it is resolved, and the **frontier** is the open, unblocked, unclaimed tasks: the edge of the known.

The answer isn't part of the body. It's recorded on resolution. Anything created while resolving a task is linked from it rather than pasted into it.

## Task types

Every decision task is either **HITL** (human in the loop, worked with a user who speaks for themselves) or **AFK**, driven by the agent alone. A HITL task only resolves through that live exchange, and the agent never stands in for the user's side of it: a grill task that answers its own questions has broken this.

- **Grill** (HITL): conversation, and the default case. Run `/grill` for the rounds and `/domain-modelling` alongside it. The task's resolution ends the session, so ignore `/grill`'s own closing fork to `/to-spec`: that route belongs to the map's destination, not to one task.
- **Research** (AFK): reading documentation, third-party APIs or other material outside the project to surface a fact a decision waits on. Dispatch a sub-agent, and keep its findings separate from any recommendation drawn from them. Stop as soon as the decision that prompted the research is resolvable rather than browsing on.
- **Prototype** (HITL): raise the fidelity of the discussion by making something cheap, rough and concrete to react to, a stub, a sketch, a throwaway slice of UI or logic. Name what it must prove or disprove before writing a line of it. Prototype code stays exploratory and is linked as an asset, promoted into the build only when the user says so.
- **Chore** (HITL or AFK): manual work that must happen before a decision can be made. Nothing to decide, prototype or research, but the discussion is blocked until it's done: signing up for a service so its API can be judged, provisioning access, moving data so its shape can be seen. It earns its place by unblocking a decision, not by delivering the destination. Drive it alone where you can, otherwise hand the user a precise checklist. The answer records what was done and any facts later tasks depend on, like where credentials live or how many rows there were.

## Fog of war

The map is deliberately incomplete: don't chart what you can't yet see. Beyond the live tasks lies the **fog of war**, the dim view of decisions you can tell are coming but can't pin down, because they hang on questions still open. Resolving a task clears the fog ahead of it, graduating whatever's now specifiable into fresh tasks, until the way to the destination is clear and none remain.

The map's **Not yet specified** section is where that dim view is written down: the suspected question, the area to revisit. Everything there is in scope, just not sharp enough to write as a task, and it doubles as a signpost for anyone reading where the effort is headed.

**Fog or task?** The test is whether you can state the question precisely now, not whether you can answer it now.

- **A task** when the question is already sharp, even if it's blocked and you can't act on it yet.
- **Not yet specified** when you can't yet phrase it that sharply. One patch of fog may graduate into several tasks, or none, so leave it coarse rather than pre-slicing it into task-sized pieces.

**Not yet specified** excludes what's already decided, what's already a live task and what's out of scope.

## Out of scope

Fog only ever gathers toward the destination, so work beyond it is **out of scope** rather than fog, and gets its own section on the map. Scope, not sharpness, lands it there.

Out-of-scope work never graduates, so it returns only if the destination is redrawn, and then as a fresh effort rather than a resumption.

When a task turns out to sit past the destination, mis-scoped in while charting or exposed by a later answer, close it (a closed task is unambiguously off the frontier) and leave one line under **Out of scope**: the gist, why it's out and a link to the closed task. It stays out of **Decisions so far**, which records the route actually walked.

## Greenfield projects

An empty project is a valid starting point, and the absence of code is not a reason to invent an architecture. Charting one runs the same way, with three affordances.

**The project needs a tracker before it can hold a map.** Run `/setup-skills` first when `docs/agents/` doesn't exist. It also records the testing stance, so where tests live and whether they're written at all comes from setup rather than a task.

**The foundation is where the fog is.** Nothing can be inspected, so the early tasks cover what implementation would otherwise have to invent: application shape and runtime, language and framework, package or workspace shape, persistence, identity and authentication boundaries, external interface style, deployment target, the boundary between domain and infrastructure. Each earns a task on the same terms as any other question, so a destination that never touches identity leaves authentication off the map entirely.

**Foundation decisions sit at the altitude of a constraint**, never a scaffold:

```text
Application
- single TypeScript web application
- Next.js App Router

Persistence
- PostgreSQL
- migrations in source control

Delivery
- deployable to Vercel
- CI runs typechecking and tests
```

The stack there is illustration; the altitude is the point. The first tracer bullet establishes the rest, the exact paths, directory trees, install commands and literal configuration files, by initialising the chosen framework and cutting the first agreed test seam as part of delivering real behaviour. That keeps the first task vertical instead of a horizontal "set the project up".

**Scout chooses the project-wide constraint. Implementation realises it when behaviour first needs it.**

## Invocation

The argument picks the mode: an argument naming a map works through it, anything else charts a new one. Before charting, look for a map that already covers this idea and work through that rather than starting a second one for the same effort.

Either way, resolve no more than one decision task per session. Research is excepted only when delegated to sub-agents. When sub-agents are unavailable, leave research tasks open rather than resolving them in the current session.

### Chart the map

The user invokes with a loose idea.

1. **Name the destination.** Run `/grill` and `/domain-modelling` to pin down what this map is finding its way to. The destination fixes the scope, so it's settled first.
2. **Map the frontier.** Grill again, **breadth-first** this time: fan out across the whole space rather than deep on any one thread, surfacing the open decisions and the first ones takeable now. **If this surfaces no fog**, the way is already clear and the whole journey fits one session, so the effort doesn't need a map. Stop and ask the user how they'd like to proceed, `/grill` and `/to-spec` being the usual answer.
3. **Create the map** per the tracker's Scouting operations: Destination and Notes filled in, Decisions so far empty, the fog sketched into **Not yet specified**.
4. **Create the tasks you can specify now**, then wire the blocking edges in a second pass, since they need identifiers before they can reference each other. Wiring sorts them into the frontier and the blocked, and everything you can't yet specify stays in the fog.
5. **If sub-agents are available, fire them** for each research task just created, resolving them in parallel and linking their findings from the task.
6. Stop. Charting is one session's work and it hand-resolves nothing.

### Work through the map

The user invokes with a map. A task is optional: without one, you pick the next decision, not the user.

1. Load the **map**, the low-resolution view, not every task body.
2. Choose the task. Use the one the user named, otherwise take the first frontier task in order. **Claim it** before any work.
3. Resolve it by its type, running whichever skills the **Notes** block names. Zoom in on demand: fetch the full body of a related or resolved task when you need its detail.
4. Record the resolution against the task, clear its claim status as part of closing it and append its one-line gist and link to the map's **Decisions so far**.
5. Add newly surfaced tasks, create then wire, then graduate any fog the answer has sharpened, clearing each graduated patch from **Not yet specified** so it lives only as its task. An answer that puts a task past the destination rules it out of scope; an answer that invalidates part of the map updates or deletes those tasks.

## Reaching the destination

The map is complete when no tasks remain, no fog is left in **Not yet specified** and a fresh session could turn **Decisions so far** into a coherent implementation contract without inventing anything consequential. The target is not zero uncertainty, it's no uncertainty with enough blast radius to belong upstream of implementation.

Before declaring it, read **Decisions so far** as a whole and check the route holds together: against the destination, existing project constraints, domain invariants, ADRs and the testing stance. Two decisions that can't both hold get surfaced and resolved here, because a contradiction passed downstream becomes a broken spec.

Then summarise: the destination; the decisions and their consequences; the risks investigated and what came back; what was deliberately left to implementation. Offer the onward paths in `/grill`'s question format: `/to-spec` to turn the map into a spec, or another round of scouting on a named uncertainty. Do nothing until an option is picked. `/to-spec` is a user-run command you can't invoke, so when it's picked, mark the map done per the Scouting operations, tell the user to run it and stop. Never synthesise the spec yourself.
