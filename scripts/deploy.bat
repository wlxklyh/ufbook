@echo off
chcp 65001 >nul
echo ====================================
echo   部署到 GitHub Pages
echo ====================================
echo.

echo [提示] 此脚本将会:
echo   1. 构建静态网站
echo   2. 推送到 gh-pages 分支
echo   3. 自动部署到 GitHub Pages
echo.

set /p confirm="确认部署? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo 已取消
    pause
    exit /b 0
)

echo.
echo [1/5] 构建静态网站...
call scripts\build.bat
if errorlevel 1 (
    echo [错误] 构建失败
    pause
    exit /b 1
)

echo.
echo [2/5] 检查 gh-pages 分支...
git show-ref --verify --quiet refs/heads/gh-pages
if errorlevel 1 (
    echo [提示] gh-pages 分支不存在，将创建新分支
    git checkout --orphan gh-pages
    git rm -rf .
    echo "# GitHub Pages" > README.md
    git add README.md
    git commit -m "Initialize gh-pages"
    git push origin gh-pages
    git checkout main
)

echo.
echo [3/5] 切换到 gh-pages 分支...
git checkout gh-pages
if errorlevel 1 (
    echo [错误] 切换分支失败
    pause
    exit /b 1
)

echo.
echo [4/5] 复制构建文件...
xcopy /E /Y /I ..\main\_book\* .
git add .
git commit -m "Deploy: %date% %time%"

echo.
echo [5/5] 推送到 GitHub...
git push origin gh-pages
if errorlevel 1 (
    echo [错误] 推送失败
    git checkout main
    pause
    exit /b 1
)

git checkout main

echo.
echo ====================================
echo   部署完成！
echo ====================================
echo 访问地址: https://wlxklyh.github.io/ufbook/
echo.
echo [提示] GitHub Pages 可能需要几分钟才能更新
pause

