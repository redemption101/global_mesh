@echo off
cd /d c:\Users\vundl\Documents\global_mesh

echo Adding all files...
"C:\Program Files\Git\bin\git.exe" add -A

echo.
echo Creating initial commit...
"C:\Program Files\Git\bin\git.exe" commit -m "Initial commit: Global Mesh project"

echo.
echo Pushing to GitHub (main branch)...
"C:\Program Files\Git\bin\git.exe" push -u origin main

echo.
echo Done! Press any key to close this window.
pause
