# Governance

Coding Autopilot System is a maintainer-led engineering portfolio. Governance favors
clear ownership, auditable decisions, and bounded automation over process volume.

## Roles

- **Maintainer:** sets direction, approves releases, manages security reports, and
  owns repository settings.
- **Contributor:** proposes scoped changes and supplies validation evidence.
- **Automation:** may analyze, test, document, or prepare changes, but is not an
  accountable approver.

The current maintainer is [@OgeonX-Ai](https://github.com/OgeonX-Ai).

## Decision Model

Routine, reversible changes are decided through pull-request review. Breaking,
cross-repository, security-sensitive, or architectural changes require an issue or
decision record before implementation.

The maintainer has final decision authority and documents material trade-offs in the
relevant issue, pull request, or architecture record.

## Change Controls

- Default branches should reject direct pushes and require passing validation.
- Pull requests must document intent, risk, verification, and rollback.
- Workflow, identity, permission, dependency, and autonomous-action changes receive
  explicit security review.
- Releases use immutable source commits and documented release notes.
- Emergency changes remain reviewable and receive retrospective evidence.

## Autonomous System Boundaries

Automation must operate with least privilege, bounded scope, explicit inputs, and
observable outputs. Human approval is required before destructive, externally
consequential, or production-changing actions. Model output is always untrusted input.

## Policy Changes

Changes to organization-wide policies use a pull request in this repository. Repository
specific policies may be stricter and take precedence for that repository.
