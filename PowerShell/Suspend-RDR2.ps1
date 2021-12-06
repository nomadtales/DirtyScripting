# Requires PSTools to work. https://docs.microsoft.com/en-us/sysinternals/downloads/pstools
# Make sure you put the PSTools into Path
# Create a desktop shortcut using the below:
# powershell.exe -command "Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest 'https://raw.githubusercontent.com/nomadtales/DirtyScripting/master/PowerShell/Suspend-RDR2.ps1').Content))"

$ps = (Get-Process -Name RDR2 -ErrorAction SilentlyContinue).Id

If ($ps)
{
    & 'pssuspend64.exe' -nobanner "$ps"
    "RDR2 Paused"
    Start-Sleep -Seconds 7
    & 'pssuspend64.exe' -r -nobanner "$ps"
    "RDR2 Resumed"
}
Else {"RDR2 Not Running"}

Start-Sleep -Seconds 10