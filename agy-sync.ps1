param(
    [Parameter(Position=0)]
    [string]$Command = "help",
    [Parameter(Position=1)]
    [string]$Arg = ""
)

$ErrorActionPreference = "Stop"

$ConfigDir = Join-Path $HOME ".gemini\config"
$AgentsDir = Join-Path $HOME ".agents"
$DefaultArchive = Join-Path $HOME "antigravity-config-bundle.tar.gz"

function Stage-AgentsIntoConfig {
    $src = Join-Path $AgentsDir "pstack-models.md"
    if (Test-Path $src) {
        $dstDir = Join-Path $ConfigDir "agents"
        New-Item -ItemType Directory -Force -Path $dstDir | Out-Null
        Copy-Item $src (Join-Path $dstDir "pstack-models.md") -Force
    }
}

function Restore-AgentsFromConfig {
    $src = Join-Path $ConfigDir "agents\pstack-models.md"
    if (Test-Path $src) {
        New-Item -ItemType Directory -Force -Path $AgentsDir | Out-Null
        Copy-Item $src (Join-Path $AgentsDir "pstack-models.md") -Force
    }
}

switch ($Command.ToLower()) {
    "apply" {
        Restore-AgentsFromConfig
        $skillsPath = Join-Path $ConfigDir "skills"
        $skills = Get-ChildItem -Path $skillsPath -Directory | Select-Object -ExpandProperty Name
        Write-Host "Applied Antigravity configuration on $env:COMPUTERNAME ($($skills.Count) skills):"
        foreach ($s in $skills) {
            Write-Host "  - $s"
        }
    }
    "push" {
        Stage-AgentsIntoConfig
        Push-Location $ConfigDir
        try {
            git add -A
            $status = git status --porcelain
            if ($status) {
                $date = Get-Date -Format "yyyy-MM-dd"
                git commit -m "chore: sync Antigravity configuration ($date)"
            }
            git push
            Write-Host "Pushed latest Antigravity config to remote."
        } finally {
            Pop-Location
        }
    }
    "pull" {
        Push-Location $ConfigDir
        try {
            git pull --rebase
            Restore-AgentsFromConfig
            Write-Host "Pulled and applied latest Antigravity config."
        } finally {
            Pop-Location
        }
    }
    "export" {
        $out = if ($Arg) { $Arg } else { $DefaultArchive }
        Stage-AgentsIntoConfig
        tar -czf $out -C $HOME ".gemini/config"
        Write-Host "Exported Antigravity config to: $out"
    }
    "import" {
        $inFile = if ($Arg) { $Arg } else { $DefaultArchive }
        if (-not (Test-Path $inFile)) {
            Write-Error "Archive not found: $inFile"
        }
        tar -xzf $inFile -C $HOME
        Restore-AgentsFromConfig
        Write-Host "Imported Antigravity config into $ConfigDir and $AgentsDir."
    }
    default {
        Write-Host @"
Usage: ~/.gemini/config/agy-sync.ps1 <command> [arg]

Commands:
  apply           Restore ~/.agents files after cloning ~/.gemini/config on a new PC
  push            Commit and push any skill/plugin updates in ~/.gemini/config
  pull            Pull latest changes from GitHub and apply them
  export [path]   Create a single-file archive (default: ~/antigravity-config-bundle.tar.gz)
  import [path]   Extract an archive into ~/.gemini/config and ~/.agents
"@
    }
}
