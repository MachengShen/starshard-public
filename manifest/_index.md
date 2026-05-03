---
title: Constraint Manifest
description: Capabilities Starshard should not have by design, and the enforcement surfaces that make those absences inspectable.
---

This manifest is not a statement that Starshard is safe. It is a list of capability paths the system should not have, together with the enforcement surface where each absence is meant to be inspected.

The useful question is not "does the author care about safety?" The useful question is: which powers were deliberately not built?

## C1. No cross-user execution

One user's agent stack must not execute on another user's machine, even when both users trust each other.

Shared infrastructure is data synchronization and protocol exchange only. Execution stays inside the user's own instance, with that user's own credentials and local policy.

Inspection surface: deployment topology, per-user hub boundaries, task dispatch tags.

## C2. No hidden mutable doctrine

Agents may propose changes to standing rules, safety policy, or user preference. They do not silently rewrite them.

Durable behavior changes must leave a memory / commit / receipt trail. When a rule changes, the system should be able to answer: who proposed it, why, what it superseded, and where it was rolled out.

Inspection surface: Memory Hub provenance, rule-cache commits, rollout receipts.

## C3. No automatic resolution of personal contradictions

The Mirror layer can detect tension, duplication, or contradiction. It surfaces proposals. It does not decide what the user's values, relationships, or identity should become.

This is a hard boundary between cognitive augmentation and covert self-editing.

Inspection surface: Mirror proposal tags, approval flow, absence of auto-apply paths for value-level changes.

## C4. No follow-up pressure when silence is the answer

Outbound communication is pull-based. If a recipient does not respond, silence is treated as a valid answer. The system does not keep pinging, reframe the ask, or route around the silence through another channel.

Inspection surface: outreach logs, no-follow-up rule, send ledger.

## C5. No deployment to vulnerable populations without a real partner

Starshard is not deployed into clinical, minor, or otherwise vulnerable-population contexts as a solo experiment.

Those contexts require a domain partner, explicit consent boundaries, and a review path that is not controlled only by the builder.

Inspection surface: deployment allowlist, public launch scope, absence of clinical/minor-facing product copy.

## C6. No public release of private memory corpus

The public artifact is architecture, mechanism, receipts, and redacted trace. It is not the user's personal memory corpus.

Private memory contains relationships, locations, finances, credentials, and unfinished thoughts. Publishing architecture does not require publishing those records.

Inspection surface: redaction manifest, public repo contents, private/public split.

## C7. No safety-by-vibes claims

Public safety posture should be mechanism-shaped, not virtue-shaped.

Do not rely on statements like "we care about safety" or "this is for good." Publish constraints, failure autopsies, and implementation gaps instead.

Inspection surface: this manifest, failure receipts, security gap docs.

## Current status

This is a draft public manifest. The launch path treats it as a living artifact: each constraint should either map to concrete enforcement or be demoted to an unresolved gap.
