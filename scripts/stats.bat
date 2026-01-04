@echo off
chcp 65001 >nul
echo ====================================
echo   GitBook 项目统计信息
echo ====================================
echo.

echo [文件统计]
echo ----------------------------------
for /f %%i in ('dir /s /b *.md ^| find /c /v ""') do echo Markdown 文件数: %%i

echo.
echo [Git 统计]
echo ----------------------------------
git log --oneline | find /c /v "" > temp.txt
set /p commit_count=<temp.txt
del temp.txt
echo 提交次数: %commit_count%

echo.
echo [最近提交]
echo ----------------------------------
git log --oneline -5

echo.
echo [仓库信息]
echo ----------------------------------
git remote -v

echo.
echo [文件大小]
echo ----------------------------------
for /f "tokens=3" %%i in ('dir /-c ^| find "File(s)"') do echo 项目大小: %%i bytes

echo.
pause

