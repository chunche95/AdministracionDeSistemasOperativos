# Ej_17.3.ps1
# 17.3. Añadir el usuario “aperez” al grupo “Finanzas”
#

$grupo = 'Finanzas'
$usuario = 'aperez'

$objGrupo = [ADSI]"WinNT://./$grupo,group"
$objGrupo.Add("WinNT://$usuario")
