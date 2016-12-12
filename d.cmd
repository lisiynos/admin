@rem Download using BitsAdmin Windows utility
@echo Download "%1" %2 - %3
@IF EXIST %3 (
  @echo %3 - exists
) ELSE (
  bitsadmin /Util /SetIEProxy localsystem AUTOSCRIPT
  bitsadmin /transfer %1 /DOWNLOAD %2 %3
)
@rem cscript download.vbs %2 %3
@rem curl -L -O http://downloads.sourceforge.net/project/freepascal/Win32/2.6.4/fpc-2.6.4.i386-win32.exe