# Ej_18.8.ps1
# 18.8. Desasignar los usuarios del grupo “Ingeniería” y luego
# renombrar el grupo por “Ingeniería e Imasdé”
#

$grupo = "Ingeniería"

$objGrupo = [ADSI]"WinNT://./$grupo,group"
$objGrupo.PSBase.Invoke('Members') | `
    foreach{
        $usuario = $_.GetType().InvokeMember('Name','GetProperty',$null,$_,$null)
        $objGrupo.Remove("WinNT://$usuario,user")
    }
    
$objGrupo.PSBase.Rename('Ingeniería e Imasdé')
$objGrupo.SetInfo()

Remove-Variable grupo,objGrupo,usuario
