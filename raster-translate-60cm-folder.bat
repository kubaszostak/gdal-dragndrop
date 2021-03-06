@echo off
echo *** %~n0 ...
echo *** %1
echo.
call %~dp0\_init.bat %1 %2 %3

SET OutDir=translate-60cm
SET TiffOpts=%TiffOpts% -tr 0.6 0.6 -r average

if not exist %OutDir% mkdir %OutDir%

for %%v in (*%SrcExt%) do (
   echo %%v
   gdal_translate %TiffOpts% -a_nodata 255 -a_srs EPSG:2180 %%v %OutDir%\%%v
   echo.
) 


echo.
echo %~n0 finished.
timeout 30
