'------------------------------------------------------------------------------ 
' magic_uninstall.vbs 
'------------------------------------------------------------------------------ 
' generic uninstaller script to uninstall applications based on the Add/Remove 
' Programs DisplayName and UninstallString properties 
'------------------------------------------------------------------------------ 
' Author: David M. Dolan 
' Created: 4/19/2005 
' Modified: 4/19/2005 
'------------------------------------------------------------------------------ 
' Use this script for whatever you want -- I'm stating that there is no warranty 
' and that I'm not responsible for any damage you do with it. 
'------------------------------------------------------------------------------ 
' designed for use with MSI's but it should work on any other program that 
' specifies and uninstall string -- but you have to miff out the /Options 
' (" " works) 
'------------------------------------------------------------------------------ 

'On error resume next 

'------------------------------------------------------------------------------ 
' constants 
'------------------------------------------------------------------------------ 
Const HKEY_LOCAL_MACHINE = &H80000002 
Const KeyPath = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

'modify this if you want to, I default mine for MSIs, and if you're silly enough 
' not to pass your own options and accidentally uninstall something, I want 
' the dialog to pop up telling you what you just foobarred 
const defaultOptions = "/qb+" 
'------------------------------------------------------------------------------ 

'------------------------------------------------------------------------------ 
' read the command line paramters, and bomb out if there is a problem 
'------------------------------------------------------------------------------ 
progToRemove = Wscript.Arguments.Named("Program") 

MSIOptions = Wscript.Arguments.Named("Options") 
if MSIOptions = "" then 
MSIOptions = defaultOptions 
end if 


'------------------------------------------------------------------------------ 
' Main Program 
'------------------------------------------------------------------------------ 
if progToRemove = "" then 
usage 
else 

SeekAndDestroy 

end if 
Wscript.Quit(0) 

'------------------------------------------------------------------------------ 
sub usage 
'------------------------------------------------------------------------------ 
Wscript.Echo "usage: magic_uninstall.vbs /Program:<DisplayNameString> /Options:<commandlineopts>" 
Wscript.Echo " ex: magic_uninstall.vbs /Program:""Orca"" /Options:""/qb-""" 
Wscript.Quit(1) 
end sub 
'------------------------------------------------------------------------------ 
sub SeekAndDestroy 
'------------------------------------------------------------------------------ 

set locator = CreateObject("WbemScripting.SWbemLocator") 
set oWMI = locator.ConnectServer(".","root/default") 


set objReg = oWMI.Get("StdRegProv") 

lRC = objReg.EnumKey (HKEY_LOCAL_MACHINE, KeyPath, arrSubKeys) 


'ok, so we're at the install key, loop through the sub keys... 
For each Subkey in arrSubKeys 

'look at the next key 
newKeyPath = KeyPath & "\" & SubKey 

'get all of the values and store them in two arrays -- value names in arrEntryNames 
'	-- value Types in to arrValueTypes 
objReg.EnumValues HKEY_LOCAL_MACHINE,_ 
newKeyPath,arrEntryNames,arrValueTypes 

'make sure we have an array, then grok it 
if isArray(arrEntryNames) then 

uninstallable = "f" 

'loop through the entry names and keep the ones we're looking for 
for i = 0 to Ubound(arrValueTypes) 
entryName = arrEntryNames(i) 

select case entryName 

case "DisplayName" 

'ok, display name, so what's the value? put it into sName 
objReg.GetStringValue HKEY_LOCAL_MACHINE, _ 
newKeyPath, entryName, sName 

case "DisplayVersion" 
'ok, displayVersion, so store it into sVers 

objReg.GetStringValue HKEY_LOCAL_MACHINE, _ 
newKeyPath, entryName, sVers 

case "UninstallString" 
objReg.GetStringValue HKEY_LOCAL_MACHINE, _ 
newKeyPath, entryName, sUninstall 
uninstallable = "t" 
end select 

Next '-- value 

if sName <> "" and uninstallable = "t" then 
  'ok so we know that we have a software name, and it's uninstallable, so 
  ' only now do we check to see if it's what we're looking for... 
  if sName = progToRemove then 
    'this is where the magic happens 
    set oCmd = CreateObject("Wscript.Shell") 
    uninstallCommand = Replace(sUninstall, "/I", "/x") & " " & MSIOptions 
    commandLine = "%comspec% /c " & uninstallCommand 
    'wscript.echo commandLine 
    oCmd.Run commandLine, 0, true 
    Wscript.Quit(0) ' haha we're done, quit digging in the registry now!   
  end if  
end if 

end if 

sName = "" 
sVers = "" 

Next '-- subKey 

end sub