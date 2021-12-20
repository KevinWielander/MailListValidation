$path = "maillist.txt"
$outPathInvalid = "invalid.txt"
$outPathValid = "valid.txt"
$outPathwrongFormat = "wrongFormat.txt"

$in = Get-Content $path
$mails = @()
$missingMXRecord = @()
$wrongFormat = @()
foreach ($line in $in){
    
    # remove wrong Formatted Mails
    if(($line -like "*@*") -and ($line.split("@").Count) -eq 2){ 
        # split the string at @ and only take the last substring
        $domain = ($line.split("@")[-1]).Trim();
            if($domain.Count -eq 2){ 
                #Write-Host $line.split("@")[-1];
                TRY{  if( $domain -eq ((Resolve-DnsName -Name $domain -Type MX)[0].name)){   
                    $mails += $line.Trim()}}
                CATCH{$missingMXRecord += $line.Trim()}
            }
    }
    else{
        $wrongFormat += $line.Trim();
    }
}
$mails | Out-File -FilePath $outPathValid
$missingMXRecord | Out-File -FilePath $outPathInvalid
$wrongFormat | Out-File -FilePath $outPathwrongFormat

