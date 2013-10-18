try {
  $chocTempDir = Join-Path $env:TEMP "chocolatey"
  $tempDir = Join-Path $chocTempDir "$packageName"
  New-Item $tempDir -type directory
  $zipFile = 'VersionOne.zip'
  $file = Join-Path $tempDir $zipFile
  $logFile = Join-Path $tempDir "VersionOneSetup.log"
  $url = 'http://www.versionone.com/download$/z2n11665/V1.13.b795g21v.zip' 
  $url64 = $url

  if ($env:V1URL) {
    $url = $env:V1URL
    $url64 = $url
  }

  $v1Params = @{
    "Quiet" = "2";
    "DbServer" = "(local)";
    "DbName" = "VersionOne";
    "InstanceName" = "VersionOne";
    "LogFile" = Join-Path $tempDir "VersionOneSetup.log";
  }

  if (!$silentArgs) {  
    Get-ChildItem Env: | Where { $_.Key.ToUpper().StartsWith("V1") } | foreach { 
      $paramName = $_.Key.Substring(2)
      $v1Params[$paramName] = $_.Value
    }
    $silentArgs = ""
    foreach ($key in $v1Params.Keys) {
      if ($key -ne "InstanceName") {
        $silentArgs = $silentArgs + " -" + $key + ":" + $v1Params[$key]
      }
    }
    $silentArgs = $silentArgs + " " + $v1Params["InstanceName"]
  }
  Get-ChocolateyWebFile $packageName $file $url $url64
  Get-ChocolateyUnzip $file $tempDir
  
  $v1FileFullPath = get-childitem $tempDir -recurse -include VersionOne.Setup*.exe | select -First 1
  Install-ChocolateyInstallPackage 'VersionOne' 'exe' $silentArgs "$v1FileFullPath"
  Remove-Item $tempDir\* -recurse -exclude VersionOneSetup.log
  Write-ChocolateySuccess 'VersionOne'
} catch {
  Write-ChocolateyFailure 'VersionOne' "$($_.Exception.Message)"
  throw
}