sfc /scannow
pause
chkdsk C: /f /r 
pause 
cd %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Cookies
pause
START RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
pause
START RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
pause
