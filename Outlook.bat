@echo off
:check_Permissions

net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative privileges confirmed.
) else (
    echo Error: This batch file requires administrative privileges.
	echo Right-click OutlookNewBlocker.bat and click "Run as administrator."
	echo.
    pause
    goto konec
)

echo Copying AppxManifest.xml to %AppData%\OutlookNewBlocker
if not exist %AppData%\OutlookNewBlocker mkdir %AppData%\OutlookNewBlocker
copy "%~dp0AppxManifest.xml" "%AppData%\OutlookNewBlocker" >nul
if %errorLevel% neq 0 (
    echo Error: Failed to copy the file. Check if you have AppxManifest.xml file downloaded.
	echo.
    pause
    goto konec
)

echo Modifying registry to allow development mode...
powershell "New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1 -Force" >nul 2>nul

echo Removing Outlook appx package...
powershell "get-appxpackage -allusers Microsoft.OutlookForWindows | Remove-AppxPackage -allusers"

echo Registering AppxManifest.xml...
powershell add-appxpackage -register "%AppData%\OutlookNewBlocker\AppxManifest.xml"

cls
echo Success! OutlookNewBlocker is "installed" and will now prevent Windows from downgrading your email and calendar experience to a slow web wrapper known as Outlook new!
pause

:konec
