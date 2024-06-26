@echo off
title OneDrive Force Synk
echo Syncing OneDrive...
"C:\Program Files\Microsoft OneDrive\OneDrive.exe" /shutdown
start "" "C:\Program Files\Microsoft OneDrive\OneDrive.exe" /background
exit