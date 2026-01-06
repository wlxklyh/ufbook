@echo off
chcp 65001 >nul
echo ====================================
echo   安装 GitBook 依赖
echo ====================================
echo.

echo [1/3] 检查 Node.js 是否安装...
node --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Node.js，请先安装 Node.js
    echo 下载地址: https://nodejs.org/
    pause
    exit /b 1
)
echo [✓] Node.js 已安装

echo.
echo [2/3] 安装 GitBook CLI...
call npm install -g gitbook-cli
if errorlevel 1 (
    echo [错误] GitBook CLI 安装失败
    pause
    exit /b 1
)
echo [✓] GitBook CLI 安装完成

echo.
echo [3/3] 安装 GitBook 插件...
call gitbook install
if errorlevel 1 (
    echo [警告] 插件安装可能有问题，但不影响基本使用
)
echo [✓] 插件安装完成

echo.
echo ====================================
echo   安装完成！
echo ====================================
echo 运行 serve.bat 可以本地预览
echo 运行 build.bat 可以构建静态网站
pause


