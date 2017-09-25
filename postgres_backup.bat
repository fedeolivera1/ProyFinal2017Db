@echo off
color 30

chcp 28591 > NUL

setlocal

set FECHA_ACTUAL=%DATE%
set HORA_ACTUAL=%TIME%

set ANO=%FECHA_ACTUAL:~6,4%
set MES=%FECHA_ACTUAL:~3,2%
set DIA=%FECHA_ACTUAL:~0,2%

set HORA=%HORA_ACTUAL:~0,2%
set MINUTOS=%HORA_ACTUAL:~3,2%
set SEGUNDOS=%HORA_ACTUAL:~6,2%

rem Si la hora tiene un sólo dígito, reemplazamos el espacio inicial por cero
set HORA=%HORA: =%
if %HORA% LSS 10 set HORA=0%HORA%

rem echo Fecha: %FECHA_ACTUAL%
rem echo Hora: %HORA_ACTUAL%

echo.
rem echo Día: %DIA%
rem echo Mes: %MES%
rem echo Año: %ANO%
echo.
rem echo Hora: %HORA%
rem echo Minutos: %MINUTOS%
rem echo Segundos: %SEGUNDOS%
echo.

set ARCHIVO=C:\Proyecto\db_backup\GestPedDsk_%ANO%%MES%%DIA%%HORA%%MINUTOS%%SEGUNDOS%.backup
pg_dump.exe --host localhost --port 5432 --username postgres --format custom --blobs --verbose --file "%ARCHIVO%" "dbDsk"

endlocal
echo.