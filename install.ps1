# WorkBuddy 技能安装脚本 (Windows PowerShell)
# 用法: .\install.ps1 -Skill <技能名> [-TargetRoot <目标目录>]
#   目标目录默认 $env:USERPROFILE\.workbuddy\skills

param(
    [Parameter(Mandatory = $true)]
    [string]$Skill,

    [string]$TargetRoot = (Join-Path $env:USERPROFILE ".workbuddy\skills")
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Show-Skills {
    Write-Host "可用技能:"
    Get-ChildItem -Path $ScriptDir -Directory | Where-Object {
        Test-Path (Join-Path $_.FullName "SKILL.md")
    } | ForEach-Object { Write-Host "  - $($_.Name)" }
}

$Src = Join-Path $ScriptDir $Skill

if (-not (Test-Path $Src -PathType Container)) {
    Write-Host "错误: 技能目录不存在 -> $Src"
    Show-Skills
    exit 1
}

if (-not (Test-Path (Join-Path $Src "SKILL.md") -PathType Leaf)) {
    Write-Host "错误: $Src 下没有 SKILL.md，不是合法的技能目录"
    exit 1
}

if (-not (Test-Path $TargetRoot)) {
    New-Item -ItemType Directory -Path $TargetRoot -Force | Out-Null
}

$Dest = Join-Path $TargetRoot $Skill

if (Test-Path $Dest) {
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $bak = "$Dest.bak-$stamp"
    Move-Item -Path $Dest -Destination $bak -Force
    Write-Host "目标已存在，已备份为: $bak"
}

Copy-Item -Path $Src -Destination $Dest -Recurse -Force

Write-Host ""
Write-Host "已安装: $Dest"
Write-Host "内容:"
Get-ChildItem -Path $Dest -Recurse -File | ForEach-Object { Write-Host "  $($_.FullName)" }
Write-Host ""
Write-Host "提示: 重启 WorkBuddy 会话后技能才会被加载。"
