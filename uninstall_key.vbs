On error resume Next

Dim strName, WshShell, oReg, keyname

Const HKEY_LOCAL_MACHINE = &H80000002
strComputer = "."

'==================================
'Change the value here with DisplayName's value
strName = "InstallShield 2009"
'==================================
Set WshShell = CreateObject("WScript.Shell")
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
strKeyPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
oReg.EnumKey HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys
For Each subkey In arrSubKeys
  keyname = ""
  keyname = wshshell.RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\" & subkey & "\DisplayName")
  Wscript.Echo  keyname
  If keyname = strName then
    i = subkey
  End If
Next

If i Then
  MsgBox "MSIEXEC.EXE /X " & i & " /QB!"
 'WshShell.Run "MSIEXEC.EXE /X " & i & " /QB!", 1, True
End If

Set WshShell = Nothing
set ObjReg = Nothing

WScript.Quit