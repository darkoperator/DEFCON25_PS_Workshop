###########################
# __InstanceCreationEvent #
###########################

# Query for new process events 
$queryCreate = "SELECT * FROM __InstanceCreationEvent WITHIN 5" + 
    "WHERE TargetInstance ISA 'Win32_Process'" 

# Create an Action
$CrateAction = {
    $name = $event.SourceEventArgs.NewEvent.TargetInstance.name
    write-host "Process $($name) was created."
}

# Register WMI event 
Register-WMIEvent -Query $queryCreate -Action $CrateAction 
 
###########################
# __InstanceDeletionEvent #
###########################

# Query for process termination
$queryDelete = "SELECT * FROM __InstanceDeletionEvent WITHIN 5"+ 
    "WHERE TargetInstance ISA 'Win32_Process'"

# Create Action
$DeleteAction = {
    $name = $event.SourceEventArgs.NewEvent.TargetInstance.name
    write-host "Process $($name) has closed."
}

# Register WMI Event
Register-WMIEvent -Query $queryDelete -Action $DeleteAction 

################################
# __InstanceModificationEvent  #
################################

# Query for service modification
$queryModify = "SELECT * FROM __InstanceModificationEvent WITHIN 5"+ 
    "WHERE TargetInstance ISA 'win32_service' AND TargetInstance.Name='BITS'"

# Create Action
$ModifyAction = {
    $name = $event.SourceEventArgs.NewEvent.TargetInstance.name
    write-host "Service $($name) was modified."
}

# Register WMI Event
Register-WMIEvent -Query $queryModify -Action $ModifyAction 

Start-Service -Name BITS
Stop-Service -Name BITS

#################################
# Extrinsic PowerShell Assembly #
#################################

$query = 'SELECT * FROM Win32_ModuleLoadTrace' + 
' WHERE FileName LIKE “%System.Management.Automation%.dll%"'

Register-WMIEvent -Query $query -Action { 
    Write-host "Management Automation assembly has been loaded." } 

###############
# Timer Event #
###############

#Setup WQL query
$TimerQuery = "SELECT * FROM __InstanceModificationEvent WHERE 
TargetInstance ISA
         'Win32_LocalTime' 
          AND (TargetInstance.Second=30
          OR TargetInstance.Second=1)"
#Register WMI Event
Register-WmiEvent -Query $TimerQuery -Action {
Write-Host "Event every 30 seconds triggered" } 

