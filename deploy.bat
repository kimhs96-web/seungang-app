@echo off
title Deploy Script
echo.
echo ================================================
echo  Seungang Fault Analysis System - Deploy Script
echo ================================================
echo.
if not exist "Dockerfile" (
    echo [ERROR] Please run this file inside the backend folder.
    pause
    exit /b 1
)
echo [OK] Dockerfile found.
echo.
echo Enter your GitHub repository URL.
echo Example: https://github.com/kimhs96-web/seungang-app.git
echo.
set /p REPO_URL=Repository URL: 
if "%REPO_URL%"=="" ( echo [ERROR] URL required & pause & exit /b 1 )
echo.
if exist ".git" ( rd /s /q .git )
echo [1/6] git init...
git init
if errorlevel 1 ( echo [ERROR] & pause & exit /b 1 )
echo [2/6] git add...
git add .
if errorlevel 1 ( echo [ERROR] & pause & exit /b 1 )
echo [3/6] git commit...
git commit -m "deploy"
if errorlevel 1 ( echo [ERROR] & pause & exit /b 1 )
echo [4/6] git branch...
git branch -M main
if errorlevel 1 ( echo [ERROR] & pause & exit /b 1 )
echo [5/6] git remote...
git remote add origin %REPO_URL% 2>nul
if errorlevel 1 ( git remote set-url origin %REPO_URL% )
echo [6/6] git push...
echo.
echo [NOTE] Username=GitHub ID  Password=Personal Access Token
echo.
git push -u origin main --force
if errorlevel 1 ( echo [ERROR] push failed & pause & exit /b 1 )
echo.
echo ================================================
echo  [SUCCESS] Upload complete! Go to railway.app
echo ================================================
echo.
pause
