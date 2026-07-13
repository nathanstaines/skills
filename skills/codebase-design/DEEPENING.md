# Deepening

How to deepen a cluster of shallow modules safely, given its dependencies. Assumes the vocabulary in [SKILL.md](./SKILL.md): **module**, **interface**, **seam**, **adapter**.

## Dependency categories

When assessing a candidate for deepening, classify its dependencies. The category determines how the deepened module is verified across its seam.

### 1. Self-contained

Pure computation, in-memory state, pure styling; no I/O and nothing outside the project. Always deepenable: merge the modules and verify through the new interface directly. No adapter needed.

### 2. Local-substitutable

Dependencies with local stand-ins that run inside the check suite (PGLite for Postgres, an in-memory filesystem, a fixture theme supplying a token contract). Deepenable when the stand-in exists. The deepened module is verified with the stand-in running in the suite. The seam is internal; no port at the module's external interface.

### 3. Remote but owned (ports and adapters)

Your own services across a network seam (microservices, internal APIs). Define a **port** (interface) at the seam. The deep module owns the logic; the transport is injected as an **adapter**. Checks use an in-memory adapter. Production uses an HTTP, gRPC or queue adapter.

Recommendation shape: *"Define a port at the seam, implement an HTTP adapter for production and an in-memory adapter for verification, so the logic sits in one deep module even though it's deployed across a network."*

### 4. True external (mock)

Third-party services you don't control (Stripe, Twilio and the like). The deepened module takes the external dependency as an injected port; checks provide a mock adapter.

## Declarative codebases

In a stylesheet, token or configuration library nearly everything is self-contained, so the taxonomy collapses to category 1. The seam and adapter concepts don't collapse with it; they reappear at theming and configuration:

- A token contract (the custom properties and variables a module consumes) is a port. Each theme that supplies those values is an adapter. Two themes justify the seam; a "themable" module with a single theme is a hypothetical seam, which is just indirection.
- The compiled output is part of the interface. Swapping one adapter for another must not force edits on the caller's side (markup, consuming stylesheets).

## Seam discipline

- **One adapter means a hypothetical seam. Two adapters means a real one.** Don't introduce a port unless at least two adapters are justified (typically production plus verification). A single-adapter seam is just indirection.
- **Internal seams vs external seams.** A deep module can have internal seams (private to its implementation, used by its own checks) as well as the external seam at its interface. Don't expose internal seams through the interface just because checks use them.

## Verification strategy: replace, don't layer

- Old checks on the shallow modules become waste once checks at the deepened module's interface exist: delete them.
- Write new checks at the deepened module's interface. The **interface is the verification surface.** The form follows the substance and the project's testing stance (the `### Testing` line in the Agent skills block): unit tests through the interface, snapshots of compiled output, visual regression over rendered states or a recorded manual flow in a test-free project.
- Checks assert on observable outcomes through the interface, not internal state.
- Checks survive internal refactors; they describe behaviour, not implementation. If a check has to change when the implementation changes, it's verifying past the interface.
