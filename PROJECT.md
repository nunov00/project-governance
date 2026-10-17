# Project configuration

- **Project:** [name]
- **Purpose:** [one sentence]
- **Owner:** [name]
- **Manager:** ChatGPT (or designated manager)
- **Governance template:** v0.2
- **Stage:** PoC
- **Governance profile:** Lightweight
- **Technology:** [stack]
- **Tests / required checks:** [commands and CI jobs]
- **Deployment:** [environment and release method]
- **Material paths:** `.github/**`
- **Control overrides:** None
- **Standing delegations:** None

Stage is one of PoC, Pilot or Production; profile is Lightweight, Standard or Strict (see `GOVERNANCE.md` → Profiles and controls). Keep the profile word first on its line: the approval check reads it. Material paths are backtick-quoted globs that always make a PR material. Control overrides are lasting changes to one control of the profile, for example: "Release approval: as in Strict (Owner, 2026-10-17, customer-facing launch)". An override does not change any check by itself; the same PR must make the matching CI or GitHub settings change (see `GOVERNANCE.md` → Profiles and controls). Temporary exemptions, such as no approvals for one feature, are review waivers (GitHub issues labelled `review-waiver`), not entries here.

Reassess the profile before the first production deployment. Changing this file does not configure GitHub rules, CI or Copilot; see `GOVERNANCE.md` → GitHub settings per profile.

## Profile history

| Date | From → to | Stage | Reason | Approved by |
|---|---|---|---|---|
| [date] | — → Lightweight | PoC | Project start | [Owner] |

## Available AI and development tools

These are starting assumptions; confirm actual access, plan limits and project suitability before relying on them.

| Service | Plan / budget | Typical use |
| --- | --- | --- |
| ChatGPT | Plus (existing subscription) | Planning, architecture, implementation, coordination |
| Claude | Pro (existing subscription) | Implementation, alternative approaches, independent review |
| GitHub Copilot | Pro (existing subscription) | Coding assistance and PR reviews |
| GitHub | Free tier; Copilot billed separately | Repository, pull requests, Actions / CI |
| Cloudflare | Free tier preferred | Hosting, Workers, static assets, deployment |

**Cost policy:** Prefer existing subscriptions and free tiers. Do not introduce paid APIs, subscriptions, metered infrastructure or recurring costs without Owner approval. Verify current quotas and limits before choosing an architecture.

**Access policy:** A subscription does not imply API access, unrestricted usage or permission to act through a connector. Verify available tools, permissions and deployment capability. Prefer simple, maintainable, portable architectures; choose a different provider when requirements justify it.

## Shared infrastructure and known limits

GitHub and Cloudflare are shared by all projects. Plan for aggregate resource use, not an assumed independent quota per repository.

| Service | Planning constraint (October 2026; verify before use) |
| --- | --- |
| ChatGPT Plus | Variable usage limits; API billed separately |
| Claude Pro | Session and weekly usage limits; API billed separately |
| Copilot Pro | Plan-specific premium requests and review limits |
| GitHub Free | Actions allowance commonly 2,000 minutes/month for private repositories; storage and other limits apply |
| Cloudflare Workers Free | Common reference: 100,000 requests/day and 10 ms CPU/request; asset and build limits also apply |

Current official documentation: [GitHub Actions billing](https://docs.github.com/en/billing/concepts/product-billing/github-actions), [Cloudflare Workers limits](https://developers.cloudflare.com/workers/platform/limits/), [Copilot plans](https://github.com/features/copilot/plans).

**Resource policy:** Prefer efficient CI triggers, caching, static delivery when suitable and proportionate background schedules. Avoid redundant builds, deployments, polling, storage and API calls. Preserve functionality, reliability, security and user experience. Check which limits are account-wide versus per-resource, and verify current usage before significant decisions. Escalate expected capacity pressure or paid upgrades to the Owner.
