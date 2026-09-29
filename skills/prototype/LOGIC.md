# Logic prototype

Build one self-contained HTML file that lets a non-developer drive a logic or state model. This shape explores business rules, transitions or data shape through concrete cases rather than judging appearance.

## 1. Show the question

Put the question and the model being explored in a visible introduction at the top of the demo. State any simplifying assumptions so the user knows what the demo cannot establish.

## 2. Separate the model from the page

Keep the logic in a small module inside an inline `<script>` block. Choose the shape that fits the question:

- A reducer for discrete actions over one state value.
- An explicit state machine when legal transitions are the uncertainty.
- Pure functions over plain data for transformations.
- A module with a clear method surface when the model owns ongoing internal state.

The page calls the model and renders its results. Keep DOM access and button handlers outside the model so presentation cannot silently change the rules. This separation makes the evidence inspectable; it does not make the model production-ready.

## 3. Build the shareable demo

Use inline HTML, CSS and JavaScript with no framework, bundler, server or external assets. The file must work when opened directly and remain usable when shared on its own.

Lay it out in this order:

1. **Title and question.** What this demo lets the user explore.
2. **Current state.** All relevant state as labelled fields in domain language, not just raw JSON. Re-render after each action and call out changes where helpful.
3. **Free-play controls.** One control per action, allowing the user to try actions in any order. Illegal attempts should visibly explain their rejection and leave state unchanged.
4. **Guided walkthroughs.** One scenario per tab, each with a plain-language situation, what to watch for and ordered action buttons. Starting a walkthrough resets to a known initial state; each step performs the actual model action. If free play interrupts a walkthrough, require a restart before continuing its guided steps.
5. **Reset.** A way to return free play to a known initial state.

Cover the happy path, an awkward edge case and an attempt at something that should be illegal. Keep the typography and layout readable, with state and controls taking priority over decoration.

## 4. Verify and hand over

Open the file directly. Exercise each walkthrough, free-play controls, illegal actions and reset. Check that displayed state matches the model after each action and that restarting a scenario reproduces it.

Hand over the file for the user to explore. Feedback such as "that shouldn't be possible" or "I assumed this meant something else" is evidence about the idea, not a reason to silently change the rules. Clarify the expectation and revise the demo as needed.

Return to **Get the human verdict** in [SKILL.md](./SKILL.md). Both the page and its model remain exploratory; any later production implementation follows the project's normal workflow.
