@echo off
title To OneDrive
echo Saved folders:
echo -------------------------------------------------
dir /b /a:d "%userProfile%\OneDrive"
echo.
set /p folderName=New name for current folder: 
cls
mklink /d "%userProfile%\OneDrive\%folderName%" "%~dp0"
echo.
echo Finish.
pause > nul
exit