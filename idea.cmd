echo off

SET dist=%~dp0

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

SET IdeaVersion=14.0.3

if not exist "%PF%\JetBrains\IntelliJ IDEA Community Edition %IdeaVersion%" (
  echo Install Idea %IdeaVersion%
  "%dist%ideaIC-%IdeaVersion%.exe" /S
)