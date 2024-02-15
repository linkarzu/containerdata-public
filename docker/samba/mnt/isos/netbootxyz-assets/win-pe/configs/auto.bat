@echo off

REM Filename: ~/github/containerdata-public/docker/samba/mnt/isos/netbootxyz-assets/win-pe/configs/auto.bat

REM Do not modify these below, unless you changed them and you know what you're doing
set SHARE=isos
set SETUP_PATH=windows\win-os\win11
set USERNAME=isos

echo.
echo Checking if config.ini exists
if not exist config.ini (
    echo.
    echo Make sure you create the config.ini file with the samba password
    echo See README.md for more details
    pause
    exit /b
)

REM Read SAMBASERVER from external file
set SERVER_FOUND=false
for /F "tokens=1,2 delims==" %%a in (config.ini) do (
    if "%%a"=="SAMBASERVER" (
        set SERVER_FOUND=true
        set SERVER=%%b
    )
)

if not "%SERVER_FOUND%"=="true" (
    echo.
    echo SAMBASERVER not set correctly in config.ini
    echo Expecting format: SAMBASERVER=serverIP or DNS name
    exit /b
)

REM Read password from external file and verify format
set PASSWORD_FOUND=false
for /F "tokens=1,2 delims==" %%a in (config.ini) do (
    if "%%a"=="PASSWORD" (
        set PASSWORD_FOUND=true
        set PASSWORD=%%b
    )
)

if not "%PASSWORD_FOUND%"=="true" (
    echo.
    echo Password not set correctly in config.ini
    echo Expecting format: PASSWORD=yourpassword
    exit /b
)

echo.
echo SERVER: %SERVER%
echo SHARE: %SHARE%
echo USERNAME: %USERNAME%
echo SETUP_PATH: %SETUP_PATH%

echo.
echo Removing restrictions
REM This is what allows us to bypass the secure boot check because netboot.xyz does not support it
for %%s in (sCPU sSecureBoot sTPM) do reg add HKLM\SYSTEM\Setup\LabConfig /f /v Bypas%%sCheck /d 1 /t reg_dword

echo.
echo Initializing network, please wait
wpeinit

REM I had to add a delay, otherwise my net use F: command below didn't work
REM So don't remove this, I spent hours trying to figure it out, maybe there's a better way, let me know
ping 127.0.0.1 -n 10 > nul

echo.
echo Verifying network connectivity to samba sever on %SERVER%...
ping %SERVER% -n 4

echo.
echo starting setup
echo Unattended installation will be performed
echo You will just need to specify the partition during setup
echo Language, region, and rest of steps will be automatic
echo Plese wait...

REM I included 3 retries in case that for a strange reason the drive cannot be mounted
echo.
echo Attempting to mount the network drive...
for /L %%i in (1,1,3) do (
    net use \\%SERVER%\%SHARE% /user:%USERNAME% "%PASSWORD%"
    if %errorlevel% == 0 (
        echo Drive was successfully mounted.
        goto executeSetup
    ) else (
        echo Failed to mount the drive. Error Level: %errorlevel%
        if %%i lss 3 (
            echo Attempt %%i of 3 failed, trying again
            ping 127.0.0.1 -n 10 > nul
        ) else (
            echo All attempts to mount the drive have failed.
            echo Try restarting the SAMBA docker container as a troubleshooting step
            pause
        )
    )
)

:executeSetup
echo.
echo Attempting to execute setup.exe...
for /L %%i in (1,1,3) do (
    \\%SERVER%\%SHARE%\%SETUP_PATH%\setup.exe /unattend:\\%SERVER%\%SHARE%\netbootxyz-assets\win-pe\configs\autoattend.xml
    if %errorlevel% == 0 (
        echo Setup was successfully executed.
        goto end
    ) else (
        echo Failed to execute setup. Error Level: %errorlevel%
        if %%i lss 3 (
            echo Attempt %%i of 3 failed, trying again
            ping 127.0.0.1 -n 20 > nul
        ) else (
            echo All attempts to execute setup have failed.
            echo Try restarting the SAMBA docker container as a troubleshooting step
            pause 
        )
    )
)

:end
pause

