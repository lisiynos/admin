@rem %ProgramFiles%\Java
SET BASE=C:\Java
SET JDK=%BASE%\JDK
SET JRE=%BASE%\JRE
if not exist %JDK% ( jdk-8u65-windows-i586.exe /s INSTALLDIR=%JDK% /INSTALLDIRPUBJRE=%JRE% )