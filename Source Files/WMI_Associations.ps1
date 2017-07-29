# WMI Associations 

# Network Car Associations

Get-WmiObject Win32_NetworkAdapter 

$nic = Get-WmiObject Win32_NetworkAdapter | Select-Object -Index 1

$nic.GetRelated()

$nic.GetRelated() | select __class -Unique


# Get all the types of objects that reference it
$nic.GetRelationships() | select __class -Unique

# Lets get the Adapter Configuration using the
# Win32_NetworkAdapterConfiguration instance
$nic.GetRelated(‘Win32_NetworkAdapterConfiguration')


# User session associations

Get-WmiObject Win32_LogonSession

Get-WmiObject Win32_LogonSession | ForEach-Object {$_.GetRelated('Win32_UserAccount')} | fl *

$sessions = Get-WmiObject Win32_LogonSession 
ForEach ($session in $sessions) {
    $account = $session.GetRelated('Win32_UserAccount')
    if ($account -ne $null)
    {
        $account | select caption, @{name='created'; expression={$session.StartTime}}
    }
} 
