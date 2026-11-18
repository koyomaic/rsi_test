# Daily 4-stage pipeline (Task: Genesis-Glass-Daily, weekdays 19:30)
# Order: settle -> evolve -> next-day research -> dingtalk push
# Prompt text lives in pipeline-prompt.txt (UTF-8) to avoid encoding issues.
# NOTE: --auto auto-approves ask-level permissions; the prompt forbids editing L0 files.
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$OutputEncoding = [Text.Encoding]::UTF8
Set-Location D:\SFI
$log = "D:\SFI\glass\logs\pipeline-$(Get-Date -Format yyyyMMdd).log"
New-Item -ItemType Directory -Force -Path (Split-Path $log) | Out-Null
$stamp = Get-Date -Format "yyyy-MM-dd HH:mm"
"===== $stamp pipeline start (settle -> evolve -> research -> push) =====" | Add-Content -Path $log -Encoding UTF8

$prompt = Get-Content -Raw -Encoding UTF8 -LiteralPath "D:\SFI\genesis\scripts\pipeline-prompt.txt"

opencode run --agent genesis -m alibaba-cn/glm-5.2 --auto --title "glass-daily-pipeline" $prompt 2>&1 | Add-Content -Path $log -Encoding UTF8

# Stage 4: push notifications via dingtalk (read UTF-8 files; avoids PowerShell->python encoding issues)
# Push order: report first (trading decision info), then brief (daily review)
$pushDir = "D:\SFI\glass\push"
$today = (Get-Date).Date

$report = Get-ChildItem -LiteralPath $pushDir -Filter "report-*.md" -ErrorAction SilentlyContinue |
  Where-Object { $_.LastWriteTime -ge $today } |
  Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($report) {
  $rtitle = (Get-Content -Encoding UTF8 -TotalCount 1 -LiteralPath $report.FullName).Trim()
  "----- push report ($rtitle) -----" | Add-Content -Path $log -Encoding UTF8
  python C:/Users/kmagic/.agents/skills/dingtalk-robot-push/scripts/dt_push.py --title $rtitle --file $report.FullName 2>&1 | Add-Content -Path $log -Encoding UTF8
  "report push exit: $LASTEXITCODE" | Add-Content -Path $log -Encoding UTF8
} else {
  "WARN: no report-*.md written today" | Add-Content -Path $log -Encoding UTF8
}

$brief = "D:\SFI\glass\push\brief-$(Get-Date -Format yyyyMMdd).md"
if (Test-Path -LiteralPath $brief) {
  $title = (Get-Content -Encoding UTF8 -TotalCount 1 -LiteralPath $brief).Trim()
  "----- push brief ($title) -----" | Add-Content -Path $log -Encoding UTF8
  python C:/Users/kmagic/.agents/skills/dingtalk-robot-push/scripts/dt_push.py --title $title --file $brief 2>&1 | Add-Content -Path $log -Encoding UTF8
  "brief push exit: $LASTEXITCODE" | Add-Content -Path $log -Encoding UTF8
} else {
  "WARN: brief file not found: $brief" | Add-Content -Path $log -Encoding UTF8
}

"===== $stamp pipeline end =====" | Add-Content -Path $log -Encoding UTF8
