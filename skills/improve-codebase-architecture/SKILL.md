---
name: improve-codebase-architecture
description: Scan a codebase, or a named area of it, for deepening opportunities, present them as a visual HTML report, then grill through whichever one the user picks.
disable-model-invocation: true
---

# Improve codebase architecture

Surface architectural friction and propose **deepening opportunities**: refactors that turn shallow modules into deep ones. The aim is verifiability and AI-navigability: fewer, deeper modules mean fewer files an agent must read before it can act safely. Any codebase with interfaces qualifies, imperative or declarative; the friction signals differ, the vocabulary doesn't.

This command is informed by the project's domain model and built on a shared design vocabulary:

- Run the `/codebase-design` skill for the architecture vocabulary (**module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, **locality**) and its principles (the deletion test, "the interface is the verification surface", "one adapter = hypothetical seam, two = real"). Use these terms exactly in every suggestion; don't drift into "component", "service", "API" or "boundary".
- The domain doc conventions live in `docs/agents/domain.md`: the glossary gives names to good seams, and ADRs record decisions this command doesn't re-litigate.

## Process

### 1. Explore

Read the project's domain docs first, per `docs/agents/domain.md`.

When the user names a scope, confine the scan to it; otherwise walk the whole project. A scope can be spatial (a path, a feature) or by substance (only the `.scss`, only the token layer). Reading outside the scope to understand callers is fine; proposing candidates outside it isn't. On a large codebase an unscoped scan dilutes the report, so suggest a scope before starting rather than pressing on with a noisy one.

Then use the Agent tool with `subagent_type=Explore` to walk the scoped codebase. Don't follow rigid heuristics; explore organically and note where you experience friction:

- Where does understanding one concept require bouncing between many small modules?
- Where are modules **shallow**, the interface nearly as complex as the implementation?
- Where have small pieces been extracted just for testability, while the real bugs hide in how they're combined (no **locality**)?
- Where do tightly coupled modules leak across their seams?
- Where do variables or tokens rename what they configure one-to-one instead of abstracting it?
- Where must a caller know a module's internals (markup structure, cascade position, call order) to use it correctly?
- Which parts of the codebase are unverified, or hard to verify through their current interface?

Apply the **deletion test** to anything you suspect is shallow: would deleting it concentrate complexity, or just move it? A "yes, concentrates" is the signal you want.

If sub-agents aren't available in the environment, explore directly.

### 2. Present candidates as an HTML report

Write a self-contained HTML file to the OS temp directory so nothing lands in the project. Resolve the temp dir from `$TMPDIR`, falling back to `/tmp` (or `%TEMP%` on Windows), and write to `<tmpdir>/architecture-review-<timestamp>.html` so each run gets a fresh file. Open it for the user (`xdg-open <path>` on Linux, `open <path>` on macOS, `start <path>` on Windows) and tell them the absolute path.

The report uses **Tailwind via CDN** for layout and styling, and **Mermaid via CDN** for diagrams where a graph, flow or sequence reliably communicates the structure. Mix Mermaid with hand-crafted CSS/SVG visuals: Mermaid when relationships are graph-shaped (call graphs, dependencies, sequences), hand-built divs and SVG when you want something more editorial (mass diagrams, cross-sections, collapse animations). Each candidate gets a **before/after visualisation**. Be visual.

For each candidate, render a card with:

- **Files**: which files or modules are involved
- **Problem**: why the current architecture is causing friction
- **Solution**: plain English description of what would change
- **Benefits**: explained in terms of locality and leverage, and how verification would improve
- **Before/after diagram**: side by side, custom-drawn, illustrating the shallowness and the deepening
- **Recommendation strength**: one of `Strong`, `Worth exploring`, `Speculative`, rendered as a badge

End the report with a **top recommendation** section: which candidate to tackle first and why.

**Use the domain glossary's vocabulary for the domain and the `/codebase-design` vocabulary for the architecture.** If the glossary defines "Order", talk about "the Order intake module", not "the FooBarHandler" and not "the Order service".

**ADR conflicts**: when a candidate contradicts an existing ADR, only surface it when the friction is real enough to warrant revisiting the ADR. Mark it clearly in the card (a warning callout: *"contradicts ADR-0007, but worth reopening because…"*). Don't list every theoretical refactor an ADR forbids.

See [HTML-REPORT.md](./HTML-REPORT.md) for the full HTML scaffold, diagram patterns and styling guidance.

Do NOT propose interfaces yet. After the file is written, ask which candidate to explore: one AskUserQuestion, the top recommendation first.

### 3. Grill the chosen candidate

Once the user picks a candidate, run the `/grilling` skill to walk the decision tree with them: constraints, dependencies and their categories (per `/codebase-design`'s DEEPENING.md), the shape of the deepened module, what sits behind the seam, which checks survive.

Side effects happen inline as decisions crystallise; run the `/domain-modelling` skill to keep the domain model current:

- **Naming a deepened module after a concept the glossary lacks?** Add the term.
- **Sharpening a fuzzy term during the conversation?** Update the glossary right there.
- **The user rejects a candidate for a load-bearing reason?** That's ADR material precisely when a future review would otherwise re-suggest the same thing; offer one per `/domain-modelling`'s criteria and skip ephemeral reasons ("not worth it right now").
- **Exploring alternative interfaces for the deepened module?** Use `/codebase-design`'s design-it-twice pattern.

Grilling ends with its usual routing fork (build it now, capture with `/to-spec` or revise). From there the deepening is an ordinary feature: each onward step (`/to-tasks`, `/implement`) is offered by the skill that precedes it, never run unprompted.

The report file is temporary, so once the routing fork resolves, offer to capture any remaining `Strong` candidates before they're lost: as tasks per the tracker conventions in `docs/agents/task-tracker.md`, or as a note wherever the user prefers. Don't publish them unasked; unpicked candidates are the user's call, not backlog filler.
