# README

## This script requires AWS Git Secrets and recommends custom regex secrets.
## for more details and install instructions, please follow https://nw-page.github.io/standards/std/security.html#pre-commit-hooks

# Example Usage
# write this in the powershell terminal, adjust for the file type(s) you want to scan - can be multiple types: $fileExtensions = @(".R", ".py")
# then execute this in the terminal: ScanFiles -FileExtensions $fileExtensions

# There's an optional parameter called $filePath. It will automatically set to your current folder
# You can change it if you need like this: $filePath = "path/to/folder"

# It will give you an output of any secrets that are contained in those files

Function ScanFiles{
    param (
        [string]$filePath = (Get-Location).Path,
        [string[]]$fileExtensions
  ) 
    Get-ChildItem $filePath -recurse | Where-Object {$_.extension -in $fileExtensions} | 
    Foreach-Object {

        git secrets --scan $_.FullName | Out-File $logFile -Append

    }
  }