# UF Book - Deploy to GitHub Pages
# PowerShell Script with UTF-8 encoding

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  UF Book - 部署到 GitHub Pages" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Change to project root
Set-Location "$PSScriptRoot\.."

# Check if MkDocs is installed
try {
    $mkdocsVersion = mkdocs --version 2>&1
    Write-Host "[✓] MkDocs 已安装: $mkdocsVersion" -ForegroundColor Green
} catch {
    Write-Host "[✗] 错误: 未检测到 MkDocs!" -ForegroundColor Red
    Write-Host ""
    Write-Host "请先运行 scripts\install.bat 安装依赖" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit 1
}

# Check if in Git repository
try {
    git status | Out-Null
    Write-Host "[✓] Git 仓库已就绪" -ForegroundColor Green
} catch {
    Write-Host "[✗] 错误: 当前目录不是 Git 仓库!" -ForegroundColor Red
    Write-Host ""
    Write-Host "请确保项目已初始化为 Git 仓库:" -ForegroundColor Yellow
    Write-Host "  git init"
    Write-Host "  git remote add origin [你的仓库地址]"
    Read-Host "按回车键退出"
    exit 1
}

Write-Host ""
Write-Host "[提示] 此操作将会:" -ForegroundColor Yellow
Write-Host "  1. 构建静态网站"
Write-Host "  2. 部署到 gh-pages 分支"
Write-Host "  3. 推送到 GitHub"
Write-Host ""
$confirm = Read-Host "确认部署? (Y/N)"
if ($confirm -ne "Y" -and $confirm -ne "y") {
    Write-Host "部署已取消" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "[部署] 正在部署到 GitHub Pages..." -ForegroundColor Cyan
Write-Host ""

# Use MkDocs built-in deploy command
try {
    mkdocs gh-deploy --clean
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "  ✓ 部署成功!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "你的网站将在几分钟内更新" -ForegroundColor Green
        Write-Host ""
        Write-Host "访问地址:" -ForegroundColor Cyan
        Write-Host "https://wlxklyh.github.io/ufbook/" -ForegroundColor Blue
        Write-Host ""
        Write-Host "提示:" -ForegroundColor Yellow
        Write-Host "- 首次部署可能需要等待 5-10 分钟"
        Write-Host "- 在 GitHub 仓库设置中启用 Pages (gh-pages 分支)"
        Write-Host ""
    } else {
        throw "MkDocs 部署失败"
    }
} catch {
    Write-Host ""
    Write-Host "[✗] 错误: 部署失败!" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因:" -ForegroundColor Yellow
    Write-Host "1. 没有配置 Git 远程仓库"
    Write-Host "2. 没有推送权限"
    Write-Host "3. 网络连接问题"
    Write-Host ""
    Write-Host "手动部署步骤:" -ForegroundColor Cyan
    Write-Host "1. mkdocs build"
    Write-Host "2. git checkout gh-pages"
    Write-Host "3. 复制 site/* 到根目录"
    Write-Host "4. git add . && git commit -m 'Update' && git push"
    Write-Host ""
    Read-Host "按回车键退出"
    exit 1
}

Read-Host "按回车键退出"

