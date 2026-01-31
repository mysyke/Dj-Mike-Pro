@echo off
setlocal
REM Double-click to build installer (developer machine)
REM Edit PROJECT_ROOT to your local path where CMakeLists.txt is.
set PROJECT_ROOT=%~dp0..\..
set CONFIG=Release
set VERSION=0.1.0

powershell -ExecutionPolicy Bypass -File "%~dp0build_and_package.ps1" -ProjectRoot "%PROJECT_ROOT%" -Config %CONFIG% -Version %VERSION%
pause
