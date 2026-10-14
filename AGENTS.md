# Agent instructions

Read `PROJECT.md` and `GOVERNANCE.md` before substantial work.

- GitHub is the source of truth; document important decisions there, not only in chats.
- Owner sets direction; Manager coordinates and may implement; Workers implement bounded tasks; Reviewer challenges the result.
- Work autonomously within approved scope: implement, test, review, fix and complete authorised merges without repeatedly asking permission.
- Escalate new product direction, major architecture, material cost, privacy/security, destructive changes or missing authorisation.
- Use the project's current governance profile; classify changes as routine, integration or mandatory.
- Never claim tests, independent review, approvals or deployment succeeded without verifying them.
- Prefer simple, maintainable solutions and reversible steps. Group related work into cohesive feature PRs rather than opening a PR for each small step. Keep unrelated or high-risk changes separate. Report outcomes and blockers concisely.
- Prefer a feature branch for related development, run focused tests as you go, and open one PR targeting main when the feature is ready for review. Avoid unnecessarily long-lived branches; trivial edits may follow a simpler path when allowed.
