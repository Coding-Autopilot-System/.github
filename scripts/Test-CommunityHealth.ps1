[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

$requiredFiles = @(
    'CODE_OF_CONDUCT.md'
    'CONTRIBUTING.md'
    'GOVERNANCE.md'
    'SECURITY.md'
    'SUPPORT.md'
    '.github/CODEOWNERS'
    '.github/PULL_REQUEST_TEMPLATE.md'
    '.github/ISSUE_TEMPLATE/bug.yml'
    '.github/ISSUE_TEMPLATE/feature.yml'
    '.github/ISSUE_TEMPLATE/config.yml'
    'docs/DEPENDENCY_POLICY.md'
    'docs/RELEASE_POLICY.md'
    'profile/README.md'
)

$failures = [System.Collections.Generic.List[string]]::new()

foreach ($relativePath in $requiredFiles) {
    $path = Join-Path $repoRoot $relativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $failures.Add("Missing required file: $relativePath")
        continue
    }

    if ((Get-Item -LiteralPath $path).Length -eq 0) {
        $failures.Add("Required file is empty: $relativePath")
    }
}

$security = Get-Content -LiteralPath (Join-Path $repoRoot 'SECURITY.md') -Raw
if ($security -notmatch 'Do not report vulnerabilities in public') {
    $failures.Add('SECURITY.md must explicitly prohibit public vulnerability reports.')
}

$pullRequestTemplate = Get-Content -LiteralPath (Join-Path $repoRoot '.github/PULL_REQUEST_TEMPLATE.md') -Raw
foreach ($heading in @('## Intent', '## Risk And Safety', '## Verification', '## Rollback')) {
    if ($pullRequestTemplate -notmatch [regex]::Escape($heading)) {
        $failures.Add("Pull request template missing section: $heading")
    }
}

foreach ($issueForm in @('bug.yml', 'feature.yml')) {
    $form = Get-Content -LiteralPath (Join-Path $repoRoot ".github/ISSUE_TEMPLATE/$issueForm") -Raw
    if ($form -notmatch 'validations:' -or $form -notmatch 'required: true') {
        $failures.Add("Issue form lacks required fields: $issueForm")
    }
}

$profile = Get-Content -LiteralPath (Join-Path $repoRoot 'profile/README.md') -Raw
foreach ($repo in @('cas-workstation', 'gsd-orchestrator', 'Promptimprover', 'autogen', 'cloud-security-service-model')) {
    if ($profile -notmatch [regex]::Escape("Coding-Autopilot-System/$repo")) {
        $failures.Add("Profile does not link to flagship repository: $repo")
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Community health validation passed: $($requiredFiles.Count) required files and policy contracts verified."
