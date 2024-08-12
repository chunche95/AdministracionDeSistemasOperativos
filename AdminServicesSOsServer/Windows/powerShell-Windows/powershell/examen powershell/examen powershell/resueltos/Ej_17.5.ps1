# Ej_17.5.ps1
# 17.5. Cambiar el directorio de usuario a
# “C:\Users\aperez” e indicar que su script de
# inicio de sesión es “C:\Users\scripts\aperez.cmd”
# usuario “aperez”
#

$usr_nm = "aperez"
$usr_hd = "C:\Users\aperez"
$usr_ls = "C:\Users\scripts\aperez.cmd"

$objUser = [ADSI]"WinNT://./$usr_nm,user"
$objUser.PSBase.InvokeSet('HomeDirectory',$usr_hd)
$objUser.PSBase.InvokeSet('LoginScript',$usr_ls)
$objUser.SetInfo()
