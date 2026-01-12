@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 部署到腾讯云服务器
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

echo [提示] 此脚本将：
echo   1. 构建静态网站
echo   2. 同步到腾讯云服务器
echo.
echo 请确保已配置：
echo   - 服务器 IP 地址
echo   - SSH 用户名
echo   - 部署路径
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
echo [提示] 请选择部署方式：
echo   1. 使用 rsync 同步（需要安装 rsync）
echo   2. 使用 SCP 同步
echo   3. 使用 Git 方式（需要在服务器上配置）
echo.
set /p choice="请输入选项 (1/2/3): "

if "%choice%"=="1" (
    echo.
    echo [部署] 使用 rsync 同步...
    echo 请修改脚本中的服务器信息后使用：
    echo   rsync -avz --delete site/ user@server-ip:/var/www/ufbook/
    echo.
    echo 或手动执行：
    echo   rsync -avz --delete site/ your-user@your-server-ip:/var/www/ufbook/
) else if "%choice%"=="2" (
    echo.
    echo [部署] 使用 SCP 同步...
    set /p server="请输入服务器地址 (user@server-ip): "
    set /p path="请输入部署路径 (/var/www/ufbook): "
    echo.
    echo [部署] 正在同步文件...
    scp -r site/* %server%:%path%/
    if errorlevel 1 (
        echo [错误] 同步失败！
        pause
        exit /b 1
    )
) else if "%choice%"=="3" (
    echo.
    echo [提示] Git 方式需要在服务器上配置
    echo 1. 在服务器上克隆仓库
    echo 2. 配置自动部署脚本
    echo 3. 推送代码后服务器自动更新
    echo.
    echo 当前仅构建完成，请手动部署到服务器
) else (
    echo [错误] 无效的选项！
    pause
    exit /b 1
)

echo.
echo ========================================
echo   [完成] 部署完成！
echo ========================================
echo.
echo 提示：
echo - 如果使用自定义域名，请检查 DNS 配置
echo - 如果使用 HTTPS，请确保已配置 SSL 证书
echo.
pause

