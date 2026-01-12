@echo off
chcp 65001 >nul
echo ================================================================================
echo 比对并同步 ufbook 和 uf2zhihu 中的图片
echo ================================================================================
echo.

cd /d "%~dp0.."

python scripts\compare_and_sync_images.py

echo.
echo 按任意键退出...
pause >nul
