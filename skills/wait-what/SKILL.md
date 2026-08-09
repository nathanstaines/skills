---
name: wait-what
description: Stop. That last message did not land. Re-pitch it.
argument-hint: "Which part lost you?"
disable-model-invocation: true
---

# Wait, what?

Your last message did not land. Re-pitch it: same position, rebuilt from the ground up. Assume none of the previous framing survived, so reach for a different explanation rather than a louder one.

Open with context. Where the work has got to, what question the message was answering and why it matters here. Then make the point.

Write the whole re-pitch in ASD-STE100 Simplified Technical English: one idea per sentence, short sentences, active voice, simple present tense and the same word for the same thing every time.

Name domain concepts with the project's glossary terms, per `docs/agents/domain.md`. Where the glossary defines a term, use that term throughout.

If the user passed arguments, treat them as the part that lost them and rebuild from there.

If the message was wrong rather than unclear, say so in a sentence and pitch the correct position instead.
