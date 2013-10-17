# Quickstart

This contains a VersionOne Chocolatey package definition with custom install and uninstall steps. It supports
overriding default installation options by setting environment variables.

## Default installation configuration

By default, the package passes only the following parameters to the VersionOne installer:

* Quiet = `2` (causes a quiet VersionOne installation with no manual button clicks required)
* InstanceName = `VersionOne`
* DBServer = `(local)` (SQL Server default location)
* DBName = `VersionOne`

## Install with default configuration

* Verify that you have IIS already installed -- TODO: create a "VersionOne DEPS" packages.config that can be used to prep a machine first (I suppose it could also be in the dependencies list of the VersionOne package, but that is a little tricky)
* Verify that you have a SQL Server instance at `(local)`.
* Install Chocolatey if you have not already.
* Open a windows command prompt as `Administrator` and create a folder `C:\VersionOneInstall`, or whatever you'd like to name it.
* Clone or download this repository into `C:\VersionOneInstall`.
* Or just directly download [https://github.com/versionone/VersionOne.CloudFormation/raw/master/chocolatey/VersionOne/VersionOne.13.2.4.66.nupkg](https://github.com/versionone/VersionOne.CloudFormation/raw/master/chocolatey/VersionOne/VersionOne.13.2.4.66.nupkg) - TODO: unhardcode this
* Then type `cinst VersionOne -source "%CD%"`

This should install VersoinOne with the defaults. After it's finished, you'll be able to navigate to [http://localhost/VersionOne](http://localhost/VersionOne) and login with admin / admin!

## Usng environment variables to override default options or specify more options

The VersionOne installer supports a number of other command-line arguments.
You can read about them in the VersionOne Community site at [TODO].

If you wanted to override the `InstanceName` and the `DBServer`, but keep the `DBName` the same, then all you 
have to do differently is add a couple of environment variables before you run `cinst`:

```batch
set V1InstanceName=V1Agile
set V1DBServer=V1AgileSql
cinst VersionOne -source "%CD%"

```

# Old notes:

* Followed steps at the QuickStart guide: https://github.com/chocolatey/chocolatey/wiki/CreatePackagesQuickStart, modifying the nuspec and ps1 files as in this folder, and using `VersionOne` as `PackageName`.
* Started command prompt as Administrator! (The following step failed without being an Admin. I do not know why, but plan to ask the Chocolatey team)
* In `c:\Chocolatey\chocolateytemplates\_templates\VersionOne>` type `cpack`

```
Calling 'C:\Chocolatey\chocolateyInstall\nuget.exe pack  -NoPackageAnalysis'.
Attempting to build package from 'VersionOne.nuspec'.
Successfully created package 'C:\Chocolatey\chocolateytemplates\_templates\VersionOne\VersionOne.13.2.4.66.nupkg'.
```

Then, I typed `cinst VersionOne -source '%CD%'`, which installed it properly, and produces this output:

```text
c:\Chocolatey\chocolateytemplates\_templates\VersionOne>cinst VersionOne -source c:\Chocolatey\chocolateytemplates\_templates\VersionOne -force
Chocolatey (v0.9.8.20) is installing VersionOne and dependencies. By installing you accept the license for VersionOne and each dependency you are installing.
______ VersionOne v13.2.4.66 ______
Downloading VersionOne (http://www.versionone.com/download$/z2n11665/V1.13.b795g21v.zip) to C:\Users\JGough\AppData\Local\Temp\chocolatey\VersionOne\VersionOneInstall.zip
Extracting C:\Users\JGough\AppData\Local\Temp\chocolatey\VersionOne\VersionOneInstall.zip to C:\Chocolatey\lib\VersionOne.13.2.4.66\tools...
C:\Chocolatey\lib\VersionOne.13.2.4.66\tools
VersionOne has finished succesfully! The chocolatey gods have answered your request!
Installing VersionOne...
Elevating Permissions and running C:\Chocolatey\lib\VersionOne.13.2.4.66\tools\VersionOne.Setup-Enterprise-13.2.4.66.exe -Quiet:2 -SigningKey:1BBD93C864A6001737BAA148DCDDB67E927982FA6A59E7DF53CDBDF0DD3CE29A -DbServer:(local) -LogFile:C:\Projects\v1Package\setup.log -DBName:V1CHOC V1CHOC . This may take awhile, depending on the statements.
VersionOne has been installed.
VersionOne has finished succesfully! The chocolatey gods have answered your request!
Adding C:\Chocolatey\bin\Setup-VersionOne.DatamartLoader-13.2.1213.3.bat and pointing to '%DIR%..\lib\versionone.13.2.4.66\tools\setup-versionone.datamartloader-13.2.1213.3.exe'.
Finished installing 'VersionOne' and dependencies - if errors not shown in console, none detected. Check log for errors if unsure.
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
