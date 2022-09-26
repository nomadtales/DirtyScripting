$accepted = Get-Content AcceptedList.json | ConvertFrom-Json
foreach ($a in $accepted) {
    $a.tochararray()



    
}