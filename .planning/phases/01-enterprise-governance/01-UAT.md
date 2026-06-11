# Enterprise Governance UAT

Date: 2026-06-11
Source: `$gsd-audit-fix --severity all --max 8`

## Audit-Fix Classification

| ID | Finding | Severity | Classification | Reason |
|---|---|---|---|---|
| F-01 | Shared contribution and conduct standards are absent | High | Auto-fixable | Standard community health files have a clear location and contract |
| F-02 | No private vulnerability reporting policy exists | High | Auto-fixable | Security policy and response targets are directly testable |
| F-03 | Support channels and boundaries are undefined | Medium | Auto-fixable | Shared support policy has an unambiguous location |
| F-04 | Repositories do not inherit structured issue and PR intake | High | Auto-fixable | GitHub shared template locations are defined |
| F-05 | Ownership, decisions, and autonomous change controls are undefined | High | Auto-fixable | Governance policy and CODEOWNERS are directly implementable |
| F-06 | Dependency and release controls are undocumented | High | Auto-fixable | Organization policies can state minimum repository requirements |
| F-07 | Organization profile omits the workstation entry point and standards | Medium | Auto-fixable | Portfolio inventory confirms the missing repository and policy navigation |
| F-08 | Community health defaults have no repeatable validation | Medium | Auto-fixable | A local contract test can verify required files and content |

## Manual-Only Findings

- Choose an explicit license for this repository and organization-wide defaults.
- Configure branch protection or repository rulesets on default branches.
- Require signed commits or web commit signoff if it matches the maintainer workflow.
- Configure organization Actions policy, security features, and Dependabot per executable repository.
- Establish a production disclosure mailbox or private vulnerability reporting on every repository.
