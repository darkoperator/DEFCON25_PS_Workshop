
# Help

Update-Help

Save-Help -DestinationPath .\PSHelp -UICulture "en-US" 

Update-Help -UICulture "en-US" -SourcePath .\PSHelp -Force

Get-Help -Name *process*

Get-Help -Name *process* -Category Cmdlet


Get-Help -Name Get-Process

Get-Alias -Definition Get-Process

help ps

help Get-Process -Full

help Get-Process -Examples

help Get-Process -Parameter Name

help Get-Process -Parameter *

help Get-Process -ShowWindow 

help Get-Process -Online

