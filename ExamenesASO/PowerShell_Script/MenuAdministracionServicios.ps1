#@Title: Menu de Administracion de sistemas operativos
#
#@Description: Menu de administracion de servicios para PowerShell version 5.1
#@Author: Pauchino.

function m1{
    Clear-Host
    Write-Host " Lista de los servicios en ejecución "
    Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Status,Name,DisplayName # | Out-Host -paging
    $servicio = Read-Host "Seleccione el servicio a detener"
    Stop-Service -Name $servicio -Force -Confirm
}

function m2{
Clear-Host
$contador=0
while ( $contador -ne 10 )
 {
    Clear-Host
    Write-Host "-------------- $contador -----------"
    Get-Process | Where-Object {$_.VirtualMemorySize} | Select-Object VirtualMemorySize, ProcessName | Sort-Object VirtualMemorySize | Format-table VirtualMemorySize, ProcessName
    sleep -s 2
    $contador+=1
 }
}

function m3{
    Clear-Host
    Get-Process -Name s* | Sort-Object -Descending pm
}

function m4{
    Clear-Host
    Get-EventLog -LogName Application -EntryType Error -Newest 5
}

function m5{
    Clear-Host
    $ruta=Read-Host "Introduzca la ruta"
    Get-ChildItem -Path $ruta | Sort-Object -Descending Length
}

function m6{
    Clear-Host
    $puerto= Read-Host " Introduzca el nuevo puerto "
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name PortNumber -Value $puerto
    Write-Host "Puerto cambiado"
}

function m7{
    Clear-Host
    Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name PortNumber
}

function m8{
    Clear-Host 
    Get-Process -ErrorAction SilentlyContinue | Sort-Object -Descending -Property PriorityClass  | Format-Table Name,CPU,PriorityClass 
}

function m9{
    Clear-Host
    
    Write-Host "Programando tarea"
    $t=New-JobTrigger -Weekly -DaysOfWeek Friday -at 17:00
    Register-ScheduledJob -Name "Diagnostico de integridad" -ScriptBlock {sfc /scannow} -Trigger $t
    Write-Host "Programada"
}

function m10{
    Clear-Host
    Write-Host "Saliendo del programa"
    sleep -s 3
    exit
}


do{
Clear-Host
Write-Host "                          Menu del Operador                          "
Write-Host "====================================================================="
Write-Host "==                                                                 =="
Write-Host "==                                                                 =="
Write-Host "== 1) Parar servicio cuyo nombre se solicita al usuario            =="
Write-Host "== 2) Ver la memoria virtual ocupada 10 veces cada 2 segundos      =="
Write-Host "== 3) Mostrar procesos cuyo nombre comienza por s ordenados        =="
Write-Host "==    inversamente por memoria fisica utilizada                    =="
Write-Host "== 4) Sacar los 5 eventos de error del registro de aplicacion más  =="
Write-Host "==    recientes.                                                   =="
Write-Host "== 5) Mostrar todos los ficheros con su tamaño de la carpeta que   =="
Write-Host "==    se solicata al usuario ordenados inversamente por el tamaño. =="
Write-Host "== 6) Cambiar puerto TCP escritorio remoto a valor solicitado al   =="
Write-Host "==    usuario.                                                     =="
Write-Host "== 7) Mostrar valor puerto TCP escritorio remoto (por defecto es   =="
Write-Host "==    3389)                                                        =="
Write-Host "== 8) Listar procesos con su nombre,cpu y prioridad ordenado       =="
Write-Host "==    descendentemente por ésta última                             =="
Write-Host "== 9) Programar que los viernes a las 17:00 se realice un          =="
Write-Host "==    diagnostico de integridad de filesystem (comando sfc)        =="
Write-Host "== S) Salir                                                        =="
Write-Host "==                                                                 =="
Write-Host "==                                                                 =="
Write-Host "====================================================================="
$opcion=Read-Host "Elige una opción "

Switch ($opcion){
    1 {m1}
    2 {m2}
    3 {m3}
    4 {m4}
    5 {m5}
    6 {m6}
    7 {m7}
    8 {m8}
    9 {m9}
    S {m10}
    s {m10}
    default { Write-Host "Error en el valor de la entrada, por favor vuelva a intentarlo de nuevo ..." }

   }
   pause
}

until ($opcion -eq "S")