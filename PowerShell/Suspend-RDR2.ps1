$ps = (Get-Process -Name RDR2).Id
& 'C:\Program Files\PSTools\pssuspend64.exe' "$ps"
"RDR2 Paused"
Start-Sleep -Seconds 7
& 'C:\Program Files\PSTools\pssuspend64.exe' -r "$ps"
"RDR2 Resumed"