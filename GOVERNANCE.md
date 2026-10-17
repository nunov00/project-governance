# Project governance — v0.2

## Principles
The repository is the source of truth. The Owner decides product direction, material architecture, costs, privacy/security policy and governance. The Manager (normally ChatGPT) plans, coordinates and handles routine technical decisions. Workers implement; reviewers challenge changes. Roles are interchangeable, but self-review is not independent review.

Maximise progress within approved scope. During product development, prioritise working software, rapid experimentation and short feedback cycles. Agents may refine implementation, UX details and technical approaches within approved objectives; complete reasonable fixes and refinements without treating each discovery as new scope. Do not repeatedly seek approval for implementation details, testing, review remediation or an already authorised merge. Do not expand scope or bypass gates. Keep solutions proportionate and avoid bureaucracy.

## Shared resource stewardship
GitHub and Cloudflare are used across multiple projects. Architecture and automation decisions should account for aggregate CI, build, deployment, storage, request and background-job consumption. Prefer efficient solutions without compromising product outcomes, security, reliability or maintainability. Verify current quota scope and usage; obtain Owner approval before adding paid capacity. See `PROJECT.md` for planning constraints.

## Profiles and controls
The active profile is recorded in `PROJECT.md`. A profile is a preset of the controls below; `PROJECT.md` may override individual controls with an Owner-approved reason. This table is the single definition of what each profile requires.

| Control | Lightweight | Standard | Strict |
|---|---|---|---|
| Typical stage | PoC, experiment, early pilot | Pilot, normal production | Sensitive, high-risk or regulated production |
| Branch and PR into `main` | Preferred; direct pushes allowed for trivial edits | Required | Required |
| Approvals | None required | Required for **material** changes | Required for **every** PR |
| Who may approve | — | An agent other than the author, or the Owner | An agent other than the author (different provider for mandatory changes), or the Owner |
| Copilot PR review | Optional, advisory | Recommended, advisory | Recommended; substantive findings resolved |
| Required CI checks | None; run focused tests locally | Tests and build | Tests, build and security checks |
| Mandatory-class changes | Owner acceptance recorded in the PR | Approval and Owner acceptance | Different-provider approval and Owner acceptance |
| Waivers | Not needed | Allowed | Allowed |
| Release | Flexible, verified | Green checks before production | Green checks and explicit Owner release approval |
| Records | Brief PR notes | Significant decisions documented | Formal risk, decision and review trail |

Critical safeguards apply in every profile, whatever the overrides: never commit secrets, and never run destructive or data-loss operations on shared or production data without explicit Owner approval.

## Change classification
Every PR into `main` states its class in the description (`Review class: routine | material | mandatory`). Classify by highest risk, not diff size; splitting work cannot avoid a gate. When unsure, choose the higher class.

- **Routine:** narrow, reversible, no material trigger. Examples: docs, tests, refactors without behaviour change, styling and copy, contained bug fixes, patch-level dependency updates.
- **Material:** hits any of these triggers:
  - authentication, authorisation, permissions or other security-relevant code;
  - data schema, migrations, retention or deletion;
  - public APIs, contracts or integrations with external services;
  - CI/CD, deployment, infrastructure or environment configuration;
  - a new runtime dependency, or anything that adds or increases cost;
  - a user-visible production behaviour change that is hard to reverse (not behind a disabled flag);
  - a significant or hard-to-reverse architectural choice;
  - any path listed under **Material paths** in `PROJECT.md`.
- **Mandatory:** material changes to governance authority, approval requirements or safeguards; secrets handling; weakening CI gates or permissions; destructive or data-loss changes; major architecture, dependencies or costs; production publication safeguards. Mandatory changes always need Owner acceptance and cannot be covered by a waiver.

Staged inactive scaffolding may be classified at the point it is activated (the integration PR), provided it has no effect until then.

## Approvals
GitHub does not let you approve your own PR, and AI agents usually act through the Owner's account, so approvals are recorded as **PR comments in a fixed format**:

```
APPROVED · reviewer: <agent> (<provider>) · author: <agent> (<provider>) · commit <sha>
<one-line summary of what was checked and any remaining findings>
```

Rules:
- The implementing agent names itself in the PR description (`Author agent: <agent> (<provider>)`).
- The reviewer must be a different agent from the author. For mandatory changes in Strict, it must be a different provider.
- An approval covers only the named commit. Any later push needs a new approval.
- Copilot PR review never counts as an approval: GitHub only lets it leave comments, it reviews the diff rather than the design, and it is not independent if it helped write the code.
- The Owner usually approves in chat rather than on GitHub. The agent then records it on the PR in the same format (`reviewer: Owner (chat)`), followed by the Owner's words and the date. An Owner approval covers the commit that was current when it was given.
- Never post an approval you did not perform, or on behalf of another agent.

The agent named in a comment is self-declared, since comments come from the same account. This convention guards against mistakes, not deliberate misuse. Standard and Strict projects can enforce it with the approval check in [`templates/github/`](templates/github/README.md).

## Waivers and bypasses
The Owner can always bypass a gate, either for a single PR or for a defined scope.

The Owner may grant either in chat; the agent then records it on GitHub, quoting the Owner's words and the date, before relying on it.

**Single PR:** the PR is merged using the ruleset bypass (by the Owner, or by an agent the Owner told to), and the PR description records `Bypass: <reason> (Owner, <date>)`.

**Review waiver (for a feature or other scope):** a GitHub issue labelled `review-waiver`, opened by the Owner or by an agent on the Owner's instruction, stating:
- **Scope:** the feature, branch or paths it covers;
- **Waives:** approvals only (CI checks still apply unless stated);
- **Reason;**
- **Ends:** a date, or when the feature merges, whichever comes first.

PRs within scope reference it (`Waiver: #<issue>`) and may merge without approval. Closing the issue ends the waiver. When it closes, list the PRs merged under it in the issue so the Owner can choose to review them afterwards. A waiver never covers mandatory-class changes. Agents must not create, widen or extend waivers, or bypass, on their own initiative; report any merge made under a waiver or bypass.

## Multi-agent handoffs and architecture review
Agents may divide work across providers using GitHub as the shared source of truth. The Manager coordinates boundaries and integration; an agent must not assume another agent has access to its chat history. Handoffs give the objective, relevant code/decisions, constraints, acceptance criteria and delivery expectations in proportion to complexity. Read existing interfaces and ADRs before implementing; avoid simultaneous conflicting edits.

| | Lightweight | Standard | Strict |
| --- | --- | --- | --- |
| Handoff | Brief issue/PR description; link relevant context | Explicit interfaces, dependencies, acceptance criteria and integration owner | Traceable responsibilities, contracts and validation evidence |
| Architecture challenge | Optional; seek one for hard-to-reverse proposals | Independent challenge before implementing material architecture; record trade-offs | Different-provider review of material proposals before implementation, with risk evidence |
| Decision record | Short PR note or ADR for non-obvious choices | Significant decisions, alternatives and rationale | Formal decision, risk, approval and review trail |

The Manager reconciles review findings; Owner approval remains required for material architecture, cost and other reserved decisions. If a required reviewer or tool is unavailable, do not misrepresent the review: defer the change or ask the Owner for a bypass or waiver.

## Normal workflow
Objective → feature branch → implementation and focused tests → cohesive PR into `main` → approval if the profile requires it → merge → verify deployment (if any).

Prefer one PR per completed feature or meaningful deliverable, not per implementation step. Keep unrelated or high-risk work separate, and avoid long-lived branches. PRs state what changed, why, checks run, `Review class`, `Author agent` and any remaining risks. Check the current head before merge; never merge failing required checks without an Owner bypass.

## Stages and changing profiles
`PROJECT.md` records the stage (PoC, Pilot or Production) and the profile. Typical defaults: PoC → Lightweight; Pilot → Lightweight or Standard; Production → Standard or Strict.

**Production checkpoint:** before the first production deployment, the Manager must stop and propose a profile assessment. The Owner either approves a transition or records in `PROJECT.md` why the current profile stays.

The Owner may approve a profile change at any stage. The Manager implements it in one PR (classified mandatory):
1. Record old/new profile, reason and stage in `PROJECT.md`.
2. Apply the matching GitHub settings below and any CI changes.
3. Verify the controls work (for example, a test PR is blocked without approval); record gaps and Owner-approved exceptions.

Downgrades are allowed for genuinely isolated work but must not weaken protections for existing production branches, deployments or data. Profile changes never happen on an agent's initiative.

## GitHub settings per profile
Template files do not copy rulesets or enable Copilot; apply these in **Settings → Rules → Rulesets** for the default branch.

| Setting | Lightweight | Standard | Strict |
|---|---|---|---|
| Block force pushes and deletion | Yes | Yes | Yes |
| Require a pull request | Optional | Yes (0 required GitHub approvals) | Yes (0 required GitHub approvals) |
| Required status checks | — | CI jobs + `governance/approval` | CI jobs + `governance/approval` |
| Require branches up to date | — | Optional | Yes |
| Bypass list | — | Owner (repository admin) | Owner (repository admin) |
| Automatic Copilot review | Optional | Recommended | Recommended |

GitHub's own "required approvals" stays at 0 because agents act through the Owner's account; the `governance/approval` check enforces the comment convention instead.

## Improve gradually
Editorial clarifications to governance documents are routine if they do not alter decision rights, gates or safeguards; substantive policy changes are mandatory. Amend this framework only when a concrete need emerges. Keep project-specific policies in `PROJECT.md` or separate project documentation.
