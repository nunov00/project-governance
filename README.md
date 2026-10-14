# Project Governance

A small, reusable governance template for projects developed with human and AI contributors. Inspired by the working practices refined in **Five Minutes**, without its project-specific rules.

## Start a new project

1. In GitHub, select **Use this template → Create a new repository**.
2. Edit **[PROJECT.md](PROJECT.md)**: name, purpose, owner, technology, checks and deployment. **Lightweight** is the default.
3. Ask your AI manager or developer to read **[AGENTS.md](AGENTS.md)** and **[GOVERNANCE.md](GOVERNANCE.md)** before making changes.
4. Enable **automatic GitHub Copilot code reviews** for pull requests if available to your account/repository. Check repository **Settings → Rules → Rulesets** (or the available Copilot code-review settings); choose automatic review and keep it advisory for routine Lightweight work. Settings and availability can vary.
5. Start building. Add CI and branch protection appropriate to the project's risk. **Template files do not copy repository rulesets or automatically enable Copilot reviews.**

**Suggested starting prompt:**

> Read PROJECT.md, AGENTS.md and GOVERNANCE.md. Help me initialise this project with Lightweight governance unless the risks justify more. Identify only essential missing decisions, propose minimal checks and GitHub protections, and proceed within the agreed scope.

## Choose a profile

| Profile | When to use | Approach |
| --- | --- | --- |
| **Lightweight (default)** | New projects, experiments and prototypes | Fast iteration, focused checks, minimal process |
| **Standard** | Projects with growing production, reliability or data risks | PRs, automated checks and proportionate review |
| **Strict** | Sensitive, high-risk or regulated systems | Stronger independent review, verification and release controls |

Start Lightweight **unless the project's risks already warrant Standard or Strict**. Production readiness should trigger a reassessment, not an automatic promotion. A simple production utility may remain Lightweight with suitable safeguards. Security, secrets and destructive changes require appropriate scrutiny under every profile.

## Copilot reviews

Automatic Copilot PR review is recommended in **all profiles** where available. Treat findings as advisory for routine Lightweight changes, address substantive issues, and request a fresh review after meaningful changes when needed. A Copilot comment is not necessarily a formal GitHub approval or a different-provider review. High-risk changes may require additional independent scrutiny.

**Enable this separately for each new repository** unless account-level settings already apply. Verify the first pull request receives the intended review. Do not add blocking review gates merely to enable advisory Copilot feedback.

## Change profile later

Profiles are **not permanent**. A common path is **Lightweight → Standard** as risks increase, but transitions require Owner approval and should be proportionate.

Ask:

> Assess whether this project needs Standard governance. Show missing checks and protections, then implement the approved transition.

A transition must update real CI, branch protections and review/release controls, not just PROJECT.md. Do not weaken safeguards for existing production systems when experimenting.

## What the files do

- **[PROJECT.md](PROJECT.md)** — editable settings and active profile.
- **[AGENTS.md](AGENTS.md)** — short instructions for AI contributors.
- **[GOVERNANCE.md](GOVERNANCE.md)** — roles, decision rights, review levels and profile transitions.
- **README.md** — this quick-start guide.

## Working principles

The Owner controls direction and significant decisions. The Manager coordinates and executes routine work autonomously within approved scope. Workers implement; reviewers challenge changes. Use the smallest process that safely fits the risk. Keep important decisions in GitHub rather than relying on chat history.

This is a **starting framework, not a preconfigured CI/security solution**. Adapt it as the project grows; avoid adding process without a concrete reason.
