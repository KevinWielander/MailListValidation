function Assert-EmailAddress
{
<#
.Synopsis
   Validate Email address 
.DESCRIPTION
   Use this cmdlet to validate Email addresses.
.EXAMPLE
   Assert-EmailAddress -StringEmail "test@domain.com"
   
   Outputs True
.EXAMPLE
   "tore.somedomain.dom" | Assert-EmailAddress
   Outputs False
.EXAMPLE
   $object = "" | Select-Object -Property Mail
   $object.Mail = "test@domain.com"
   $object | Assert-EmailAddress
   Outputs True
.INPUTS
   [string]
.OUTPUTS
   It outpus a boolean value indicating if it is a valid Email Address
.NOTES
   Use at your own Risk!
.COMPONENT
   General scripting
.ROLE
   Mail space
.FUNCTIONALITY
   Validating Email Addresses
#>
[OutputType([bool])]
[cmdletbinding()]
Param(
    [Parameter(
        Mandatory=$true, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        ValueFromRemainingArguments=$false        
        )]
    [ValidateNotNullOrEmpty()]
    [Alias("Email","Mail","Address")]
    [string]$StringEmail
)
Begin
{
    $f = $MyInvocation.InvocationName
    Write-Verbose -Message "$f - START"
}

Process
{
    Write-Verbose -Message "$f -  Asserting email $StringEmail"
    try
    {
        $Email = New-Object -TypeName System.Net.Mail.MailAddress -ArgumentList $StringEmail
        if($Email.Address -eq $StringEmail)
        {
            Write-Verbose -Message "$f -  Valid email address $StringEmail"
            return $true
        }
        else
        {
            Write-Warning -Message "$f -  Invalid email address $StringEmail, was parsed to $($Email.Address)"
            return $false
        }
    }
    catch
    {
        Write-Warning -Message "$f -  Invalid email address $StringEmail"
        return $false
    }
}

End
{
    Write-Verbose -Message "$f - END"
}
}