erase "%TEMP%\*.*" /f /s /q
for /D %%i in ("%TEMP%\*") do RD /S /Q "%%i"

erase "%TMP%\*.*" /f /s /q
for /D %%i in ("%TMP%\*") do RD /S /Q "%%i"

erase "%ALLUSERSPROFILE%\TEMP\*.*" /f /s /q
for /D %%i in ("%ALLUSERSPROFILE%\TEMP\*") do RD /S /Q "%%i"

erase "%SystemRoot%\TEMP\*.*" /f /s /q
for /D %%i in ("%SystemRoot%\TEMP\*") do RD /S /Q "%%i"

@echo Clear IE cache -  (Deletes Temporary Internet Files Only)
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
erase "%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*") do RD /S /Q "%%i"

@echo Clear Google Chrome cache
rem erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q
rem for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i"

@echo Clear Firefox cache
erase "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do RD /S /Q "%%i"

@echo Windows Update
wuauclt.exe /updatenow
wuauclt.exe /detectnow /updatenow
sleep 20
shutdown -r