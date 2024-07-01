:: Path to OneDrive
@set oneDrivePath=%userProfile%\OneDrive

@echo off
title To OneDrive
if not exist "%oneDrivePath%" (
    echo %oneDrivePath%
    echo.
    echo Error: unable to find OneDrive directory. Edit this ".bat" file to the correct location.
    pause > nul
    exit
)
whoami /groups | find "S-1-16-12288" > nul
if %errorLevel% neq 0 (
   echo Accept Administrator Privileges to continue.
   echo createObject("shell.application"^).shellExecute "%~s0", "", "", "runas", 1 > "%temp%\uac_%~n0.vbs"
   "%temp%\uac_%~n0.vbs"
   del /q "%temp%\uac_%~n0.vbs"
   exit
)
pushd "%~dp0"

:start
echo Saved folders:
echo -------------------------------------------------
dir /b /a:d "%oneDrivePath%"
echo.
set /p folderJunction=Folder name: 
if not exist "%oneDrivePath%\%folderJunction%" (
   echo.
   echo The specified folder does not exist.
   pause > nul
   cls
   goto :start
)
choice /c yn /m "All files will be copied to this folder. This could cause disastrous consequences. Continue"
if %errorLevel% equ 2 (exit)
cls
xcopy "%oneDrivePath%\%folderJunction%" "%~dp0" /v /f /e /-y
rmdir "%oneDrivePath%\%folderJunction%" /s /q
echo.
mklink /j "%oneDrivePath%\%folderJunction%" "%~dp0"
echo.
echo Finish.
pause > nul
cls
goto :start