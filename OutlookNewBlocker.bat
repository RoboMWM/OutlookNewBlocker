@echo off
:check_Permissions

net session >nul 2>&1
if %errorLevel% == 0 (
    echo.
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
    echo AppxManifest.xml not found, attempting to download from GitHub...
    curl https://raw.githubusercontent.com/RoboMWM/OutlookNewBlocker/refs/heads/master/AppxManifest.xml -o %AppData%\OutlookNewBlocker\AppxManifest.xml
    if %errorLevel% neq 1 (
        echo.
        echo Error: Failed to create AppxManifest.xml. Download AppxManifest.xml from GitHub and try again.
        echo.
        pause
        goto konec
    )
)
echo Modifying registry to enable development mode...
powershell "New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1 -Force" >nul 2>nul

echo Removing Outlook appx package...
powershell "get-appxpackage -allusers Microsoft.OutlookForWindows | Remove-AppxPackage -allusers"

echo Registering AppxManifest.xml...
powershell add-appxpackage -register "%AppData%\OutlookNewBlocker\AppxManifest.xml"

cls
echo Success! OutlookNewBlocker is "installed" and will prevent Windows from installing Outlook new. You should now be able to continue using the Mail and Calendar apps without interruption!
pause

:konec
