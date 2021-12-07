## Variables
$delay = 10

While ($choice -ne 1)
{
    Clear-Host

    $ps = (Get-Process -Name RDR2 -ErrorAction SilentlyContinue).Id

    if ($ps)
    {
        & 'pssuspend64.exe' -nobanner "$ps"
        "RDR2 Paused"
        Start-Sleep -Seconds $delay
        & 'pssuspend64.exe' -r -nobanner "$ps"
        "RDR2 Resumed"
    }

    else {"RDR2 Not Running"}

    $title = 'Would you like to rerun?'
    $rerun = New-Object System.Management.Automation.Host.ChoiceDescription '&Rerun','Rerun the script'
    $exit = New-Object System.Management.Automation.Host.ChoiceDescription '&Exit','Aborts the script'
    $options = [System.Management.Automation.Host.ChoiceDescription[]] ($rerun,$exit)
 
    $choice = $host.ui.PromptForChoice($title,$null,$options,0)
    
} # End While