@echo off
setlocal EnableDelayedExpansion
color 0A
title Windows System Health Scanner - by X1

:: Header
cls
echo.
echo ====================================================
echo            "WINDOWS SYSTEM HEALTH & REPAIR Scanner"
echo                  Version 0.8.2
echo                  Github: @ox1d3x3
echo                     __   __  __ 
echo                    "\ \ / / /_ |"
echo                    " \ V /   | |"
echo                     " > <    | |"
echo                     "/ . \   | |"
echo                    "/_/ \_\  |_|" 
echo
echo ====================================================
echo 
echo.

:: Check Admin Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Please run this script as Administrator!
    echo.
    pause
    exit /b
)

:: System Info Section
echo [+] Gathering Basic System Information...
echo ----------------------------------------------------
echo OS Version:
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
echo.
echo Architecture:
wmic os get OSArchitecture
echo ----------------------------------------------------
echo.

:: STARTING SYSTEM SCANS
echo [+] Starting System Health Checks...
echo ----------------------------------------------------

:: 1. DISM CheckHealth
echo [1/6] DISM /Online /Cleanup-Image /CheckHealth
Dism /Online /Cleanup-Image /CheckHealth
echo.

:: 2. DISM ScanHealth
echo [2/6] DISM /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /ScanHealth
echo.

:: 3. DISM RestoreHealth (uses Windows Update)
echo [3/6] DISM /Online /Cleanup-Image /RestoreHealth
Dism /Online /Cleanup-Image /RestoreHealth
echo.

:: 4. System File Checker
echo [4/6] Running SFC /Scannow...
sfc /scannow
echo.

:: 5. Check Disk (Optional on Reboot)
echo [5/6] Scheduling Check Disk (will run on next boot)...
chkdsk C: /F
echo.

:: 6. (Optional) Reset Windows Update components
echo [6/6] Resetting Windows Update components...
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
echo.

:: Summary
echo ----------------------------------------------------
echo "[✓] System Health Scan & Repairs Completed."
echo ----------------------------------------------------
echo Please review the output above for any errors or repairs.
echo Press any key to exit...
pause >nul
endlocal
