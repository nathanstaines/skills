---
name: codebase-design
description: Shared vocabulary for designing deep modules. Use when the user wants to design or improve a module's interface, find deepening opportunities, decide where a seam goes or make code more verifiable or AI-navigable. Also use when another skill needs the deep-module vocabulary.
---

# Codebase design

Design **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam, verifiable through that interface. Use this language and these principles wherever something with an interface is being designed or restructured, whatever it's made of: imperative code, stylesheets, design tokens, configuration. The aim is leverage for callers, locality for maintainers and verifiability for everyone.

"Caller" throughout means any consumer of the interface: code that calls a function, a stylesheet that `@use`s a partial, markup that applies a class, a build that reads a config.

## Glossary

Use these terms exactly; don't substitute "component", "service", "API" or "boundary". Consistent language is the whole point.

**Module**: anything with an interface and an implementation. Deliberately scale-agnostic and substance-agnostic: a function, class, package, SCSS partial, design-token layer or tier-spanning slice. _Avoid_: unit, component, service.

**Interface**: everything a caller must know to use the module correctly: the type signature, but also invariants, ordering constraints, error modes, required configuration and performance characteristics. In declarative code that includes the mixins, functions, variables and custom properties exposed, plus whatever markup structure, cascade position or load order the module assumes. _Avoid_: API, signature (too narrow; they name only the type-level surface).

**Implementation**: what's inside a module, its body of code. Distinct from **adapter**: a thing can be a small adapter with a large implementation (a Postgres repository) or a large adapter with a small implementation (an in-memory fake). Reach for "adapter" when the seam is the topic; "implementation" otherwise.

**Depth**: leverage at the interface: the amount of behaviour a caller (or check) can exercise per unit of interface they have to learn. A module is **deep** when a large amount of behaviour sits behind a small interface, **shallow** when the interface is nearly as complex as the implementation.

**Seam** _(Michael Feathers)_: a place where you can alter behaviour without editing in that place; the *location* at which a module's interface lives. Where to put the seam is its own design decision, distinct from what goes behind it. _Avoid_: boundary (overloaded with DDD's bounded context).

**Adapter**: a concrete thing that satisfies an interface at a seam. Describes *role* (what slot it fills), not substance (what's inside). A theme satisfying a token contract is as much an adapter as an HTTP client satisfying a port.

**Leverage**: what callers get from depth: more capability per unit of interface they learn. One implementation pays back across N call sites and M checks.

**Locality**: what maintainers get from depth: change, bugs, knowledge and verification concentrate in one place rather than spreading across callers. Fix once, fixed everywhere.

## Deep vs shallow

**Deep module** = small interface + lots of implementation:

```
┌─────────────────────┐
│   Small interface   │  ← Few entry points, simple params
├─────────────────────┤
│                     │
│ Deep implementation │  ← Complex logic hidden
│                     │
└─────────────────────┘
```

**Shallow module** = large interface + little implementation (avoid):

```
┌─────────────────────────────────┐
│       Large interface           │  ← Many entry points, complex params
├─────────────────────────────────┤
│  Thin implementation            │  ← Just passes through
└─────────────────────────────────┘
```

Depth is substance-agnostic. A `pagination($total, $current)` mixin that hides layout, states and responsive behaviour is deep; a `$button-border-radius` variable that renames one CSS property is shallow. A `parseSchedule(text)` function that hides a grammar is deep; a `getName()` wrapper over `.name` is shallow.

When designing an interface, ask:

- Can I reduce the number of entry points?
- Can I simplify the parameters?
- Can I hide more complexity inside?

## Principles

- **Depth is a property of the interface, not the implementation.** A deep module can be internally composed of small, swappable parts; they just aren't part of the interface. A module can have **internal seams** (private to its implementation, used by its own checks) as well as the **external seam** at its interface.
- **The deletion test.** Imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across N callers, it was earning its keep.
- **The interface is the verification surface.** Callers and checks cross the same seam, whether the check is a unit test calling a function, a snapshot of compiled output, visual regression over rendered states or a manual verification flow. If verifying means reaching past the interface, the module is probably the wrong shape.
- **One adapter means a hypothetical seam. Two adapters means a real one.** Don't introduce a seam unless something actually varies across it.

## Designing for verifiability

Good interfaces make verification natural:

1. **Accept dependencies, don't create them.**

   ```typescript
   // Verifiable
   function processOrder(order, paymentGateway) {}

   // Hard to verify
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

   ```scss
   // Verifiable: the theme enters at the seam
   @mixin badge($palette) { /* ... */ }

   // Hard to vary: reaches past the seam for a global
   @mixin badge() { color: $brand-colour; }
   ```

2. **Return results, don't produce side effects.**

   ```typescript
   // Verifiable
   function calculateDiscount(cart): Discount {}

   // Hard to verify
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

   ```scss
   // Verifiable: emits CSS only where included
   @mixin visually-hidden { /* ... */ }

   // Side effect: emits CSS the moment the file is @used
   * { box-sizing: border-box; }
   ```

3. **Small surface area.** Fewer entry points mean fewer checks needed. Fewer parameters mean simpler setup.

## Relationships

- A **module** has exactly one **interface** (the surface it presents to callers and checks).
- **Depth** is a property of a **module**, measured against its **interface**.
- A **seam** is where a **module**'s **interface** lives.
- An **adapter** sits at a **seam** and satisfies the **interface**.
- **Depth** produces **leverage** for callers and **locality** for maintainers.

## Rejected framings

- **Depth as a ratio of implementation lines to interface lines** (Ousterhout): rewards padding the implementation. Use depth-as-leverage instead.
- **"Interface" as a language's `interface` keyword or a class's public methods**: too narrow; interface here includes every fact a caller must know.
- **"Boundary"**: overloaded with DDD's bounded context. Say **seam** or **interface**.

## Going deeper

- **Deepening a cluster given its dependencies**: see [DEEPENING.md](./DEEPENING.md) for dependency categories, seam discipline and replace-don't-layer verification.
- **Exploring alternative interfaces**: see [DESIGN-IT-TWICE.md](./DESIGN-IT-TWICE.md) for the parallel sub-agent pattern that designs the interface several radically different ways, then compares on depth, locality and seam placement.
