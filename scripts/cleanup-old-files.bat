@echo off
chcp 65001 >nul
cls

echo ========================================
echo   UF Book - 清理旧文件
echo ========================================
echo.
echo 此脚本将删除以下旧的 GitBook 相关文件：
echo.
echo 📁 根目录下的重复章节目录（已迁移到 docs/）：
echo    - animation-physics/
echo    - appendix/
echo    - ecosystem/
echo    - engine-features/
echo    - industry/
echo    - mobile/
echo    - network/
echo    - pcg/
echo    - performance/
echo    - project-cases/
echo    - rendering/
echo    - tools/
echo.
echo 📄 旧的文档文件：
echo    - 使用指南.md
echo    - 快速参考.md
echo    - PROJECT_README.md
echo    - build_output.txt
echo    - build.log
echo.
echo ⚠️  警告：此操作不可恢复！
echo ⚠️  建议先提交当前更改到 Git，以便必要时回滚
echo.
echo ========================================
echo.

set /p confirm="确认删除以上文件？ (Y/N): "

if /i not "%confirm%"=="Y" (
    echo.
    echo 已取消操作
    pause
    exit /b 0
)

echo.
echo ========================================
echo   开始清理...
echo ========================================
echo.

REM 切换到项目根目录
cd /d "%~dp0\.."

REM 删除章节目录
if exist "animation-physics" (
    echo [删除] animation-physics/
    rmdir /s /q "animation-physics"
)

if exist "appendix" (
    echo [删除] appendix/
    rmdir /s /q "appendix"
)

if exist "ecosystem" (
    echo [删除] ecosystem/
    rmdir /s /q "ecosystem"
)

if exist "engine-features" (
    echo [删除] engine-features/
    rmdir /s /q "engine-features"
)

if exist "industry" (
    echo [删除] industry/
    rmdir /s /q "industry"
)

if exist "mobile" (
    echo [删除] mobile/
    rmdir /s /q "mobile"
)

if exist "network" (
    echo [删除] network/
    rmdir /s /q "network"
)

if exist "pcg" (
    echo [删除] pcg/
    rmdir /s /q "pcg"
)

if exist "performance" (
    echo [删除] performance/
    rmdir /s /q "performance"
)

if exist "project-cases" (
    echo [删除] project-cases/
    rmdir /s /q "project-cases"
)

if exist "rendering" (
    echo [删除] rendering/
    rmdir /s /q "rendering"
)

if exist "tools" (
    echo [删除] tools/
    rmdir /s /q "tools"
)

REM 删除旧文档文件
if exist "使用指南.md" (
    echo [删除] 使用指南.md
    del /f /q "使用指南.md"
)

if exist "快速参考.md" (
    echo [删除] 快速参考.md
    del /f /q "快速参考.md"
)

if exist "PROJECT_README.md" (
    echo [删除] PROJECT_README.md
    del /f /q "PROJECT_README.md"
)

if exist "build_output.txt" (
    echo [删除] build_output.txt
    del /f /q "build_output.txt"
)

if exist "build.log" (
    echo [删除] build.log
    del /f /q "build.log"
)

REM 删除旧的GitBook脚本（如果存在）
if exist "build_gitbook.bat" (
    echo [删除] build_gitbook.bat
    del /f /q "build_gitbook.bat"
)

if exist "serve_gitbook.bat" (
    echo [删除] serve_gitbook.bat
    del /f /q "serve_gitbook.bat"
)

if exist "start.bat" (
    echo [删除] start.bat（根目录旧版本）
    del /f /q "start.bat"
)

if exist "install.bat" (
    echo [删除] install.bat（根目录旧版本）
    del /f /q "install.bat"
)

echo.
echo ========================================
echo   ✓ 清理完成！
echo ========================================
echo.
echo 已删除所有旧的 GitBook 相关文件
echo.
echo 保留的文件：
echo   ✓ docs/ - 新的 MkDocs 内容目录
echo   ✓ scripts/ - 新的脚本工具
echo   ✓ mkdocs.yml - MkDocs 配置
echo   ✓ requirements.txt - Python 依赖
echo   ✓ 使用指南-MkDocs.md - 新的使用指南
echo   ✓ QUICKSTART.md - 快速开始
echo   ✓ README.md - 项目主页
echo   ✓ MIGRATION.md - 迁移说明
echo   ✓ site/ - 构建输出
echo.
echo 建议：
echo 1. 运行 "git status" 查看删除的文件
echo 2. 确认无误后提交：git add . ^&^& git commit -m "清理旧的GitBook文件"
echo 3. 推送到远程：git push
echo.
pause

