---
title: "When Does Memory Become Mass? Inertia and Feedback in Systems with History"
date: 2026-07-02
author: "Macheng Shen"
description: "A system whose present is shaped by its accumulated past can be modeled with a memory kernel. Two intuitions compete for what that kernel *is*: control-theoretic feedback, or Newtonian inertia. A short derivation shows they are two different projections of one object — and that a purely dissipative (viscous) memory can never, by itself, produce stable inertia."
section_label: essay
---

{{< langswitch current="en" en="memory-inertia-feedback.md" zh="memory-inertia-feedback-zh.md" >}}

*Macheng Shen*

*Epistemic status: a self-contained derivation plus a small reproducible toy, done in an afternoon. The core linear-response results (Sections 3–4) I am confident in — they are textbook Mori–Zwanzig once you see the sign. The framing claims (Sections 1, 6) are `design_hypothesis`: offered to invite critique, not asserted as settled. Disclosure, per the norm of this blog: the derivation and this write-up were produced through my agent system, which I then checked. Corrections welcome.*

*Corrections (2026-07-02, after a detailed external technical review): the core result stands — the algebra, the signs, and the pole condition are correct, and "monotone forgetting is not inertia; inertial memory must store and return" survives. Three things below were fixed: (1) the wrong-sign mass is not a physical "runaway" — only a truncated approximation is unstable; (2) a negative `γ_eff` in Channel B does **not** mean the exact system is unstable — with `k, B, gA > 0` it is always stable, the low-frequency expansion has just left its range of validity; (3) "passive" was too broad and the Higgs analogy was stated too strongly. The corrected claims are marked inline.*

---

## 1. The question

Many systems carry their past into their present. A habit is a low bar for action learned by repetition. Hysteresis in a magnet is the material "remembering" its history of applied fields. In contemplative language, *karma* — stripped of its moral overlay — is just the claim that accumulated, repeated action deposits a bias into how a system responds now. In every case, the honest first-principles home for "the past acting on the present" is a **memory kernel**: the present drift depends not on the instantaneous state alone but on a weighted integral over the state's history,

```
        t
drift ~ ∫  K(t − t') ( · )(t') dt'
        0
```

When people reason informally about such systems, two different mechanical metaphors show up, and they are usually treated as interchangeable:

- **Feedback** (control-theoretic): the past sets a loop gain — positive feedback amplifies, negative feedback damps. The relevant quantities are the sign of the damping and the curvature of the effective restoring force.
- **Inertia** (Newtonian): the past gives the system *mass* — a resistance to changing its velocity, a `M · ẍ` term. Change is now second-order; the system can overshoot and oscillate.

The two pictures are not obviously the same. Feedback lives in a **first-order** world (rates, gains, damping). Inertia is intrinsically **second-order** (acceleration, momentum, resonance). So: **can a memory kernel in an overdamped, first-order system actually grow a genuine second-order inertia — or does it only ever renormalize the feedback?** And if it can grow inertia, under what condition?

There is a useful constraint to respect from the start. In modern physics, mass is not a primitive substance; it is an *emergent effect* of coupling to a background field (the Higgs mechanism being the sharp example). So the honest target is not to postulate inertia — it is to find inertia **emerging** from coupling to something, and to see exactly when that emergence succeeds or fails.

## 2. Setup

The workhorse is the generalized Langevin equation (GLE). For a coordinate `x` with restoring force `−U'(x)`, a memory friction kernel `K`, and noise `ξ`:

```
m ẍ(t) = − ∫₀ᵗ K(t−t') ẋ(t') dt' − U'(x) + ξ(t)
```

We are interested in the **overdamped** regime — take the bare mass `m → 0`, so there is *no* inertia put in by hand. The question is whether the kernel `K` can put it back. Linearize the restoring force, `U'(x) = k·x`, and work in the frequency domain, `ẋ → −iω x`, with the one-sided kernel transform

```
K̂(ω) = ∫₀^∞ K(s) e^{iωs} ds .
```

The linear response `x(ω) = χ(ω) ξ(ω)` has inverse

```
χ⁻¹(ω) = k − iω K̂(ω) .
```

A *genuine* inertial system, for comparison, has `χ⁻¹(ω) = k − m ω² − iγ ω`. So the entire question reduces to one thing: **does `−iω K̂(ω)` contain a `−m ω²` term with `m > 0`?** The sign is everything.

## 3. Channel A — a viscous (dissipative) memory kernel gives the *wrong sign*

Take the simplest physical memory friction: an exponentially decaying, everywhere-positive kernel,

```
K(s) = (γ / τ) e^{−s/τ},   γ, τ > 0 .
```

This is "sticky mud with a memory" — a viscous drag proportional to a time-averaged recent velocity. Expand its transform at low frequency:

```
K̂(ω) = ∫₀^∞ K(s)(1 + iωs − …) ds = γ₀ + iω γ₁ + O(ω²),
   with  γ₀ = ∫K = γ,   γ₁ = ∫ s K(s) ds = γτ > 0 .
```

For *any* positive kernel, `γ₁ = ∫ s K(s) ds > 0` — it is a positive weight times a positive time. Now form the response:

```
χ⁻¹(ω) = k − iω K̂(ω) = k − iω(γ₀ + iω γ₁ + …) = k + γ₁ ω² − i γ₀ ω + …
```

Compare term by term with the inertial form `k − m ω² − iγ ω`:

```
γ (damping)     = γ₀ = ∫K            ✓  (ordinary friction, fine)
m (inertia)     = − γ₁ = − ∫ s K < 0  ✗  (WRONG SIGN)
```

**A pointwise-positive (forgetting) memory friction kernel produces a low-frequency effective mass with the wrong sign, `m_eff < 0`.** Non-negativity alone is enough — the kernel need not even be monotone. Physically it is obvious in hindsight: a friction kernel only ever *removes* energy (with a delay); it can never *store and return* the kinetic energy that inertia requires. You cannot build momentum out of drag.

Two corrections to how an earlier version of this essay put it. **First, the wrong-sign mass is not a physical "runaway."** The exact first-order-with-memory system here has stable (real) poles; the instability appears *only* if you truncate the low-frequency expansion into a fake second-order ODE, which manufactures a spurious high-frequency pole. So the honest statement is: a positive forgetting kernel gives an `ω²` coefficient of the wrong sign for inertia — *no stable positive-mass interpretation* — not an instability. **Second, the forbidden class is "pointwise-positive forgetting," not "passive."** Passivity is a frequency-domain condition (a positive-real response, `Re K̂(ω) ≥ 0`), and a passive kernel is *allowed* to dip negative in time. A passive kernel with a negative tail lobe **can** produce positive inertia — see the next paragraph. The thing that cannot is a kernel that stays non-negative for all time.

To get *positive* inertia this way you would need `∫ s K(s) ds < 0`, i.e. the kernel must go **negative** somewhere — it must overshoot. A kernel with a negative lobe is precisely the signature of an underdamped, *reactive* degree of freedom hiding underneath, not a monotone dissipative one. Which brings us to the other channel.

## 4. Channel B — eliminate a reactive mode, and inertia emerges (à la Higgs)

Instead of a friction kernel on velocity, let the memory come from a genuine second variable `z` that carries its own state — something that can store and return. Two coupled first-order equations:

```
ẋ = − k x + g z + ξ
ż = − A x − B z          (z relaxes at rate B)
```

Integrate `z` out. Its solution is a convolution of `x`'s history — that *is* the memory kernel — and substituting back gives

```
χ⁻¹(ω) = (k − iω) + gA / (B − iω) .
```

Expand at low frequency (`gA/(B−iω) = gA/B · [1 + iω/B + (iω/B)² + …]`) and read off the three effective coefficients:

```
k_eff     = k + gA/B          renormalized stiffness   — this is FEEDBACK on the restoring force
γ_eff     = 1 − gA/B²         renormalized damping     — can go NEGATIVE ⇒ positive-feedback runaway
m_eff     = gA/B³   > 0       EMERGENT INERTIA
```

Now there *is* a positive effective mass. And note its form: `m_eff = gA / B³` — a coupling (`gA`) divided by a power of the background mode's stiffness/rate (`B`). It is not a substance; it is an induced effect of coupling to a background variable, and it **vanishes as `B → ∞`** (at fixed coupling). This is *Higgs-like only in a weak, effective-field-theory sense*: an inertial coefficient is **induced by coupling to an eliminated background degree of freedom, and vanishes under fixed-coupling adiabatic decoupling**. Read no more into it than that — there is no gauge symmetry, no symmetry breaking, no vacuum expectation value; `B` is a relaxation rate, not a field stiffness or a relativistic invariant mass; and if `gA` were scaled together with `B`, even the clean decoupling story would break.

But "there is an `ω²` term" is not the same as "there is a physical resonance." Two coupled first-order ODEs *always* give a formally second-order characteristic polynomial. Whether the system is a genuine underdamped oscillator (complex poles, real momentum) or just a disguised pair of overdamped relaxations (real poles, no momentum) depends on the parameters. The poles are the eigenvalues of `[[−k, g], [−A, −B]]`; they are complex — genuine oscillation — only when

```
(k + B)² < 4(k B + g A).
```

A small toy sweep (fix `k = 1`, `gA = 4`, vary the background rate `B`):

| `B` | poles | regime | `m_eff` | `γ_eff` |
|----:|:-----:|:------:|-------:|-------:|
| 0.5 | −0.75 ± 1.98i | stable oscillator; `γ_eff<0` = reduced model out of range | 32 | −15 |
| 1.0 | −1.0 ± 2.0i | stable oscillator; `γ_eff<0` = reduced model out of range | 4.0 | −3.0 |
| 2.0 | −1.5 ± 1.94i | stable oscillator (`γ_eff=0`) | 0.5 | 0.0 |
| **4.0** | **−2.5 ± 1.32i** | **inertial, stable ✓** | **0.0625** | **0.75** |
| 8.0 | −1.63 (real) | feedback only | 0.008 | 0.94 |
| 20 | −1.21 (real) | feedback only | 5e-4 | 0.99 |
| 100 | −1.04 (real) | feedback only | 5e-6 | ~1.0 |

Two things to read off. First, complex poles — real inertia — appear only when the background mode is **slow or comparable** to the system; in the **adiabatic (fast-bath) limit `B → ∞`, `m_eff → 0`** and you are left with pure renormalized feedback. Second — and this corrects an earlier version of this essay — a negative `γ_eff` does **not** mean the system is unstable. With `k, B, gA > 0` the full two-mode system is *always* linearly stable (`tr M = −(k+B) < 0`, `det M = kB + gA > 0`); the row `k=1, gA=4, B=1` gives `λ = −1 ± 2i`, a perfectly stable underdamped oscillator. A negative `γ_eff` only signals that the **truncated low-frequency expansion has left its range of validity** — you can no longer use its damping coefficient to predict the true pole locations. The reduced description stops being a reliable pole model; the exact system is fine.

## 5. The two axes

Putting the channels together, inertia and feedback are indeed **two projections of one object** — the memory kernel `K̂(ω)`. Feedback lives in its real (dissipative) part plus the low-frequency renormalization of stiffness; inertia lives in its **reactive** part, the piece contributed by a mode that stores and returns. But they are separated by two axes, and are not freely interchangeable:

1. **Channel.** Reactive/state memory (can store *and* return energy) → inertia. Dissipative/friction memory (can only remove) → feedback, and its naive `ω²` term has the wrong sign.
2. **Timescale.** Memory comparable to the system's own dynamics → inertia. Adiabatic, fast-relaxing memory → feedback (the induced mass vanishes).

Two honest caveats on this "two projections" language, both owed to a careful external review:

- **The reactive and dissipative parts are not freely separable.** Causality ties them together — the Kramers–Kronig relations make the real and imaginary parts of any causal response determine each other (nonlocally in frequency). And the split is *representation-dependent*: in the Mori–Zwanzig framework the memory kernel, the noise, and the projection are one package, not a unique objective object. So "inertia = reactive part, feedback = dissipative part" holds *within a fixed scalar velocity-kernel representation*, not as a frame-free law.

- **The two channels are really one criterion.** Integrating the eliminated mode `z` out by parts turns Channel B into a velocity-memory kernel `K_B(s) = δ(s) − (gA/B) e^{−Bs}` — which has a **negative lobe**, so `∫ s K_B ds = −gA/B³ < 0`, giving `m_eff = gA/B³ > 0`. Channels A and B thus collapse into a single test: **does the causal velocity kernel have a negative first moment?** Monotone forgetting (A) never does; a hidden reactive mode (B) does. That is the whole result in one line. (One boundary: this assumes finite moments. For power-law / fractional memory, where `∫ s K` diverges, there is no ordinary `m_eff` — you get fractional damping and storage, not a clean second-order mass.)

## 6. What this says about "karma," habit, and history-dependent systems

Return to the motivating picture. Suppose you want to model an accumulated-history bias — a habit, a `karma`-like deposit, a policy shaped by its own past — as a memory kernel, and you are tempted to call it "inertia," a mass that makes the system resist redirection. The derivation says: **you are only entitled to the inertia reading if that memory can store and return, and if it operates on a timescale comparable to the behavior it shapes.** If the honest model of the accumulated bias is monotone forgetting — a `習氣`/habit as an ever-decaying, always-positive weight on the past, which is the natural reading — then it is a *viscous drag*, i.e. **feedback, not inertia.** Calling it mass would be borrowing a resonance and a stored momentum that the model does not contain.

So the concrete claim to hold: *inertia and feedback are the reactive and dissipative parts of one memory kernel; they are not the same limit.* Modeling history-dependence as Newtonian mass smuggles in an assumption — that the system has a reactive storage mode — that a plain "accumulated forgetting" kernel does not satisfy. The conservative default is feedback (sticky drag proportional to a weighted recent velocity, exactly as one would guess); the inertial upgrade must be *earned* by exhibiting the storage mode.

## 7. A single disconfirming test

For any specific history-dependent system you want to call "inertial," write down its memory kernel `K(s)` and check two things:

1. **Does `K(s)` have a negative lobe** (equivalently `∫ s K(s) ds < 0`)? No negative lobe ⇒ purely dissipative ⇒ feedback, and the "mass" is a metaphor.
2. **Is its memory time non-adiabatic** — comparable to the system's own timescale, not vanishingly fast? If the memory is fast relative to the dynamics, `m_eff → 0` ⇒ feedback.

Only if **both** are yes does the second-order/inertial description carry real content. Otherwise the honest word is *feedback*.

A caveat on this test, again from review: a negative first moment is genuinely **necessary and sufficient for positive *apparent* low-frequency mass** in a scalar finite-moment kernel. But *stable, genuine* inertia asks for more — the effective damping must stay positive in the relevant band (passivity), all poles must sit in the stable half-plane, a complex pole pair must actually exist (`(k−B)² < 4gA` in Channel B), and the resonance must lie inside the validity range of the reduced model. The two-part test is the right quick sanity check, not the full theorem.

---

### Reproducibility

The whole result is a few lines of linear response; the toy in Section 4 is pure `numpy` (no external calls). The essential computation:

```python
import numpy as np

# Channel A: viscous memory kernel K(s) = (gamma/tau) exp(-s/tau)
def channelA_meff(gamma, tau):
    # m_eff = -∫ s K(s) ds = -gamma*tau  (always < 0)
    return -gamma * tau

# Channel B: eliminate a reactive coupled mode
def channelB(k, g, A, B):
    k_eff  = k + g*A/B
    g_eff  = 1 - g*A/B**2
    m_eff  = g*A/B**3          # > 0, -> 0 as B -> inf (Higgs pattern)
    poles  = np.linalg.eigvals(np.array([[-k, g], [-A, -B]]))
    return k_eff, g_eff, m_eff, poles   # complex poles => genuine inertia
```

*If you spot an error — a sign, a limit, a missed regime — or a sharper framing, I would like to hear it.*
