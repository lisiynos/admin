#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <Constants.au3>
#include <Date.au3> ; _Now()
#include <File.au3>

Dim $TimeStamp = False

Func X($s, $FileName = -1)
  ConsoleWrite($s & @CRLF)
  Local $sDrive = "", $sDir = "", $sFilename = "", $sExtension = ""
  Local $aPathSplit = _PathSplit(@ScriptFullPath, $sDrive, $sDir, $sFilename, $sExtension)
  If $FileName == -1 Then $FileName = @ScriptDir & "\\" & $sFilename & ".log"
  $hFile = FileOpen($FileName, 1)
  If $hFile <> -1 Then
    If $TimeStamp = True Then $s = _Now() & ' - ' & $s
	FileWriteLine($hFile, $s)
	FileClose($hFile)
  EndIf
EndFunc

Func getStd(Const $cmd)
    Local       $s = ""
    Local       $all = ""
    Local Const $pid = Run(@ComSpec & ' /c ' & $cmd, "", @SW_HIDE, $STDERR_MERGED)
    While 1 = 1
        $s = StdoutRead($pid, False, False)
		; ProcessWaitClose($pid)
        If @error Then
            ExitLoop
        Else
            $all &= $s
            ; ConsoleWrite($s)
            Sleep(10)
        EndIf
    WEnd
    Return $all & @CRLF & @CRLF
EndFunc

; ConsoleWrite(getStd("ipconfig /all"))

Local $JRE = "D:\\JRE"
Local $JAVA_EXE = $JRE & "\\bin\\java.exe"

X(getStd($JAVA_EXE & " -version") & @CRLF)

; getSTD("ping localhost -n 10")
; MsgBox($MB_SYSTEMMODAL, "Заголовок", "Текст :)")