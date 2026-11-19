# Auto git archive: commit + push after daily pipeline (Stage 5)
# Runs sanity checks FIRST; aborts push on any failure. All ASCII (encoding-safe).
[Console]::OutputEncoding = [Text.Encoding]::UTF8
Set-Location D:\SFI

# --- Check 1: JSON validity (performance.json + registry.json) ---
node -e "const fs=require('fs');try{JSON.parse(fs.readFileSync('D:/SFI/glass/performance.json','utf8'));JSON.parse(fs.readFileSync('D:/SFI/genesis/registry.json','utf8'));console.log('JSON_OK')}catch(e){console.log('JSON_FAIL: '+e.message);process.exit(1)}"
if ($LASTEXITCODE -ne 0) { Write-Output "ABORT push: JSON invalid"; exit 1 }
Write-Output "check1 JSON: OK"

# --- Check 2: sensitive scan ---
node D:/SFI/genesis/scripts/sensitive-scan.js
if ($LASTEXITCODE -ne 0) { Write-Output "ABORT push: sensitive content found"; exit 1 }
Write-Output "check2 sensitive scan: OK"

# --- Check 3: changes present? ---
# -uall expands untracked directories; default status collapses them and undercounts files
$status = git status --porcelain -uall 2>&1
if (-not $status) { Write-Output "no changes to commit; push skipped"; exit 0 }
$n = ($status | Measure-Object -Line).Lines
Write-Output "check3 changes: $n file(s)"

# --- Commit + push ---
$date = Get-Date -Format "yyyy-MM-dd"
git add -A 2>&1 | Out-Null
git commit -m "auto: daily evolution $date ($n files: settle/evolve/research/push)" 2>&1 | Out-Null
$head = git rev-parse --short HEAD 2>&1
# NOTE: git progress goes to stderr (PowerShell treats as error); use exit code instead of $?
git push 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) { Write-Output "git commit $head OK but PUSH FAILED - check network/credentials"; exit 1 }
Write-Output "git archived: $head pushed ($n files)"
