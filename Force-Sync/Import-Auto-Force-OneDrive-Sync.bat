@echo off
title Auto Force OneDrive Sync
whoami /groups | find "S-1-16-12288" > nul
if %errorLevel% neq 0 (
   echo Accept Administrator Privileges to continue.
   echo createObject("shell.application"^).shellExecute "%~s0", "", "", "runas", 1 > "%temp%\UAC_%~n0.vbs"
   "%temp%\UAC_%~n0.vbs"
   del "%temp%\UAC_%~n0.vbs" /q
   exit
)
pushd "%~dp0"
schtasks /create /tn "Auto Force OneDrive Sync" /xml "Auto-Force-OneDrive-Sync.xml" /f
echo.
echo Finish.
pause > nul
exit