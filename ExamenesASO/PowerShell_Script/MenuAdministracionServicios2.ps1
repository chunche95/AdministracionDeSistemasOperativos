#@Title: Menu de administracion de autorun
#
#@Description: Script Menu de administracion de servicios en Windows Server 2016 con PowerShell 5.1
#
#@Author: Pauchino


function m1{
    Clear-Host
    Write-Host "Procesos en ejecución"
    Start-Sleep -s 1
    Get-Process | Format-Table ProcessName, Id, CPU, WS
    $proceso= Read-Host "Selecione el proceso a matar"
    Stop-Service -Name $proceso
    Write-Host "OKEY"
}

function m2{
    Clear-Host
    $contador=0
    Write-Host " Procesador total (Tiempo)"
    while ( $contador -ne 3)
    {
        Get-Counter -Counter "\Procesador(_Total)\% de tiempo de procesador"
        $contador+=1
        sleep -s 2
    }
}

function m3{
    Clear-Host
    New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer -Name NoDriveTypeAutoRun -Value 0xff
    Write-Host "Terminado"
}

function m4{
    Clear-Host
    Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer -Name NoDriveTypeAutoRun 
}

function m5{
    Clear-Host
    Write-Host "Buscando ficheros en directorio"
    $dir= Read-Host "Introduzca un directorio"
    $tam= Read-Host "¿Tamaño mínimo en KB?"
    Get-ChildItem -Path $dir -Recurse | Where-Object {$_.Length/1KB -gt $tam}
}

function m6{
    Clear-Host
    Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol
}

function m7{
    Clear-Host
    Write-Host "Comprobando"
    Get-SmbServerConfiguration | Select-Object EnableSMB1Protocol
}

function m8{
    Clear-Host
    Get-Process | Where-Object {$_.VirtualMemorySize -gt 30000} | Select-Object VirtualMemorySize, ProcessName | Sort-Object VirtualMemorySize -Descending | Out-Host -Paging
}

function m9{
    Clear-Host
    $accion=New-ScheduledTaskAction -Execute "Write-VolumeCache C"
    $trigger=New-ScheduledTaskTrigger -Daily -at 7pm
    Register-ScheduledTask -Action $accion -Trigger $trigger -TaskName "Flush Cache" -Description "Sincroniza la cache de la unidad C:\ diariamente a las 7pm"
}

function m10{
    Clear-Host
    Write-Host "Saliendo del programa"
    sleep -s 2
    exit
}


do{
Clear-Host
Write-Host "                          Menu del Operador                             " -foregroundcolor yellow
Write-Host "========================================================================"
Write-Host "==                                                                    =="
Write-Host "==                                                                    =="
Write-Host "== 1) Matar todos los procesos cuyo nombre se solicita al usuario     =="
Write-Host "== 2) Ver % de tiempo de procesador 3 veces cada 2 segundos.          =="
Write-Host "== 3) Desactivar Autorun                                              =="
Write-Host "== 4) Comprobar Autorun                                               =="
Write-Host "== 5) Buscar ficheros grandes en un directorio                        =="
Write-Host "== 6) Deshabilitar SMBV1 (Para prevenir WannaCry)                     =="
Write-Host "== 7) Comprobar si SMBV1 está habilitado                              =="
Write-Host "== 8) Listar procesos que consuman más de 30MB de memoria virtual     =="
Write-Host "==    ordenados descendentemente por ésta                             =="
Write-Host "== 9) Programar que diariamente se guarde (flush) la caché de la      =="
Write-Host "==    unidad c: a las 19:00                                           =="
Write-Host "== S) Salir                                                           =="
Write-Host "==                                                                    =="
Write-Host "==                                                                    =="
Write-Host "========================================================================"
$op=Read-Host "Seleccione una opcion de la pantalla"
Switch($op){

    1{m1}
    2{m2}
    3{m3}
    4{m4}
    5{m5}
    6{m6}
    7{m7}
    8{m8}
    9{m9}
    S{m10}
    s{m10}
    default{
        Write-Host "Por favor, seleccione una opción válida"
    }
}
    pause
}
until($op -eq "s")