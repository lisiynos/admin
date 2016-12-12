SET DESKTOP=%USERPROFILE%\Рабочий стол
IF NOT EXIST "%DESKTOP%" (
  SET DESKTOP=%USERPROFILE%\Desktop
)


mkdir "%DESKTOP%\Olymp_2016"
copy "%~dp0Тестирующая система.url" "%DESKTOP%"
copy "%~dp0*.lnk" "%DESKTOP%"

echo Download... 
SET dist=C:\dist
SET src=%~dp0dist
echo Copy dist: "%src%" to "%dist%"
IF NOT EXIST %dist% (
  mkdir %dist%
)
xcopy "%src%\*.*" /D %dist%
robocopy  "%src%" "%dist%" /MIR

exit 

rem if exist "C:\Users\Все пользователи\Desktop" (
rem   echo Copy icons 
rem   xcopy "%src%\icons\*.*" /D "C:\Users\Все пользователи\Desktop"  
rem )

rem if exist "C:\Users\All Users\Desktop"  (
rem   echo Copy icons 2
rem   xcopy "%~dp0icons\*.*" /D "C:\Users\All Users\Desktop"
rem   echo "%~dp0internet_on.cmd"
rem   xcopy "%~dp0internet_on.cmd" /D "C:\Users\All Users\Desktop"
rem   xcopy "%~dp0do.cmd" /D "C:\Users\All Users\Desktop"
rem   copy "%~dp0internet_off.bat" "C:\Users\All Users\Desktop\internet_off_%CLASS%_%COMP%.bat"
rem )

echo PROCESSOR_ARCHITECTURE = %PROCESSOR_ARCHITECTURE%
if %PROCESSOR_ARCHITECTURE% == x86 ( goto :x86 ) 
if %PROCESSOR_ARCHITECTURE% == AMD64 ( goto :x64 )
stop
:x64
set PF=%ProgramFiles(x86)%
goto :download
:x86
set PF=%ProgramFiles%
goto :download
:download
echo PF = %PF%

echo === Far Manager ===
if not exist "%ProgramFiles%\Far Manager" (
  echo ## Install Far manager...
  msiexec /i %dist%\Far30b4510.x64.20160115.msi /passive /quiet 
) else (
  echo [ OK ]
)

echo === Python ===
if not exist C:\Python27 (
  echo ## Install Python27...
  @rem %dist%\python-2.7.11.msi /qn
)
set Python3Dir=C:\Python35
if not exist %Python3Dir% (
  echo ## Install Python 3.5...
  @rem %dist%\python-3.5.1.exe /quiet TargetDir=%Python3Dir% InstallAllUsers=1 Include_pip=1
)

set FreePascal=2.6.4
set FreePascalExe=fpc-%FreePascal%.i386-win32.exe
xcopy %FreePascalExe% /D %dist%
set fp_dist=%dist%\%FreePascalExe%
set fp=C:\FPC\%FreePascal%\bin\i386-win32\fp.exe
IF exist %fp% (
  echo Free Pascal %FreePascal%: %fp% - exist
) else (
  %dist%\%FreePascalExe% /silent /nocancel /suppressmsgboxes=no 
)

set Zip="%PF%\7-Zip"
echo 7-Zip path = %Zip%
IF exist %Zip% ( 
  echo %Zip% exist
) else ( 
  echo 7-Zip install 
  "%dist%\7z1514.exe" /Q
) 

set Git="%PF%\Git"
IF exist %Git% (
  echo Git: %Git% - exist
) else (
  echo Git path = %Git% 
  REM "%dist%\Git-1.8.5.2-preview20131230.exe" /silent
)
git config --global user.email "super.denis@gmail.com"
git config --global user.name "Denis Stepulenok"
git config --global push.default simple

set WingIDE="%PF%\Wing IDE 101 5.0\bin\wing-101.exe"
if exist %WingIDE% (
   echo Wing IDE: %WingIDE% - exist
) else (
   %dist%\wingide-101-5.0.2-1.exe /silent
)

rem echo Add user "olymp" with password "olymp"
rem net user olymp olymp /ADD
if not exist C:\work (
  echo Create directory "C:\work"
  mkdir C:\work
)
if exist C:\.dist (
  rem rmdir C:\.dist /q/s
)
rem rmdir C:\olymp /q/s
rem net use L: \\macpro2\admin

echo === Java ===
set JavaDist=%dist%\jdk-8u31-windows-i586.exe
echo echo "%PF%\Java"
if exist "%PF%\Java" (
  echo "%PF%\Java" exists
) else (
  echo %JavaDist% /s /quiet /passive
  %JavaDist% /s
)

:download
SET IdeaVersion=14.0.3

if not exist "%PF%\JetBrains\IntelliJ IDEA Community Edition %IdeaVersion%" (
  echo Install Idea %IdeaVersion%
  "%dist%ideaIC-%IdeaVersion%.exe" /S
)
