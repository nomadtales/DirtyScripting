
# Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest 'https://raw.githubusercontent.com/nomadtales/DirtyScripting/master/PowerShell/Suspend-RDR2.ps1').Content))

$ps = (Get-Process -Name RDR2).Id

If ($ps)
{
    & 'C:\Program Files\PSTools\pssuspend64.exe' -nobanner "$ps"
    "RDR2 Paused"
    Start-Sleep -Seconds 7
    & 'C:\Program Files\PSTools\pssuspend64.exe' -r -nobanner "$ps"
    "RDR2 Resumed"
}