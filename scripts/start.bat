@echo off
chcp 65001 >nul
cls

:MENU
echo ========================================
echo   UF Book - 项目管理菜单
echo ========================================
echo.
echo   1. 安装依赖环境
echo   2. 本地预览（实时更新）
echo   3. 构建静态网站
echo   4. 生成 PDF 文档
echo   5. 部署到 GitHub Pages
echo.
echo   0. 退出
echo.
echo ========================================
echo.

set /p choice="请选择操作 [0-5]: "

if "%choice%"=="1" goto INSTALL
if "%choice%"=="2" goto SERVE
if "%choice%"=="3" goto BUILD_WEB
if "%choice%"=="4" goto BUILD_PDF
if "%choice%"=="5" goto DEPLOY
if "%choice%"=="0" goto EXIT

echo [错误] 无效的选择！
timeout /t 2 >nul
cls
goto MENU

:INSTALL
cls
echo.
echo [执行] 安装依赖...
echo.
call scripts\install.bat
echo.
pause
cls
goto MENU

:SERVE
cls
echo.
echo [执行] 启动本地预览...
echo.
call scripts\server.bat
cls
goto MENU

:BUILD_WEB
cls
echo.
echo [执行] 构建静态网站...
echo.
call scripts\build-web.bat
cls
goto MENU

:BUILD_PDF
cls
echo.
echo [执行] 生成 PDF...
echo.
call scripts\build-pdf.bat
cls
goto MENU

:DEPLOY
cls
echo.
echo [执行] 部署到 GitHub Pages...
echo.
call scripts\deploy.bat
cls
goto MENU

:EXIT
echo.
echo 再见！
timeout /t 1 >nul
exit

