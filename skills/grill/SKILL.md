---
name: grill
description: Grill the user relentlessly about a plan, decision or idea. Use when the user wants to stress-test their thinking or uses any 'grill' trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map this as a decision tree: every decision branches into the decisions that hang off it.

Work the tree in rounds. The frontier is every decision whose prerequisites are already settled, the questions you can ask now without guessing at answers you haven't heard yet. Ask the whole frontier in one round, then wait for the user's answers before the next round. The frontier only ever holds independent, answerable-now questions, so a round is never a bewildering wall: a question whose answer depends on another still open in this round belongs to a later round, not this one.

Open each round with a `## Round N` header and one or two sentences of what is already settled, so the user reads the questions in context.

Format a round like so:

```
❓ **Q1** - **<question title>**: <question body, in a sentence or two>

- **A.** <option>
- **B.** <option>
- **C.** <option>
- **D.** <option>

➡️ **Recommended: B** - <why this one, in a sentence or two>

---

❓ **Q2** - **<question title>**: <question body, in a sentence or two>

- **A.** <option>
- **B.** <option>

➡️ **Recommended: A** - <why this one, in a sentence or two>
```

Answer a round as `1B, 2A, 3C`, off-menu in prose or `Accept all` to take every recommendation.

List options when the decision has natural discrete alternatives and keep the question open when it doesn't. Give as many options as the decision actually has, usually two or three. Options are a menu, not a fence: the user may always answer off-menu.

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round.

Finding facts is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it rather than asking the user. If sub-agents are unavailable, investigate it directly. While a sub-agent runs, treat its exploration as an unsettled prerequisite: ask the rest of the frontier now; only questions downstream of its report wait. The decisions are the user's, put each one to them and wait.

The session is done when the frontier is empty: every branch of the tree visited, nothing left silently assumed. Then write up what was agreed and ask the user to confirm it. Confirming and deciding what happens next are separate. The confirm question uses the same format, with the onward paths as its options: build it now, capture it with `/to-spec` or revise. Recommend `/to-spec` when the work is bigger than one session and building directly when it's small. Do nothing until an option is picked. `/to-spec` is a user-run command you can't invoke: if the capture path is picked, tell the user to run `/to-spec` and stop. Never synthesise the spec yourself.
