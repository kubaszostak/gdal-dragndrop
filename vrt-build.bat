@echo off
echo *** %~n0 ...
echo *** %1
echo.
call %~dp0\_init.bat %1 %2 %3

gdalbuildvrt %2 _merge.vrt *%SrcExt%

echo.
echo %~n0 finished.
timeout 30