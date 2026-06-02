param()

$gitPath = "C:\Program Files\Git\bin\git.exe"
$repoPath = "c:\Users\vundl\Documents\global_mesh"

Push-Location $repoPath

Write-Host "Git Status:"
& $gitPath status

Write-Host "`nGit Remote:"
& $gitPath remote -v

Write-Host "`nGit Log (last 3 commits):"
& $gitPath log --oneline -3 2>&1

Pop-Location
