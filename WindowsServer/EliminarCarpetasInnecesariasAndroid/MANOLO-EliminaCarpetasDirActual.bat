@echo off
:: Busqueda de las carpetas.

FORFILES /P %HOMEPATH% /S /M .idea
FORFILES /P %HOMEPATH% /S /M .gradle
FORFILES /P %HOMEPATH% /S /M build

CLS 

COLOR DC
    echo Borrando del sistema .idea  ... Un momento por favor.
    ::del .idea
    RMDIR /S /Q .idea
    echo .idea eliminado del sistema.
COLOR 90
    echo .
    RMDIR /S /Q .gradle
    echo .gradle eliminado del sistema.
COLOR 8B
    echo .
    RMDIR /S /Q build
    echo /build eliminado del sistema.
COLOR 07
    echo.
    ::RMDIR /s /Q  %HOMEPATH%\app\build
    RMDIR /S /Q app\build
    echo directorio /app/build eliminado del sistema <TAB>.
    echo .
pause
cls
    echo Fin del trabajo, se ha terminado la eliminación de las siguientes carpetas:
	echo - .idea
	echo - .gradle
	echo - build
	echo - /app/build
pause
exit