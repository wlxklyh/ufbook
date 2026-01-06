@echo off
chcp 65001 >nul
echo ====================================
echo   GitBook 快速菜单
echo ====================================
echo.
echo 请选择操作:
echo.
echo  [1] 安装依赖 (首次使用)
echo  [2] 本地预览
echo  [3] 构建网站
echo  [4] 生成 PDF
echo  [5] 更新并推送
echo  [6] 部署到 GitHub Pages
echo  [7] 创建 Release
echo  [8] 查看统计
echo  [9] 清理文件
echo  [0] 退出
echo.

set /p choice="请输入选项 (0-9): "

if "%choice%"=="1" call scripts\install.bat
if "%choice%"=="2" call scripts\serve.bat
if "%choice%"=="3" call scripts\build.bat
if "%choice%"=="4" call scripts\pdf.bat
if "%choice%"=="5" call scripts\update.bat
if "%choice%"=="6" call scripts\deploy.bat
if "%choice%"=="7" call scripts\release.bat
if "%choice%"=="8" call scripts\stats.bat
if "%choice%"=="9" call scripts\clean.bat
if "%choice%"=="0" exit /b 0

echo.
pause
cls
goto :eof


