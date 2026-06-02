@echo off
cd /d c:\Users\vundl\Documents\global_mesh

echo Checking git status...
"C:\Program Files\Git\bin\git.exe" status

echo.
echo Checking git remotes...
"C:\Program Files\Git\bin\git.exe" remote -v

echo.
echo Checking git log...
"C:\Program Files\Git\bin\git.exe" log --oneline -3

pause
