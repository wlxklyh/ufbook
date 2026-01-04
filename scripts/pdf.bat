@echo off
chcp 65001 >nul
echo ====================================
echo   生成 PDF 电子书
echo ====================================
echo.

echo [提示] 此功能需要安装 Calibre
echo [提示] 下载地址: https://calibre-ebook.com/download
echo.

echo [1/3] 检查 Calibre 是否安装...
ebook-convert --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Calibre，请先安装
    echo.
    echo 安装 Calibre 后，需要将其添加到系统 PATH：
    echo 默认路径: C:\Program Files\Calibre2\
    pause
    exit /b 1
)
echo [✓] Calibre 已安装

echo.
echo [2/3] 安装 GitBook PDF 插件...
call npm install -g gitbook-pdf

echo.
echo [3/3] 生成 PDF...
set OUTPUT_FILE=UF2025_虚幻引擎嘉年华演讲总结_%date:~0,4%%date:~5,2%%date:~8,2%.pdf
call gitbook pdf . "%OUTPUT_FILE%"
if errorlevel 1 (
    echo.
    echo [错误] PDF 生成失败
    pause
    exit /b 1
)

echo.
echo ====================================
echo   PDF 生成完成！
echo ====================================
echo 文件: %OUTPUT_FILE%
pause

