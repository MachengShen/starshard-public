---
title: 2026-05-04 launch packet
date: 2026-05-04
description: Added credibility-first launch packet, wired public URLs, drafted wave-1 outreach review.
---

# 2026-05-04 launch packet

## What changed

- Added `/launch/` as the public home for launch execution material.
- Added `/launch/72-hour-credibility-first-launch/` as the first launch packet, including a stable public-artifact link section.
- Expanded `/manifest/` from a stub into a draft Constraint Manifest (C1–C7).
- Updated the homepage and navigation to point at launch material.
- Drafted a wave-1 outreach review packet at `~/projects/starshard-paper/outreach/wave-1-review-packet-2026-05-04.md`. Not sent. Awaits Macheng per-recipient approval.

## Verification

- `hugo --minify` builds clean locally (Hugo 0.161.1+extended). 16 pages, no errors. Two deprecation warnings about `languageCode`; non-blocking.
- `git diff --check` clean.
- Searched the changed launch / manifest / layout text for private memory ids, internal infrastructure paths, private-network IPs, secrets, and relationship-specific terms. No matches.
- Pre-commit secret scan (gitleaks) reported no leaks.
- Public URL inventory checked via `gh repo view`: `MachengShen/starshard-public`, `MachengShen/the-form-was-the-cage`, `starshard-ai/reference-impl`, and `MachengShen/system-evolution-public` are all `PUBLIC`.

## Public artifact link inventory

| Item | URL | Status |
|---|---|---|
| Public site | https://starshard.clawishmacheng.com/ | live (pre-launch-packet) |
| Launch packet | https://starshard.clawishmacheng.com/launch/72-hour-credibility-first-launch/ | committed to `main`, awaiting deploy |
| Constraint Manifest | https://starshard.clawishmacheng.com/manifest/ | committed to `main`, awaiting deploy |
| Receipts | https://starshard.clawishmacheng.com/receipts/ | live |
| Paper repo | https://github.com/MachengShen/the-form-was-the-cage | live, source only |
| Paper PDF | n/a | pending — LaTeX source committed at `arxiv/main.tex`; no rendered PDF on `main` |
| Reference implementation | https://github.com/starshard-ai/reference-impl | live |
| Architecture / governance | https://github.com/MachengShen/system-evolution-public | live |

## Known gaps

- **Deploy mechanism unverified.** The launch packet commit `9cb3d01` was pushed to `MachengShen/starshard-public` `main` at 2026-05-04. As of three minutes after push, `https://starshard.clawishmacheng.com/launch/72-hour-credibility-first-launch/` returns HTTP 404 and the live homepage does not yet show launch in the nav. The site is otherwise live (older content), so a deploy mechanism exists but the auto-build-on-push-to-main path appears not to be wired (no `.github/workflows/`, no local `cloudflared`, no `wrangler` configured under the Macheng user). The minimum unblocking action is for whoever owns the Cloudflare Pages / deploy account to (a) confirm the project bound to `starshard.clawishmacheng.com`, (b) verify whether it is wired to this repo + `main`, and (c) trigger a rebuild or wire auto-deploy from `main`.
- Paper PDF and arXiv URL are not yet stable. First-wave outreach links to the paper repo (LaTeX source) and explicitly marks PDF / arXiv pending.
- Outreach send is gated on per-recipient Macheng approval.

## Next verification target

- Re-fetch `https://starshard.clawishmacheng.com/launch/72-hour-credibility-first-launch/` after the deploy mechanism is confirmed; expect HTTP 200 and the C1–C7 Constraint Manifest body live at `/manifest/`.
- After deploy is green, return wave-1 outreach review packet to Macheng for per-recipient APPROVE / DECLINE / DEFER / EDIT-HOOK markers.
