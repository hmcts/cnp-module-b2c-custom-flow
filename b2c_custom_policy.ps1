Param(
    [Parameter(Mandatory = $true)][string]$clientId,
    [Parameter(Mandatory = $true)][string]$clientSecret,
    [Parameter(Mandatory = $true)][string]$tenantId,
    [Parameter(Mandatory = $true)][string]$folder,
    [Parameter(Mandatory = $true)][string]$files
)

try {

  if ($clientSecret -eq "") {
    $scope = "https://graph.microsoft.com/.default"
    $url = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token?api-version=2018-02-01&resource=$scope&client_id=$clientId"
  
    $response = Invoke-RestMethod -Uri $url -Method Post
  }
  else {
    $body = @{grant_type = "client_credentials"; scope = "https://graph.microsoft.com/.default"; client_id = $clientId; client_secret = $clientSecret }
  
    $response = Invoke-RestMethod -Uri https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token -Method Post -Body $body
  }
  $token = $response.access_token
  if ($token -eq "") {
    Write-Error "Failed to get token."
    exit 1
  }

  $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
  $headers.Add("Content-Type", 'application/xml')
  $headers.Add("Authorization", 'Bearer ' + $token)

  # Get the list of files to upload
  $filesArray = $files.Split(",")

  Foreach ($file in $filesArray) {
    Write-Host "Working on $file"
    $filePath = $folder + $file.Trim()

    # Check if file exists
    $FileExists = Test-Path -Path $filePath -PathType Leaf

    if ($FileExists) {
      Write-Host "File Found"
      $policycontent = Get-Content $filePath

      # Optional: Change the content of the policy. For example, replace the tenant-name with your tenant name.
      # $policycontent = $policycontent.Replace("your-tenant.onmicrosoft.com", "contoso.onmicrosoft.com")     
  
  
      # Get the policy name from the XML document
      $match = Select-String -InputObject $policycontent  -Pattern '(?<=\bPolicyId=")[^"]*'
  
      If ($match.matches.groups.count -ge 1) {
        Write-Host "Policy Id found in XML"
        $PolicyId = $match.matches.groups[0].value
  
        Write-Host "Uploading the" $PolicyId "policy..."
  
        $graphuri = 'https://graph.microsoft.com/beta/trustframework/policies/' + $PolicyId + '/$value'
        $response = Invoke-RestMethod -Uri $graphuri -Method Put -Body $policycontent -Headers $headers
  
        Write-Host "Policy" $PolicyId "uploaded successfully."
      }
      else {
            
        Write-Host "Policy Id NOT found in XML"
      }
    }
    else {
      $warning = "File " + $filePath + " couldn't be not found."
      Write-Warning -Message $warning
    }

    # Spacer
    Write-Host ""
  }
}
catch {
  Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__

  $_

  $streamReader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
  $streamReader.BaseStream.Position = 0
  $streamReader.DiscardBufferedData()
  $errResp = $streamReader.ReadToEnd()
  $streamReader.Close()

  $ErrResp

  exit 1
}

exit 0