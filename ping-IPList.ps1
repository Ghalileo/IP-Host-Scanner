Param(
    [Parameter(Mandatory=$true, position=0)][string]$csvfile
)

$IPColumn = "Address"

Write-Host "Reading File" $csvfile
$theIPAddresses = import-csv $csvfile | select-object $IPColumn


Write-Host "Pinging Started...."
foreach($ip in $theIPAddresses) {
    if (test-connection $ip.("Address") -count 1 -quiet){
        write-host $ip.("Address") "Successful Ping to Host." -foreground Magenta
     
        echo $ip.("Address") >> online.txt
        # echo $res. >> online.txt

    } else {
        write-host $ip.("Address") "Failed to Ping Host." -foreground DarkRed 
        
        echo $ip.("Address") >> offline.txt
    }
}

Write-Host "Completed Pinging Processes"