@echo off
setlocal

:: Display a starting message
echo Starting system health checks - Script by X1...
echo ========================================

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

:: Display completion message
echo ========================================
echo System health checks completed.

endlocal
pause
