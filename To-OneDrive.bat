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
   echo createObject("shell.application"^).shellExecute "%~s0", "", "", "runas", 1 > "%temp%\UAC_%~n0.vbs"
   "%temp%\UAC_%~n0.vbs"
   del "%temp%\UAC_%~n0.vbs" /q
   exit
)
pushd "%~dp0"

:start
echo Saved folders:
echo -------------------------------------------------
dir /b /a:d "%oneDrivePath%"
echo.
set /p folderJunction=New name for current folder: 
if exist "%oneDrivePath%\%folderJunction%" (goto :conflict) else (goto :createLink)

:conflict
echo.
choice /c yn /m "A folder with that name already exists, I would like to replace it"
cls
if %errorLevel% equ 1 (
   rmdir "%oneDrivePath%\%folderJunction%" /s /q
   goto :createLink
)
if %errorLevel% equ 2 (goto :start)

:createLink
cls
mklink /j "%oneDrivePath%\%folderJunction%" "%~dp0"
echo.
echo Finish.
pause > nul
exit