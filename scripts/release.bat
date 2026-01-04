@echo off
chcp 65001 >nul
echo ====================================
echo   创建 GitHub Release
echo ====================================
echo.

echo [提示] 此功能需要安装 GitHub CLI (gh)
echo [提示] 下载地址: https://cli.github.com/
echo.

echo [1/6] 检查 GitHub CLI...
gh --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 GitHub CLI
    echo 请先安装: https://cli.github.com/
    pause
    exit /b 1
)
echo [✓] GitHub CLI 已安装

echo.
echo [2/6] 检查登录状态...
gh auth status >nul 2>&1
if errorlevel 1 (
    echo [提示] 需要登录 GitHub
    gh auth login
)

echo.
set /p version="请输入版本号 (例如: v1.0.0): "
if "%version%"=="" (
    echo [错误] 版本号不能为空
    pause
    exit /b 1
)

echo.
set /p release_notes="请输入发布说明: "
if "%release_notes%"=="" (
    set release_notes=Release %version%
)

echo.
echo [3/6] 创建 Git Tag...
git tag -a %version% -m "%release_notes%"
if errorlevel 1 (
    echo [错误] Tag 创建失败
    pause
    exit /b 1
)
echo [✓] Tag 已创建

echo.
echo [4/6] 推送 Tag 到 GitHub...
git push origin %version%
if errorlevel 1 (
    echo [错误] 推送失败
    pause
    exit /b 1
)
echo [✓] Tag 已推送

echo.
echo [5/6] 构建 PDF (可选)...
set /p build_pdf="是否生成 PDF 并附加到 Release? (Y/N): "
if /i "%build_pdf%"=="Y" (
    call scripts\pdf.bat
    set PDF_FILE=UF2025_虚幻引擎嘉年华演讲总结_%date:~0,4%%date:~5,2%%date:~8,2%.pdf
) else (
    set PDF_FILE=
)

echo.
echo [6/6] 创建 GitHub Release...
if "%PDF_FILE%"=="" (
    gh release create %version% --title "%version%" --notes "%release_notes%"
) else (
    gh release create %version% --title "%version%" --notes "%release_notes%" "%PDF_FILE%"
)

if errorlevel 1 (
    echo [错误] Release 创建失败
    pause
    exit /b 1
)

echo.
echo ====================================
echo   Release 创建完成！
echo ====================================
echo 版本: %version%
echo 查看: https://github.com/wlxklyh/ufbook/releases
pause

