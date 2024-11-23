@echo off
echo Initializing UAMS database...

REM Set PostgreSQL connection details
set PGHOST=localhost
set PGPORT=5432
set PGUSER=postgres
set PGPASSWORD=Abhayaj@621
set DBNAME=uams

REM Create database if it doesn't exist
echo Creating database if it doesn't exist...
psql -c "SELECT 1 FROM pg_database WHERE datname = '%DBNAME%'" | findstr /C:"1 row" > nul
if errorlevel 1 (
    psql -c "CREATE DATABASE %DBNAME%"
)

REM Run initialization script
echo Running initialization script...
psql -d %DBNAME% -f src/main/resources/db/init.sql

echo Database initialization complete.
pause
