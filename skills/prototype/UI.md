# UI prototype

Build several structurally different UI variants on one route. The user switches between them in the browser, chooses a direction or combines parts, then records what the comparison established.

## 1. Pick the host and alternatives

Prefer the existing page where the design belongs, including a new section inside that page. Keep its surrounding navigation, read-only data fetching, parameters and authentication so the comparison has realistic context and density. Stub mutations and use fixtures when real data cannot be read safely.

Only create a new throwaway route when no existing page is a plausible host. Follow the project's routing conventions and make its prototype status obvious in its path or filename.

Default to **three variants**, capped at five. State the question and planned alternatives in a visible prototype note. Each variant must offer a different layout, information hierarchy or primary interaction, not just different colours or copy.

## 2. Build independent variants

Use the project's component library and styling system. Give each variant a clear component name and a short descriptive label, such as `B: Sidebar layout`.

Share existing primitives where helpful, but let each variant choose its own layout. If two variants look like minor tweaks of each other, replace one with a genuinely different structure.

Keep the relevant sample data and state visible and comparable across variants. Note any deliberate differences so the user can distinguish a design choice from a fixture mismatch.

## 3. Gate the whole prototype

Use the project's development-only mechanism to gate variants, prototype routes and switcher together. Hiding only the switcher leaves experimental rendering reachable.

On an existing page, normal rendering stays unchanged without an explicit prototype selection and in production. On a new route, the prototype is unavailable in production. If the framework cannot provide a reliable gate, use a separate local-only demo rather than modifying a production route.

Within that gate, use a `?variant=` search parameter to select a variant. Preserve unrelated query parameters and use the framework's router. On a dedicated prototype route, default to the first variant; on an existing page, absent or invalid selections retain normal rendering.

## 4. Add the floating switcher

Use one shared prototype switcher across the variants, located with the prototype files. Render a small fixed bar at the bottom centre with:

- A previous button that wraps around.
- The current variant key and descriptive label.
- A next button that wraps around.

Use accessible button labels and a visually distinct style so the controls are clearly outside the design being judged. Keep page content reachable behind the bar.

Switching updates the URL so the selection survives reloads and can be shared. Left and right arrow keys may also cycle, but leave keyboard events alone in editable fields, native controls or widgets that use those keys, and when modifiers are held or the event is already handled.

## 5. Verify and hand over

Check every variant URL, reload behaviour, switcher wraparound and query-parameter preservation. Check keyboard controls if provided, ensuring page interactions still work. Confirm mutations are stubbed and relevant state remains visible after switching.

Check normal rendering without prototype selection and verify the production gate using the project's build or preview mechanism. If that is unavailable, report the gate as unverified rather than claiming production isolation.

Provide the start command and variant URLs. Ask which direction works and why; combining the header from one with the layout of another is a valid result.

Return to **Get the human verdict** in [SKILL.md](./SKILL.md). Record the chosen direction without replacing the real page, promoting a route or removing the alternatives. Those changes belong to a separately requested production implementation.
