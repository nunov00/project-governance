# Project configuration

- **Project:** [name]
- **Purpose:** [one sentence]
- **Owner:** [name]
- **Manager:** ChatGPT (or designated manager)
- **Governance profile:** Lightweight
- **Stage:** Development
- **Technology:** [stack]
- **Tests / required checks:** [commands and CI jobs]
- **Deployment:** [environment and release method]
- **Automatic Copilot PR reviews:** Recommended; enable in GitHub if available
- **Owner-approved exceptions / standing delegations:** None

Start Lightweight unless the project's risk requires stronger controls. Reassess before production or significant security/data changes. Changing this file does not configure GitHub rules, CI or Copilot automatically.

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
