rem @echo off
mkdir %~dp0dist

set Py2=2.7.10
set Py2URL="http://www.python.org/ftp/python/%Py2%/python-%Py2%.msi"
set Py2Local="%~dp0dist\python-%Py2%.msi"
echo Python2Local = %Python2Local%
call d.cmd Python2 %Py2URL% %Py2Local%

set Py3=3.5.0
set Py3URL="http://www.python.org/ftp/python/%Py3%/python-%Py3%.exe"
set Py3Local="%~dp0dist\python-%Py3%.exe"
call d.cmd Python3 %Py3URL% %Py3Local%

set FPC=2.6.4
set FPC_EXE=fpc-%FPC%.i386-win32.exe
set FPC_URL=http://downloads.sourceforge.net/project/freepascal/Win32/%FPC%/%FPC_EXE%
call d.cmd FreePascal %FPC_URL% "%~dp0dist\%FPC_EXE%"