@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
cls

echo ========================================
echo   UF Book - Local Preview Server
echo ========================================
echo.

REM 获取脚本所在目录并切换到项目根目录
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%.."
cd /d "%PROJECT_ROOT%"

REM 显示当前工作目录
echo [INFO] Current directory: %CD%
echo.

REM 检查是否已安装 MkDocs
echo [CHECK] Checking MkDocs installation...
mkdocs --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] MkDocs is not installed or not in PATH!
    echo.
    echo Please run one of the following:
    echo   1. scripts\install.bat
    echo   2. pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

REM 显示 MkDocs 版本
for /f "tokens=*" %%i in ('mkdocs --version 2^>nul') do set MKDOCS_VERSION=%%i
echo [OK] MkDocs found: !MKDOCS_VERSION!
echo.

REM 检查 mkdocs.yml 是否存在
echo [CHECK] Checking for mkdocs.yml...
if not exist "mkdocs.yml" (
    echo [ERROR] Config file 'mkdocs.yml' does not exist!
    echo.
    echo Current directory: %CD%
    echo Expected location: %CD%\mkdocs.yml
    echo.
    echo Please ensure you are running this script from the project root.
    echo.
    pause
    exit /b 1
)
echo [OK] Config file found: mkdocs.yml
echo.

REM 检查 docs 目录是否存在
if not exist "docs" (
    echo [WARNING] 'docs' directory not found!
    echo.
)

echo ========================================
echo   Starting MkDocs Development Server
echo ========================================
echo.
echo Server address: http://127.0.0.1:8000
echo.
echo Tips:
echo   - Press Ctrl+C to stop the server
echo   - Changes to files will auto-reload
echo   - Check the terminal for any errors
echo.
echo ========================================
echo.

REM 启动 MkDocs 开发服务器
mkdocs serve

REM 如果服务器异常退出，显示错误信息
if errorlevel 1 (
    echo.
    echo ========================================
    echo   Server stopped with errors
    echo ========================================
    echo.
    echo Possible causes:
    echo   1. Port 8000 is already in use
    echo   2. Configuration error in mkdocs.yml
    echo   3. Missing dependencies
    echo.
    echo To use a different port, edit this script and add:
    echo   mkdocs serve --dev-addr=127.0.0.1:8001
    echo.
)

pause
endlocal


