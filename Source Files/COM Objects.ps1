# List com objects
gci HKLM:\Software\Classes -ea 0| ? {$_.PSChildName -match '^\w+\.\w+$' -and (gp "$($_.PSPath)\CLSID" -ea 0)} | select -expand pschildname

# Create an Object
$ws1 = New-Object -ComObject "wscript.shell"

# Create a COM Object by CLSID
$ws2 = [activator]::CreateInstance([type]::GetTypeFromCLSID("{72C24DD5-D70A-438B-8A42-98424B88AFB8}"))

# Show Overloads for GetTypeFromCLSID
[type]::GetTypeFromCLSID
