@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 构建静态网站
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

REM 切换到项目根目录
cd /d "%~dp0\.."

echo [构建] 正在构建静态网站...
echo.

REM 构建网站
mkdocs build --clean

if errorlevel 1 (
    echo.
    echo [错误] 构建失败！
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✓ 构建成功！
echo ========================================
echo.
echo 输出目录: site\
echo.
echo 可以使用以下方式预览：
echo 1. 用浏览器打开 site\index.html
echo 2. 使用 Python: python -m http.server --directory site 8080
echo 3. 部署到服务器或 GitHub Pages
echo.
pause

