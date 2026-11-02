@echo off
setlocal DisableDelayedExpansion
title ScapeLedger - RuneLite ontwikkelmodus
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
echo RuneLite start rechtstreeks in ontwikkelmodus. ScapeLedger wordt automatisch geladen.
echo De normale RuneLite-installatie wordt niet gewijzigd.
echo Sluit dit venster niet zolang je deze RuneLite-client gebruikt.
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
echo Geen bruikbare 64-bit Java-runtime gevonden, of het pakket is onvolledig.
echo Pak de HELE ZIP uit, inclusief de map lib.
echo Is Java nodig? Installeer Temurin 17 x64 en open deze starter opnieuw:
echo winget install --id EclipseAdoptium.Temurin.17.JDK -e
echo Deel geen credentials.properties, wachtwoorden of sessietokens.
if /i "%~1"=="--check" exit /b 1
pause
exit /b 1

:incomplete
echo Pak eerst de HELE ZIP uit. De starter moet naast de map lib staan.
if /i "%~1"=="--check" exit /b 1
pause
exit /b 1

:failed
echo.
echo Start mislukt. De foutmelding staat hierboven; deel geen login-/sessiegeheimen.
if /i "%~1"=="--check" exit /b 1
pause
exit /b 1

