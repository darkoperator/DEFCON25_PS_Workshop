Sub vba_exec()
    dblShellReturn = Shell("powershell.exe", vbHide)
End Sub


Sub wshell_exec()
    Set wsh = CreateObject("wscript.shell")
    wsh.Run "powershell.exe", 0
End Sub

Sub wshell_exec2()
    Set wsh = GetObject("new:72C24DD5-D70A-438B-8A42-98424B88AFB8")
    wsh.Run "powershell.exe", 0
End Sub
Sub wmi_exec()
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
    Set objStartUp = objWMIService.Get("Win32_ProcessStartup")
    Set objProc = objWMIService.Get("Win32_Process")
    Set procStartConfig = objStartUp.SpawnInstance_
    procStartConfig.ShowWindow = 0
    objProc.Create "powershell.exe", Null, procStartConfig, intProcessID
End Sub
 
