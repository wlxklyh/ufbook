@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 生成 PDF 文档
echo ========================================
echo.

REM 检查是否已安装 Pandoc
pandoc --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Pandoc！
    echo.
    echo 请从以下地址下载安装 Pandoc:
    echo https://pandoc.org/installing.html
    echo.
    echo Windows 用户推荐下载 MSI 安装包
    pause
    exit /b 1
)

REM 切换到项目根目录
cd /d "%~dp0\.."

echo [检测] Pandoc 版本信息:
pandoc --version | findstr "pandoc"
echo.

REM 创建输出目录
if not exist "output" mkdir output

echo [准备] 正在收集所有 Markdown 文件...
echo.

REM 创建临时合并文件
set TEMP_FILE=output\temp_combined.md

REM 清空临时文件
if exist "%TEMP_FILE%" del "%TEMP_FILE%"

REM 合并所有章节文件（按照目录顺序）
echo # UF2025 虚幻引擎嘉年华演讲总结 >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
type docs\index.md >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"

REM 引擎功能
echo ## 📌 引擎功能 Engine Features >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\engine-features\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 性能优化
echo ## ⚡ 性能优化 Performance >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\performance\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 渲染技术
echo ## 🎮 渲染技术 Rendering >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\rendering\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 移动开发
echo ## 📱 移动开发 Mobile >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\mobile\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 程序化生成
echo ## 🎨 程序化生成 PCG >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\pcg\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 动画与物理
echo ## 🏃 动画与物理 Animation ^& Physics >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\animation-physics\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 开发工具
echo ## 🛠️ 开发工具 Tools >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\tools\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 项目实战
echo ## 🎯 项目实战 Project Cases >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\project-cases\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 行业应用
echo ## 🏢 行业应用 Industry Applications >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\industry\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 引擎生态
echo ## 🚀 引擎生态 Engine Ecosystem >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\ecosystem\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

REM 附录
echo ## 📚 附录 Appendix >> "%TEMP_FILE%"
echo. >> "%TEMP_FILE%"
for %%f in (docs\appendix\*.md) do (
    echo ### %%~nf >> "%TEMP_FILE%"
    type "%%f" >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
    echo. >> "%TEMP_FILE%"
)

echo [生成] 正在生成 PDF 文档...
echo.

REM 生成 PDF
pandoc "%TEMP_FILE%" -o output\ufbook.pdf ^
    --pdf-engine=xelatex ^
    --toc ^
    --toc-depth=2 ^
    -V CJKmainfont="Microsoft YaHei" ^
    -V geometry:margin=1in ^
    -V documentclass=report ^
    --highlight-style=tango ^
    --number-sections

if errorlevel 1 (
    echo.
    echo [错误] PDF 生成失败！
    echo.
    echo 可能的原因：
    echo 1. 未安装 LaTeX 环境（需要 MiKTeX 或 TeX Live）
    echo 2. 字体不存在
    echo.
    echo 建议：
    echo - 安装 MiKTeX: https://miktex.org/download
    echo - 或使用轻量级方案（不包含LaTeX特性）
    pause
    exit /b 1
)

REM 清理临时文件
del "%TEMP_FILE%"

echo.
echo ========================================
echo   ✓ PDF 生成成功！
echo ========================================
echo.
echo 输出文件: output\ufbook.pdf
echo.
pause

