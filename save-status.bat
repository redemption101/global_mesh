@echo off
cd /d c:\Users\vundl\Documents\global_mesh

echo Git Status and Info > git-output.txt
echo ================= >> git-output.txt
echo. >> git-output.txt

echo Checking git status... >> git-output.txt
"C:\Program Files\Git\bin\git.exe" status >> git-output.txt 2>&1

echo. >> git-output.txt
echo Checking git remotes... >> git-output.txt
"C:\Program Files\Git\bin\git.exe" remote -v >> git-output.txt 2>&1

echo. >> git-output.txt
echo Checking git log... >> git-output.txt
"C:\Program Files\Git\bin\git.exe" log --oneline -5 >> git-output.txt 2>&1

echo. >> git-output.txt
echo Checking git config... >> git-output.txt
"C:\Program Files\Git\bin\git.exe" config --global user.email >> git-output.txt 2>&1
"C:\Program Files\Git\bin\git.exe" config --global user.name >> git-output.txt 2>&1

echo Output saved to git-output.txt
pause
