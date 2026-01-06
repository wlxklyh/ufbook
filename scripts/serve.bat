@echo off
chcp 65001 >nul
echo ====================================
echo   启动 GitBook 本地预览服务器
echo ====================================
echo.

echo [提示] 服务器将在 http://localhost:4000 启动
echo [提示] 按 Ctrl+C 可以停止服务器
echo.

gitbook serve
if errorlevel 1 (
    echo.
    echo [错误] 启动失败，请确保已运行 install.bat 安装依赖
    pause
    exit /b 1
)


