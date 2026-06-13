# Coding-Autopilot-System

AI-native engineering portfolio focused on autonomous workflows, prompt governance,
multi-agent execution, and enterprise operating models.

This organization is structured as a small platform, not a random set of demos.
The core story is:

1. install a governed workstation,
2. exchange work through versioned lifecycle contracts,
3. run prompt-aware and agent-aware engineering workflows,
4. deploy through a managed-identity Azure platform,
5. evaluate, observe, validate, and audit what happened.

## Start Here

- **End-to-end reference product**: [cas-reference-product](https://github.com/Coding-Autopilot-System/cas-reference-product)
- **Verified case study**: [immutable golden-path evidence](https://github.com/Coding-Autopilot-System/cas-reference-product/blob/main/docs/case-study-evidence.md)
- **Workstation bootstrap**: [cas-workstation](https://github.com/Coding-Autopilot-System/cas-workstation)
- **Lifecycle contracts**: [cas-contracts](https://github.com/Coding-Autopilot-System/cas-contracts)
- **Azure platform foundation**: [cas-platform](https://github.com/Coding-Autopilot-System/cas-platform)
- **Evaluation evidence**: [cas-evals](https://github.com/Coding-Autopilot-System/cas-evals)
- **Autonomous execution**: [gsd-orchestrator](https://github.com/Coding-Autopilot-System/gsd-orchestrator)
- **Prompt governance**: [Promptimprover](https://github.com/Coding-Autopilot-System/Promptimprover)
- **Multi-agent workbench**: [autogen](https://github.com/Coding-Autopilot-System/autogen)
- **Enterprise architecture depth**: [cloud-security-service-model](https://github.com/Coding-Autopilot-System/cloud-security-service-model)

## Portfolio Map

### End-to-End Proof

#### [cas-reference-product](https://github.com/Coding-Autopilot-System/cas-reference-product)

Production-oriented reference workload that connects the CAS platform story.

- Demonstrates Foundry Next Gen agent integration through a bounded application
  interface
- Uses managed identity, canonical lifecycle events, health checks, and
  OpenTelemetry boundaries
- Provides the workload contract implemented by `cas-platform` and an executable
  local HTTP golden path evaluated by `cas-evals`
- Publishes a [verified case study](https://github.com/Coding-Autopilot-System/cas-reference-product/blob/main/docs/case-study-evidence.md)
  backed by an [immutable evidence bundle](https://github.com/Coding-Autopilot-System/cas-reference-product/tree/main/evidence/verified-local-golden-path-v0.1)

### Platform Foundations

#### [cas-contracts](https://github.com/Coding-Autopilot-System/cas-contracts)

Authoritative, versioned lifecycle contracts for the complete CAS workflow.

- Standardizes prompts, policy decisions, work requests, run events, artifacts,
  verification, and evaluation
- Requires correlation identifiers and W3C trace context
- Provides executable schemas and compatibility rules

#### [cas-platform](https://github.com/Coding-Autopilot-System/cas-platform)

Secure Azure deployment and observability foundation.

- Uses Bicep, isolated environments, and system-assigned managed identity
- Provides Container Apps hosting, Application Insights, budgets, and safe
  non-deploying validation
- Keeps public ingress disabled by default

#### [cas-evals](https://github.com/Coding-Autopilot-System/cas-evals)

Reproducible evaluation and benchmark evidence.

- Runs deterministic golden-task and adversarial-prompt suites
- Measures quality, safety, cost, and latency independently
- Produces machine-readable evidence suitable for regression gates

### Flagship Repos

#### [cas-workstation](https://github.com/Coding-Autopilot-System/cas-workstation)

Windows-first AI-native developer workstation bootstrap.

- Establishes a repeatable engineering baseline
- Validates installed tools and configuration
- Reduces setup drift before autonomous workflows run

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
- Versioned cross-repository contracts and reproducible evaluation evidence
- MCP integration as infrastructure, not just local tooling
- Multi-agent and autonomous workflow design with operational guardrails
- Enterprise-oriented concerns: auditability, resilience, boundaries, rollout, and documentation
- Azure managed identity, infrastructure-as-code, observability, and hybrid architecture

## Review Path

If you are evaluating this portfolio quickly:

1. Read the [verified case study](https://github.com/Coding-Autopilot-System/cas-reference-product/blob/main/docs/case-study-evidence.md) and inspect its [immutable evidence bundle](https://github.com/Coding-Autopilot-System/cas-reference-product/tree/main/evidence/verified-local-golden-path-v0.1).
2. Read [cas-workstation](https://github.com/Coding-Autopilot-System/cas-workstation) for the reproducible developer baseline.
3. Read [cas-contracts](https://github.com/Coding-Autopilot-System/cas-contracts) for the shared lifecycle and traceability model.
4. Read [cas-platform](https://github.com/Coding-Autopilot-System/cas-platform) for secure Azure hosting and observability.
5. Read [cas-evals](https://github.com/Coding-Autopilot-System/cas-evals) for measurable quality and safety evidence.
6. Read [gsd-orchestrator](https://github.com/Coding-Autopilot-System/gsd-orchestrator) for autonomous execution design.
7. Read [Promptimprover](https://github.com/Coding-Autopilot-System/Promptimprover) for prompt governance and MCP thinking.
8. Read [autogen](https://github.com/Coding-Autopilot-System/autogen) for operator-facing multi-agent runtime design.
9. Read [cloud-security-service-model](https://github.com/Coding-Autopilot-System/cloud-security-service-model) for enterprise architecture depth.

## Organization Standards

Shared contribution, security, support, governance, intake, dependency, and release
policies are maintained in the
[organization `.github` repository](https://github.com/Coding-Autopilot-System/.github).
Repository-specific standards may be stricter.

Built by [@OgeonX-Ai](https://github.com/OgeonX-Ai).
