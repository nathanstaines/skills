---
name: grilling
description: Grill the user relentlessly about a plan or design. Use when the user wants to stress-test a plan before building or uses any 'grill' trigger phrases.
---

Interview the user relentlessly about every aspect of this plan until no open decisions remain. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask questions one at a time, waiting for feedback on each question before continuing. Asking multiple questions at once is bewildering. When a question has a small set of concrete options, present it with the AskUserQuestion tool, recommended answer first.

If a *fact* can be found by exploring the codebase, look it up rather than asking the user. The *decisions*, though, are the user's - present each one to them and wait for an answer.

When no open decisions remain, write up the agreed plan and ask the user to confirm it. Confirming the plan and deciding what happens next are separate: the confirm question offers the onward paths as options - build it now, capture it with `/to-spec`, or revise the plan. Recommend `/to-spec` when the work is bigger than one session and building directly when it's small. Do nothing until an option is picked.
