echo Compile sources
dcc32 -cc p1\a.dpr
dcc32 -cc p2\a.dpr
set path=%~dp0p1;%~dp0p2
echo %~dp0p1;%~dp0p2
echo Path with disk: %~dp0
echo Full path with filename: %~fp0
a.exe
set path=%~dp0p2;%~dp0p1
a.exe
