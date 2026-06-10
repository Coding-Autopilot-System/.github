# Coding-Autopilot-System

AI-native engineering portfolio focused on autonomous workflows, prompt governance,
multi-agent execution, and enterprise operating models.

This organization is structured as a small platform, not a random set of demos.
The core story is:

1. install a governed workstation,
2. run prompt-aware and agent-aware engineering workflows,
3. observe, validate, and audit what happened,
4. scale those patterns toward enterprise controls.

## Start Here

- **Autonomous execution**: [gsd-orchestrator](https://github.com/Coding-Autopilot-System/gsd-orchestrator)
- **Prompt governance**: [Promptimprover](https://github.com/Coding-Autopilot-System/Promptimprover)
- **Multi-agent workbench**: [autogen](https://github.com/Coding-Autopilot-System/autogen)
- **Enterprise architecture depth**: [cloud-security-service-model](https://github.com/Coding-Autopilot-System/cloud-security-service-model)

## Portfolio Map

### Flagship Repos

#### [gsd-orchestrator](https://github.com/Coding-Autopilot-System/gsd-orchestrator)

C#/.NET 10 autonomous issue-to-PR engine.

- Reads GitHub issues
- Plans and edits through a state machine
- Uses MCP tooling for GitHub operations
- Preserves checkpointed workflow state for retry and recovery

#### [Promptimprover](https://github.com/Coding-Autopilot-System/Promptimprover)

TypeScript MCP-first prompt governance layer.

- Refines prompts before execution
- Injects repo-aware context and reusable rules
- Builds traceability between prompt intent and engineering output

#### [autogen](https://github.com/Coding-Autopilot-System/autogen)

Python local-first multi-agent engineering workbench.

- Coordinates manager-led agent workflows
- Supports provider routing and fallback
- Keeps operator approvals and run artifacts visible

#### [cloud-security-service-model](https://github.com/Coding-Autopilot-System/cloud-security-service-model)

Enterprise cloud security operating model for Azure and hybrid environments.

- Service architecture and governance
- Controls-as-code posture
- Auditability, metrics, and runbooks

### Supporting Repos

#### [autopilot-core](https://github.com/Coding-Autopilot-System/autopilot-core)

Control plane for org-level CI repair automation.

#### [ci-autopilot](https://github.com/Coding-Autopilot-System/ci-autopilot)

Worker/runtime pattern for queued repair execution on self-hosted runners.

#### [autopilot-demo](https://github.com/Coding-Autopilot-System/autopilot-demo)

Bounded demo target for the full failure-to-fix loop.

## What This Portfolio Demonstrates

- C#/.NET, TypeScript, Python, PowerShell, and Bicep across one coherent platform story
- MCP integration as infrastructure, not just local tooling
- Multi-agent and autonomous workflow design with operational guardrails
- Enterprise-oriented concerns: auditability, resilience, boundaries, rollout, and documentation
- Azure and hybrid architecture thinking beyond application code alone

## Review Path

If you are evaluating this portfolio quickly:

1. Read [gsd-orchestrator](https://github.com/Coding-Autopilot-System/gsd-orchestrator) for autonomous execution design.
2. Read [Promptimprover](https://github.com/Coding-Autopilot-System/Promptimprover) for prompt governance and MCP thinking.
3. Read [autogen](https://github.com/Coding-Autopilot-System/autogen) for operator-facing multi-agent runtime design.
4. Read [cloud-security-service-model](https://github.com/Coding-Autopilot-System/cloud-security-service-model) for enterprise architecture depth.

Built by [@OgeonX-Ai](https://github.com/OgeonX-Ai).
