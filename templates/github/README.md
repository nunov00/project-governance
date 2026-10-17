# GitHub templates

Files here are **not active** in the template repository. Copy them in when a project moves to Standard or Strict, so Lightweight projects spend no CI minutes on them.

## Approval check

`workflows/governance-approval.yml` enforces the comment-based approvals and review waivers described in [GOVERNANCE.md](../../GOVERNANCE.md#approvals).

1. Copy it to `.github/workflows/governance-approval.yml` in one PR.
2. Make sure `PROJECT.md` on `main` has `Governance profile:` and, optionally, `Material paths:` (backtick-quoted globs).
3. Create the `review-waiver` label.
4. In the default-branch ruleset, add `governance/approval` as a required status check and keep the Owner on the bypass list.
5. Verify: open a test PR with `Review class: material` and no approval; it should be blocked until an approval comment for the head commit is posted.

What it checks, on each PR update or comment:
- **Lightweight:** always passes.
- **Standard:** routine PRs pass, unless they touch a material path. Material and mandatory PRs need an approval or (except mandatory) an open waiver.
- **Strict:** every PR needs an approval or (except mandatory) an open waiver. Mandatory changes need a reviewer from a different provider than the author.

An approval counts only if it names the current head commit, the author agent declared in the PR, and a different reviewer (not Copilot). Owner approvals given in chat are recorded by the agent as `reviewer: Owner (chat)`; a bypass goes through the ruleset.

Limits: profile and material paths are read from the base branch, so a PR cannot loosen its own gate. Comments and issues all come from the Owner's account, so names are self-declared; the check catches mistakes, not deliberate misuse. Each run is a few seconds of Actions time, triggered only by PR events and PR comments.
