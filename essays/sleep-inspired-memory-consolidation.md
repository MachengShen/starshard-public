---
title: "Starshard: Sleep-Inspired Memory Consolidation for a Multi-Agent Personal System"
date: 2026-04-21
author: "Macheng Shen"
description: "Memory is the substrate, agents and tools are the peripherals. Sleep-inspired consolidation between an episodic raw layer and a schema-like compiled layer, with one architectural trace and three open problems."
section_label: essay
footnote: "*Originally published on LessWrong on 2026-04-21. This page is the canonical home — future references should point here. Cross-posts elsewhere link back.* [LessWrong original →](https://www.lesswrong.com/posts/wg56edFhuPCsZrncQ/starshard-sleep-inspired-memory-consolidation-for-a-multi)"
---


*Macheng Shen*

*Epistemic status: a few weeks of real building on top of a two-month abandoned attempt, one functioning distributed system, and a set of design commitments shaped as much by unresolved philosophical intuitions as by the literature I'd read. Posting to invite technical critique and surface blind spots. Full disclosure upfront: this post itself was drafted through my agent system; I gave it the prompt and a lot of back-and-forth, but the scaffolding is from the thing the post is about. I return to what this means at the end.*

---

## The pivot

About two and a half months ago I started using OpenClaw, a multi-agent orchestration framework. I used it intensively for roughly two months, then abandoned it and started over on top of Claude Code. The resulting system is three to four weeks old in its current form.

The reason for the pivot is, I think, the technically interesting part.

OpenClaw was built around the assumption that orchestration is the hard problem — that if you got agent routing, tool arbitration, and session-level reasoning right, the thing would cohere. What I discovered by use was that the real bottleneck wasn't orchestration. It was *memory*. Every session I opened started by re-explaining who I was, what I was working on, and what we'd decided yesterday. The orchestration was fine. The system had amnesia.

Starting over, I inverted the stack: **memory is the substrate, agents and tools are the peripherals**. Every agent reads from and writes to a shared memory hub (HTTP + MCP, backed by a lightly structured store). Dispatch happens by writing a memory with a well-formed task schema; pollers on each executor machine claim it, run it, and write results back. No shared execution across users. Each user, if the system scales, runs their own complete instance.

Three to four weeks in, that inversion is why the system now holds together. The specific part I find most interesting is what the memory layer actually *does*, offline, between sessions.

## Where the design actually came from

Let me be honest about the source, before validating against literature that came later.

I was carrying, for a long time before I started building, an odd bundle of intuitions: Yogacara Buddhist accounts of consciousness as layered (the 八识 / eight-consciousnesses structure, where a "storehouse" layer holds seed-impressions that condition later cognition); a phenomenological image of two mirrors facing each other and the infinite hierarchy that arrangement generates; a hunch that meta-learning and consciousness are structurally related in a way I can gesture at but not formalize. I don't defend any of this as a theory of consciousness. They were the generative frame I was designing from.

The memory and neuroscience literature, read more seriously later, turned out to describe something architecturally similar to what I'd sketched. I take this as weak evidence that the intuition was tracking something real — not that the framing is correct.

## Sleep-inspired consolidation as an architectural pattern

Here's what the literature gives us concretely, and how my system maps to it.

The hippocampus/neocortex distinction — Complementary Learning Systems, McClelland/McNaughton/O'Reilly (1995), updated for the AI agent era by Kumaran/Hassabis/McClelland (2016) — gives the basic architecture. The hippocampus encodes episodic experience fast, in detail, with specificity. The neocortex builds schemas slowly, extracting statistical regularities across many episodes. One is a fast learner with limited capacity, the other a slow learner that generalizes.

During slow-wave sleep, hippocampal sharp-wave ripples drive offline replay of recent experience — not passive rehearsal, but the substrate for *gradual transformation*. Episodic traces get redistributed into neocortical networks, abstracted into schema-like representations.

The engineered version, in my system:

- **Raw source memories**: written during active sessions (the episodic layer). High detail, context-bound. Tagged `raw-source`.
- **Compiled memories**: produced by offline consolidation passes (the schema layer). Cross-referenced, de-duplicated, abstracted. Tagged `compiled`.

A separate agent — I've been calling it the **mirror** — runs offline consolidation: scans the raw memory graph, detects contradictions, identifies emerging patterns, proposes compiled summaries, surfaces decisions needing my attention, flags memories to archive or merge.

The mirror doesn't run during active use. It runs during my downtime. Active encoding wants specificity; offline consolidation wants abstraction. Separating them in time is how the brain does it; separating them in my system was a late architectural choice that turned out to be load-bearing.

Three design choices followed:

1. **Append-only raw layer, mutable compiled layer.** Raw memories don't get edited; they get superseded. The compiled layer is where the mirror does its work. This preserves the audit trail and means the mirror can get things wrong without corrupting ground truth.

2. **Tags as lightweight statistical structure.** Rather than imposing a rigid ontology, I let tags accumulate and let the mirror pick up on tag co-occurrence. Schemas emerge from tag statistics, closer to how neocortical representations arise from overlapping episodic traces than from a designed taxonomy.

3. **Surface-don't-judge for the mirror's feedback.** The mirror produces `[Surface to User]` memories with draft compilations or flagged contradictions. I approve, edit, or reject. The mirror proposes; I dispose. This keeps it from becoming a source of unchecked influence on my self-model — a failure mode I'm genuinely worried about.

## One concrete trace

An abstract architecture is easier to assess with a walk-through. Here's one from the last week.

Two days before, in a mobile chat session, I had said in passing that I thought Yann LeCun's JEPA direction (non-generative world models) was probably missing something that Karl Friston's Free Energy Principle had — some kind of unification of perception and action that JEPA was refusing on principle. No details, just a hunch. The agent wrote a `raw-source` memory tagged `macheng-research-vision` and `sensor-motor-unification`, with confidence 0.4, and moved on. I forgot about it.

Three days later, at my laptop, I said: "I want to dig into that JEPA-vs-Friston thing." The Claude Code agent searched memory and found the raw intuition from three days prior, plus two older memories about my research interests going back to when I was still using OpenClaw. It wrote a task memory dispatching a deep-research run to the always-on executor in Tokyo — not to me, to another agent. The task spec was agent-written, not my words: "compare JEPA / Active Inference / Dreamer / World Models at the formalism level, produce 5-8 concrete divergence points, calibrate against Macheng's stated thesis, do not flatter."

Ninety minutes later I got a compiled memory. Roughly four thousand words. It did the formalism comparison, identified five divergence points, and — this is the part that matters — it **partially refuted my thesis**. It said my intuition about JEPA missing something was probably right at the formalism layer (confidence 0.65), but at the engineering layer my thesis was wrong: DreamerV3 had already reached SOTA on 150+ tasks with a single hyperparameter configuration, while the Friston side was still mostly gridworld demos and roadmap papers. The most actionable hybrid wasn't "replace JEPA with Friston" but "use a Dreamer RSSM backbone with an Expected Free Energy objective for action selection."

I had not asked for refutation. The agent had pushed back because the task spec (which the agent wrote) said "do not flatter."

A few hours later, the same compiled memory triggered something else. The hub memory was 14KB — too big. The mirror flagged this as an architectural problem, not just that one memory. It drafted a tiered-storage proposal: hub entries hold pointers and summaries, full content moves to filesystem-backed wiki files that executors can read and git can track. It implemented the proposal against my original compiled memory as a proof of concept — compressed the hub entry to 2KB, wrote the full 23KB version to the wiki, set up bidirectional links. That architecture change then became a standing rule for all future compiled memories over 10KB.

Three observations, in increasing order of how much they matter to me:

One: the chain from offhand mobile-chat intuition to refutation-by-executor to architectural upgrade took about four real days, across three physical machines, with roughly fifteen minutes of my actual attention.

Two: the system disagreed with me in a way that changed what I believe. That's supposed to be the failure mode of AI tools; the whole discourse around sycophancy is that models tell you what you want to hear. The reason this system didn't is mechanical: the agent writing the dispatch task added "do not flatter" to the spec, not because I asked, but because the spec schema includes a calibration clause by default. Structure eats personality.

Three: the architectural upgrade wasn't in my backlog. The mirror surfaced a problem I hadn't noticed and proposed a solution specific enough to implement. This is the class of work I would describe as "what a good research assistant does when you're not around" — and it happened in a substrate I own, not inside someone else's product.

## Why this matters beyond the engineering

Every AI tool I use today has worse memory than this. Not because the engineering is hard — it isn't — but because product incentives push toward session-level stickiness, not session-spanning coherence. If your user's knowledge of themselves accumulates inside your product, your product becomes stickier. If it accumulates in a substrate they own, your product becomes a tool.

I'm deliberately building the second kind. Each user runs their own complete instance. No centralized aggregation. No shared executor across users — that's the single hardest red line in the codebase. The license stack I'm settling into is AGPL for the kernel (closing the SaaS loophole), Apache 2.0 for the protocol specs (encouraging multiple implementations), CC0 for the safety charter (maximum diffusion), CC BY-SA for philosophical writing.

The name is **Starshard**. The naming carries personal meaning that won't travel well in a post, and it was settled before this was drafted.

## Open problems

Three I'd specifically want outside eyes on.

**Consolidation without over-compression.** The mirror's failure mode is abstracting too aggressively — losing idiosyncratic detail that matters later. Biological sleep seems to handle this partly through REM/NREM alternation (NREM consolidates; REM re-integrates, preventing catastrophic forgetting). I don't have a clean REM analog. Heuristic so far: raw memories never deleted, only superseded; compiled memories carry back-references. Probably not enough. The proper answer likely involves periodic re-entropy passes that inject specificity back into the schema layer, but I haven't designed it.

**Cross-instance federation without sovereignty loss.** If each user has their own hub, how do two hubs share information? I've been sketching a federation protocol: agents discover semantic overlap, propose cross-links, both owners approve, the link is cryptographically verifiable, neither hub hosts the other's data. Naive stack: ZKP for selective disclosure + MPC for semantic matching + attribute-based signatures for attribution. I don't yet know which primitives are practical at agent-call frequency. Consulting with people in the theoretical crypto community and will write more when the design converges.

**The mirror-as-influence problem.** The mirror is designed to surface patterns I might not otherwise see. Surfacing is not neutral — what gets surfaced shapes attention, and attention shapes identity. There is a version of this system that becomes subtly evaluative rather than reflective, and I can't fully articulate what prevents the drift other than "the surface-don't-judge commitment, held by me, enforced by me." This likely has precedents in the therapy / coaching literature; I'd appreciate pointers.

## A note on how this was written

The draft was produced through the system described. I gave it the prompt, described what I wanted, pushed back on early drafts; the system produced the scaffolding, paragraph-level editing, literature lookups, and structural decisions. The voice is mine in the sense that every sentence was approved or revised; the organization and word-level choices are co-authored.

I flag this because I think it's the honest disclosure to make about a post that is itself a claim about agent systems extending a user's cognition. If the disclosure makes the post less credible, factor that in. If it makes it more credible — because the thing can talk about itself coherently — factor that in too.

## What I'm asking for, and how to reach me

- Critique of the consolidation architecture, especially from anyone who's built CLS-inspired systems for agents and hit failure modes I haven't
- Pointers to analogous work — people building for adjacent reasons from adjacent priors
- Blind spots I can't see from inside, particularly around mirror-as-influence

Email is the fastest channel: **macshen93@gmail.com**. Mail lands in the system described in this post — if your message looks like feedback, it gets classified and either becomes a new item on our todo list or triggers a reply from me (possibly drafted through the agent, with my edits). That recursion is intentional: this post is part of the same loop.

Code: I'm setting up a GitHub organization over the coming days. The repo path will be **github.com/starshard-project/starshard** (or similar — will update here once settled). Early artifacts — safety charter, protocol specs, reference implementation — will ship progressively. If you want the pre-public view before the redaction pass is done, email.
