@echo off
setlocal

:: Display a starting message
echo Starting system health checks
echo Script by X1 
echo.
echo   __   __  __ 
echo  "\ \ / / /_ |"
echo  " \ V /   | |"
echo   " > <    | |"
echo   "/ . \   | |"
echo  "/_/ \_\  |_|" 
echo.


echo Version 0.4
echo Github @Ox1de-crypto
echo ========================================

echo Please wait..
echo.
echo Gathering System Information...
echo.
echo Windows System Information
echo =========================

:: Get Windows Version
echo.
echo Windows Version:
systeminfo | findstr /B /C:"OS Version"

:: Get Windows Architecture
echo.
echo System Architecture:
wmic os get OSArchitecture

echo.

echo System Check Started...
echo.

:: Run DISM commands with verbose output
echo Running DISM /Online /Cleanup-Image /CheckHealth...
Dism /Online /Cleanup-Image /CheckHealth

echo.
echo Running DISM /Online /Cleanup-Image /ScanHealth...
Dism /Online /Cleanup-Image /ScanHealth

echo.
echo Running DISM /Online /Cleanup-Image /RestoreHealth...
Dism /Online /Cleanup-Image /RestoreHealth

echo.
echo Running sfc /SCANNOW...
sfc /SCANNOW

echo.
echo.
:: Display completion message
echo ========================================
echo System health checks completed.

endlocal
pause
