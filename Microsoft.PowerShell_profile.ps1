
# Default Visual Studio Path
$REPOS = $HOME + '\source\repos'

# Function to Take a look at the top left corner of a file
function Glimpse-File {
    param(
        [Parameter(Mandatory)]
        [string]$FileName
    )
    $ColW = 80
    $RowCount = 10
    Get-Content $FileName -TotalCount $RowCount | foreach { if ($_.Length -le $ColW) { $_ } else { $_.SubString(0, $ColW)}  }
}

Function Get-BranchName { return (git branch --show-current) }

Function Git-WordDiff { git diff --word-diff=color $args }

Function Git-Log { git log -n 10 --reverse --oneline $args }

Function Git-PushUpstreamOrigin { git push -u origin (Get-BranchName) }

Function Git-SwitchInteractive {
    $a = git branch -l | Where-Object { $_ -NotLike "``*`` *" }
    if ($? -NE $True) {
        return
    }
    if ($a.Length -EQ 0) {
        Write-Host "No other branches, exiting"
        return
    }
    if ($a -is [string]) {
        $a = @($a)
    }
    $a | ForEach-Object {$counter = 0} { Write-Host "$counter -$_" } { ++$counter } -End $null
    $index = Read-Host "Please select an index"
    $branch = $a[$index]
    if ($?) {
        if ($branch -eq $null) {
            Write-Host "Invalid index. Aborting."
        } else {
            git switch $branch.Trim()
        }
    }    
}

oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\reimagined-octo-sniffle.minimal.omp.json" | Invoke-Expression
