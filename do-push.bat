@echo off
setlocal enabledelayedexpansion

cd /d c:\Users\vundl\Documents\global_mesh

REM Create output file
set output=c:\Users\vundl\Documents\global_mesh\push-output.txt
(
    echo ============================================
    echo Git Push to GitHub - Output Log
    echo ============================================
    echo.
    echo Current directory: %CD%
    echo.
    
    echo Step 1: Adding all files to git...
    "C:\Program Files\Git\bin\git.exe" add -A
    echo Git add completed with exit code: !ERRORLEVEL!
    echo.
    
    echo Step 2: Creating initial commit...
    "C:\Program Files\Git\bin\git.exe" commit -m "Initial commit: Global Mesh project"
    echo Git commit completed with exit code: !ERRORLEVEL!
    echo.
    
    echo Step 3: Setting branch to main...
    "C:\Program Files\Git\bin\git.exe" branch -M main
    echo Branch rename completed with exit code: !ERRORLEVEL!
    echo.
    
    echo Step 4: Pushing to GitHub...
    "C:\Program Files\Git\bin\git.exe" push -u origin main
    echo Push completed with exit code: !ERRORLEVEL!
    echo.
    
    echo ============================================
    echo Process Complete
    echo ============================================
) > "%output%" 2>&1

REM Display the output
type "%output%"
echo.
echo Output saved to: %output%
echo.
pause
