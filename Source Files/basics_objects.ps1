# Object Basics

Get-Process | Get-Member

Get-Process | Get-Member -MemberType Properties

Get-Process | Get-Member -MemberType Methods

Start-Process notepad.exe -WindowStyle Minimized 

$notepad = Get-Process -Name notepad

$notepad.Modules

$notepad.Close

$notepad.Close()

# Comparisson Operators

"hello" -eq "HELLO"

"hello" -ceq "HELLO"

1 -eq "1"

# Collection Operators

"a","b","c" -contains "b"

"b" -in "a","b","c"

# Boolean Operators
((1 -eq 1) -or (15 -gt 20)) -and ("running" -like "*run*")


    