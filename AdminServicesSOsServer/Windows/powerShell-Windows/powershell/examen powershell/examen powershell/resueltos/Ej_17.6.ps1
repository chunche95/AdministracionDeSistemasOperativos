# Ej_17.6.ps1
# 17.6. Añadir a “aperez” al grupo “Administradores”
# y quitarlo de “Finanzas”
#

$usr_nm = "aperez"
$grupo_add = "Administradores"
$grupo_del = "Finanzas"

$objGrupo = [ADSI]"WinNT://./$grupo_add,group"
$objGrupo.Add("WinNT://$usr_nm")
$objGrupo = [ADSI]"WinNT://./$grupo_del,group"
$objGrupo.Remove("WinNT://$usr_nm")



