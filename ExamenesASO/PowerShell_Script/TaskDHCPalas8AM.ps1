# Realizar un script Powershell que programe una
# tarea en la que todos los lunes a las 8 en punto
# de la mañana se configure el adaptador de red para
# que configure la IP automáticamente (dhcp a on).
cls
Unregister-ScheduledTask -TaskName TaskDHCP -Confirm:$false -ErrorAction Ignore
$action = New-ScheduledTaskAction -Execute "C:\Users\Administrador.WIN-V0LV1BK8OEB\Desktop\dhcpRestart.ps1"
$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 1 -DaysOfWeek Monday -At 8am
Register-ScheduledTask TaskDHCP -Action $action -Trigger $trigger


