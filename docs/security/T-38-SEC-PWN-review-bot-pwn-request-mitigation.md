# T-38-SEC-PWN: review-bot pwn-request mitigation

## Finding

CodeQL (`actions/checkout-of-untrusted-code`, "Checkout of untrusted code in a
privileged context") flagged `.github/workflows/review-bot.yml` on PR #17.
The `review` job runs on `pull_request_target`, which mints a GitHub App
installation token with `pull-requests: write` scope before the diff step
ran. The prior "Compute PR diff (base...head)" step fetched the PR head ref
directly (`git fetch origin pull/<n>/head:pr-head`) into the runner's local
git object database and then diffed against it. Fetching attacker-controlled
ref content into a privileged job's git state is the classic GitHub Actions
pwn-request pattern (see GitHub's own docs on "Preventing pwn requests"),
even though the original step never wrote that content to the working tree
or executed it directly.

## Mitigation

The privileged `review` job is now checkout-free of any untrusted ref:

- The eligibility classifier (`.github/scripts/classify-automerge-eligibility.ps1`)
  already sourced its input exclusively from `gh pr view --json files,author`
  (API text), not from any checked-out ref.
- The diff step now calls `gh pr diff <n> --repo <repo>` (GitHub API over
  HTTPS, returning diff text) and streams that text directly into
  `critic_cli` over stdin (`--diff -`). No `git fetch`/`git checkout` of the
  PR head, and no PR-head commit ever enters the runner's git object
  database or filesystem.
- The only `actions/checkout` calls remaining in the job are: (1) the job's
  own repository at its default/base ref (never the PR head — no `ref:`
  override is supplied, so under `pull_request_target` this resolves to the
  base branch), and (2) `Coding-Autopilot-System/autogen` pinned to a fixed,
  trusted commit SHA for `critic_cli`. Neither checks out attacker-controlled
  content.
- Added fail-closed handling: if `gh pr diff` itself fails (non-zero exit),
  the job now hard-stops rather than silently treating an empty/partial diff
  as "no findings" and proceeding toward approval.

## Verification

- Structural check: `grep` confirms zero occurrences of `git fetch .*pull/`,
  `pr-head`, or `actions/checkout` with a PR-head `ref:` in
  `.github/workflows/review-bot.yml`. The remaining `actions/checkout` uses
  are the base-ref self-checkout and the pinned trusted `autogen` checkout.
- The change was pushed to PR #17 (`feat/merge-flow-review-bot`); GitHub's
  CodeQL check re-runs automatically on `synchronize` and is expected to
  clear the "Checkout of untrusted code in a privileged context" alert on
  the updated lines.

## Note on scope

This note was added directly to PR #17 rather than to PR #18, because PR #18
("fix(release): resolve reusable workflow reference") is an unrelated
release-engineering fix and does not contain a merge-flow threat table to
update.
