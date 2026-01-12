@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - 环境安装脚本
echo ========================================
echo.

REM 检查 Python 是否已安装
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Python！
    echo.
    echo 请先安装 Python 3.7 或更高版本：
    echo https://www.python.org/downloads/
    echo.
    echo 安装时请勾选 "Add Python to PATH" 选项！
    pause
    exit /b 1
)

echo [✓] Python 已安装
python --version
echo.

REM 检查 pip 是否可用
pip --version >nul 2>&1
if errorlevel 1 (
    echo [错误] pip 不可用！
    echo 请重新安装 Python 并确保包含 pip
    pause
    exit /b 1
)

echo [✓] pip 已安装
pip --version
echo.

echo ========================================
echo   正在安装 MkDocs 及相关依赖...
echo ========================================
echo.

REM 升级 pip
python -m pip install --upgrade pip

REM 安装依赖
pip install -r requirements.txt

if errorlevel 1 (
    echo.
    echo [错误] 依赖安装失败！
    echo 请检查网络连接或尝试使用国内镜像源：
    echo pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✓ 依赖安装完成！
echo ========================================
echo.
echo 可选：安装 Pandoc 以支持 PDF 生成
echo 1. 下载 Pandoc: https://pandoc.org/installing.html
echo 2. 安装后可使用 build-pdf.bat 生成 PDF
echo.
echo 现在可以使用以下命令：
echo   - serve.bat       : 本地预览
echo   - build-web.bat   : 构建网站
echo   - build-pdf.bat   : 生成 PDF (需要 Pandoc)
echo   - deploy.bat      : 部署到 GitHub Pages
echo.
pause



