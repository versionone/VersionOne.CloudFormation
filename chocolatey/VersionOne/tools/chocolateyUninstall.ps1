try {
  $chocTempDir = Join-Path $env:TEMP "chocolatey"
  $tempDir = Join-Path $chocTempDir "$packageName"
  $logFile = Join-Path $tempDir "VersionOneUninstall.log"

  $instanceName = "VersionOne"
  
  if ($env:V1InstanceName) {
    $instanceName = $env:V1InstanceName
  }
  
  if (!$silentArgs) {
    $silentArgs = '-Quiet:2 -DeleteDatabase -LogFile:"' + $logFile + '" -u ' + $instanceName
  }

  $v1FileFullPath = get-childitem $tempDir -recurse -include VersionOne.Setup*.exe | select -First 1
  Install-ChocolateyInstallPackage 'VersionOne' 'exe' $silentArgs "$v1FileFullPath"
  Write-ChocolateySuccess 'VersionOne uninstall'
} catch {
  Write-ChocolateyFailure 'VersionOne uninstall' "$($_.Exception.Message)"
  throw
}