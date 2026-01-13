# 检查站点大小脚本
# 用于检查构建后的 site 目录大小，判断是否超过 GitHub Pages 的 1GB 限制

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  检查站点大小" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 切换到项目根目录
Set-Location "$PSScriptRoot\.."

# 检查 site 目录是否存在
if (-not (Test-Path "site")) {
    Write-Host "[!] site 目录不存在，请先构建站点：" -ForegroundColor Yellow
    Write-Host "   mkdocs build" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "[检查] 正在计算 site 目录大小..." -ForegroundColor Cyan
Write-Host ""

# 计算 site 目录总大小
$files = Get-ChildItem -Path "site" -Recurse -File
$totalSize = ($files | Measure-Object -Property Length -Sum).Sum
$sizeGB = [math]::Round($totalSize / 1GB, 2)
$sizeMB = [math]::Round($totalSize / 1MB, 2)
$fileCount = $files.Count

# GitHub Pages 限制：1GB
$limitGB = 1
$limitBytes = $limitGB * 1GB

Write-Host "站点大小统计：" -ForegroundColor Yellow
Write-Host "  文件数量: $fileCount 个文件" -ForegroundColor White
Write-Host "  总大小: $sizeGB GB ($sizeMB MB)" -ForegroundColor White
Write-Host ""
Write-Host "GitHub Pages 限制: $limitGB GB" -ForegroundColor Yellow
Write-Host ""

# 判断是否超过限制
if ($totalSize -gt $limitBytes) {
    $overSizeGB = [math]::Round(($totalSize - $limitBytes) / 1GB, 2)
    Write-Host "[✗] 警告：站点大小超过 GitHub Pages 限制！" -ForegroundColor Red
    Write-Host "   超出: $overSizeGB GB" -ForegroundColor Red
    Write-Host ""
    Write-Host "GitHub Pages 限制为 1GB，当前站点大小为 $sizeGB GB。" -ForegroundColor Yellow
    Write-Host "这会导致部署失败或超时。" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "解决方案：" -ForegroundColor Cyan
    Write-Host "1. 压缩图片文件（推荐使用 TinyPNG、Squoosh）" -ForegroundColor White
    Write-Host "2. 移除不必要的文件" -ForegroundColor White
    Write-Host "3. 将大文件存储到外部服务（如腾讯云 COS）" -ForegroundColor White
    Write-Host "4. 使用腾讯云开发部署（支持更大的文件大小）" -ForegroundColor White
    Write-Host ""
    Write-Host "详细说明请查看：GITHUB_PAGES_TIMEOUT_TROUBLESHOOTING.md" -ForegroundColor Cyan
} elseif ($totalSize -gt ($limitBytes * 0.9)) {
    Write-Host "[!] 警告：站点大小接近 GitHub Pages 限制" -ForegroundColor Yellow
    Write-Host "   建议优化文件大小，避免后续部署问题" -ForegroundColor Yellow
} else {
    Write-Host "[✓] 站点大小在 GitHub Pages 限制范围内" -ForegroundColor Green
    Write-Host "   可以正常部署到 GitHub Pages" -ForegroundColor Green
}

Write-Host ""

# 显示最大的几个文件
Write-Host "最大的 10 个文件：" -ForegroundColor Cyan
$largeFiles = $files | Sort-Object Length -Descending | Select-Object -First 10
foreach ($file in $largeFiles) {
    $fileSizeMB = [math]::Round($file.Length / 1MB, 2)
    $relativePath = $file.FullName.Replace((Get-Location).Path + "\", "")
    Write-Host "  $fileSizeMB MB - $relativePath" -ForegroundColor Gray
}

Write-Host ""
Read-Host "按回车键退出"

