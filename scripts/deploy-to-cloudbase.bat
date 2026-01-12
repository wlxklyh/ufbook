@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 部署到腾讯云 CloudBase
echo ========================================
echo.

REM 检查是否已安装 CloudBase CLI
where tcb >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 CloudBase CLI！
    echo.
    echo 请先安装 CloudBase CLI：
    echo   npm install -g @cloudbase/cli
    echo.
    echo 然后运行以下命令登录：
    echo   tcb login
    echo.
    pause
    exit /b 1
)

REM 切换到项目根目录
cd /d "%~dp0\.."

REM 检查是否已登录 CloudBase
tcb env:list >nul 2>&1
if errorlevel 1 (
    echo [错误] 未登录到 CloudBase！
    echo.
    echo 请先运行以下命令登录：
    echo   tcb login
    echo.
    echo 然后在控制台创建环境后，配置 cloudbaserc.json 文件
    pause
    exit /b 1
)

REM 检查配置文件
if not exist cloudbaserc.json (
    echo [错误] 未找到 cloudbaserc.json 配置文件！
    echo.
    echo 请先创建配置文件，参考 CLOUDBASE_DEPLOYMENT.md
    pause
    exit /b 1
)

echo [提示] 此操作将会：
echo   1. 构建静态网站到 site/ 目录
echo   2. 上传到 CloudBase 静态托管
echo   3. 自动发布到 CDN
echo.
echo 确认部署？
pause

echo.
echo [步骤 1/3] 构建静态网站...
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
echo [步骤 2/3] 上传到 CloudBase...
echo.

REM 部署到 CloudBase
tcb hosting:deploy site -e production

if errorlevel 1 (
    echo.
    echo [错误] 部署失败！
    echo.
    echo 可能的原因：
    echo 1. 环境 ID 配置错误（检查 cloudbaserc.json）
    echo 2. 没有静态托管权限
    echo 3. 网络连接问题
    echo.
    pause
    exit /b 1
)

echo.
echo [步骤 3/3] 清理缓存（可选）...
echo.

REM 刷新 CDN 缓存
tcb hosting:detail -e production

echo.
echo ========================================
echo   ✓ 部署成功！
echo ========================================
echo.
echo 你的网站已部署到 CloudBase 静态托管
echo.
echo 查看详细信息：
echo   tcb hosting:detail -e production
echo.
echo 自定义域名配置：
echo   访问 CloudBase 控制台 → 静态托管 → 域名管理
echo.
echo 提示：
echo - CDN 缓存刷新可能需要 5-10 分钟
echo - 首次访问可能较慢，后续会自动加速
echo.
pause

