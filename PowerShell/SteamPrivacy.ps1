[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $apikey
)

## Start Variablees
$starthour = 8
$endhour = 17


## Start Script

#Check time
$datetime = Get-Date

if (($datetime.DayOfWeek -ge 1 -or $datetime -le 5) -and ($datetime.Hour -ge $starthour -or $datetime.Hour -le $endhour)) {
    $true



}


