@echo Internet Explorer: delete ALL History
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255 
@echo RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1 (Deletes History Only)
@echo RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 (Deletes Cookies Only)
@echo RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 (Deletes Temporary Internet Files Only)
@echo RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16 (Deletes Form Data Only)
@echo RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32 (Deletes Password History Only)