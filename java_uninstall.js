/*********************************************************************
 * Uninstall all JRE/JDK on this system
 * @author Rakesh Menon
 *********************************************************************/

WshShell = WScript.CreateObject("WScript.Shell")

var objArgs = WScript.Arguments;
WScript.Echo("Command line arguments: " + WScript.Arguments.Count())
for(i = 0; i < objArgs.Count(); i++){
  WScript.Echo(objArgs[i]);
};

var log = "";

/**
 * Uninstall product with specified guid and registry key
 */
function uninstallAUUpdater() {
  WScript.Echo("uninstallAUUpdater");
  try {
    var AUGUID="{4A03706F-666A-4037-7777-5F2748764D10}";		
    var uninstallCmd = "MsiExec.exe REBOOT=Suppress /x" + AUGUID + " /qn";
    WScript.Echo(uninstallCmd);
    WshShell.Run(uninstallCmd, 1, true);
  } catch(exception) {        
    return false;
  }
  return true;
 }

uninstallAUUpdater();

JAVA_GUIDS = new Array(
    "35A3A4F4-B792-11D6-A78A-00B0D0",  /* 1.4.2 JDK  */
    "32A3A4F4-B792-11D6-A78A-00B0D0",  /* 32-bit JDK */
    "64A3A4F4-B792-11D6-A78A-00B0D0",  /* 64-bit JDK */
    "7148F0A8-6813-11D6-A77B-00B0D0",  /* 1.4.2 JRE  */
    "3248F0A8-6813-11D6-A77B-00B0D0",  /* 32-bit JRE */
    "6448F0A8-6813-11D6-A77B-00B0D0",  /* 64-bit JRE */
    "26A24AE4-039D-4CA4-87B4-2F84A32", /* Consumer JRE */
    "26A24AE4-039D-4CA4-87B4-2F832",   /* 6uN */
    "26A24AE4-039D-4CA4-87B4-2F864"    /* 6uN - 64 bit JRE*/
)

JAVA_VERSION = new Array("142", "150", "160", "170", "180");
MAX_BUILD=99

function uninstallImpl(regKey, guid, name) {
  try {
    var uninstallStr = WshShell.RegRead(regKey);

    var uninstallCmd = "MsiExec.exe REBOOT=Suppress /x" + guid + " /qn /L " + guid + "_uninstall.log";
    WScript.Echo("Java " + name + ": " + uninstallCmd);
    WshShell.Run(uninstallCmd, 1, true);
  } catch(exception) {		
    return false;
  }
  return true;
}

/**
 * Uninstall product with specified guid
 */
function uninstall(guid, name) {    
  var regKey = "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\" + guid + "\\UninstallString";
  uninstallImpl(regKey, guid, name);
    
  var regWOWKey = "HKLM\\SOFTWARE\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\" + guid + "\\UninstallString";
  uninstallImpl(regWOWKey, guid, name);
}

/**
 * Uninstall all JDK and JRE - {<JAVA_GUID><JAVA_VERSION><UR_VERSION>0}
 */
for (i = 0; i < JAVA_GUIDS.length; i++) {
  for (j = 0; j < JAVA_VERSION.length; j++) {
    for (k = 0; k < 10; k++) {
      var name = JAVA_VERSION[j] + " u" + k;
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "0" + k + "0}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "0" + k + "}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "0" + k + "FF}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "0" + k + "F0}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "0" + k + "FB}", name);
    }
    for (k = 10; k < MAX_BUILD; k++) {
      var name = JAVA_VERSION[j] + " u" + k;
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + k + "0}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + k + "}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + k + "FF}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + k + "F0}", name);
      uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + k + "FB}", name);
    }
    uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "FF}", JAVA_VERSION[j]);
    uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "F0}", JAVA_VERSION[j]);
    uninstall("{" + JAVA_GUIDS[i] + JAVA_VERSION[j] + "FB}", JAVA_VERSION[j]);
  }
}
