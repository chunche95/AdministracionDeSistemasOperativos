@echo off
echo "Eliminar el historial de Internet Explorer?"
pause
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 1
@echo off 
echo "Eliminar el historial de Firefox"
pause 
@echo off
DEL /P /S "C:\Users\%username%\AppData\Roaming\Mozilla\Firefox\Profiles\places.sqlite*"
echo "Eliminar el historial de Firefox"
pause 
@echo off
del /P /S "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\History*"
