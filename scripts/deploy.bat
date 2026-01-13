@echo off
chcp 65001 >nul
echo ========================================
echo   UF Book - Deploy to GitHub Pages
echo ========================================
echo.

REM Check if MkDocs is installed
mkdocs --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] MkDocs not detected!
    echo.
    echo Please run scripts\install.bat first
    pause
    exit /b 1
)

REM Check if in Git repository
cd /d "%~dp0\.."
git status >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Current directory is not a Git repository!
    echo.
    echo Please ensure the project is initialized as Git repo:
    echo   git init
    echo   git remote add origin [your-repo-url]
    pause
    exit /b 1
)

echo [INFO] This operation will:
echo   1. Build the static website
echo   2. Deploy to gh-pages branch
echo   3. Push to GitHub
echo.
echo Confirm deployment?
pause

echo.
echo [DEPLOY] Deploying to GitHub Pages...
echo.

REM Use MkDocs built-in deploy command
mkdocs gh-deploy --clean

if errorlevel 1 (
    echo.
    echo [ERROR] Deployment failed!
    echo.
    echo Possible reasons:
    echo 1. No Git remote repository configured
    echo 2. No push permission
    echo 3. Network connection issue
    echo.
    echo Manual deployment steps:
    echo 1. mkdocs build
    echo 2. git checkout gh-pages
    echo 3. Copy site/* to root directory
    echo 4. git add . ^&^& git commit -m "Update" ^&^& git push
    pause
    exit /b 1
)

echo.
echo ========================================
echo   SUCCESS! Deployment completed!
echo ========================================
echo.
echo Your website will be updated in a few minutes
echo.
echo Visit:
echo https://wlxklyh.github.io/ufbook/
echo.
echo Tips:
echo - First deployment may take 5-10 minutes
echo - Enable Pages in GitHub repository settings (gh-pages branch)
echo.
pause
