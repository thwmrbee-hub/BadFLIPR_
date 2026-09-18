@echo off
setlocal EnableDelayedExpansion
color 0a
title BadFLIPR

:MAIN_MENU
cls
call :BANNER
echo.
echo    [build v2]
echo.
echo    [1] Install Original Firmware
echo    [2] Install CFW
echo    [3] Flash Firmware Manually
echo    [4] Install Apps
echo    [5] Replace All with CFW
echo    [0] Exit
echo.
choice /c 123450 /n /m "   Select an option: "
set "MENUCHOICE=%errorlevel%"

if "%MENUCHOICE%"=="1" set "SELECTED=1" & goto CONFIRM_WIPE
if "%MENUCHOICE%"=="2" set "SELECTED=2" & goto CONFIRM_WIPE
if "%MENUCHOICE%"=="3" set "SELECTED=3" & goto CONFIRM_WIPE
if "%MENUCHOICE%"=="4" goto INSTALL_APPS
if "%MENUCHOICE%"=="5" set "SELECTED=5" & goto CONFIRM_WIPE
if "%MENUCHOICE%"=="6" exit /b
goto MAIN_MENU

:CONFIRM_WIPE
cls
call :BANNER
echo.
echo    WARNING: EVERYTHING will be DELETED! Continue? (Y/N)
choice /c YN /n /m "   > "
if %errorlevel% EQU 2 goto MAIN_MENU
goto ROUTE

:ROUTE
if "%SELECTED%"=="1" goto FLASH_ORIGINAL
if "%SELECTED%"=="2" goto CFW_MENU
if "%SELECTED%"=="3" goto FLASH_MANUAL
if "%SELECTED%"=="5" goto CFW_MENU
goto MAIN_MENU

:FLASH_ORIGINAL
cls
call :BANNER
echo.
echo    Flashing original firmware...
call :SCROLL_CODE
echo.
echo    Completed! Original firmware installed.
pause >nul
goto MAIN_MENU

:FLASH_MANUAL
cls
call :BANNER
echo.
set /p fwfile="   Enter path to firmware file: "
echo    Flashing !fwfile! ...
call :SCROLL_CODE
echo.
echo    Completed! Firmware flashed manually.
pause >nul
goto MAIN_MENU

:CFW_MENU
cls
call :BANNER
echo.
echo    Choose a Custom Firmware:
echo     [1] Bruce
echo     [2] BadFLIPR
echo     [3] cryrpluss
choice /c 123 /n /m "   Select: "
set "CFWSEL=%errorlevel%"
set "CFWNAME="
if "%CFWSEL%"=="1" set "CFWNAME=Bruce"
if "%CFWSEL%"=="2" set "CFWNAME=BadFLIPR"
if "%CFWSEL%"=="3" set "CFWNAME=cryrpluss"

cls
call :BANNER
echo.
echo    Installing !CFWNAME! ...
call :SCROLL_CODE
echo.
echo    Completed! Your Flipper is now jailbroken!
echo    It wont look any different, but the limitations are gone and it is now updated!
set "CFWNAME="
pause >nul
goto MAIN_MENU

:INSTALL_APPS
cls
call :BANNER
echo.
echo    Opening file browser...
set "APPFILE="
for /f "usebackq delims=" %%F in (`powershell -NoProfile -STA -Command "Add-Type -AssemblyName System.Windows.Forms; $owner = New-Object System.Windows.Forms.Form; $owner.TopMost = $true; $owner.StartPosition = 'CenterScreen'; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.Title = 'Select App to Install'; if ($f.ShowDialog($owner) -eq 'OK') { $f.FileName }; $owner.Dispose()"`) do set "APPFILE=%%F"

if not defined APPFILE (
    echo    No file selected.
    pause >nul
    goto MAIN_MENU
)

echo    Installing !APPFILE! ...
call :SCROLL_CODE
echo.
echo    Completed!
set "APPFILE="
pause >nul
goto MAIN_MENU

:SCROLL_CODE
for /L %%i in (1,1,450) do (
    set /a a=!random! %% 256
    set /a b=!random! %% 256
    set /a c=!random! %% 256
    set /a d=!random! %% 256
    echo    0x!a!  0x!b!  0x!c!  0x!d!   patching block %%i/450...
    ping -n 1 -w 400 127.0.0.1 >nul
)
goto :eof

:BANNER
echo   ####.  .###.  ####.  #####  #....  #####  ####.  ####.
echo   #...#  #...#  #...#  #....  #....  ..#..  #...#  #...#
echo   ####.  #####  #...#  ###..  #....  ..#..  ####.  ####.
echo   #...#  #...#  #...#  #....  #....  ..#..  #....  #..#.
echo   ####.  #...#  ####.  #....  #####  #####  #....  #...#
goto :eof
