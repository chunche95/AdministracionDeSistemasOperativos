# Ej_17.2.ps1
# 17.2. Crear el usuario local “aperez”,
# con nombre completo “Antonio Pérez” y contraseña
# “Pa$$w0rd”
#

$usr_nm = "aperez"
$usr_fn = "Antonio Pérez"
$usr_pass = "Pa$$w0rd"

$conexion = [ADSI]"WinNT://."
$objUser = $conexion.Create('user',$usr_nm)
$objUser.SetPassword($usr_pass)
$objUser.PSBase.InvokeSet('FullName',$usr_fn)
$objUser.SetInfo()
