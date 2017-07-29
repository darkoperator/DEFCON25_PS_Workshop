<#
.Synopsis
   Function to demo use of pipeline.
.DESCRIPTION
   Function to demo use of pipeline.
.EXAMPLE
   Get-Process | Test-Pipeline
   By Value
.EXAMPLE
   Get-Process |  Select-Object -Property @{name = 'ProcName'; expression = {$_.Name}} | Test-Pipeline
   By Name
#>
function Test-Pipeline {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param (
        # Process Name
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Name',
                   ValueFromPipelineByPropertyName = $true,
                   Position = 0)]
        [string]
        $ProcName,

        # Process Object
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Object',
                   ValueFromPipeline = $true,
                   Position = 0)]
        [Diagnostics.Process]
        $InputObject
    )

    Begin { }
    Process {
        switch ($PSCmdlet.ParameterSetName) {
            'Name' {
                Write-Host -Object "Got from pipeline by name $($ProcName)"
            }
            'Object' { 
                Write-Host -Object "Got from pipeline by value $($InputObject.Name)"
            }
        }
    }
    End { }
}


Get-Process | Test-Pipeline

Get-Process |  Select-Object -Property @{name = 'ProcName'; expression = {$_.Name}} | Test-Pipeline

# Filtering Objects 

 Get-Service | where-object { $_.Status -eq "Running" } 

# Filtering Objects PSv3+

Get-Service | Where-Object -Property Status -eq -Value Running
 
Get-Service | Where-Object Status -eq Running 

# Selecting objects

Get-Process | Sort-Object workingset -Descending | Select-Object -Index 0,1,2,3,4 

Get-Process | Sort-Object workingset -Descending | Select-Object -Index (0..4) 

Get-Process | Sort-Object workingset -Descending | Select-Object -first 5 

Get-Process |  Select-Object -Property name,@{name = 'PID'; expression = {$_.id}} 

# Iterating ofver objects

foreach ($n in (1..5)) {"Processed $($n)"}

1..5 | ForEach-Object {"Processed $($_)"}

1..5 | ForEach-Object -Begin { $Sum = 0 } -Process { $Sum += $_ } -End { $Sum }

# Skipping in interation

1..10 | foreach-object { if (($_ -gt 4) -and ($_ -lt 9)) { return }; $_ }

foreach($n in (1..10)){ if (($n -gt 4) -and ($n -lt 9)) { continue }; $n }

 
# Meassuring objects

Get-Service | Measure-Object 

Get-Content C:\Windows\WindowsUpdate.log | Measure-Object -Line -Word -Character 

Get-Process | Measure-Object  -property workingset -minimum -maximum -average

# Group Objects

Get-Service | Group-Object status


# Formating

Get-Process -name explorer | Format-Table -Property name, startinfo, starttime, workingset -AutoSize 

Get-Service | Format-Table -Property name, displayname, status, servicetype -Wrap 

Get-Process -Name explorer | format-list -Property * 

# Converssion

Get-Process -Name lsass | ConvertTo-Csv

Get-Process -Name lsass | ConvertTo-Html

Get-Process -Name lsass | ConvertTo-Xml

Get-Process -Name lsass | ConvertTo-Json
