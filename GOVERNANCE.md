# Project governance — v0.1

## Principles
The repository is the source of truth. The Owner decides product direction, material architecture, costs, privacy/security policy and governance. The Manager (normally ChatGPT) plans, coordinates and handles routine technical decisions. Workers implement; reviewers challenge changes. Roles are interchangeable, but self-review is not independent review.

Maximise progress within approved scope. During product development, prioritise working software, rapid experimentation and short feedback cycles. Agents may refine implementation, UX details and technical approaches within approved objectives; complete reasonable fixes and refinements without treating each discovery as new scope. Avoid excessive planning, documentation, approvals and review cycles. Do not repeatedly seek approval for implementation details, testing, review remediation or an already authorised merge. Do not expand scope or bypass gates. Keep solutions proportionate and avoid bureaucracy.

## Profiles
The active profile is recorded in `PROJECT.md`. Start with **Lightweight** unless project risks justify stronger controls; reassess as risks evolve, including before production. Production does not automatically require Standard for a low-risk utility.

| | Lightweight | Standard | Strict |
|---|---|---|---|
| Use | Prototype / experiment | Normal development / production | High-risk or regulated work |
| Branch and PR | Recommended | Required | Required |
| Checks | Focused, relevant tests | Automated relevant tests and build | Extended testing and security checks |
| Review | Focused self-review and advisory Copilot PR review where available | Reviewer for material integration | Independent reviewer for material changes |
| Releases | Flexible, verified | Green gates before production | Green gates and explicit release approval |
| Records | Brief decisions | Significant decisions documented | Formal risk/change evidence |

Automatic Copilot PR review is recommended for every profile where available, but must be enabled separately in GitHub (template files do not copy rulesets). Keep routine Lightweight feedback advisory, address substantive findings, and use additional independent scrutiny for high-risk changes. A Copilot comment does not equal formal approval or different-provider review.

A profile is a minimum, not a substitute for assessing risk. Critical safeguards apply in every profile. Do not treat a prototype profile as permission to expose unsafe production changes.

## Change classification
- **Routine:** Narrow, reversible, within approved scope; focused review and proportionate tests. Manager may merge if authorised.
- **Integration:** Activates an approved feature or significant behaviour; review the combined feature, tests and deployment impact before merge. Staged inactive scaffolding may be reviewed at the integration gate.
- **Mandatory:** Material changes to governance authority, review requirements or safeguards, or major architecture; secrets, security/privacy/authentication; permissions or weakened CI gates; destructive/data-loss changes; major dependencies/costs; production publication safeguards. Requires independent review and Owner approval for decisions reserved to the Owner.

Classify by highest risk, not diff size. Splitting work cannot avoid a review gate. Prefer a reviewer who did not implement the change; a different AI provider is preferable for mandatory reviews. Copilot review can supplement or, for lower-risk eligible changes, serve as an independent review execution, but does not prove provider independence. For security, substantive governance controls, secrets and CI-permission changes, require a different-provider review or explicit Owner acceptance of the exact change and risks. A review comment is not necessarily a GitHub approval.

## Normal workflow
Objective → feature branch → implementation and focused tests → cohesive PR into main → appropriate review → merge → verify deployment (if any).

Prefer one PR per completed feature or meaningful deliverable, not per implementation step. Keep unrelated or high-risk work separate, and avoid long-lived branches. In Lightweight projects, feature branches and PRs are preferred but not mandatory for trivial edits, subject to actual branch rules. Copilot review normally runs on a PR targeting main rather than on each development commit.

PRs should state what changed, why, checks run, review class and any remaining risks. Check the current head before merge; changed code may need re-testing and re-review. Resolve important findings, and never merge failing required checks without explicit exception. Owner approval is required for material product/architecture, costs, security/privacy policy, destructive changes and substantive changes to governance controls; it is not required again for routine execution of an already approved decision.

## Changing profiles
The Owner may approve a profile change at any stage. The Manager proposes a short checklist and implements the change in one governed PR:
1. Record old/new profile, reason and effective stage in `PROJECT.md`.
2. Adjust actual CI, branch rules, review requirements and release controls to match.
3. Verify the controls work; record any gaps and obtain Owner approval for exceptions.

Reassess **Lightweight → Standard** before production or when risk grows: confirm tests, CI, branch protection, reviews, secrets management, deployment and rollback. **Standard → Strict** adds risk-specific controls. Downgrades are allowed for genuinely isolated work, but must not weaken protections for existing production branches, deployments or data. Profile changes never silently happen on an agent's initiative.

## Improve gradually
Routine editorial clarifications to governance documents may use proportionate review if they do not alter decision rights, gates or safeguards; substantive policy changes remain mandatory. Record important decisions in a PR or short ADR. Amend this framework only when a concrete need emerges. Keep project-specific policies in `PROJECT.md` or separate project documentation.
