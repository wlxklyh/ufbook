@echo off
chcp 65001 >nul
echo ====================================
echo   更新内容并推送到 GitHub
echo ====================================
echo.

echo [1/4] 检查 Git 状态...
git status
echo.

set /p commit_msg="请输入提交信息: "
if "%commit_msg%"=="" (
    echo [错误] 提交信息不能为空
    pause
    exit /b 1
)

echo.
echo [2/4] 添加所有更改...
git add .
echo [✓] 已添加所有更改

echo.
echo [3/4] 提交更改...
git commit -m "%commit_msg%"
if errorlevel 1 (
    echo [警告] 可能没有更改需要提交
)

echo.
echo [4/4] 推送到 GitHub...
git push origin main
if errorlevel 1 (
    echo.
    echo [错误] 推送失败，请检查网络连接和权限
    pause
    exit /b 1
)

echo.
echo ====================================
echo   更新完成！
echo ====================================
echo 更改已推送到: https://github.com/wlxklyh/ufbook
pause


