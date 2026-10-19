# Project Governance

A small, reusable governance template for projects developed with human and AI contributors. It scales from a PoC with no review gates to production with mandatory approvals, and the Owner can bypass or waive gates when needed.

## Start a new project

1. In GitHub, select **Use this template → Create a new repository**.
2. Edit **[PROJECT.md](PROJECT.md)**: name, purpose, owner, stage, technology, checks, deployment and available tools/budget. **Lightweight** is the default.
3. Ask your AI manager or developer to read **[AGENTS.md](AGENTS.md)** and **[GOVERNANCE.md](GOVERNANCE.md)** before making changes.
4. Optionally enable **automatic GitHub Copilot code reviews** (Settings → Rules → Rulesets, or the Copilot code-review settings). It is advisory in every profile.
5. Apply the GitHub settings for your profile ([GOVERNANCE.md → GitHub settings per profile](GOVERNANCE.md#github-settings-per-profile)). **Template files do not copy rulesets or enable Copilot.**

**Suggested starting prompt:**

> Read PROJECT.md, AGENTS.md and GOVERNANCE.md. Help me initialise this project with Lightweight governance unless the risks justify more. Identify only essential missing decisions, propose minimal checks and GitHub protections, and proceed within the agreed scope.

## Adopt in an existing project

1. Copy `PROJECT.md`, `AGENTS.md`, `GOVERNANCE.md`, `.github/workflows/privacy.yml` and `templates/` into the repository.
2. Fill in `PROJECT.md`, choosing the profile that matches the protections the repository **actually has today**, not the one you want.
3. Ask the Manager to list the gaps to the target profile, then close them in one profile-transition PR.

## Choose a profile

| Profile | Typical stage | Approvals |
| --- | --- | --- |
| **Lightweight (default)** | PoC, experiments, early pilot | None required |
| **Standard** | Pilot, normal production | Required for material changes |
| **Strict** | Sensitive, high-risk or regulated production | Required for every PR |

The full list of controls per profile is in [GOVERNANCE.md](GOVERNANCE.md#profiles-and-controls). Agents must stop and propose a profile assessment before the first production deployment; the Owner decides whether to change profile. Individual controls can be overridden in `PROJECT.md` with a reason.

## Approvals, bypasses and waivers

AI agents usually act through the Owner's GitHub account, so GitHub's own approvals can't be used. Instead, a reviewing agent (different from the author) posts an `APPROVED · …` comment naming the head commit. Copilot comments are advisory and never count as approvals. For Standard and Strict, copy the approval check in [`templates/github/`](templates/github/README.md) to enforce this.

The Owner approves, bypasses and grants waivers in chat; the agent records each one on GitHub. A bypass covers one PR; a **review waiver** issue covers a whole feature and PRs reference it. Details are in [GOVERNANCE.md → Waivers and bypasses](GOVERNANCE.md#waivers-and-bypasses).

## What the files do

- **[PROJECT.md](PROJECT.md)**: editable settings, stage, active profile, overrides and profile history.
- **[AGENTS.md](AGENTS.md)**: short instructions for AI contributors.
- **[GOVERNANCE.md](GOVERNANCE.md)**: roles, controls per profile, change classes, approvals, waivers and GitHub settings.
- **[.github/workflows/privacy.yml](.github/workflows/privacy.yml)**: the privacy check, active in every profile; it blocks PRs that add personal emails or secrets ([GOVERNANCE.md → Personal data and secrets](GOVERNANCE.md#personal-data-and-secrets)).
- **[templates/github/](templates/github/README.md)**: the approval check workflow, inactive until copied into `.github/workflows/`.
- **README.md**: this quick-start guide.

## Working principles

Favour fast experiments, cohesive feature delivery and autonomous refinements within approved objectives. Escalate genuinely new scope or risk, not every implementation choice. Use existing AI subscriptions and free infrastructure first; verify limits and obtain approval before introducing costs. Keep important decisions in GitHub rather than relying on chat history.

This is a **starting framework, not a preconfigured CI/security solution**. Adapt it as the project grows; avoid adding process without a concrete reason.
