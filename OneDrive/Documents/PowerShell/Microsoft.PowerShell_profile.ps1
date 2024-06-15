oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.custom.omp.json" | Invoke-Expression

Import-Module PSReadLine
Import-Module -Name Terminal-Icons

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

function Set-SourceCodePath {
  Set-Location -Path "X:\Code"
}

Set-Alias -Name src -Value Set-SourceCodePath

## Add argument completer for the dotnet CLI tool
$scriptblock = {
  param($wordToComplete, $commandAst, $cursorPosition)
  dotnet complete --position $cursorPosition $commandAst.ToString() |
  ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock

Invoke-Expression (& { (zoxide init powershell | Out-String) })