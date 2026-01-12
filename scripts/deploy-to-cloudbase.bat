@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 部署到腾讯云 CloudBase
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

REM 检查是否已安装 CloudBase CLI
tcb --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 CloudBase CLI！
    echo.
    echo 请先安装 CloudBase CLI：
    echo   npm install -g @cloudbase/cli
    echo.
    echo 或访问：https://docs.cloudbase.net/cli-v1/intro
    pause
    exit /b 1
)

echo [提示] 此脚本将：
echo   1. 构建静态网站
echo   2. 部署到 CloudBase 静态网站托管
echo.
echo 请确保已：
echo   - 登录 CloudBase CLI (tcb login)
echo   - 选择正确的环境 (tcb env:list)
echo.
echo 确认继续？
pause

echo.
echo [构建] 正在构建网站...
mkdocs build --clean

if errorlevel 1 (
    echo [错误] 构建失败！
    pause
    exit /b 1
)

echo.
echo [检查] 检查 CloudBase 登录状态...
tcb env:list >nul 2>&1
if errorlevel 1 (
    echo [提示] 需要先登录 CloudBase
    echo.
    echo 请执行：
    echo   tcb login
    echo.
    echo 然后重新运行此脚本
    pause
    exit /b 1
)

echo.
echo [部署] 正在部署到 CloudBase...
echo.

REM 部署到 CloudBase 静态网站托管
tcb hosting:deploy site/ -e %CLOUDBASE_ENV_ID%

if errorlevel 1 (
    echo.
    echo [错误] 部署失败！
    echo.
    echo 可能的原因：
    echo 1. 未设置环境 ID，请设置环境变量 CLOUDBASE_ENV_ID
    echo 2. 未登录 CloudBase CLI
    echo 3. 没有部署权限
    echo.
    echo 手动部署步骤：
    echo 1. tcb login
    echo 2. tcb env:list （查看环境列表）
    echo 3. set CLOUDBASE_ENV_ID=your-env-id
    echo 4. tcb hosting:deploy site/ -e your-env-id
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✓ 部署成功！
echo ========================================
echo.
echo 你的网站已部署到 CloudBase
echo.
echo 提示：
echo - 访问地址可在 CloudBase 控制台查看
echo - 可以绑定自定义域名
echo - 支持 HTTPS 和 CDN 加速
echo.
pause

