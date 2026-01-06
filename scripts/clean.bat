@echo off
chcp 65001 >nul
echo ====================================
echo   清理构建文件
echo ====================================
echo.

echo 将要删除以下目录/文件:
echo   - _book\     (构建输出)
echo   - node_modules\  (依赖包)
echo   - *.pdf      (生成的PDF文件)
echo.

set /p confirm="确认删除? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo 已取消
    pause
    exit /b 0
)

echo.
echo [1/4] 清理 _book 目录...
if exist "_book" (
    rmdir /s /q "_book"
    echo [✓] 已删除 _book
) else (
    echo [✓] _book 不存在
)

echo.
echo [2/4] 清理 node_modules 目录...
if exist "node_modules" (
    rmdir /s /q "node_modules"
    echo [✓] 已删除 node_modules
) else (
    echo [✓] node_modules 不存在
)

echo.
echo [3/4] 清理 PDF 文件...
if exist "*.pdf" (
    del /q *.pdf
    echo [✓] 已删除 PDF 文件
) else (
    echo [✓] 无 PDF 文件
)

echo.
echo [4/4] 清理 GitBook 缓存...
if exist "%USERPROFILE%\.gitbook" (
    rmdir /s /q "%USERPROFILE%\.gitbook"
    echo [✓] 已清理缓存
)

echo.
echo ====================================
echo   清理完成！
echo ====================================
echo 运行 install.bat 可以重新安装依赖
pause


