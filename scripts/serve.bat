@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 本地预览服务
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

echo [启动] 正在启动本地预览服务...
echo.
echo 服务地址: http://127.0.0.1:8000
echo 按 Ctrl+C 停止服务
echo.
echo ========================================
echo.

REM 切换到项目根目录
cd /d "%~dp0\.."

REM 启动 MkDocs 开发服务器
mkdocs serve

pause


