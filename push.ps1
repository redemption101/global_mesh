param()

$gitPath = "C:\Program Files\Git\bin\git.exe"
$repoPath = "c:\Users\vundl\Documents\global_mesh"

Push-Location $repoPath

Write-Host "Step 1: Adding all files..."
& $gitPath add -A

Write-Host "`nStep 2: Creating initial commit..."
& $gitPath commit -m "Initial commit: Global Mesh project"

Write-Host "`nStep 3: Setting main branch..."
& $gitPath branch -M main

Write-Host "`nStep 4: Pushing to GitHub main branch..."
Write-Host "Note: You may be prompted for GitHub credentials (use your Personal Access Token)"
& $gitPath push -u origin main

Write-Host "`nDone! Your repository has been pushed to GitHub."
Pop-Location
