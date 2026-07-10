<#
.SYNOPSIS
  Fail-closed auto-merge eligibility classifier (REQ-1.5.1 / Phase 38-01 Task 1).
.DESCRIPTION
  Classifies a PR's changed-file set as IN-CLASS (safe to auto-merge via the
  review-bot flow, see docs/merge-flow-policy.md) or OUT-OF-CLASS (falls back
  to ordinary human review). The decision is derived strictly from the actual
  changed paths returned by `gh pr view --json files` plus the PR author from
  `gh pr view --json author` -- NEVER from labels or title, which are
  author-controllable and therefore untrusted input for this decision.

  IN-CLASS iff EITHER:
    (a) the author login is 'dependabot[bot]' AND every changed path is a
        dependency-manifest file (package*.json, requirements*.txt,
        *.csproj, Directory.Packages.props, common lockfiles), OR
    (b) every changed path matches the docs allowlist
        (**/*.md, **/*.mdx, docs/**, including docs/wiki/assets/** and
        docs/wiki/diagrams/**).

  The denylist (workflow files under .github/workflows/**, executables,
  scripts, and non-docs config/source files) applies to ALL authors,
  including dependabot: a dependabot PR that touches .github/workflows/**
  (its github-actions ecosystem PRs legitimately do) is OUT-OF-CLASS, even
  though every other changed path is a manifest file. This is checked FIRST,
  before the manifest/docs checks, so it cannot be bypassed by author
  identity (regression coverage for plan-checker blocker #2).

  Classification never depends on PR labels or PR title.

.PARAMETER PrNumber
  The PR number to classify.
.PARAMETER Repo
  The "owner/repo" slug, as accepted by `gh pr view --repo`.
.PARAMETER SelfTest
  Runs the built-in table-driven fixtures instead of calling gh. Exits 0 if
  all fixtures pass, 1 otherwise. Use this in CI/local verification; it does
  not require network access or a gh session.
.EXAMPLE
  pwsh -File classify-automerge-eligibility.ps1 -PrNumber 42 -Repo Coding-Autopilot-System/autogen
  pwsh -File classify-automerge-eligibility.ps1 -SelfTest
#>
[CmdletBinding()]
param(
    [int]$PrNumber,
    [string]$Repo,
    [switch]$SelfTest
)
$ErrorActionPreference = 'Stop'

# --- Pattern tables -----------------------------------------------------

# Docs allowlist: markdown, mdx, and anything under docs/ (this already
# covers docs/wiki/assets/** and docs/wiki/diagrams/** since those are
# subpaths of docs/).
$script:DocsPatterns = @(
    '\.md$',
    '\.mdx$',
    '^docs/'
)

# Dependency-manifest patterns: only relevant when the author is
# dependabot[bot]. Deliberately narrow -- these are the files a dependency
# bump legitimately touches.
$script:ManifestPatterns = @(
    '(^|/)package(-lock)?\.json$',
    '(^|/)requirements.*\.txt$',
    '\.csproj$',
    '(^|/)Directory\.Packages\.props$',
    '(^|/)yarn\.lock$',
    '(^|/)pnpm-lock\.yaml$',
    '(^|/)Gemfile\.lock$',
    '(^|/)poetry\.lock$',
    '(^|/)Cargo\.lock$',
    '(^|/)composer\.lock$'
)

# Explicit deny extensions/paths that always force OUT-OF-CLASS, evaluated
# BEFORE the manifest check so dependabot cannot smuggle a workflow-file
# change through as part of a "manifest-only" changeset.
$script:WorkflowDenyPatterns = @(
    '^\.github/workflows/'
)

$script:ExecDenyPatterns = @(
    '\.ya?ml$',
    '\.ps1$',
    '\.py$',
    '\.cs$',
    '\.ts$',
    '\.js$',
    '(^|/)Dockerfile'
)

function Test-PathAgainstPatterns {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string[]]$Patterns
    )
    foreach ($pattern in $Patterns) {
        if ($Path -match $pattern) { return $true }
    }
    return $false
}

function Get-PathClass {
    <#
    Classifies a single changed path into one of: 'deny', 'docs', 'manifest',
    'other'. Order is significant: workflow-deny is checked first so it can
    never be shadowed by a manifest or docs match (blocker #2 fix).
    #>
    param([Parameter(Mandatory = $true)][string]$Path)

    $normalized = $Path -replace '\\', '/'

    if (Test-PathAgainstPatterns -Path $normalized -Patterns $script:WorkflowDenyPatterns) {
        return 'deny'
    }
    if (Test-PathAgainstPatterns -Path $normalized -Patterns $script:DocsPatterns) {
        return 'docs'
    }
    if (Test-PathAgainstPatterns -Path $normalized -Patterns $script:ManifestPatterns) {
        return 'manifest'
    }
    if (Test-PathAgainstPatterns -Path $normalized -Patterns $script:ExecDenyPatterns) {
        return 'deny'
    }
    if ($normalized -match '\.json$') {
        # Non-docs, non-manifest JSON (e.g. tsconfig.json, app config) -- deny.
        return 'deny'
    }
    # Fail-closed: any path we do not explicitly recognize is denied rather
    # than silently allowed.
    return 'deny'
}

function Get-Classification {
    <#
    Returns a pscustomobject with Decision ('IN-CLASS' | 'OUT-OF-CLASS') and
    Reason (populated for OUT-OF-CLASS).
    #>
    param(
        [Parameter(Mandatory = $true)][string[]]$Paths,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Author
    )

    if (-not $Paths -or @($Paths).Count -eq 0) {
        return [pscustomobject]@{ Decision = 'OUT-OF-CLASS'; Reason = 'no changed files reported' }
    }

    $classes = @($Paths) | ForEach-Object { [pscustomobject]@{ Path = $_; Class = (Get-PathClass -Path $_) } }

    $denied = @($classes | Where-Object { $_.Class -eq 'deny' })
    if ($denied.Count -gt 0) {
        $deniedList = ($denied | ForEach-Object { $_.Path }) -join ', '
        return [pscustomobject]@{
            Decision = 'OUT-OF-CLASS'
            Reason   = "denylisted path(s) present (workflow/executable/non-docs config): $deniedList"
        }
    }

    $isDependabot = ($Author -eq 'dependabot[bot]')
    $allManifest = -not (@($classes | Where-Object { $_.Class -ne 'manifest' }).Count -gt 0)
    $allDocs = -not (@($classes | Where-Object { $_.Class -ne 'docs' }).Count -gt 0)

    if ($isDependabot -and $allManifest) {
        return [pscustomobject]@{ Decision = 'IN-CLASS'; Reason = $null }
    }
    if ($allDocs) {
        return [pscustomobject]@{ Decision = 'IN-CLASS'; Reason = $null }
    }

    if ($isDependabot -and -not $allManifest) {
        return [pscustomobject]@{ Decision = 'OUT-OF-CLASS'; Reason = 'dependabot PR touches non-manifest path(s); manifest-only requirement not met' }
    }
    return [pscustomobject]@{ Decision = 'OUT-OF-CLASS'; Reason = 'changeset is not pure-docs and author is not dependabot[bot] with manifest-only changes' }
}

# --- Self-test fixtures --------------------------------------------------

function Invoke-SelfTest {
    $fixtures = @(
        [pscustomobject]@{
            Name     = 'pure-docs'
            Paths    = @('docs/merge-flow-policy.md', 'README.md')
            Author   = 'someuser'
            Expected = 'IN-CLASS'
        },
        [pscustomobject]@{
            Name     = 'docs-plus-one-workflow-file'
            Paths    = @('docs/foo.md', '.github/workflows/ci.yml')
            Author   = 'someuser'
            Expected = 'OUT-OF-CLASS'
        },
        [pscustomobject]@{
            Name     = 'dependabot-manifest-only'
            Paths    = @('package.json', 'package-lock.json')
            Author   = 'dependabot[bot]'
            Expected = 'IN-CLASS'
        },
        [pscustomobject]@{
            Name     = 'dependabot-with-workflow-file'
            Paths    = @('package.json', '.github/workflows/ci.yml')
            Author   = 'dependabot[bot]'
            Expected = 'OUT-OF-CLASS'
        },
        [pscustomobject]@{
            Name     = 'mixed-docs-and-code'
            Paths    = @('docs/foo.md', 'src/app.ts')
            Author   = 'someuser'
            Expected = 'OUT-OF-CLASS'
        }
    )

    $pass = 0
    $fail = 0
    foreach ($fx in $fixtures) {
        $result = Get-Classification -Paths $fx.Paths -Author $fx.Author
        if ($result.Decision -eq $fx.Expected) {
            Write-Host ("PASS  {0} -> {1}" -f $fx.Name, $result.Decision) -ForegroundColor Green
            $pass++
        }
        else {
            Write-Host ("FAIL  {0} -> expected {1}, got {2} ({3})" -f $fx.Name, $fx.Expected, $result.Decision, $result.Reason) -ForegroundColor Red
            $fail++
        }
    }
    Write-Host ("SelfTest: {0} passed, {1} failed" -f $pass, $fail)
    return ($fail -eq 0)
}

# --- Entry point -----------------------------------------------------------

if ($SelfTest) {
    if (Invoke-SelfTest) { exit 0 } else { exit 1 }
}

if (-not $PrNumber -or -not $Repo) {
    Write-Error "PrNumber and Repo are required unless -SelfTest is used."
    exit 1
}

$ghJson = & gh pr view $PrNumber --repo $Repo --json files, author 2>$null
if (-not $ghJson) {
    Write-Output "automerge-eligibility: OUT-OF-CLASS reason=unable to read PR files/author via gh (fail-closed)"
    exit 1
}

try {
    $prData = $ghJson | ConvertFrom-Json
}
catch {
    Write-Output "automerge-eligibility: OUT-OF-CLASS reason=unable to parse gh pr view output (fail-closed)"
    exit 1
}

$changedPaths = @($prData.files | ForEach-Object { $_.path })
$authorLogin = $prData.author.login

$decision = Get-Classification -Paths $changedPaths -Author $authorLogin

if ($decision.Decision -eq 'IN-CLASS') {
    Write-Output "automerge-eligibility: IN-CLASS"
    exit 0
}
else {
    Write-Output ("automerge-eligibility: OUT-OF-CLASS reason={0}" -f $decision.Reason)
    exit 1
}
