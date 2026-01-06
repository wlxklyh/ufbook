@echo off
chcp 65001 >nul
echo ====================================
echo   构建 GitBook 静态网站
echo ====================================
echo.

echo [1/2] 清理旧的构建文件...
if exist "_book" (
    rmdir /s /q "_book"
    echo [✓] 已清理旧文件
)

echo.
echo [2/2] 开始构建...
call gitbook build
if errorlevel 1 (
    echo.
    echo [错误] 构建失败
    pause
    exit /b 1
)

echo.
echo ====================================
echo   构建完成！
echo ====================================
echo 输出目录: _book\
echo 可以直接部署 _book 目录到服务器
pause


