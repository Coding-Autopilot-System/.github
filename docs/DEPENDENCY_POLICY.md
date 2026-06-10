# Dependency And Supply-Chain Policy

## Standard

Each executable repository must:

- commit its package-manager lockfile;
- enable Dependabot or an equivalent automated update service;
- group low-risk development updates where supported;
- keep runtime and security updates reviewable;
- run tests, build, linting, and security checks before merge;
- pin GitHub Actions to immutable commit SHAs;
- produce an SBOM and provenance evidence for published artifacts when practical.

Dependabot configuration is repository-specific and is not inherited from this
organization `.github` repository. Every executable repository therefore owns its
`.github/dependabot.yml`.

## Review Requirements

Dependency updates require review of:

- changelog and breaking-change impact;
- license and source reputation;
- transitive dependency and vulnerability changes;
- install scripts, generated artifacts, and permission changes;
- reproducible validation results.

Automated updates must not bypass required reviews or branch protection. High-severity
security fixes should be prioritized, but emergency handling still requires evidence
and retrospective review.

## Exceptions

Document exceptions in the affected pull request with owner, reason, risk, mitigation,
and expiry date. Permanent unowned exceptions are not accepted.
