# Suspend-RDR2
Quick script to pause and restart Red Dead Redemption 2 process on PC. Specifically used when playing Red Dead Online as it will put you into a temporary solo lobby.

## Requirements
1. PSTools - https://docs.microsoft.com/en-us/sysinternals/downloads/pstools
2. Make sure you add the PSTools into the Windows Environmental Path

## Setup
Create a desktop shortcut using the below:
`powershell.exe -command "Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest 'https://raw.githubusercontent.com/nomadtales/DirtyScripting/master/PowerShell/Suspend-RDR2.ps1').Content))"`