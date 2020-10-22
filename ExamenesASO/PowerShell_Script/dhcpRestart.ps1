cls
$habilita={Get-NetAdapter | Where-Object -FilterScript {($_.ifIndex -in 10) -and  ($_.Status -eq 'Up')} |  Set-NetIPInterface -Dhcp Enabled -PassThru}
Write-Host "$habilita - Hace algo raro que no se"

# Mi version como lo veo

# Veo 'index' las interfaces que tengo instaladas
Get-NetIPConfiguration | Select InterfaceIndex | ft -HideTableHeaders
$index=Read-Host "Seleccione una interfaz" 

# Asignación de IP con DHCP
Set-NetIPInterface -InterfaceIndex $index -Dhcp Enabled

# Tome los DNS automaticos para conectividad
Set-DnsClientServerAddress -InterfaceIndex $index -ResetServerAddresses

# Reiniciamos la interfaz de red
Restart-NetAdapter -Name "Ethernet 3"