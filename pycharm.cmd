SET DIST=%~dp0dist
SET PyCharmDist=%DIST%\pycharm-community-2016.3.exe

IF NOT EXIST "%PyCharmDist%" (
  echo PyCharm Community Edition download to %DIST%
  explorer "https://www.jetbrains.com/pycharm/download/#section=windows"
) else (
  REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JetBrains\PyCharm Community Edition" 
  @rem /v ValueName
)