@echo off
echo *** %~n0 ...
echo *** %SrcDir% 
echo.
call %~dp0\_init.bat %1 %2 %3


SET MergeName=FotoMapa-2019
::SET MergeParams=-vrtnodata 0 

echo VRT...
gdalbuildvrt %MergeParams% %MergeName%.vrt *%SrcExt%

:: -te xmin ymin xmax ymax
SET ExtWybrz=-te 345000 745000 465000 777000
SET ExtZatoka=-te 455000 743000 500000 777000
SET ExtTrm=-te 455000 710000 503000 750000
SET ExtZw=-te 490000 695000 555000 735000

echo.
echo Merge Wybrzeze...
gdalwarp -wm 1024 -multi %ExtWybrz%  %TiffOpts% %MergeName%.vrt ..\%MergeName%-wybrz%SrcExt%

echo.
echo Merge Zatoka...
gdalwarp -wm 1024 -multi %ExtZatoka% %TiffOpts% %MergeName%.vrt ..\%MergeName%-zatoka%SrcExt%

echo.
echo Merge Trojmiasto...
gdalwarp -wm 1024 -multi %ExtTrm%    %TiffOpts% %MergeName%.vrt ..\%MergeName%-trm%SrcExt%

echo.
echo Merge Zalew wislany...
gdalwarp -wm 1024 -multi %ExtZw%     %TiffOpts% %MergeName%.vrt ..\%MergeName%-zw%SrcExt%

echo.
echo.

call %~dp0\raster-pyramid.bat ..\%MergeName%-wybrz%SrcExt%
call %~dp0\raster-pyramid.bat ..\%MergeName%-zatoka%SrcExt%
call %~dp0\raster-pyramid.bat ..\%MergeName%-trm%SrcExt%
call %~dp0\raster-pyramid.bat ..\%MergeName%-zw%SrcExt%

echo.
echo %~n0 finished.
timeout 30