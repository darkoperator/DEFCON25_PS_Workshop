$var1 = 1

${this is a variable with speci@l char} = 10  

# Variable Cmdlets

Get-Command *variable* -CommandType Cmdlet

Get-Variable

New-Variable -Name var2 -Value "hello" -Description "Sample string variable"

Set-Variable -Name var3 -Value 3

Get-Variable -Name var2 | Format-List *

# Variable PSDrive
Get-ChildItem variable: 

$PSHOME

Get-Content Variable:\PSHOME


# Dynamic Variables

$var1 = 1
$var1.GetType().Name


$var1 = "string"
$var1.GetType().Name


# Casting or hard typing a variable
[int32]$var2 = 10
$var2 = "hello"


# Strings
Write-Host "one line `n another line"

Write-Host 'I can have $ symbol'

write-host "My culture is $(Get-Culture | select -ExpandProperty name)"

# working with string as an object
Get-Member -InputObject “” -MemberType method 
$str = "my string"

$str.Contains("my")

$str.Replace("my","the")


# Arrays 

$a1 = 1,"a",2.8
$a2 = @(2,"b",-30) 

$a2[2]

Get-Member -InputObject @() -MemberType method 

$a2.Length 

$a3 = $a1 + $a2 

$a3 += "PS" 


# Hash

$h1 = @{"dc01" = "192.168.10.1" ; "exch01" = "192.168.10.2" ; "HV01" = "192.168.10.4"} 

$h1["hv01"]

$h1.dc01


Get-Member -InputObject @{}

$h1.ContainsKey("HV01")

$h1.ContainsValue("192.168.1.1")

$h1.Add("loki","102.168.1.6")
