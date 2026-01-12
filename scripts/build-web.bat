@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - Build Static Website
echo ========================================
echo.

REM 检查是否已安装 MkDocs
mkdocs --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] MkDocs not detected!
    echo.
    echo Please run scripts\install.bat first to install dependencies
    pause
    exit /b 1
)

REM 切换到项目根目录
cd /d "%~dp0\.."

REM 检查 mkdocs.yml 是否存在
if not exist "mkdocs.yml" (
    echo [ERROR] Config file 'mkdocs.yml' does not exist in current directory.
    echo Current directory: %CD%
    echo.
    pause
    exit /b 1
)

echo [BUILD] Building static website...
echo.

REM 构建网站
mkdocs build --clean

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Build successful!
echo ========================================
echo.
echo Output directory: site\
echo.
echo You can preview using:
echo 1. Open site\index.html in browser
echo 2. Use Python: python -m http.server --directory site 8080
echo 3. Deploy to server or GitHub Pages
echo.
pause

