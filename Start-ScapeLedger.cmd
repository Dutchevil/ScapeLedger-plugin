@echo off
setlocal DisableDelayedExpansion
title ScapeLedger - RuneLite development mode
cd /d "%~dp0"
if not exist "%~dp0lib\scapeledger-dev-launcher.jar" goto :incomplete
set "JAVA_CMD="
rem First try the user's RuneLite runtime, then JAVA_HOME and PATH. Never change RuneLite.exe.
if defined LOCALAPPDATA call :tryJava "%LOCALAPPDATA%\RuneLite\jre\bin\java.exe"
if defined LOCALAPPDATA call :tryJava "%LOCALAPPDATA%\RuneLite\runtime\bin\java.exe"
if defined ProgramFiles call :tryJava "%ProgramFiles%\RuneLite\jre\bin\java.exe"
if defined JAVA_HOME call :tryJava "%JAVA_HOME%\bin\java.exe"
for /f "delims=" %%J in ('where java.exe 2^>nul') do call :tryJava "%%J"
if not defined JAVA_CMD goto :noJava
"%JAVA_CMD%" -ea -cp "%~dp0lib\*" app.scapeledger.WindowsDevLauncher --check
if errorlevel 1 goto :failed
if /i "%~1"=="--check" exit /b 0
echo.
echo RuneLite starts directly in development mode. ScapeLedger loads automatically.
echo Your normal RuneLite installation is unchanged.
echo Keep this window open while using this RuneLite client.
echo.
"%JAVA_CMD%" -ea -cp "%~dp0lib\*" app.scapeledger.WindowsDevLauncher --developer-mode --debug
if errorlevel 1 goto :failed
exit /b 0

:tryJava
if defined JAVA_CMD exit /b 0
if not exist "%~1" exit /b 0
"%~1" -ea -cp "%~dp0lib\*" app.scapeledger.WindowsDevLauncher --check >nul 2>&1
if not errorlevel 1 set "JAVA_CMD=%~1"
exit /b 0

:noJava
echo No compatible 64-bit Java runtime found, or the package is incomplete.
echo Extract the ENTIRE ZIP, including the lib directory.
echo Need Java? Install Temurin 17 x64 and reopen this launcher:
echo winget install --id EclipseAdoptium.Temurin.17.JDK -e
echo Do not share credentials.properties, passwords or session tokens.
if /i "%~1"=="--check" exit /b 1
pause
exit /b 1

:incomplete
echo Extract the ENTIRE ZIP first. Keep the launcher beside the lib directory.
if /i "%~1"=="--check" exit /b 1
pause
exit /b 1

:failed
echo.
echo Launch failed. See the error above; do not share login or session secrets.
if /i "%~1"=="--check" exit /b 1
pause
exit /b 1

