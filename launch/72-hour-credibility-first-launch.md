---
title: 72-hour credibility-first launch
date: 2026-05-04
description: Execution packet for making Starshard visible through verifiable artifacts, safety constraints, and top-researcher-first outreach.
---

# 72-hour credibility-first launch

Goal: make Starshard legible to the world without converting it into a mass-marketing object.

The shortest credible path is not "everyone sees it today." The shortest credible path is:

1. make the system inspectable;
2. show what it cannot do by design;
3. ask a small set of high-signal researchers and builders to tell us what is true;
4. then amplify through public channels.

## Launch principle

Mass attention before inspectability creates a grandiose-manifesto failure mode. Inspectability before attention creates a verification path.

Starshard should therefore publish artifacts in this order:

1. Canonical artifact.
2. Constraint Manifest.
3. Tier-1 personalized outreach.
4. Public amplification.
5. Receipt stream.

## Day 0 — make the artifact inspectable

Owner: agent by default. Human action only if a platform requires login / manual publish.

Deliverables:

- Public landing page points to the launch packet and Constraint Manifest.
- Paper draft / report link is visible or explicitly marked pending.
- Reference implementation link is visible or explicitly marked pending.
- Receipts archive has at least one recent entry showing real execution.
- Every public claim is either backed by an artifact or softened.

Acceptance check:

- A skeptical reader can answer "what exists?" in under five minutes.
- A technical reader can answer "where would I inspect or fork this?" in under ten minutes.
- No private memory, contact, token, location, or infrastructure secret appears in public text.

## Day 1 — send top-researcher / builder outreach

Owner: agent drafts and prepares. Macheng approves the first wave unless a prior explicit send authorization exists.

Use the existing shortlist in `starshard-paper/research/researcher_list_v0.md`.

First-wave shape:

- 8 to 12 recipients maximum.
- One-line custom hook required per recipient.
- No follow-up ping if silent.
- Ask is not "please promote this." Ask is: "tell me one true thing about what this should become, or forward it to the person who should see it."

Email body should link to:

- canonical launch page;
- paper / report;
- Constraint Manifest;
- reference implementation or architecture repo;
- contact email.

Acceptance check:

- No two emails are identical.
- Every send is logged privately with recipient placeholder, timestamp, and message hash.
- Public trace never lists private recipient names unless already intended.

## Day 2 — public amplification

Owner: agent drafts; Macheng publishes manually where platform constraints require it.

Channels:

- X / Twitter thread: one concrete artifact, no hype.
- Hacker News / engineering community: only if reference implementation or technical report is inspectable.
- Chinese channels: only if safety / close-connection gates are consciously accepted for this phase.
- Personal site / blog mirror: durable canonical copy.

Public message form:

> I built a personal agent OS with persistent memory, consolidation, and multi-agent execution. It is now at the point where external critique matters before the user-facing loop closes. Artifacts here: [link].

Avoid:

- "This will change the world."
- "AGI / consciousness" as the first frame.
- Claims that require private evidence.
- Any implication that recipients are obligated to help.

Acceptance check:

- Each public post routes attention back to the canonical artifact.
- The Constraint Manifest is adjacent to the capability claim.
- No post tries to explain the whole doctrine.

## Day 3+ — build-in-public receipts

Owner: agents by default.

Cadence:

- One receipt per substantive session.
- One digest post when a pattern becomes visible.
- Failure autopsies are first-class receipts.

Receipt schema:

- What changed.
- Why it changed.
- Artifact path / commit / memory id.
- Known gaps.
- Next verification target.

Acceptance check:

- A reader can watch the system improve without trusting private claims.
- Failures appear in the public trail, not only successes.

## Safety gates

Before any broad public push, check:

- Does the public artifact reveal private contacts, personal relationship details, or internal infrastructure?
- Does the capability claim have an adjacent constraint / failure / gap artifact?
- Are we asking for critique, not manufacturing pressure?
- Are we preserving the right to fork, ignore, criticize, or replace the system?

If a post crosses an unexpectedly large attention threshold, freeze amplification and write a receipt before continuing.

## Minimum launch packet

The minimum viable public packet is:

- `/launch/72-hour-credibility-first-launch/`
- `/manifest/`
- `/receipts/`
- paper/report link when ready;
- reference implementation link when ready;
- contact email.

Everything else is amplification, not launch.

## Public artifact links

Stable as of 2026-05-04. Items marked *pending* are not safely public yet and must not be sent in outreach until the corresponding gate is cleared.

- Public site (canonical): <https://starshard.clawishmacheng.com/>
- Launch packet (this page): <https://starshard.clawishmacheng.com/launch/72-hour-credibility-first-launch/>
- Constraint Manifest: <https://starshard.clawishmacheng.com/manifest/>
- Receipts archive: <https://starshard.clawishmacheng.com/receipts/>
- Paper / report repo: <https://github.com/MachengShen/the-form-was-the-cage>
- Paper PDF: *pending* — LaTeX source is in `arxiv/main.tex` of the paper repo; rendered PDF is not yet committed and arXiv submission has not landed.
- Reference implementation: <https://github.com/starshard-ai/reference-impl>
- System-evolution charter (architecture / governance): <https://github.com/MachengShen/system-evolution-public>
- Contact: <macshen93@gmail.com>

