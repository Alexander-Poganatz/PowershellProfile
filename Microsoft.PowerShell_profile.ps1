
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

oh-my-posh init pwsh --config "$HOME\Documents\PowerShell\reimagined-octo-sniffle.minimal.omp.json" | Invoke-Expression
