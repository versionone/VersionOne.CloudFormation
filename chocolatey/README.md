Here's what I did to get it working:

* Followed steps at the QuickStart guide: https://github.com/chocolatey/chocolatey/wiki/CreatePackagesQuickStart, modifying the nuspec and ps1 files as in this folder, and using `VersionOne` as `PackageName`.
* Started command prompt as Administrator! (The following step failed without being an Admin. I do not know why, but plan to ask the Chocolatey team)
* In `c:\Chocolatey\chocolateytemplates\_templates\VersionOne>` type `cpack`

```
Calling 'C:\Chocolatey\chocolateyInstall\nuget.exe pack  -NoPackageAnalysis'.
Attempting to build package from 'VersionOne.nuspec'.
Successfully created package 'C:\Chocolatey\chocolateytemplates\_templates\VersionOne\VersionOne.13.2.4.66.nupkg'.
```

Then, I typed `cinst VersionOne -source '%CD%'`, which installed it properly, but still produced this error:

```text
c:\Chocolatey\chocolateytemplates\_templates\VersionOne>cinst VersionOne -source c:\Chocolatey\chocolateytemplates\_templates\VersionOne
Chocolatey (v0.9.8.20) is installing VersionOne and dependencies. By installing you accept the license for VersionOne and each dependency you are installing.
______ VersionOne v13.2.4.66 ______
Downloading VersionOne (http://www.versionone.com/download$/z2n11665/V1.13.b795g21v.zip) to C:\Users\JGough\AppData\Local\Temp\chocolatey\VersionOne\VersionOneInstall.zip
Extracting C:\Users\JGough\AppData\Local\Temp\chocolatey\VersionOne\VersionOneInstall.zip to C:\Chocolatey\lib\VersionOne.13.2.4.66\tools...
C:\Chocolatey\lib\VersionOne.13.2.4.66\tools
VersionOne has finished succesfully! The chocolatey gods have answered your request!
Installing VersionOne...
Elevating Permissions and running C:\Chocolatey\lib\VersionOne.13.2.4.66\tools\VersionOne.Setup-Enterprise-13.2.4.66.exe -Quiet:2 -SigningKey:1BBD93C864A6001737BAA148DCDDB67E927982FA6A59E7DF53CDBDF0DD3CE29A -DbServer:(local) -LogFile:C:\Projects\v1Package\setup.log -DBName:V1CHOC V1CHOC . This may take awhile, depending on the statements.
VersionOne has been installed.
Move-Item : The process cannot access the file because it is being used by another process.
At C:\Chocolatey\chocolateyInstall\helpers\functions\Write-ChocolateyFailure.ps1:14 char:7
+       Move-Item $successLog $oldSuccessLog -Force
+       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : WriteError: (C:\Users\JGough...One\success.log:FileInfo) [Move-Item], IOException
    + FullyQualifiedErrorId : MoveFileInfoItemIOError,Microsoft.PowerShell.Commands.MoveItemCommand

Write-Error : VersionOne did not finish successfully. Boo to the chocolatey gods!
-----------------------
[ERROR] A positional parameter cannot be found that accepts argument 'e'.
-----------------------
At C:\Chocolatey\chocolateyInstall\helpers\functions\Write-ChocolateyFailure.ps1:29 char:2
+     Write-Error $errorMessage
+     ~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,Write-Error

Remove-Item : A positional parameter cannot be found that accepts argument 'e'.
At C:\Chocolatey\lib\VersionOne.13.2.4.66\tools\chocolateyInstall.ps1:7 char:3
+   Remove-Item "$v1FileFullPath"e
+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Remove-Item], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : PositionalParameterNotFound,Microsoft.PowerShell.Commands.RemoveItemCommand

```

# Contents of tools folder for VersionOne package

Also, after doing this the way I did above (whether right or wrong), it resulted in these files being in the 
`c:\Chocolatey\lib\VersionOne.13.2.4.66\tools` folder:

```
 Directory of c:\Chocolatey\lib\VersionOne.13.2.4.66\tools

10/02/2013  01:32 PM    <DIR>          .
10/02/2013  01:32 PM    <DIR>          ..
10/02/2013  01:32 PM               714 chocolateyInstall.ps1
08/13/2013  03:18 PM         2,206,207 Setup-VersionOne.DatamartLoader-13.2.1213.3.exe
09/19/2013  01:36 PM           172,804 V1.R13.2.InstallationGuide.Enterprise.pdf
08/13/2013  03:18 PM         1,458,768 V1Datamart.pdf
10/02/2013  01:32 PM    <DIR>          V1DatamartHTMLDoc
09/20/2013  01:04 PM        20,707,453 VersionOne.Setup-Enterprise-13.2.4.66.exe
10/02/2013  01:32 PM                 6 VersionOne.Setup-Enterprise-13.2.4.66.exe.ignore

```
