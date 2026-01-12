@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 部署到 GitHub Pages
echo ========================================
echo.

REM 检查是否已安装 MkDocs
mkdocs --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 MkDocs！
    echo.
    echo 请先运行 scripts\install.bat 安装依赖
    pause
    exit /b 1
)

REM 检查是否在 Git 仓库中
cd /d "%~dp0\.."
git status >nul 2>&1
if errorlevel 1 (
    echo [错误] 当前目录不是 Git 仓库！
    echo.
    echo 请确保项目已初始化为 Git 仓库：
    echo   git init
    echo   git remote add origin [你的仓库地址]
    pause
    exit /b 1
)

echo [提示] 此操作将会：
echo   1. 构建静态网站
echo   2. 部署到 gh-pages 分支
echo   3. 推送到 GitHub
echo.
echo 确认部署？
pause

echo.
echo [部署] 正在部署到 GitHub Pages...
echo.

REM 使用 MkDocs 内置部署命令
mkdocs gh-deploy --clean

if errorlevel 1 (
    echo.
    echo [错误] 部署失败！
    echo.
    echo 可能的原因：
    echo 1. 没有配置 Git 远程仓库
    echo 2. 没有推送权限
    echo 3. 网络连接问题
    echo.
    echo 手动部署步骤：
    echo 1. mkdocs build
    echo 2. git checkout gh-pages
    echo 3. 复制 site/* 到根目录
    echo 4. git add . ^&^& git commit -m "Update" ^&^& git push
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✓ 部署成功！
echo ========================================
echo.
echo 你的网站将在几分钟内更新
echo.
echo 访问地址：
echo https://yourusername.github.io/ufbook/
echo.
echo 提示：
echo - 首次部署可能需要等待 5-10 分钟
echo - 在 GitHub 仓库设置中启用 Pages（gh-pages 分支）
echo.
pause


