try {
  $chocTempDir = Join-Path $env:TEMP "chocolatey"
  $tempDir = Join-Path $chocTempDir "$packageName"
  $zipFile = 'VersionOne.zip'
  $file = Join-Path $tempDir $zipFile
  $logFile = Join-Path $tempDir "VersionOneSetup.log"
  $url = 'http://www.versionone.com/download$/z2n11665/V1.13.b795g21v.zip' 
  $url64 = $url
  Get-ChocolateyWebFile $packageName $file $url $url64
  Get-ChocolateyUnzip $file $tempDir
  
  $silentArgs = '-Quiet:2 -SigningKey:1BBD93C864A6001737BAA148DCDDB67E927982FA6A59E7DF53CDBDF0DD3CE29A -DbServer:(local) -LogFile:"' + $logFile + '" -DBName:V1CHOC V1CHOC'

  $v1FileFullPath = get-childitem $tempDir -recurse -include VersionOne.Setup*.exe | select -First 1
  Install-ChocolateyInstallPackage 'VersionOne' 'exe' $silentArgs "$v1FileFullPath"
  Remove-Item $tempDir -recurse -exclude "$logFile"
  Write-ChocolateySuccess 'VersionOne'
} catch {
  Write-ChocolateyFailure 'VersionOne' "$($_.Exception.Message)"
  throw
}
