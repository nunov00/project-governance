# Project Governance

A small, reusable governance template for projects developed with human and AI contributors. Inspired by the working practices refined in **Five Minutes**, without its project-specific rules.

## Start a new project

1. In GitHub, select **Use this template → Create a new repository**.
2. Edit **[PROJECT.md](PROJECT.md)**: name, purpose, owner, current profile, technology, checks and deployment.
3. Ask your AI manager or developer to read **[AGENTS.md](AGENTS.md)** and **[GOVERNANCE.md](GOVERNANCE.md)** before making changes.
4. Agree on the first task and start building. Add CI and branch protection as required by the chosen profile; copying this template does **not** configure GitHub settings automatically.

**Suggested starting prompt:**

> Read PROJECT.md, AGENTS.md and GOVERNANCE.md. Help me initialise this project using the selected governance profile. Identify only essential missing decisions, propose the minimum appropriate checks and GitHub protections, then proceed within the agreed scope.

## Choose a profile

| Profile | When to use | Approach |
| --- | --- | --- |
| **Lightweight** | Early experiments and prototypes | Fast iteration, focused checks, minimal process |
| **Standard** | Most applications and production projects | PRs, automated checks and proportionate review |
| **Strict** | Sensitive or high-risk systems | Stronger independent review, verification and release controls |

The default in PROJECT.md is **Standard**. Change it to **Lightweight** when prototyping or **Strict** when justified by risk. Security, secrets and destructive changes always need appropriate safeguards, regardless of profile.

## Change profile later

Profiles are **not permanent**. A common path is **Lightweight → Standard** before production, but changes in either direction are possible with Owner approval.

Ask:

> Assess whether this project is ready to move from Lightweight to Standard. Show the missing checks and protections, then implement the approved transition.

The transition must update the real CI, branch protections and review/release controls, not just the text in PROJECT.md. Never weaken safeguards on an existing production system merely because experimental work is under way.

## What the files do

- **[PROJECT.md](PROJECT.md)** — the project's editable settings and active profile.
- **[AGENTS.md](AGENTS.md)** — short instructions for AI contributors.
- **[GOVERNANCE.md](GOVERNANCE.md)** — roles, decision rights, review levels and profile transitions.
- **README.md** — this quick-start guide.

## Working principles

The Owner controls direction and significant decisions. The Manager coordinates and can execute routine work autonomously within approved scope. Workers implement; reviewers challenge changes. Use the smallest process that safely fits the risk. Keep important decisions in GitHub rather than relying on chat history.

This is a **starting framework, not a preconfigured CI/security solution**. Adapt it as the project grows; avoid adding process without a concrete reason.
