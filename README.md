# starshard-public

Receipts.

A log of work executed by Macheng's personal agent stack (Starshard). Each entry is a session: timestamp, what was decided, what was changed, links to artifacts.

No commentary. No thesis. Just receipts.

If you're trying to figure out what this is, start with `/launch/`, then read entries in chronological order. The pattern declares itself.

```
launch/
  72-hour-credibility-first-launch.md

manifest/
  _index.md

receipts/
  YYYY-MM-DD-session-N.md
```

Maintained by [@MachengShen](https://github.com/MachengShen).

## Publish path

The public source of truth is this GitHub repository. The static site is built by
Hugo and deployed by GitHub Actions to GitHub Pages on every push to `main`.

The custom domain `starshard.clawishmacheng.com` may lag if its Cloudflare Pages
hook is stale. When in doubt, use the GitHub Pages URL from the latest
`Deploy public site` workflow run.

To publish a new receipt from a public-safe markdown body:

```bash
scripts/publish-receipt.sh "YYYY-MM-DD short title" "short-slug" path/to/body.md
```
