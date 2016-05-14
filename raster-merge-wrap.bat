@echo off
echo *** %~n0 ...
echo *** %1
echo.
call %~dp0\_init.bat %1 %2 %3

:: Use it float rasters, eg. DTM's

:: SET PixelSize=-tr 0.6 0.6
:: -srcnodata 0.0 -dstnodata -9999.0

gdalwarp  -multi -wm %GDAL_CACHEMAX% -ovr NONE -r average %TiffOpts%  %PixelSize% *%SrcExt% _merge.tif

%~dp0\raster-pyramid.bat _merge.tif
%~dp0\raster-calc-stats.bat _merge.tif

echo.
echo %~n0 finished.
timeout 30