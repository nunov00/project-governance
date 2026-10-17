# Agent instructions

Read `PROJECT.md` (including available tools and cost limits) and `GOVERNANCE.md` before substantial work.

- GitHub is the source of truth; document important decisions there, not only in chats.
- Owner sets direction; Manager coordinates and may implement; Workers implement bounded tasks; Reviewer challenges the result.
- Work autonomously within approved scope: implement, test, review, fix and complete authorised merges without repeatedly asking permission.
- Escalate materially new product scope, major architecture, material cost, privacy/security, destructive changes or missing authorisation. Refine implementation, UX details and technical approaches autonomously within approved objectives.
- Check the active profile and stage in `PROJECT.md` before merging. Classify every PR as routine, material or mandatory and declare `Review class:` and `Author agent:` in its description.
- Approvals are PR comments in the format in `GOVERNANCE.md` → Approvals, for the current head commit, by an agent other than the author. Copilot comments are not approvals. Never post an approval you did not perform.
- Never bypass a gate or create, widen or extend a review waiver on your own initiative. When the Owner approves, bypasses or grants a waiver in chat, record it on the PR or a `review-waiver` issue with their words and the date. Report any merge made under a bypass or waiver.
- Before the first production deployment, stop and propose a profile assessment.
- Never claim tests, independent review, approvals or deployment succeeded without verifying them.
- Prefer simple, maintainable solutions and reversible steps. Group related work into cohesive feature PRs rather than opening a PR for each small step. Keep unrelated or high-risk changes separate. Report outcomes and blockers concisely.
- Prefer a feature branch for related development, run focused tests as you go, and open one PR targeting main when the feature is ready for review. Avoid unnecessarily long-lived branches; trivial edits may follow a simpler path when allowed.

- Treat GitHub and Cloudflare capacity as shared across projects. Minimise unnecessary CI runs, builds, deployments, storage, requests and background jobs without compromising quality or outcomes. Check current limits and aggregate usage before making significant architecture decisions.
- Delegate bounded tasks to other agents using a concise GitHub issue/PR handoff: goal, relevant architecture/code, constraints, acceptance criteria, and delivery. Scale detail and review to Lightweight/Standard/Strict; do not assume shared chat history or tool access.
- For significant architectural proposals, invite an independent challenge before expensive implementation according to the active profile and mandatory-change rules. Record material trade-offs and decisions; Copilot PR review supplements rather than replaces required different-provider architecture review.
