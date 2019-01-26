@echo off
ECHO.
ECHO.
ECHO.
set /p month=Enter MONTH: 
ECHO.
set /p date=Enter DATE: 
ECHO.
set /p year=Enter YEAR: 

set /a sec=min*60
echo.
date %month%/%date%/%year%
echo.
ECHO new Date (%month%/%date%/%year%) has been set.
echo.
PAUSE.