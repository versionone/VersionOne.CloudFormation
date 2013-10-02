try {
  $toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  Install-ChocolateyZipPackage 'VersionOne' 'http://www.versionone.com/download$/z2n11665/V1.13.b795g21v.zip' $toolsDir

  $v1FileFullPath = get-childitem $toolsDir -recurse -include VersionOne.Setup*.exe | select -First 1
  Install-ChocolateyInstallPackage 'VersionOne' 'exe' '-Quiet:2 -SigningKey:1BBD93C864A6001737BAA148DCDDB67E927982FA6A59E7DF53CDBDF0DD3CE29A -DbServer:(local) -LogFile:C:\Projects\v1Package\setup.log -DBName:V1CHOC V1CHOC' "$v1FileFullPath"
  Remove-Item "$v1FileFullPath"
  Write-ChocolateySuccess 'VersionOne'
} catch {
  Write-ChocolateyFailure 'VersionOne' "$($_.Exception.Message)"
  throw
}
