# Organization Architecture and Governance

This document outlines the architecture and logical flow of the `org-dotgithub` repository within the broader **Coding-Autopilot-System (CAS)** ecosystem.

## Logical Architecture

The `org-dotgithub` repository acts as the governance and standardization hub. GitHub automatically falls back to this repository for any organization repository that lacks specific health files or issue templates.

### Organization Fallback Mechanism

```mermaid
graph TD
    %% Define Styles
    classDef orgRepo fill:#2C3E50,stroke:#34495E,stroke-width:2px,color:#ECF0F1
    classDef portfolioRepo fill:#2980B9,stroke:#3498DB,stroke-width:2px,color:#ECF0F1
    classDef externalUser fill:#8E44AD,stroke:#9B59B6,stroke-width:2px,color:#ECF0F1
    classDef policy fill:#27AE60,stroke:#2ECC71,stroke-width:2px,color:#ECF0F1
    
    User((Developer /<br/>Contributor)):::externalUser

    subgraph "Coding-Autopilot-System Organization"
        OrgHub["org-dotgithub<br/>(Central Governance & Profile)"]:::orgRepo
        
        Repo1["gsd-orchestrator"]:::portfolioRepo
        Repo2["Promptimprover"]:::portfolioRepo
        Repo3["cas-reference-product"]:::portfolioRepo
        RepoN["... other repos"]:::portfolioRepo
        
        Profile["Profile Landing Page<br/>(profile/README.md)"]:::policy
        Health["Community Health Files<br/>(CODE_OF_CONDUCT, SECURITY)"]:::policy
        Templates["Issue/PR Templates"]:::policy
        
        OrgHub --> Profile
        OrgHub --> Health
        OrgHub --> Templates
    end

    User -->|Visits Org| Profile
    User -->|Creates PR/Issue| Repo1
    User -->|Creates PR/Issue| Repo2
    
    Repo1 -. "Inherits Defaults" .-> Templates
    Repo2 -. "Inherits Defaults" .-> Health
    Repo3 -. "Inherits Defaults" .-> Health
    RepoN -. "Inherits Defaults" .-> Templates
```

## Portfolio Map Integration

As the central hub, this repository documents the relationship between all CAS core components:

1. **Foundations**: `cas-contracts`, `cas-platform`, `cas-evals`
2. **Flagship Engines**: `gsd-orchestrator`, `Promptimprover`, `autogen`
3. **Reference Implementations**: `cas-reference-product`
4. **Workstation Environment**: `cas-workstation`

By centralizing the `profile/README.md`, `org-dotgithub` ensures that structural updates to the CAS portfolio only need to be published in one place, automatically updating the organization's public-facing GitHub profile.
