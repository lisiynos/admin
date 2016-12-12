' Set your settings
strFileURL = "http://www.python.org/ftp/python/2.7.6/python-2.7.6.msi"
strHDLocation = "dist\python-2.7.6.msi"

If WScript.Arguments.Count = 2 Then
  strFileURL = WScript.Arguments.Item(0)
  strHDLocation = WScript.Arguments.Item(1)
End if 
Wscript.Echo  strFileURL,"->",strHDLocation

Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(strHDLocation) Then 
  Wscript.Echo  strHDLocation,"- exists :)"
  WScript.Quit
End if

' Fetch the file
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
' Msxml2.XMLHttp.6.0
' CreateObject("MSXML2.XMLHTTP")

objXMLHTTP.open "GET", strFileURL, false
objXMLHTTP.send()

If objXMLHTTP.Status = 200 Then
  Set objADOStream = CreateObject("ADODB.Stream")
  objADOStream.Open
  objADOStream.Type = 1 'adTypeBinary

  objADOStream.Write objXMLHTTP.ResponseBody
  objADOStream.Position = 0    'Set the stream position to the start

  If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation
  Set objFSO = Nothing

  objADOStream.SaveToFile strHDLocation
  objADOStream.Close
  Set objADOStream = Nothing
End if

Set objXMLHTTP = Nothing