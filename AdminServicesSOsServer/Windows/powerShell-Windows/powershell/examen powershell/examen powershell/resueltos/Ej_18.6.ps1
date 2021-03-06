# Ej_18.6.ps1
# 18.6. Desactivar las cuentas de los usuarios
# que pertenecen al grupo “Logística”
#

$grupo = "Logística"

$objGrupo = [ADSI]"WinNT://./$grupo,group"
$objGrupo.PSBase.Invoke('Members') | `
    foreach{
        $usuario = $_.GetType().InvokeMember('Name','GetProperty',$null,$_,$null)
        $objUser = [ADSI]"WinNT://./$usuario,user"
        $objUser.PSBase.InvokeSet('AccountDisabled',$True)
        $objUser.PSBase.CommitChanges()
    }

Remove-Variable objGrupo,usuario,objUser
