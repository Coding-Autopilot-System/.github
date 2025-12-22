# Coding Autopilot System

Enterprise automation for CI remediation, self-hosted runners, and guardrailed fixes.

## Platform overview
- Control plane: GitHub Issues as the source of truth
- Operator: self-hosted automation that fixes CI failures and opens PRs
- Guardrails: minimal diffs, verification first, audit trails for every attempt

## Dashboards
- Org status snapshot: `https://github.com/Coding-Autopilot-System/autopilot-core/blob/main/docs/status.md`
- Autopilot dashboard: `https://coding-autopilot-system.github.io/autopilot-core/`

## Repositories
- `autopilot-core` - org control plane, operator, installer, runbooks
- `ci-autopilot` - runner operations, workflows, and alerts
- `autopilot-demo` - end-to-end demo with intentional CI failure
- `.github` - org profile and community health files

## Operations
- Intake: failures open issues with `autofix` + `queued`
- Operator: picks queued issues, runs Codex, opens PRs
- Monitoring: runner offline alerts + email notifications (SMTP)
- Docs: daily status refresh via workflow

## Demos
- Demo template: `autopilot-core/templates/demo-repo`
- Walkthrough: `autopilot-core/docs/demos/demo-repo.md`

## Contact
Use issues in the relevant repo for access requests or support.
