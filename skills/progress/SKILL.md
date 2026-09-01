---
name: progress
description: Show the state of every feature in the task tracker at a glance: what's done, what's in flight, what's startable now and which specs are still waiting on a path.
disable-model-invocation: true
---

# Progress

Answer one question in one screen: **where is this project, and what should I pick up next?**

The task tracker conventions live in `docs/agents/task-tracker.md`. Run `/setup-skills` if that file doesn't exist.

This skill only reads. It never changes a status, never publishes and never closes anything; acting on what it surfaces is `/implement`'s job, or the user's.

## Process

### 1. Read the tracker

**Local markdown**: read every `.scratchpad/*/spec.md`, every `.scratchpad/*/tasks/*.md` and every `.scratchpad/*/scout-map.md` with its `decisions/*.md`. Take the frontmatter block and the title line from each and stop there. The bodies are long and nothing in this report needs them, so reading them only burns the context the user wants left for the work itself.

**GitHub**: `gh issue list --state all --json number,title,state,labels,body`, grouping tasks under the `Spec:` issue each one references and decision tasks under their `Scout:` map.

Then apply the tracker's rule for which signal counts: where a feature has tasks, the tasks are the truth and the spec's own status is ignored; where it has none, the spec's status is.

The states named through the rest of this skill (`open`, `in-progress`, `blocked`, `done` and the spec states) are the local tracker's vocabulary. On GitHub they map to labels, issue open/closed state and the native `updatedAt`, exactly as that tracker's Status section defines; read them there rather than expecting a frontmatter block.

### 2. Check the edges hold

Before reporting, look for the states that mean the tracker itself is wrong rather than the work being behind:

- a `blocked_by` naming a task number that doesn't exist in the feature
- a task marked `blocked` whose blockers are all `done` (it belongs on the frontier and isn't being seen)
- a task marked `open` or `in-progress` whose blockers are *not* all done (work started out of order)
- a cycle in the blocking edges
- `in-progress` with an `updated` more than a few days old, which on a decision task is a claim left behind by a session that died
- a map with no open decision tasks and nothing left in **Not yet specified**, which has reached its destination and is waiting on `/to-spec`

Report these under **Needs attention**, each naming the file. Don't fix them; a wrong edge is usually a decision the user needs to make, not a typo.

### 3. Report

Lead with what to do next, not with the inventory. Order features by most recently updated, and fold finished ones to a single line each so the view doesn't degrade as `.scratchpad/` fills up.

<report-shape>

## Start next

- **payment-retries** `03-retry-backoff`: blockers clear
- **payment-retries** `04-dead-letter-queue`: blockers clear

## In flight

- **payment-retries** `02-idempotency-keys`: in-progress since 2026-07-27, 2 of 4 criteria ticked

## Being scouted

- **realtime-collab**: 4 of 11 decisions resolved, frontier `Decision: which document model`. 2 patches of fog still unspecified.

## Specs awaiting a path

- **audit-log-export**: draft, 23 days old. `/to-tasks` to break it down, or `/implement` if it's still small.

## Features

| Feature | Progress | State |
| --- | --- | --- |
| payment-retries | 2/6 | 1 in flight, 2 on the frontier |
| audit-log-export | n/a | spec, draft |
| realtime-collab | 4/11 | map, being scouted |

## Needs attention

- `payment-retries/tasks/05-alerting.md`: blocked by `07`, which doesn't exist

## Done

- **session-timeouts**: 5/5, done 2026-07-11

</report-shape>

Show the frontier even when it's empty, and say why it's empty: everything's done, everything's blocked, or there's nothing published yet. An empty section with no explanation reads as a bug in this skill.

End by naming the single task you'd pick up next and why, then stop. Don't run `/implement` yourself; each task gets its own fresh session.
