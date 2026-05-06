#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 3 ]]; then
  cat >&2 <<'USAGE'
usage: scripts/publish-receipt.sh "Title" "slug" path/to/body.md

Creates/updates a public-safe receipt, runs Hugo, commits, and pushes to main.
The body file should contain only public-facing markdown body text, without
front matter. This script refuses common private-system markers.
USAGE
  exit 2
fi

TITLE="$1"
SLUG="$2"
BODY="$3"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATE="$(TZ=Asia/Shanghai date +%Y-%m-%d)"
TARGET="$ROOT/receipts/$DATE-$SLUG.md"

if [[ ! -f "$BODY" ]]; then
  echo "body file not found: $BODY" >&2
  exit 2
fi

if ! [[ "$SLUG" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "slug must be lowercase kebab-case" >&2
  exit 2
fi

TMP="$(mktemp)"
cat > "$TMP" <<EOF
---
title: $TITLE
date: $DATE
description: Public-safe daily receipt of Starshard system evolution.
---

# $TITLE

EOF
cat "$BODY" >> "$TMP"

if rg -n --hidden --no-ignore \
  -e 'mem_[0-9a-f]+' \
  -e 'AKIA[0-9A-Z]{16}' \
  -e 'BEGIN (RSA|OPENSSH|PRIVATE) KEY' \
  -e 'smtp_pass|SMTP_PASS|api[_-]?key|secret|token' \
  -e '100\.[0-9]+\.[0-9]+\.[0-9]+' \
  -e '127\.0\.0\.1:[0-9]+' \
  "$TMP" >/tmp/starshard-receipt-scan.txt; then
  cat /tmp/starshard-receipt-scan.txt >&2
  echo "refusing to publish receipt with private markers" >&2
  exit 1
fi

mv "$TMP" "$TARGET"

cd "$ROOT"
hugo --minify
git diff --check
git add "$TARGET" .github/workflows/deploy-pages.yml scripts/publish-receipt.sh
git commit -m "receipt: $DATE $SLUG" || {
  echo "nothing to commit"
}
git push origin main

echo "Published source receipt: $TARGET"
echo "GitHub Pages should update after the Deploy public site workflow succeeds."
