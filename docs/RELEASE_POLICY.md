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
