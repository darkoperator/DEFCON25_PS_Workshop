
# Show History

Get-History

# Show PSReadline History file 

Get-PSReadlineOption

psEdit C:\Users\Carlos\AppData\Roaming\PSReadline\ConsoleHost_history.txt

# Show approved verbs for cmdlets

Get-Verb


# Get-Command
Get-Command

Get-Command -Name *help*

Get-Command -Name *help* -CommandType Function

Get-Command -Name *help* -CommandType Application

Get-Command -Verb Invoke

Show-Command


# Aliases 

Get-Alias -Name dir

Get-Alias -Definition Get-ChildItem

New-Alias -Name "ll" -Value Get-ChildItem -Description "long list just like in HPUX."

Export-Alias -Path .\my_aliases.txt

Import-Alias -Path .\my_aliases.txt

ll
