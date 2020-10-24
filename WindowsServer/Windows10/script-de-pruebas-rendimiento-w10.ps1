Set-ExecutionPolicy Unrestricted -Scope CurrentUser
ls -Recurse *.ps*1 | Unblock-File

# experimental_unfuckery.ps1
# Deshabilitar las aplicaciones relacionadas con la retroalimentación de W10.


Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1



Write-Output "Elevating priviledges for this process"

do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)



Write-Output "Force removing system apps"

$needles = @(

    #"Anytime"

    "BioEnrollment"

    #"Browser"

    "ContactSupport"

    #"Cortana"       # This will disable startmenu search.

    #"Defender"

    "Feedback"

    "Flash"

    "Gaming"

    #"Holo"

    #"InternetExplorer"

    #"Maps"

    #"MiracastView"

    "OneDrive"

    #"SecHealthUI"

    #"Wallet"

    #"Xbox"          # This will result in a bootloop since upgrade 1511

)
foreach ($needle in $needles) {

    Write-Output "Trying to remove all packages containing $needle"



    $pkgs = (Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" |

        Where-Object Name -Like "*$needle*")



    foreach ($pkg in $pkgs) {

        $pkgname = $pkg.Name.split('\')[-1]



        Takeown-Registry($pkg.Name)

        Takeown-Registry($pkg.Name + "\Owners")



        Set-ItemProperty -Path ("HKLM:" + $pkg.Name.Substring(18)) -Name Visibility -Value 1

        New-ItemProperty -Path ("HKLM:" + $pkg.Name.Substring(18)) -Name DefVis -PropertyType DWord -Value 2

        Remove-Item      -Path ("HKLM:" + $pkg.Name.Substring(18) + "\Owners")



        dism.exe /Online /Remove-Package /PackageName:$pkgname /NoRestart

    }

}

# disable-services.ps1
# deshabilita servicios de w10 como:
# - Servicios de seguimiento de diagnostico
# - Servicios de geolocalización
# - Registro remoto
$services = @(

    "diagnosticshub.standardcollector.service" # Microsoft (R) Diagnostics Hub Standard Collector Service

    "DiagTrack"                                # Diagnostics Tracking Service

    "dmwappushservice"                         # WAP Push Message Routing Service (see known issues)

    "lfsvc"                                    # Geolocation Service

    "MapsBroker"                               # Downloaded Maps Manager

    "NetTcpPortSharing"                        # Net.Tcp Port Sharing Service

    "RemoteAccess"                             # Routing and Remote Access

    "RemoteRegistry"                           # Remote Registry

    "SharedAccess"                             # Internet Connection Sharing (ICS)

    "TrkWks"                                   # Distributed Link Tracking Client

    "WbioSrvc"                                 # Windows Biometric Service (required for Fingerprint reader / facial detection)

    #"WlanSvc"                                 # WLAN AutoConfig

    "WMPNetworkSvc"                            # Windows Media Player Network Sharing Service

    #"wscsvc"                                  # Windows Security Center Service

    #"WSearch"                                 # Windows Search

    "XblAuthManager"                           # Xbox Live Auth Manager

    "XblGameSave"                              # Xbox Live Game Save Service

    "XboxNetApiSvc"                            # Xbox Live Networking Service

    "ndu"                                      # Windows Network Data Usage Monitor

    # Services which cannot be disabled

    #"WdNisSvc"

)



foreach ($service in $services) {

    Write-Output "Trying to disable $service"

    Get-Service -Name $service | Set-Service -StartupType Disabled

}

# fix-privacity-settings.ps1
# Aumenta la privacidad para el sistema operativo
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1

Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1



Write-Output "Elevating priviledges for this process"

do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)



Write-Output "Defuse Windows search settings"

Set-WindowsSearchSetting -EnableWebResultsSetting $false



Write-Output "Set general privacy options"

# "Let websites provide locally relevant content by accessing my language list"

Set-ItemProperty "HKCU:\Control Panel\International\User Profile" "HttpAcceptLanguageOptOut" 1

# Locaton aware printing (changes default based on connected network)

force-mkdir "HKCU:\Printers\Defaults"

Set-ItemProperty "HKCU:\Printers\Defaults" "NetID" "{00000000-0000-0000-0000-000000000000}"

# "Send Microsoft info about how I write to help us improve typing and writing in the future"

force-mkdir "HKCU:\SOFTWARE\Microsoft\Input\TIPC"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Input\TIPC" "Enabled" 0

# "Let apps use my advertising ID for experiencess across apps"

force-mkdir "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0

# "Turn on SmartScreen Filter to check web content"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" "EnableWebContentEvaluation" 0



Write-Output "Disable synchronisation of settings"

# These only apply if you log on using Microsoft account

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "BackupPolicy" 0x3c

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "DeviceMetadataUploaded" 0

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" "PriorLogons" 1

$groups = @(

    "Accessibility"

    "AppSync"

    "BrowserSettings"

    "Credentials"

    "DesktopTheme"

    "Language"

    "PackageState"

    "Personalization"

    "StartLayout"

    "Windows"

)

foreach ($group in $groups) {

    force-mkdir "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group"

    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\$group" "Enabled" 0

}



Write-Output "Set privacy policy accepted state to 0"

# Prevents sending speech, inking and typing samples to MS (so Cortana

# can learn to recognise you)

force-mkdir "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" "AcceptedPrivacyPolicy" 0



Write-Output "Do not scan contact informations"

# Prevents sending contacts to MS (so Cortana can compare speech etc samples)

force-mkdir "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" "HarvestContacts" 0



Write-Output "Inking and typing settings"

# Handwriting recognition personalization

force-mkdir "HKCU:\SOFTWARE\Microsoft\InputPersonalization"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitInkCollection" 1

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\InputPersonalization" "RestrictImplicitTextCollection" 1



Write-Output "Microsoft Edge settings"

force-mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main"

Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Main" "DoNotTrack" 1

force-mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes"

Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\User\Default\SearchScopes" "ShowSearchSuggestionsGlobal" 0

force-mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead"

Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\FlipAhead" "FPEnabled" 0

force-mkdir "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter"

Set-ItemProperty "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" "EnabledV9" 0



Write-Output "Disable background access of default apps"

foreach ($key in (Get-ChildItem "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications")) {

    Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\" + $key.PSChildName) "Disabled" 1

}



Write-Output "Denying device access"

# Disable sharing information with unpaired devices

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" "Type" "LooselyCoupled"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" "Value" "Deny"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" "InitialAppValue" "Unspecified"

foreach ($key in (Get-ChildItem "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global")) {

    if ($key.PSChildName -EQ "LooselyCoupled") {

        continue

    }

    Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" + $key.PSChildName) "Type" "InterfaceClass"

    Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" + $key.PSChildName) "Value" "Deny"

    Set-ItemProperty ("HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\" + $key.PSChildName) "InitialAppValue" "Unspecified"

}



Write-Output "Disable location sensor"

force-mkdir "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" "SensorPermissionState" 0



Write-Output "Disable submission of Windows Defender findings (w/ elevated privileges)"

Takeown-Registry("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet")

Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender\Spynet" "SpyNetReporting" 0       # write-protected even after takeown ?!

Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows Defender\Spynet" "SubmitSamplesConsent" 0



# The following section can cause problems with network / internet connectivity

# in generel. See the corresponding issue:

# https://github.com/W4RH4WK/Debloat-Windows-10/issues/270

#Write-Output "Do not share wifi networks"

#$user = New-Object System.Security.Principal.NTAccount($env:UserName)

#$sid = $user.Translate([System.Security.Principal.SecurityIdentifier]).value

#force-mkdir ("HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\" + $sid)

#Set-ItemProperty ("HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\" + $sid) "FeatureStates" 0x33c

#Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" "WiFiSenseCredShared" 0

#Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features" "WiFiSenseOpen" 0


# optimizer-user-interfaces.ps1
# Optimización de elementos significativos en el SO

Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1

Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1



Write-Output "Elevating priviledges for this process"

do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)



Write-Output "Apply MarkC's mouse acceleration fix"

Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSensitivity" "10"

Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSpeed" "0"

Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0"

Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0"

Set-ItemProperty "HKCU:\Control Panel\Mouse" "SmoothMouseXCurve" ([byte[]](0x00, 0x00, 0x00,

0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xCC, 0x0C, 0x00, 0x00, 0x00, 0x00, 0x00,

0x80, 0x99, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x66, 0x26, 0x00, 0x00,

0x00, 0x00, 0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00))

Set-ItemProperty "HKCU:\Control Panel\Mouse" "SmoothMouseYCurve" ([byte[]](0x00, 0x00, 0x00,

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00,

0x00, 0x00, 0x70, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0x00,

0x00, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00))



Write-Output "Disable mouse pointer hiding"

Set-ItemProperty "HKCU:\Control Panel\Desktop" "UserPreferencesMask" ([byte[]](0x9e,

0x1e, 0x06, 0x80, 0x12, 0x00, 0x00, 0x00))



Write-Output "Disable Game DVR and Game Bar"

force-mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"

Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowgameDVR" 0



Write-Output "Disable easy access keyboard stuff"

Set-ItemProperty "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "506"

Set-ItemProperty "HKCU:\Control Panel\Accessibility\Keyboard Response" "Flags" "122"

Set-ItemProperty "HKCU:\Control Panel\Accessibility\ToggleKeys" "Flags" "58"



Write-Output "Disable Edge desktop shortcut on new profiles"

New-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer -Name DisableEdgeDesktopShortcutCreation -PropertyType DWORD -Value 1



Write-Output "Restoring old volume slider"

force-mkdir "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC"

Set-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" "EnableMtcUvc" 0



Write-Output "Setting folder view options"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideDrivesWithNoMedia" 0

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" 0



Write-Output "Disable Aero-Shake Minimize feature"

Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "DisallowShaking" 1



Write-Output "Setting default explorer view to This PC"

Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" 1



Write-Output "Removing user folders under This PC"

# Remove Desktop from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}"

# Remove Documents from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}"

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}"

# Remove Downloads from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}"

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}"

# Remove Music from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}"

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}"

# Remove Pictures from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}"

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}"

# Remove Videos from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}"

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}"

# Remove 3D Objects from This PC

Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"

Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"



#echo "Disabling tile push notification"

#force-mkdir "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"

#sp "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" "NoTileApplicationNotification" 1

# Optimización de rendimiento del sistema operativo a través de la configuración de registro.

#Set-OSRegSettings.ps1  
param($RAMMb, $NumCPU,$VolType)  
if (($RAMMb -eq $null) -or ($NumCPU -eq $null) -or ($VolType -eq $null) -or ($VolType -gt 4))  
{  
"`r"  
"Please specify required paramemters of -RAMMb and -NumCPU and -VolType"  
"Usage: .\OSSettings.ps1 -RAMMb 2048 -NumCPU 2 -VolType 4"  
"Valid VolType values are: 1(few files), 2 or 3(moderate files), 4(many files)"  
"`r"  
exit  
}  
$ErrorActionPreference = "SilentlyContinue"  
$LogFileName="OSSettings.log"  
$LogTime=([System.DateTime]::Now).ToString("dd-MM-yyyy hh:mm:ss")   
Add-Content $LogFileName "*********** Settings changed at $LogTime ************"  
  
function SetProperty([string]$path, [string]$key, [string]$Value)   
{  
#Clear Error Count  
$error.clear()  
$oldValue = (Get-ItemProperty -path $path).$key  
#Set the Registry Key  
Set-ItemProperty -path $path -name $key -Type DWORD -Value $Value  
#if error count is 0, regkey was updated OK  
if ($error.count -eq 0)  
{  
$newValue = (Get-ItemProperty -path $path).$key  
$data =  "$path\$key=$oldValue"   
if($oldvalue -eq $null)  
{  
Write-Output "Value for $path\$key created and set to $newValue"  
Add-Content $LogFileName "Value for $path\$key created and set to $newValue"  
}  
else  
{  
Write-Output "Value for $path\$key changed from $oldValue to $newValue"  
Add-Content $LogFileName "Value for $path\$key changed from $oldValue to $newValue"  
}  
}  
#if error count is greater than 0 an error occurred and the regkey was not set  
else  
{  
Add-Content $LogFileName "Error: Could not set key $path\$key"  
Add-Content $LogFileName $Error[$error.count-1].exception.message  
Write-Output "Error: Could not set key $path\$key"  
Write-Output $Error[$error.count-1].exception  
}  
}  
  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\ldap" "ldapclientintegrity" 0x0  
  
#Work out Value of $IoPageLockLimit  
$IoPageLockLimit = ($RAMMb - 65) * 1024  
if ($IoPageLockLimit -gt 4294967295)  
{  
$IoPageLockLimit = "0xFFFFFFFF"  
}  
else  
{  
#Convert to Hexadecimal  
  
$IoPageLockLimit = "{0:X}" -f $IoPageLockLimit   
$IoPageLockLimit = "0x" + $IoPageLockLimit  
}  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "IoPageLockLimit" ($IoPageLockLimit)  
  
#Work out Value of $WorkerThreads  
$WorkerThreads = $NumCPU * 16  
if ($WorkerThreads -gt 64)  
{$WorkerThreads = "0x40"} #Hexadecimal Value of 64  
else  
{  
$WorkerThreads = "{0:X}" -f $WorkerThreads  
$WorkerThreads = "0x" + $WorkerThreads  
}  
  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" "AdditionalDelayedWorkerThreads" 0x10  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" "AdditionalCriticalWorkerThreads" 0x10  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" "MaxWorkItems" 8192  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" "MaxMpxCt" 2048  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" "MaxCmds" 2048  
#Value depends of -VolType parameter passed in  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "NtfsMftZoneReservation" $VolType  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "NTFSDisableLastAccessUpdate" 1  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "NTFSDisable8dot3NameCreation" 1  
SetProperty "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "DontVerifyRandomDrivers" 1  
SetProperty "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters" "Size" 3  
SetProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" "LargeSystemCache" 0

# Optimización de rendimiento de red a través de la red.

#Set-NetworkRegSettings.ps1  
param([int] $MTUSize = $(throw "usage: ./Set-NetworkSettings <MTU Size>"))  
  
$LogFileName="NetworkRegSettings.log"  
$LogTime=([System.DateTime]::Now).ToString("dd-MM-yyyy hh:mm:ss")   
Add-Content $LogFileName "*********** Settings changed at $LogTime ************"  
  
function SetProperty([string]$path, [string]$key, [string]$Value) {  
$oldValue = (Get-ItemProperty -path $path).$key  
Set-ItemProperty -path $path -name $key -Type DWORD -Value $Value  
$newValue = (Get-ItemProperty -path $path).$key  
$data =  "$path\$key=$oldValue"   
Add-Content $LogFileName $data  
Write-Output "Value for $path\$key changed from $oldValue to $newValue"  
}  
SetProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" "DisablePagingExecutive" 1  
# Set SystemPages to 0xFFFFFFFF  
# Maximize system pages. The system creates the largest number of page table entries possible within physical memory.   
# The system monitors and adjusts this value dynamically when the configuration changes.  
SetProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management" "SystemPages" 0xFFFFFFFF  
# HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters  
# ======  
$path = "HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters"  
$returnValue = (Get-ItemProperty -path $path).IRPStackSize  
if ( $returnValue -eq $null) {  
SetProperty $path "IRPStackSize" 0x20 # IRPStackSize -> +10 (Use DWORD 0x20 (32) if not present)  
}else{  
$returnValue = $returnValue + 1  
SetProperty $path "IRPStackSize" $returnValue  
}  
SetProperty $path "SizReqBuf" 0x4000 # SizReqBuf -> 0x4000 (16384)  
  
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters  
# =============  
$path = "HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters"  
SetProperty $path "DefaultTTL" 0x40 # DefaultTTL -> 0x40 (64)  
SetProperty $path "EnablePMTUDiscovery" 1 # EnablePMTUDiscovery -> 1 (do not enable this if your server is directly exposed to potential attackers)  
SetProperty $path "EnablePMTUBHDetect" 1 # EnablePMTUBHDetect -> 1 (if your system is using a SOAP or HTTP and/or initiating web connections to other systems)  
SetProperty $path "TcpMaxDupAcks" 2 # TcpMaxDupAcks -> 2  
SetProperty $path "Tcp1323Opts" 1 # Tcp1323Opts -> 1 (experiment with a value of 3 for possible improved performance, especially if you are experiencing high packet loss/retransmits)  
SetProperty $path "SackOpts" 1 # SackOpts -> 1 (VERY important for large TCP window sizes, such as specified below)  
SetProperty $path "MaxFreeTcbs" 0x5000 # MaxFreeTcbs -> 0x5000 (20480)  
SetProperty $path "TcpMaxSendFree" 0xFFFF # TcpMaxSendFree -> 0xFFFF (65535)  
SetProperty $path "MaxHashTableSize" 0xFFFF # MaxHashTableSize -> 0xFFFF (65535)  
SetProperty $path "MaxUserPort" 0xFFFF # MaxUserPort -> 0xFFFF (65535)  
SetProperty $path "TcpTimedWaitDelay" 0x1E # TcpTimedWaitDelay -> 0x1E (30)  
SetProperty $path "GlobalMaxTcpWindowSize" 0xFFFF # GlobalMaxTcpWindowSize -> 0xFFFF (65535)  
SetProperty $path "NumTCPTablePartitions" 4 # NumTCPTablePartitions -> 2 per Processor/Core (include processor cores BUT NOT hyperthreading)  
# TcpAckFrequency (requires Windows Server 2K3 Hotfix 815230)  
# SetProperty $path "TcpAckFrequency" 5 #5 for 100Mb, 13 for 1Gb (requires Windows Server 2K3 Hotfix 815230) - can also be set at the interface level if mixed speeds; only set for connections primarily processing data  
SetProperty $path "SynAttackProtect" 0 # SynAttackProtect -> 0 (Only set this on systems with web exposure if other H/W or S/W is providing DOS attack protection)  
#Dedicated Network (DATA)  
#------------------------  
#Interfaces\<adapter ID\>\MTU -> 1450-1500, test for maximum value that will pass on each interface using PING -f -l <MTU Size> <Interface Gateway Address>, pick the value that works across all interfaces  
$RegistryEntries = Get-ItemProperty -path "HKLM:\system\currentcontrolset\services\tcpip\parameters\interfaces\*"  
foreach ( $iface in $RegistryEntries ) {   
$ip = $iface.DhcpIpAddress  
if ( $ip -ne $null ) { $childName = $iface.PSChildName}  
else {  
$ip = $iface.IPAddress  
if ($ip -ne $null) { $childName = $iface.PSChildName }  
}  
$Interface = Get-ItemProperty -path "HKLM:\system\currentcontrolset\services\tcpip\parameters\interfaces\$childName"  
$path = $Interface.PSPath  
SetProperty $path MTU $MTUSize  
}  
$path = "HKLM:\System\CurrentControlSet\Services\Tcpip\Parameters"  
$ForwardBufferMemory = 100*$MTUSize  
SetProperty $path "ForwardBufferMemory" $ForwardBufferMemory # ForwardBufferMemory -> 100*MTUSize, rounded up to the nearest 256 byte boundary  
SetProperty $path "MaxForwardBufferMemory" $ForwardBufferMemory # MaxForwardBufferMemory -> ForwardBufferMemory  
$NumForwardPackets = $ForwardBufferMemory/256  
SetProperty $path "NumForwardPackets" $NumForwardPackets # NumForwardPackets -> ForwardBufferMemory / 256  
SetProperty $path "MaxNumForwardPackets" $NumForwardPackets # MaxNumForwardPackets -> NumForwardPackets  
SetProperty $path "TcpWindowSize" 0xFBA4 # TcpWindowSize -> 0xFBA4 (64420) (make this a multiple of the TCP MSS (Max Segment Size)  
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters  
# ===========  
$path = "HKLM:\SYSTEM\CurrentControlSet\Services\AFD\Parameters"  
SetProperty $path "EnableDynamicBacklog" 1 # EnableDynamicBacklog -> 1  
SetProperty $path "MinimumDynamicBacklog" 0xc8 # MinimumDynamicBacklog -> 0xc8 (200)  
SetProperty $path "MaximumDynamicBacklog" 0x4e20 # MaximumDynamicBacklog -> 0x4e20 (20000)  
SetProperty $path "DynamicBacklogGrowthDelta" 0x64 # DynamicBacklogGrowthDelta -> 0x64 (100)  
#S/W Configuration  
#=============  
#Disable NETBIOS on cluster private network, if configured


# Liberación de archivos temporales en sistema

Get-ChildItem -Recurse -Filter *.tmp | Remove-Item -Force