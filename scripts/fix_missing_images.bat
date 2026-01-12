@echo off
chcp 65001 >nul
echo ================================================================================
echo 修复 MkDocs 文档中缺失的图片
echo ================================================================================
echo.

cd /d "%~dp0.."

python scripts\fix_missing_images.py

echo.
echo 按任意键退出...
pause >nul
