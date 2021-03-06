# Ej_18.7.ps1
# 18.7. Eliminar las cuentas de los usuarios del grupo “Servicios”
#

$grupo = "Servicios"
$users = New-Object System.Collections.ArrayList

$objGrupo = [ADSI]"WinNT://./$grupo,group"
$objGrupo.PSBase.Invoke('Members') | `
    foreach{
        $users.add($_.GetType().InvokeMember('Name','GetProperty',$null,$_,$null)) >$null
    }

$conexion = [ADSI]"WinNT://."

ForEach($usuario in $users){
    "Eliminando al usuario "+$usuario
    $conexion.Delete('user',$usuario)
}

Remove-Variable grupo,objGrupo,usuario,conexion
$users.Clear()
