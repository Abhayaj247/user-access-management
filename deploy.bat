@echo off
echo Building and deploying User Access Management System...

REM Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrative privileges.
    echo Please run as administrator.
    pause
    exit /b 1
)

REM Set environment variables
set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 10.1"
echo Using Tomcat at: %CATALINA_HOME%

REM Build the project using Maven
echo Building project with Maven...
call mvn clean package

if errorlevel 1 (
    echo Maven build failed.
    pause
    exit /b 1
)

REM Stop Tomcat if it's running
echo Stopping Tomcat...
sc query "Tomcat10.1" >nul 2>&1
if %errorLevel% equ 0 (
    net stop "Tomcat10.1"
    timeout /t 5
) else (
    echo Tomcat service not found. Trying to stop using shutdown script...
    call "%CATALINA_HOME%\bin\shutdown.bat"
    timeout /t 5
)

REM Delete old deployment if exists
if exist "%CATALINA_HOME%\webapps\uams.war" (
    echo Removing old WAR file...
    del /F "%CATALINA_HOME%\webapps\uams.war"
)
if exist "%CATALINA_HOME%\webapps\uams" (
    echo Removing old deployment directory...
    rmdir /s /q "%CATALINA_HOME%\webapps\uams"
)

REM Copy new WAR file
echo Deploying new version...
copy "target\uams.war" "%CATALINA_HOME%\webapps\uams.war"
if errorlevel 1 (
    echo Failed to copy WAR file.
    pause
    exit /b 1
)

REM Start Tomcat
echo Starting Tomcat...
sc query "Tomcat10.1" >nul 2>&1
if %errorLevel% equ 0 (
    net start "Tomcat10.1"
) else (
    echo Tomcat service not found. Trying to start using startup script...
    call "%CATALINA_HOME%\bin\startup.bat"
)

echo.
echo Deployment complete!
echo Application will be available at http://localhost:8080/uams/
echo Default admin credentials: username=admin, password=admin123
echo.
echo Press any key to exit...
pause
