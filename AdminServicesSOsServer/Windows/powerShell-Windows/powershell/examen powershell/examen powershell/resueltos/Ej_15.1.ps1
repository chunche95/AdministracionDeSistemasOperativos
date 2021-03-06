# Ej_15.1.ps1
# Realizar un informe completo de los adaptadores de red y
#    crear con él un fichero de texto

Set-Location "F:\Documents\Cursos\2011-06 - Administrador de redes\Administrador de redes - Mód. 3 PowerShell\Ejemplos"

"INFORME DE LOS ADAPTADORES DE RED" >Ej_15.1.txt
"=================================" >>Ej_15.1.txt
"" >>Ej_15.1.txt
Get-Date >>Ej_15.1.txt
"" >>Ej_15.1.txt

$strComputer = "."

$colItems = get-wmiobject -class "Win32_NetworkAdapter" -namespace "root\CIMV2" `
-computername $strComputer

foreach ($objItem in $colItems) {
 "-"*50 >>Ej_15.1.txt
 "Tipo de adaptador: " + $objItem.AdapterType >>Ej_15.1.txt
 "Id. de tipo de adaptador: " + $objItem.AdapterTypeId >>Ej_15.1.txt
 "Detección automática: " + $objItem.AutoSense >>Ej_15.1.txt
 "Disponibilidad: " + $objItem.Availability >>Ej_15.1.txt
 "Etiqueta: " + $objItem.Caption >>Ej_15.1.txt
 "Código de error del administrador de configuración: " + $objItem.ConfigManagerErrorCode >>Ej_15.1.txt
 "Administrador de configuración de Configuración de usuario: " + $objItem.ConfigManagerUserConfig >>Ej_15.1.txt
 "Creación de nombre de clase: " + $objItem.CreationClassName >>Ej_15.1.txt
 "Descripción: " + $objItem.Description >>Ej_15.1.txt
 "Id. dispositivo: " + $objItem.DeviceID >>Ej_15.1.txt
 "Error borrado: " + $objItem.ErrorCleared >>Ej_15.1.txt
 "Descripción de error: " + $objItem.ErrorDescription >>Ej_15.1.txt
 "Índice: " + $objItem.Index >>Ej_15.1.txt
 "Fecha de instalación: " + $objItem.InstallDate >>Ej_15.1.txt
 "Instalado: " + $objItem.Installed >>Ej_15.1.txt
 "Último código de error: " + $objItem.LastErrorCode >>Ej_15.1.txt
 "Dirección MAC: " + $objItem.MACAddress >>Ej_15.1.txt
 "Fabricante: " + $objItem.Manufacturer >>Ej_15.1.txt
 "Número máximo controlado: " + $objItem.MaxNumberControlled >>Ej_15.1.txt
 "Velocidad máxima: " + $objItem.MaxSpeed >>Ej_15.1.txt
 "Nombre: " + $objItem.Name >>Ej_15.1.txt
 "Id. Conexión de red: " + $objItem.NetConnectionID >>Ej_15.1.txt
 "Estado de la conexión de red: " + $objItem.NetConnectionStatus >>Ej_15.1.txt
 "Dirección de red: " + $objItem.NetworkAddresses >>Ej_15.1.txt
 "Dirección permanente: " + $objItem.PermanentAddress >>Ej_15.1.txt
 "Id. Dispositivo PNP: " + $objItem.PNPDeviceID >>Ej_15.1.txt
 "Capacidad de administración de energía: " + $objItem.PowerManagementCapabilities >>Ej_15.1.txt
 "Administración de energía soportada: " + $objItem.PowerManagementSupported >>Ej_15.1.txt
 "Nombre de producto: " + $objItem.ProductName >>Ej_15.1.txt
 "Nombre de servicio: " + $objItem.ServiceName >>Ej_15.1.txt
 "Velocidad: " + $objItem.Speed >>Ej_15.1.txt
 "Estado: " + $objItem.Status >>Ej_15.1.txt
 "Información de estado: " + $objItem.StatusInfo >>Ej_15.1.txt
 "Creación del sistema de nombre de clase: " + $objItem.SystemCreationClassName >>Ej_15.1.txt
 "Nombre de sistema: " + $objItem.SystemName >>Ej_15.1.txt
 "Hora de último reinicio: " + $objItem.TimeOfLastReset >>Ej_15.1.txt
}

