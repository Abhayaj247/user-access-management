@echo off
echo Initializing User Access Management System database...

set PGPASSWORD=Abhayaj@621

REM Create database if it doesn't exist
echo Creating database...
psql -U postgres -c "CREATE DATABASE uams;" 2>nul
if errorlevel 1 echo Database already exists. Continuing...

REM Run initialization script
echo Running database initialization script...
psql -U postgres -d uams -f src/main/resources/db/init.sql

echo Database initialization complete.
echo Default admin credentials: username=admin, password=admin123