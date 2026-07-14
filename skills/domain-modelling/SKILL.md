---
name: domain-modelling
description: Build and sharpen a project's domain model. Use when the user wants to pin down domain terminology or a ubiquitous language, when an architectural decision needs recording or when another skill needs to maintain the domain model.
---

# Domain modelling

Actively build and sharpen the project's domain model as you design. This is the *active* discipline: challenging terms, inventing edge-case scenarios and writing the glossary and decisions down the moment they crystallise. (Merely *reading* `CONTEXT.md` for vocabulary is not this skill; that's a one-line habit any skill can do. This skill is for when you're changing the model, not just consuming it.)

## Where the files live

The project's domain doc layout (single-context or multi-context) lives in `docs/agents/domain.md`. When that file doesn't exist, assume the single-context default (`CONTEXT.md` and `docs/adr/` at the project root) and suggest running `/setup-skills` at the end of the session rather than blocking on it.

Create files lazily, only when you have something to write. If no `CONTEXT.md` exists, create one when the first term is resolved. If no `docs/adr/` exists, create it when the first ADR is needed. In a multi-context project, infer which context the current topic relates to; if unclear, ask.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in `CONTEXT.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account'. Do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. When you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible. Which is right?"

### Update CONTEXT.md inline

When a term is resolved, update `CONTEXT.md` right there. Don't batch these up; capture them as they happen. Use the format in [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` stays totally devoid of implementation details. Don't treat it as a spec, a scratch pad or a repository for implementation decisions. It is a glossary and nothing else.

### Offer ADRs sparingly

Only offer to create an ADR when all three are true:

1. **Hard to reverse**: the cost of changing your mind later is meaningful
2. **Surprising without context**: a future reader will wonder "why did they do it this way?"
3. **The result of a real trade-off**: there were genuine alternatives and you picked one for specific reasons

If any of the three is missing, skip the ADR. Create it in the relevant `docs/adr/` with the next sequential number: list the directory first and increment from the highest existing prefix, never defaulting to `0001`. Use the format in [ADR-FORMAT.md](./ADR-FORMAT.md).
