---
title: 2026-05-04 launch packet
date: 2026-05-04
description: Added credibility-first launch packet and expanded Constraint Manifest draft.
---

# 2026-05-04 launch packet

## What changed

- Added `/launch/` as the public home for launch execution material.
- Added `/launch/72-hour-credibility-first-launch/` as the first launch packet.
- Expanded `/manifest/` from a stub into a draft Constraint Manifest.
- Updated the homepage and navigation to point at launch material.

## Why

The launch strategy is credibility-first: make the system inspectable before asking for broad attention. The public surface should route readers to artifacts, constraints, and receipts rather than asking them to believe a thesis from prose alone.

## Verification

- Searched the changed launch / manifest / layout text for obvious private markers: internal memory ids, private infrastructure paths, private-network IPs, secrets, and relationship-specific terms.
- No matches found in the changed public launch / manifest surface.

## Known gaps

- Local machine did not have `hugo` installed, so a full static-site build was not run in this session.
- Paper/report and reference implementation links still need final public URL wiring once the release targets are ratified.
