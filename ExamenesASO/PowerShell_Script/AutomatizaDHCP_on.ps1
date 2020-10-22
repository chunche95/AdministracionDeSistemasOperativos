$tiempo=(New-JobTrigger -DaysOfWeek "Monday" -At 8:00)
$tarea=(Add-JobTrigger -Name DHCP_Inicio -Trigger $tiempo)
$comando=Get-NetAdapter | Where-Object -FilterScript {($_.ifIndex -in 1) -and ($_.Status -eq 'Up')} | Set-NetIPInterface -Dhcp Enabled -PassThru
Write-Host "Resultado del comando es:" $comando
Register-ScheduledJob -Name "Inicio_ip_automática" -ScriptBlock {$comando} -Trigger $tarea
# Set-NetIPInterface -InterfaceIndex 1