# Working the yes-queue

A run of `/architecture-review` ends once every candidate is triaged and the ledger is written. Grilling the candidates the user said yes to is a separate session, started from a handoff so it begins with a clean context. This doc is what that session follows; it assumes the review itself is over and its report is on disk.

## What you are picking up

The handoff names the paths. Read them before grilling anything:

- **The report**, a self-contained HTML file in the OS temp directory. It holds each candidate's files, problem, solution, benefits and recommendation strength. The yes-queue is a subset of its cards.
- **The ledger** at `docs/agents/architecture-review-ledger.md` in the project under review. It records what the user turned down and why, so it settles questions rather than reopening them. Its format is in [LEDGER-FORMAT.md](./LEDGER-FORMAT.md).
- **The domain docs**, per `docs/agents/domain.md`. The glossary names the concepts; the ADRs record decisions this session doesn't re-litigate.

Run the `/codebase-design` skill for the architecture vocabulary (**module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, **locality**). Use those terms exactly, and the glossary's terms for the domain. Don't drift into "component", "service", "API" or "boundary".

If the report is missing from the temp directory, say so rather than reconstructing it from memory. The candidates were argued from evidence that isn't in this session, and a re-run of `/architecture-review` is the honest way back.

## The loop

Grill the candidates one at a time, top recommendation first, finishing one before starting the next. A candidate is finished when its grill reaches the routing fork and the user picks a route, not when the argument feels settled.

Run the `/grill` skill for each one. The decision tree to walk:

- The constraints the deepening has to hold.
- Its dependencies and their categories, per `/codebase-design`'s DEEPENING.md.
- The shape of the deepened module: its interface, and what sits behind the seam.
- Which checks survive the change, and which have to be rewritten.

Grilling ends with its usual routing fork: build it now, capture with `/to-spec`, or revise. Do nothing until the user picks one. From there the deepening is an ordinary feature, and each onward step (`/to-tasks`, `/implement`) is offered by the skill that precedes it, never run unprompted.

## Side effects

Decisions crystallise mid-grill. Run the `/domain-modelling` skill to keep the domain model current as they do, rather than saving them for the end:

- **Naming a deepened module after a concept the glossary lacks?** Add the term.
- **Sharpening a fuzzy term during the conversation?** Update the glossary right there.
- **The user rejects a candidate mid-grill for a load-bearing reason?** That's ADR material; offer one per `/domain-modelling`'s criteria.
- **Exploring alternative interfaces for the deepened module?** Use `/codebase-design`'s design-it-twice pattern.

## When a grill changes the answer

A grill that talks the user out of a candidate has turned a `yes` into a `no` or a `maybe-later`. Offer a ledger entry for it, per [LEDGER-FORMAT.md](./LEDGER-FORMAT.md), and write it while the reason is fresh. An ephemeral reason ("not worth it right now") is too thin for an ADR and too real to lose, so the ledger is where it belongs. A load-bearing one earns an ADR as well, linked from the entry.

Fingerprinting a candidate at this point means reading the files for their current line counts. The report's figures are from the review session and the code may have moved since.
