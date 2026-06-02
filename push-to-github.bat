@echo off
setlocal enabledelayedexpansion

REM Navigate to the repository directory
cd /d c:\Users\vundl\Documents\global_mesh

REM Configure git
"C:\Program Files\Git\bin\git.exe" config --global user.email "vundlamkv@gmail.com"
"C:\Program Files\Git\bin\git.exe" config --global user.name "redemption101"

REM Initialize git repository if not already initialized
if not exist ".git" (
    echo Initializing git repository...
    "C:\Program Files\Git\bin\git.exe" init
)

REM Add all files to staging
echo Adding files...
"C:\Program Files\Git\bin\git.exe" add -A

REM Create initial commit
echo Creating initial commit...
"C:\Program Files\Git\bin\git.exe" commit -m "Initial commit: Global Mesh project"

REM Add remote origin
echo Adding remote origin...
"C:\Program Files\Git\bin\git.exe" remote add origin https://github.com/redemption101/global_mesh.git

REM Push to main branch
echo Pushing to GitHub (main branch)...
"C:\Program Files\Git\bin\git.exe" branch -M main
"C:\Program Files\Git\bin\git.exe" push -u origin main

echo Done!
pause
