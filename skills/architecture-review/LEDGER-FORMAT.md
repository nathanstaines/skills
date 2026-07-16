# Review ledger format

The ledger is the review's memory. It lives at `docs/agents/architecture-review-ledger.md` in the project under review, and its one job is to stop a later run re-proposing a candidate the user has already turned down or parked.

Create the file lazily, only when the first triage produces a `no` or a `maybe-later`.

## Template

```md
# Architecture review ledger

Candidates already triaged. `/architecture-review` reads this before proposing anything.

## Order intake spread across four shallow modules

- **Date**: 2026-07-16
- **Disposition**: no
- **Reason**: the split mirrors the team split; merging it would cross an ownership line.
- **Files**: `src/order/intake.ts` (84), `src/order/validate.ts` (37), `src/order/normalise.ts` (52), `src/order/dispatch.ts` (61)
- **Signature**: intake logic reads across four modules whose interfaces are each about as complex as their implementations.
- **See also**: ADR-0007
```

Newest entry first. The heading is the candidate as the report titled it, so the two are recognisable as the same thing.

`See also` is optional: link the ADR when a load-bearing `no` produced one, or the task when a `maybe-later` was captured per `docs/agents/task-tracker.md`. A `maybe-later` suppresses on the strength of its ledger entry whether or not a task exists.

## Fingerprint

`Files` and `Signature` together are the fingerprint. A dismissal is a judgement about a shape in the code, so it holds exactly as long as that shape does.

- **Files**: every file the candidate rested on, each with its line count at the time of dismissal. Line counts are a cheap, VCS-neutral change signal; don't reach for hashes or history, the project may not use git.
- **Signature**: one sentence naming the structural claim that made this a candidate. Write the claim, not the fix. "Four shallow modules with interfaces as complex as their implementations" is a signature; "merge the intake modules" is a proposal.

## Reading the ledger

Suppress a candidate when its fingerprint still matches: the files are broadly the ones listed, at broadly the sizes listed, and the signature still describes what's there. Broadly is deliberate; a few lines either way is noise, not a change of shape.

Re-surface it when the shape has moved on: listed files gone, renamed or split; line counts shifted enough that the module isn't the one that was dismissed; or the signature no longer describing the code, whatever the line counts say. The matching is a judgement rather than a string compare, and the anchors exist to make it an informed one.

A re-surfaced candidate appears as an ordinary card that notes it was previously dismissed and what changed since.

## Writing over an old entry

One entry per candidate, however many times it has been through triage. When a re-surfaced candidate is dismissed again, rewrite its existing entry in place with the new date, reason and fingerprint rather than appending a second one; two entries under one heading means two fingerprints competing to answer the same question. The old reason is superseded, not history worth keeping. Change of disposition works the same way: a `maybe-later` that becomes a `no` is an edit to one entry.

Delete an entry outright when every file it lists is gone. The shape it described can't recur because the code doesn't exist.
