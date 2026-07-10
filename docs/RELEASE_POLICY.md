# Release Policy

## Release Readiness

A releasable repository must have:

- a versioned, reviewable source commit;
- passing required validation;
- documented user-visible changes and known limitations;
- dependency and vulnerability review;
- rollback or disablement guidance;
- no unresolved release-blocking security findings.

## Release Process

1. Select the validated source commit from the protected default branch.
2. Assign a semantic version when the repository publishes a versioned artifact.
3. Generate release notes that identify changes, migrations, and known risks.
4. Build from a clean environment using locked dependencies.
5. Publish checksums, SBOM, signatures, and provenance where the ecosystem supports it.
6. Verify the published artifact and installation path.
7. Record rollback instructions and monitor post-release signals.

Tags and release artifacts are immutable. Corrections use a new version rather than
rewriting published history.

## Pre-1.0 And Demonstration Repositories

Repositories that are demonstrations or not yet stable must state that clearly in
their README. They still require reproducible setup, validation evidence, and explicit
safety boundaries.

## Release Automation (v1.5)

1. **Tool: release-please via a single reusable workflow.** All 13 portfolio repos
   call `.github/workflows/release-please-reusable.yml` in this repo
   (`Coding-Autopilot-System/.github`) instead of each hand-rolling a
   semver-bump/changelog script or duplicating a release-please config 13 times.
   release-please deterministically parses conventional commits — already enforced
   org-wide by pr-lint's PR-title check — rather than reinventing that parsing logic,
   and its default flow opens a review-gated "release PR" rather than tagging
   directly on every merge, which fits the existing two-party-review governance
   instead of fighting it.
2. **Uniform `release-type: simple` across all 13 repos**, regardless of language
   (C#, Python, Node, PowerShell, docs-only). `simple` only manages a
   `CHANGELOG.md` + version manifest and never mutates a language-specific manifest
   file, avoiding 13 different per-language configurations.
3. **Each repo keeps its own independent SemVer line** — not synced to the CAS
   portfolio milestone number (e.g. v1.5). gsd-orchestrator (already at v4.0.0) and
   cas-contracts (already at v1.1.1) already prove per-repo versioning is
   independent of portfolio milestone numbering; forcing a shared baseline across
   repos with unrelated existing tag histories would be meaningless and would
   collide with gsd-orchestrator's real v4.x line.
4. **Bootstrap baseline.** Repos with zero existing GitHub tags (including this
   repo, org-dotgithub) bootstrap their `.release-please-manifest.json` at
   `"0.0.0"` so release-please's first run computes the genuine first version from
   complete commit history. Repos with a real existing latest tag on GitHub (e.g.
   gsd-orchestrator at `4.0.0`, cas-contracts at `1.1.1`) bootstrap their manifest
   from that real tag so their first automated release only covers what changed
   since that point. Baselines are verified against `gh api .../tags` output, not
   assumed from local-only tags.
5. **SHA-pinned cross-repo dependency.** Other repos pin their caller workflow's
   `uses:` line to a specific org-dotgithub commit SHA (never `@main`), and the
   third-party `googleapis/release-please-action` inside this reusable workflow is
   itself SHA-pinned, per the existing Phase 31 org action-pinning policy. Bumping
   the pinned release-please-action version later requires a deliberate, reviewed
   SHA update in each caller — the same accepted maintenance tradeoff Phase 31
   already established for direct action pins.
