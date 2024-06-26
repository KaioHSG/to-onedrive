@echo off
title To OneDrive
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
dir /b /a:d "%userProfile%\OneDrive"
echo.
set /p folderLink=New name for current folder: 
if exist "%userProfile%\OneDrive\%folderLink%" (goto :conflict) else (goto :createLink)

:conflict
echo.
choice /c yn /m "A directory with that name already exists, I would like to replace it"
cls
if %errorLevel% equ 1 (
   rmdir /q "%userProfile%\OneDrive\%folderLink%"
   goto :createLink
)
if %errorLevel% equ 2 (goto :start)

:createLink
mklink /d "%userProfile%\OneDrive\%folderLink%" "%~dp0"
echo.
echo Finish.
pause > nul
exit